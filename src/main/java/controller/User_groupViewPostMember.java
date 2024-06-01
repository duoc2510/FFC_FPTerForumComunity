/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Comment;
import model.DAO.Comment_DB;
import model.DAO.Group_DB;
import model.DAO.User_DB;
import model.Post;
import model.User;

/**
 *
 * @author PC
 */
public class User_groupViewPostMember extends HttpServlet {

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
            out.println("<title>Servlet User_groupViewPostMember</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_groupViewPostMember at " + request.getContextPath() + "</h1>");
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
        // Get userId and groupId from request parameters
        int userId = Integer.parseInt(request.getParameter("userId"));
        int groupId = Integer.parseInt(request.getParameter("groupId"));
        
        // Fetch the user
        User user = User_DB.getUserById(userId);
        
        // Fetch the posts of the user in the specified group
        List<Post> userPosts = Group_DB.getUserPostsInGroup(userId, groupId);
        
        // Loop through the userPosts to fetch comments for each post
        for (Post post : userPosts) {
            // Fetch comments for the current post
            List<Comment> comments = Comment_DB.getCommentsByPostId(post.getPostId());
            
            // Fetch user information for each comment
            for (Comment comment : comments) {
                User commentUser = User_DB.getUserById(comment.getUserId());
                if (commentUser != null) {
                    comment.setUser(commentUser);
                }
            }
            
            // Set comments for the current post
            post.setComments(comments);
        }
        
        // Set user and userPosts as request attributes
        request.setAttribute("user", user);
        request.setAttribute("userPosts", userPosts);

        // Forward to the JSP page to display the posts
        request.getRequestDispatcher("/group/listPostOfMember.jsp").forward(request, response);
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
