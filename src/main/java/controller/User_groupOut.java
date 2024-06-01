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
import model.DAO.Group_DB;
import model.User;

/**
 *
 * @author PC
 */
public class User_groupOut extends HttpServlet {

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
            out.println("<title>Servlet User_groupOut</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_groupOut at " + request.getContextPath() + "</h1>");
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
    String action = request.getParameter("action");
    User user = (User) request.getSession().getAttribute("USER");
    int userIdLeave = user.getUserId();
    int userIdOut = Integer.parseInt(request.getParameter("userId"));
    int groupId = Integer.parseInt(request.getParameter("groupId"));
    
    boolean success = false;
    String message = "";

    if ("leave".equals(action)) {
        // Gọi phương thức leave group
        success = Group_DB.leaveGroup(groupId, userIdLeave);
        if (success) {
            message = "You have successfully left the group.";
        } else {
            message = "Failed to leave the group. Please try again.";
        }
            response.sendRedirect(request.getContextPath() + "/inGroup?groupId=" + groupId);
    } else if ("kick".equals(action)) {
        // Gọi phương thức kick member
        
        success = Group_DB.kickMember(groupId, userIdOut);
        if (success) {
            message = "Member has been kicked out successfully.";
        } else {
            message = "Failed to kick member. Please try again.";
        }
       response.sendRedirect(request.getContextPath() + "/groupViewMember?groupId=" + groupId);
    } else if ("ban".equals(action)) {
        // Gọi phương thức ban member
        
        success = Group_DB.banMember(groupId, userIdOut);
        if (success) {
            message = "Member has been banned successfully.";
            
        } else {
            message = "Failed to ban member. Please try again.";
        }
         response.sendRedirect(request.getContextPath() + "/groupViewMember?groupId=" + groupId);
    }

    // Lưu thông điệp vào session
    request.getSession().setAttribute("message", message);

    // Chuyển hướng người dùng lại trang chi tiết nhóm

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
