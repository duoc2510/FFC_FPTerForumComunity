/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.http.HttpServletRequest;
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
import model.DAO.Group_DB;
import model.DAO.Post_DB;
import model.DAO.User_DB;
import model.Post;
import model.User;

/**
 *
 * @author PC
 */
public class User_viewProfile extends HttpServlet {

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
            out.println("<title>Servlet User_viewProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_viewProfile at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false); // Không tự động tạo session mới
        User userPersonal = (User) session.getAttribute("USER");
        String userName = request.getParameter("username");
        int userId = userPersonal.getUserId();
        String friendStatus = User_DB.getFriendRequestStatus(userId, userName);

        // Fetch the user
        User user = User_DB.getUserByEmailorUsername(userName);

        // Fetch the posts of the user in the specified group
        List<Post> userPosts = Post_DB.getPostsByUsername(userName);

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
        boolean areFriend = User_DB.areFriendsAccepted(userId, userName);
        boolean isPendingRq= User_DB.hasFriendRequestFromUser(userId, userName);
        int postCountofUser = User_DB.countPostByUserName(userName);

        // Thiết lập các thuộc tính cho session và request
        session.setAttribute("isPendingRq", isPendingRq);
        session.setAttribute("areFriend", areFriend);
        session.setAttribute("postCountofUser", postCountofUser);

        // Set user and userPosts as request attributes
        request.setAttribute("friendStatus", friendStatus);
        request.setAttribute("user", user);
        request.setAttribute("userPosts", userPosts);

        // Forward to the JSP page to display the posts
        request.getRequestDispatcher("/user/anotherUserProfile.jsp").forward(request, response);
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
        processRequest(request, response);
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
