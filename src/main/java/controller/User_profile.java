/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Comment;
import model.DAO.Comment_DB;
import model.DAO.Post_DB;
import model.DAO.User_DB;
import model.Post;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
public class User_profile extends HttpServlet {

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
            out.println("<title>Servlet User_profile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_profile at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false); // Không tự động tạo session mới
        // Kiểm tra xem người dùng đã đăng nhập chưa
        if (session != null && session.getAttribute("USER") != null) {
            User currentUser = (User) session.getAttribute("USER");
            String requestedUsername = request.getParameter("username");
            // Kiểm tra xem người dùng đang xem hồ sơ của mình hay của người khác
            if (currentUser.getUsername().equals(requestedUsername)) {
                // Đang xem hồ sơ của chính mình
                // Lấy số bài đăng của người dùng từ cơ sở dữ liệu
                int postCount = User_DB.countPost(currentUser.getUserEmail());
                // Lấy bài đăng của người dùng từ cơ sở dữ liệu
                List<Post> posts = Post_DB.getPostsByUsername(currentUser.getUsername());
                // Lặp qua danh sách bài viết để lấy thông tin về người đăng và các comment
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
                // Đặt các thuộc tính vào request
                request.setAttribute("postCount", postCount);
                request.setAttribute("posts", posts);
                // Chuyển hướng đến trang profile.jsp
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
            } else {
                // Đang xem hồ sơ của người khác
                // Lấy thông tin của người dùng từ cơ sở dữ liệu
                User userInfo = User_DB.getUserByEmailorUsername(requestedUsername);
                // Kiểm tra xem người dùng có tồn tại không
                if (userInfo == null) {
                    response.sendRedirect(request.getContextPath() + "/auth/login.jsp?errorMessage=User not found");
                    return;
                }
                // Lấy số bài đăng của người dùng từ cơ sở dữ liệu
                int postCount = User_DB.countPost(userInfo.getUserEmail());

                // Đặt các thuộc tính vào request
                request.setAttribute("postCount", postCount);
                // Chuyển hướng đến trang profile.jsp
                List<Post> userPosts = Post_DB.getPostsByUsername(requestedUsername);

                // Loop through the userPosts to fetch comments for each post
                for (Post post : userPosts) {
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

                // Set user and userPosts as request attributes
                request.setAttribute("user", userInfo);
                request.setAttribute("userPosts", userPosts);
                // Chuyển hướng đến trang profile.jsp
                request.getRequestDispatcher("/user/anotherUserProfile.jsp").forward(request, response);
            }
        } else {
            // Người dùng chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   
        
        
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
