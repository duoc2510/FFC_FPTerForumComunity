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
import java.util.ArrayList;
import java.util.List;
import model.DAO.Report_DB;
import model.DAO.User_DB;
import model.Report;
import model.User;
import notifications.NotificationWebSocket;

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
    String action = request.getParameter("action");
NotificationWebSocket nw = new NotificationWebSocket();
    if (action != null && !action.isEmpty()) {
        if ("cancelReportPost".equals(action)) {
            int postId = Integer.parseInt(request.getParameter("postId"));
            boolean reportCancelled = Report_DB.cancelReport(reporterId, postId);

            if (reportCancelled) {
                String msg = "Report cancelled successfully.";
                session.setAttribute("msg", msg);
            } else {
                String msg = "Failed to cancel report.";
                session.setAttribute("msg", msg);
            }

            response.sendRedirect(request.getContextPath() + "/post");
            return; // Exit method to prevent further processing
        } else if ("editPostReport".equals(action)) {
            int postId = Integer.parseInt(request.getParameter("postId"));
            String newReason = request.getParameter("editReason");
            boolean reportEdited = Report_DB.editReport(reporterId, postId, newReason);

            if (reportEdited) {
                String msg = "Report edited successfully.";
                session.setAttribute("msg", msg);
            } else {
                String msg = "Failed to edit report.";
                session.setAttribute("msg", msg);
            }

            response.sendRedirect(request.getContextPath() + "/post");
            return; // Exit method to prevent further processing
        } else if ("revokeReportU".equals(action)) {
         int userId = Integer.parseInt(request.getParameter("reportId"));
            boolean reportRevoked = Report_DB.cancelReportUser(reporterId, userId);
            String username = request.getParameter("username");
            if (reportRevoked) {
                String msg = "Report revoked successfully.";
                session.setAttribute("msg", msg);
            } else {
                String msg = "Failed to revoke report.";
                session.setAttribute("msg", msg);
            }

              response.sendRedirect(request.getContextPath() + "/profile?username=" +username);
            return; // Exit method to prevent further processing
        } else if ("editReportU".equals(action)) {
             int userId = Integer.parseInt(request.getParameter("reportId"));
            String newReason = request.getParameter("editReason");
            String username = request.getParameter("username");
            boolean reportEdited = Report_DB.editReportUser(reporterId, userId, newReason);

            if (reportEdited) {
                String msg = "Report edited successfully.";
                session.setAttribute("msg", msg);
            } else {
                String msg = "Failed to edit report.";
                session.setAttribute("msg", msg);
            }

             response.sendRedirect(request.getContextPath() + "/profile?username=" +username);
            return; // Exit method to prevent further processing
       
        } else if ("rpUser".equals(action) || "rpPost".equals(action)) {
            // Keep the existing code for reporting users or posts
            String reason = request.getParameter("reportReason");
            String username = request.getParameter("username");
            int userRole = Integer.parseInt(request.getParameter("userRole"));
            Report report = new Report();
            report.setReporter_id(reporterId);
            report.setReason(reason);
            report.setStatus(userRole == 2 ? "pendingM" : "pending");
            
            boolean success = false;
            String msg = "";
            List<User> manager = User_DB.getAllUsers();
            List<Integer> managerIds = new ArrayList<>();

                for (User user : manager) {
                    if (user.getUserRole() == 2) {
                        managerIds.add(user.getUserId());
                    }
                }
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
                for (Integer managerId : managerIds) {
                        nw.saveNotificationToDatabase(managerId, "You have a new report to process!", "/manager/report");
                        nw.sendNotificationToClient(managerId, "You have a new report to process!", "/manager/report");
                    }
                msg = "Report submitted successfully.";
            } else {
                msg = "Failed to submit report. Please try again later.";
            }
            session.setAttribute("msg", msg);
            response.sendRedirect(request.getContextPath() + (action.equals("rpUser") ? "/profile?username=" + username : "/post"));
            return; // Exit method to prevent further processing
        }
    }

    String errorMsg = "Invalid action.";
    session.setAttribute("msg", errorMsg);
    response.sendRedirect(request.getContextPath() + "/manager/report");
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
