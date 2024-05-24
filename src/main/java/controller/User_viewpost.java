package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAO.Post_DB;
import model.Post;
import model.User;

/**
 *
 * @author Admin
 */
public class User_viewpost extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet viewPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet viewPost at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy session từ request
        HttpSession session = request.getSession(false); // Không tạo session mới nếu không tồn tại

        // Kiểm tra xem session có tồn tại và có chứa thông tin người dùng không
        if (session != null && session.getAttribute("USER") != null) {
            // Lấy thông tin người dùng từ session
            User user = (User) session.getAttribute("USER");

            // Lấy danh sách tất cả các bài viết
            List<Post> posts = Post_DB.getPostsWithUploadPath();

            // Lặp qua danh sách bài viết để lấy thông tin người đăng cho mỗi bài viết
            for (Post post : posts) {
                // Lấy thông tin người đăng cho bài viết
                User author = Post_DB.getUserByPostId(post.getPostId());
                post.setUser(author); // Đặt thông tin người đăng vào thuộc tính user của bài viết
            }

            // Đặt danh sách bài viết vào request attribute
            request.setAttribute("posts", posts);
            // Đặt thông tin người dùng vào request attribute
            request.setAttribute("user", user);

            // Chuyển hướng đến trang JSP để hiển thị thông tin
            request.getRequestDispatcher("/user/newsfeed.jsp").forward(request, response);
        } else {
            // Xử lý khi không tìm thấy thông tin người dùng trong session
            response.sendRedirect("login"); // Chuyển hướng đến trang đăng nhập
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
