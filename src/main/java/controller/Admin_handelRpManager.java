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
import java.util.stream.Collectors;
import model.DAO.Report_DB;
import model.Report;
import notifications.NotificationWebSocket;

/**
 *
 * @author PC
 */
public class Admin_handelRpManager extends HttpServlet {

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
            out.println("<title>Servlet Admin_handelRpManager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_handelRpManager at " + request.getContextPath() + "</h1>");
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
        List<Report> reports = Report_DB.getAllReports();

        // Lọc và chỉ lấy các report có status là "pending" cho từng danh sách
        List<Report> pendingAllReportsM = reports.stream()
                .filter(report -> "pendingM".equalsIgnoreCase(report.getStatus()))
                .collect(Collectors.toList());

        List<Report> pendingAllPostReportsM = reports.stream()
                .filter(report -> report.getPostId() != 0 && "pendingM".equalsIgnoreCase(report.getStatus()))
                .collect(Collectors.toList());

        List<Report> pendingAllUserReportsM = reports.stream()
                .filter(report -> report.getPostId() == 0 && "pendingM".equalsIgnoreCase(report.getStatus()))
                .collect(Collectors.toList());
        request.setAttribute("reportsM", pendingAllReportsM);
        request.setAttribute("allPostReportsM", pendingAllPostReportsM);
        request.setAttribute("allUserReportsM", pendingAllUserReportsM);
        request.getRequestDispatcher("/admin/reportManager.jsp").forward(request, response);
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
        String msg = null;
        NotificationWebSocket nw = new NotificationWebSocket();
        if (action != null && !action.isEmpty()) {
            if (action.equals("banPost")) {
                int postId = Integer.parseInt(request.getParameter("postId"));
                String reason = request.getParameter("banReason");

                int reportedId = Integer.parseInt(request.getParameter("reportedId"));
                boolean postBanned = Report_DB.banPost(postId, reason);
                String postContent = request.getParameter("postContent");
                if (postBanned) {
                    List<Integer> reporterIds = Report_DB.getReporterIdsByPostId(postId);

                    // Send notifications to each reporter
                    for (int reporterId : reporterIds) {
                        nw.saveNotificationToDatabase(reporterId, "Report on post " + postContent + " processed!", "/#");
                        nw.sendNotificationToClient(reporterId, "Report on post " + postContent + " processed!", "/#");
                    }
                    nw.saveNotificationToDatabase(reportedId, "Your post " + postContent + " has been banned for a reason " + reason, "/#");
                    nw.sendNotificationToClient(reportedId, "Your post " + postContent + " has been banned for a reason " + reason, "/#");
                    msg = "Post has been banned successfully.";
                } else {
                    msg = "Failed to ban the post.";
                }
            } else if (action.equals("banUser")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean userBanned = Report_DB.banUser(userId);

                String username = request.getParameter("username");
                if (userBanned) {
                    List<Integer> reporterIds = Report_DB.getReporterIdsByUserId(userId);

                    // Send notifications to each reporter
                    for (int reporterId : reporterIds) {
                        nw.saveNotificationToDatabase(reporterId, "Report on user " + username + " processed!", "/#");
                        nw.sendNotificationToClient(reporterId, "Report on user " + username + " processed!", "/#");
                    }
                    msg = "User has been banned successfully.";
                } else {
                    msg = "Failed to ban the user.";
                }
            } else if (action.equals("cancelReportMgP")) {
                int postId = Integer.parseInt(request.getParameter("postId"));
                boolean reportCancelled = Report_DB.cancelReportMgP(postId);

                if (reportCancelled) {
                    msg = "Report for the post has been cancelled successfully.";
                } else {
                    msg = "Failed to cancel the report for the post.";
                }
            } else if (action.equals("cancelReportMgU")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean reportCancelled = Report_DB.cancelReportMgU(userId);

                if (reportCancelled) {
                    msg = "Report for the user has been cancelled successfully.";
                } else {
                    msg = "Failed to cancel the report for the user.";
                }
            } else if (action.equals("revokeM")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean managerRevoked = Report_DB.revokeManagerPrivileges(userId);

                if (managerRevoked) {
                    nw.saveNotificationToDatabase(userId, " Bạn đã bị thu hồi quyền manager!", "/#");
                    nw.sendNotificationToClient(userId, " Bạn đã bị thu hồi quyền manager!", "/#");
                    msg = "Manager status has been revoked successfully.";
                } else {
                    msg = "Failed to revoke manager status.";
                }

            } else {
                msg = "Invalid action.";
            }
        } else {
            msg = "Action parameter is missing.";
        }

        // Set msg attribute in session if not already set
        if (request.getSession().getAttribute("msg") == null) {
            request.getSession().setAttribute("msg", msg);
        }

        // Redirect to the report page
        response.sendRedirect(request.getContextPath() + "/admin/handelRpManager");
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
