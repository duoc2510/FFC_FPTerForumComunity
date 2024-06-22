
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
import java.sql.SQLException;
import model.DAO.Post_DB;
import model.DAO.Rate_DB;
import model.DAO.User_DB;
import model.User;
import org.json.JSONObject;

/**
 *
 * @author ThanhDuoc
 */
public class Post_rate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int userId = user.getUserId();
        int postId = Integer.parseInt(request.getParameter("postId"));
        String action = request.getParameter("action");

        try {
            if ("like".equals(action)) {
                Rate_DB.addLike(postId, userId);
            } else if ("unlike".equals(action)) {
                Rate_DB.removeLike(postId, userId);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            // Fetch updated like count and like status
            int likeCount = Rate_DB.getLikes(postId);
            boolean likedByCurrentUser = Rate_DB.checkIfLiked(postId, userId);

            // Prepare JSON response
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("likeCount", likeCount);
            jsonResponse.put("likedByCurrentUser", likedByCurrentUser);

            // Send JSON response
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

}