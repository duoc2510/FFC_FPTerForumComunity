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
import model.Comment;
import model.DAO.Comment_DB;
import model.DAO.Post_DB;
import model.DAO.User_DB;
import model.Post;
import model.User;

/**
 *
 * @author Admin
 */
public class User_postView extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false); // Không tạo session mới nếu không tồn tại

        if (session != null && session.getAttribute("USER") != null) {
            User user = (User) session.getAttribute("USER");

            // Lấy danh sách tất cả các bài viết
            List<Post> posts = Post_DB.getPostsWithUploadPath();

            for (Post post : posts) {
                // Lấy thông tin người đăng cho bài viết
                User author = Post_DB.getUserByPostId(post.getPostId());
                post.setUser(author); // Đặt thông tin người đăng vào thuộc tính user của bài viết

                // Lấy danh sách comment cho bài viết
                List<Comment> comments = Comment_DB.getCommentsByPostId(post.getPostId());
                for (Comment comment : comments) {
                    // Lấy thông tin người dùng cho comment
                    User commentUser = User_DB.getUserById(comment.getUserId());
                    if (commentUser != null) {
                        comment.setUser(commentUser);
                    }
                }
                post.setComments(comments); // Đặt danh sách comment vào bài viết
            }

            request.setAttribute("posts", posts);
            request.setAttribute("user", user);

            // Chuyển hướng đến trang JSP để hiển thị thông tin
            request.getRequestDispatcher("/user/newsfeed.jsp").forward(request, response);
        } else {
            response.sendRedirect("login"); // Chuyển hướng đến trang đăng nhập
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("text/html;charset=UTF-8");

        if ("deletePost".equals(action)) {
            // Lưu lại URL của trang hiện tại

            // Xóa bài đăng
            int postId = Integer.parseInt(request.getParameter("postId"));
            boolean success = Post_DB.deletePost(postId);

            if (success) {
                // Nếu thành công, chuyển hướng người dùng đến trang hiện tại
                String referer = request.getHeader("referer");
                response.sendRedirect(referer);
            } else {
                // Nếu thất bại, gửi mã lỗi 500
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete post.");
            }
        }
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
