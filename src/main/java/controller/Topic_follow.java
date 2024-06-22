/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import model.DAO.Topic_DB;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
public class Topic_follow extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get topicId parameter from request
        String topicIdParam = request.getParameter("topicId");
        String action = request.getParameter("action");

        if (topicIdParam == null || action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing topicId or action parameter");
            return;
        }

        int topicId;
        try {
            topicId = Integer.parseInt(topicIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid topicId");
            return;
        }

        // Get userId from session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");
        int userId = user.getUserId();
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        boolean result;
        if ("follow".equalsIgnoreCase(action)) {
            result = Topic_DB.followTopic(userId, topicId);
        } else if ("unfollow".equalsIgnoreCase(action)) {
            result = Topic_DB.unfollowTopic(userId, topicId);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            return;
        }

        try (PrintWriter out = response.getWriter()) {
            if (result) {
                out.println("Success");
                response.sendRedirect("home");
                session.removeAttribute("topics");
            } else {
                out.println("Failed");
                response.sendRedirect("home");
                session.removeAttribute("topics");
            }
        }
    }

}
