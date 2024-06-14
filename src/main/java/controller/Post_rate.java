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

/**
 *
 * @author ThanhDuoc
 */
public class Post_rate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");

        if (user == null) {
            response.getWriter().write("{\"error\": \"User not logged in.\"}");
            return;
        }

        int userId = user.getUserId();
        int postId = Integer.parseInt(request.getParameter("postId"));
        String action = request.getParameter("action");

        try {
            if ("like".equals(action)) {
                Rate_DB.addLike(postId, userId); // Thực hiện thêm like vào bài viết
            } else if ("unlike".equals(action)) {
                Rate_DB.removeLike(postId, userId); // Thực hiện xóa like khỏi bài viết
            }

            int likeCount = Rate_DB.getLikes(postId); // Lấy số lượt like mới

            // Tạo JSON response để gửi về client
            String jsonResponse = "{\"likeCount\": " + likeCount + "}";
            response.getWriter().write(jsonResponse);
        } catch (SQLException ex) {
            ex.printStackTrace();
            response.getWriter().write("{\"error\": \"Failed to perform like/unlike operation.\"}");
        }
    }

}
