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
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Comment;
import model.DAO.Comment_DB;
import model.DAO.Post_DB;
import model.DAO.Rate_DB;
import model.DAO.Report_DB;
import model.DAO.User_DB;
import model.Post;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
public class Post_detail extends HttpServlet {

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
            out.println("<title>Servlet Post_detail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Post_detail at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));

        List<Post> posts = Post_DB.getPostByPostId(postId);
        User user = (User) request.getSession().getAttribute("USER");

        if (posts != null && !posts.isEmpty()) {
            for (Post post : posts) {
                User author = Post_DB.getUserByPostId(post.getPostId());
                post.setUser(author);
                post.setHasReportedPost(Report_DB.postReportedAtLeastThreeTimes(post.getPostId()));
                List<Comment> comments = Comment_DB.getCommentsByPostId(post.getPostId());
                for (Comment comment : comments) {
                    User commentUser = User_DB.getUserById(comment.getUserId());
                    if (commentUser != null) {
                        comment.setUser(commentUser);
                    }
                }
                post.setComments(comments);
                // Kiểm tra xem người dùng đã like bài viết này chưa và cập nhật trường likedByCurrentUser
                boolean likedByCurrentUser = false;
                try {
                    likedByCurrentUser = Rate_DB.checkIfLiked(post.getPostId(), user.getUserId());
                } catch (SQLException ex) {
                    Logger.getLogger(Post_postView.class.getName()).log(Level.SEVERE, null, ex);
                }
                post.setLikedByCurrentUser(likedByCurrentUser);

                // Lấy số lượt thích của bài viết và cập nhật vào đối tượng Post
                int likeCount = 0;
                try {
                    likeCount = Rate_DB.getLikes(post.getPostId());
                } catch (SQLException ex) {
                    Logger.getLogger(Post_postView.class.getName()).log(Level.SEVERE, null, ex);
                }
                post.setLikeCount(likeCount);
            }
        }
        request.getSession().setAttribute("postDetail", posts);
        request.getRequestDispatcher("/user/postDetail.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
