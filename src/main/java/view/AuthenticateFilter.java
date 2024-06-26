package view;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAO.User_DB;
import model.User;

public class AuthenticateFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter nếu cần thiết
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false); // Không tự động tạo session mới
        User user = (session != null) ? (User) session.getAttribute("USER") : null;

        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // Bỏ qua xác thực cho các đường dẫn cụ thể
        if (uri.startsWith(contextPath + "/marketplace/allshop")
                || uri.startsWith(contextPath + "/marketplace/allshop/shopdetail")
                || uri.startsWith(contextPath + "/marketplace/allshop/shopdetail/productdetail")) {
            chain.doFilter(request, response);
            return;
        }

        // Xác thực cho các đường dẫn cần đăng nhập
        if (uri.startsWith(contextPath + "/rank/")
                || uri.startsWith(contextPath + "/profile")
                || uri.startsWith(contextPath + "/marketplace/")
                || uri.startsWith(contextPath + "/manager/")
                || uri.startsWith(contextPath + "/post")
                || uri.startsWith(contextPath + "/messenger")) {

            if (user == null) {
                // Lưu lại URL hiện tại
                String referer = httpRequest.getHeader("referer");
                if (referer != null && !referer.isEmpty()) {
                    httpRequest.getSession(true).setAttribute("redirectURL", referer);
                }
                // Chuyển hướng đến trang đăng nhập
                httpResponse.sendRedirect(httpResponse.encodeRedirectURL(contextPath + "/logingooglehandler?value=login"));
                return;
            }
        }

        // Kiểm tra quyền truy cập vào trang admin
        if (uri.startsWith(contextPath + "/admin/")) {
            // Kiểm tra userRole của người dùng
            if (user == null || user.getUserRole() != 3) {
                // Nếu không có quyền, chuyển hướng về trang home
                httpResponse.sendRedirect(contextPath + "/home");
                return;
            }
        } else if (uri.startsWith(contextPath + "/manager/")) {
            User currentUser = (User) session.getAttribute("USER");

            // Kiểm tra và cập nhật lại thông tin người dùng trong session
            if (currentUser != null) {
                User refreshedUser = User_DB.getUserById(currentUser.getUserId());
                if (refreshedUser != null) {
                    // Cập nhật lại session với thông tin người dùng mới
                    session.setAttribute("USER", refreshedUser);
                }
            }

            // Lấy lại thông tin user từ session sau khi cập nhật
            User userCurrent = (User) session.getAttribute("USER");

            // Kiểm tra userRole của người dùng
            if (userCurrent == null || userCurrent.getUserRole() == 1) {
                // Nếu không có quyền, chuyển hướng về trang home
                httpResponse.sendRedirect(contextPath + "/home");
                return;
            }
        }

        // Kiểm tra nếu người dùng đã đăng nhập và cố truy cập vào trang login hoặc register
        if ((uri.equals(contextPath + "/login") || uri.equals(contextPath + "/register")) && user != null) {
            // Chuyển hướng đến trang chủ
            httpResponse.sendRedirect(contextPath + "/home");
            return;
        }

        // Tiếp tục với các filter khác hoặc servlet đích
        chain.doFilter(request, response);
    }

    public void destroy() {
        // Hủy filter nếu cần thiết
    }
}
