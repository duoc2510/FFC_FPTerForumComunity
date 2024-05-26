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

public class AuthenticateFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter nếu cần thiết
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String uri = httpRequest.getRequestURI();

        // Kiểm tra nếu URL bắt đầu bằng /rank/
        if (uri.startsWith(httpRequest.getContextPath() + "/rank/")) {
            // Kiểm tra xem người dùng đã đăng nhập chưa
            if (httpRequest.getSession().getAttribute("USER") == null) {
                // Lưu lại URL hiện tại
                String referer = httpRequest.getHeader("referer");
                if (referer != null && !referer.isEmpty()) {
                    httpRequest.getSession().setAttribute("redirectURL", referer);
                }

                // Chuyển hướng đến trang đăng nhập
                httpResponse.sendRedirect(httpResponse.encodeRedirectURL(httpRequest.getContextPath() + "/login"));
                return;
            }
        }

        // Tiếp tục với các filter khác hoặc servlet đích
        chain.doFilter(request, response);
    }

    public void destroy() {
        // Hủy filter nếu cần thiết
    }
}
