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
import model.DAO.Group_DB;
import model.DAO.Post_DB;
import model.DAO.User_DB;
import model.Group_member;
import model.Post;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
public class Manager_post extends HttpServlet {

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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");
        if (user == null) {
            response.sendRedirect("logingoooglehandle");
        } else if (user.getUserRole() > 1) {
            request.getRequestDispatcher("/manager/post.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String reason = request.getParameter("reason");
        boolean result = false;
        if (action != null && !action.isEmpty()) {
            if ("acceptPost".equals(action) || "denyPost".equals(action)) {
                int postId = 0;
                try {
                    postId = Integer.parseInt(request.getParameter("postId"));
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid postId parameter");
                    return;
                }
                result = ("acceptPost".equals(action)) ? Post_DB.updatePostStatus(postId, "Active", reason) : Post_DB.updatePostStatus(postId, "Denied", reason);
            }
        }

        boolean success = false;
        if ("acceptPost".equals(action) || "denyPost".equals(action)) {
            success = result;
        }
        if (success) {
            List<Post> posts = Post_DB.getPostsWithTopicId();
            for (Post p : posts) {
                User author = Post_DB.getUserByPostId(p.getPostId());
                p.setUser(author);
                List<Comment> comments = Comment_DB.getCommentsByPostId(p.getPostId());
                for (Comment comment : comments) {
                    User commentUser = User_DB.getUserById(comment.getUserId());
                    if (commentUser != null) {
                        comment.setUser(commentUser);
                    }
                }
                p.setComments(comments);
            }
            session.setAttribute("postsTopic", posts);
            System.out.println("Post status updated successfully.");
        } else {
            System.out.println("Failed to update post status.");
        }

        // Chuyển hướng lại trang hiện tại
        String referer = request.getHeader("referer");
        if (referer != null) {
            response.sendRedirect(referer);
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
