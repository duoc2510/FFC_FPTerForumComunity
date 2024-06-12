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
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.DAO.Group_DB;
import model.Group;
import model.Group_member;
import model.User;

/**
 *
 * @author PC
 */
public class User_groupSetting extends HttpServlet {

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
            out.println("<title>Servlet User_inGroup</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_inGroup at " + request.getContextPath() + "</h1>");
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
        // Lấy userId và groupId từ request, bạn cần thay đổi phần này tùy vào cách bạn truyền dữ liệu từ client
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");
        int userId = user.getUserId();
        int groupId = Integer.parseInt(request.getParameter("groupId"));
        int postCount = Group_DB.countPostsInGroup(groupId);

        // Gọi phương thức viewGroup để lấy thông tin nhóm từ cơ sở dữ liệu
        Group group = Group_DB.viewGroup(groupId);

        boolean isPending = Group_DB.isUserPendingApproval(userId, groupId);
        group.setPending(isPending);
        boolean isUserApproved = Group_DB.isUserApproved(userId, groupId);
        boolean isUserBanned = Group_DB.isUserBan(userId, groupId);
        session.setAttribute("isUserApproved", isUserApproved);
         session.setAttribute("isUserBanned", isUserBanned);
        session.setAttribute("group", group);
        session.setAttribute("postCount", postCount);

        request.getRequestDispatcher("/group/groupDetails.jsp").forward(request, response);

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
