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
import model.DAO.Report_DB;
import model.Report;
import model.User;

/**
 *
 * @author PC
 */
public class Report_submitRp extends HttpServlet {

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
            out.println("<title>Servlet Report_handel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Report_handel at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
    HttpSession session = request.getSession();
    User currentUser = (User) session.getAttribute("USER");
    int reporterId = currentUser.getUserId();
    String reason = request.getParameter("reportReason");
    String action = request.getParameter("action");
   
    String username = request.getParameter("username");

    Report report = new Report();
    report.setReporter_id(reporterId);
    report.setReason(reason);
    report.setStatus("pending");

    boolean success = false;
    String msg = "";

    if ("rpUser".equals(action)) {
        int userId = Integer.parseInt(request.getParameter("userId"));
        report.setUserId(userId);
        report.setShopId(0);
        report.setPostId(0);
        success = Report_DB.insertReport(report);
    } else if ("rpPost".equals(action)) {
        int userId = Integer.parseInt(request.getParameter("userId"));
        int postId = Integer.parseInt(request.getParameter("postId"));
        report.setPostId(postId);
        report.setUserId(userId);
        report.setShopId(0);
        success = Report_DB.insertReport(report);
    }

    if (success) {
        msg = "Report submitted successfully.";
    } else {
        msg = "Failed to submit report. Please try again later.";
    }
    session.setAttribute("reportMessage", msg);
    response.sendRedirect(request.getContextPath() + (action.equals("rpUser") ? "/profile?username=" + username : "/post"));
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
