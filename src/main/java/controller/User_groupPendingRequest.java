/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.RequestDispatcher;
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
import java.util.stream.Collectors;
import model.DAO.Group_DB;
import model.Group;
import model.Group_member;

/**
 *
 * @author PC
 */
public class User_groupPendingRequest extends HttpServlet {

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
            out.println("<title>Servlet User_groupPendingRequest</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_groupPendingRequest at " + request.getContextPath() + "</h1>");
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
    int groupId = Integer.parseInt(request.getParameter("groupId"));

    // Lấy danh sách tất cả các thành viên của nhóm
    List<Group_member> allMembers = Group_DB.getAllMembersByGroupId(groupId);

    // Lọc ra các thành viên có trạng thái là 'pending'
    List<Group_member> pendingMembers = new ArrayList<>();

    for (Group_member member : allMembers) {
        if ("pending".equals(member.getStatus())) {
            pendingMembers.add(member);
        }
    }

    // Đặt danh sách các thành viên đang chờ duyệt vào thuộc tính request
    request.setAttribute("pendingMembers", pendingMembers);

   
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
           int memberGroupId = Integer.parseInt(request.getParameter("memberId"));
    String action = request.getParameter("action");

    boolean result = false;
    String messageOfApprove = "";
    if ("accept".equals(action)) {
        result = Group_DB.accept(memberGroupId);
        messageOfApprove = result ? "Member approved successfully!" : "Failed to approve member.";
    } else if ("deny".equals(action)) {
        result = Group_DB.deny(memberGroupId);
        messageOfApprove = result ? "Member denied successfully!" : "Failed to deny member.";
    }

     HttpSession session = request.getSession();
    session.setAttribute("messageOfApprove", messageOfApprove);

    if (result) {
        response.sendRedirect("inGroup?groupId=" + request.getParameter("groupId"));
    } else {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update member status");

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
