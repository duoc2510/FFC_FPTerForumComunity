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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?errorMessage=You must be logged in to view posts");
            return;
        }

        String userEmail = user.getUserEmail();
        User userInfo = User_DB.getUserByEmailorUsername(userEmail);

        if (userInfo == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?errorMessage=User not found");
            return;
        }

        // Cập nhật điểm số và đếm số bài đăng của người dùng
        User_DB.updateScore(userEmail);
        int postCount = User_DB.countPost(userEmail);

        // Thiết lập các thuộc tính cho session và request
        session.setAttribute("postCount", postCount);

        // Lấy bài đăng của người dùng từ cơ sở dữ liệu
        String username = user.getUsername();
        List<Post> posts = Post_DB.getPostsByUsername(username);


        request.setAttribute("posts", posts);

        // Chuyển tiếp yêu cầu tới trang profile.jsp
        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
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
