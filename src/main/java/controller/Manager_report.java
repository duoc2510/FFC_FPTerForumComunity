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
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import model.DAO.Post_DB;
import model.DAO.Report_DB;
import model.DAO.User_DB;
import model.Post;
import model.Report;
import model.User;
import notifications.NotificationWebSocket;

/**
 *
 * @author ThanhDuoc
 */
public class Manager_report extends HttpServlet {

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
            out.println("<title>Servlet Manager_reportHandle</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Manager_reportHandle at " + request.getContextPath() + "</h1>");
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

        // Làm mới thông tin người dùng từ cơ sở dữ liệu (giả sử có phương thức getUserById)
        List<Report> reports = Report_DB.getAllReports();

        // Lọc và chỉ lấy các report có status là "pending" cho từng danh sách
        List<Report> pendingAllReports = reports.stream()
                .filter(report -> "pending".equalsIgnoreCase(report.getStatus()))
                .collect(Collectors.toList());

        List<Report> pendingAllPostReports = reports.stream()
                .filter(report -> report.getPostId() != 0 && "pending".equalsIgnoreCase(report.getStatus()))
                .collect(Collectors.toList());

        List<Report> pendingAllUserReports = reports.stream()
                .filter(report -> report.getPostId() == 0 && "pending".equalsIgnoreCase(report.getStatus()))
                .collect(Collectors.toList());

        List<Report> pendingReportedPosts = Report_DB.getPostsReportedAtLeastThreeTimesWithReasons().stream()
                .filter(report -> "pending".equalsIgnoreCase(report.getStatus()))
                .collect(Collectors.toList());

        List<Report> pendingReportedUsers = Report_DB.getUsersReportedAtLeastThreeTimesWithReasons().stream()
                .filter(report -> "pending".equalsIgnoreCase(report.getStatus()))
                .collect(Collectors.toList());

        // Đưa danh sách reports vào trong attribute của request để chuyển cho JSP
        request.setAttribute("reports", pendingAllReports);
        request.setAttribute("allPostReports", pendingAllPostReports);
        request.setAttribute("allUserReports", pendingAllUserReports);
        request.setAttribute("reportedPosts", pendingReportedPosts);
        request.setAttribute("reportedUsers", pendingReportedUsers);

        // Forward đến trang JSP để hiển thị danh sách reports
        request.getRequestDispatcher("/manager/report.jsp").forward(request, response);
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
                int reportedId = Integer.parseInt(request.getParameter("reportedId"));
                String reason = request.getParameter("banReason");
                boolean postBanned = Report_DB.banPost(postId, reason);
                String postContent = request.getParameter("postContent");
              
                if (postBanned) {
                  List<Integer> reporterIds = Report_DB.getReporterIdsByPostId(postId);
                 
                  
                    for (Integer reporterId : reporterIds) {
                        
                        nw.saveNotificationToDatabase(reporterId, "Report on post " + postContent + " processed!", "");
                        nw.sendNotificationToClient(reporterId, "Report on post " + postContent + " processed!", "");
                    }

                    nw.saveNotificationToDatabase(reportedId, "Your post " + postContent + " has been banned for a reason " + reason, "");
                    nw.sendNotificationToClient(reportedId, "Your post " + postContent + " has been banned for a reason " + reason, "");
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
                    for (Integer reporterId : reporterIds) {
                        nw.saveNotificationToDatabase(reporterId, "Report on user " + username + " processed!", "");
                        nw.sendNotificationToClient(reporterId, "Report on user " + username + " processed!", "");
                    }
                    msg = "User has been banned successfully.";
                } else {
                    msg = "Failed to ban the user.";
                }
            } else if (action.equals("banUserByAd")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String username = request.getParameter("username");
                boolean userBanned = Report_DB.banUserByAd(userId);

                if (userBanned) {
                    msg = "User has been banned successfully.";
                } else {
                    msg = "Failed to ban the user.";
                }
                // Set msg attribute in session
                request.getSession().setAttribute("msg", msg);
                // Redirect to the profile page with the username
                response.sendRedirect(request.getContextPath() + "/profile?username=" + username);
                return; // Exit the method to prevent further processing
            } else if (action.equals("banPostMore3Time")) {
                int postId = Integer.parseInt(request.getParameter("postId"));
                int reportedId = Integer.parseInt(request.getParameter("reportedId"));
                String reason = request.getParameter("banReason");
                boolean postBanned = Report_DB.banPost(postId, reason);
                String postContent = request.getParameter("postContent");
               
                if (postBanned) {
                  List<Integer> reporterIds = Report_DB.getReporterIdsByPostId(postId);
                    for (Integer reporterId : reporterIds) {
                        nw.saveNotificationToDatabase(reporterId, "Report on post " + postContent + " processed!", "");
                        nw.sendNotificationToClient(reporterId, "Report on post " + postContent + " processed!", "");
                    }

                    nw.saveNotificationToDatabase(reportedId, "Your post " + postContent + " has been banned for a reason " + reason, "");
                    nw.sendNotificationToClient(reportedId, "Your post " + postContent + " has been banned for a reason " + reason, "");
                    msg = "Post has been banned successfully.";
                } else {
                    msg = "Failed to ban the post.";
                }
                request.getSession().setAttribute("msg", msg);
                response.sendRedirect(request.getContextPath() + "/post");
                return; // Exit the method to prevent further processing
            } else if (action.equals("banUserByM")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String username = request.getParameter("username");
                boolean userBanned = Report_DB.banUser(userId);      
                if (userBanned) {
                     List<Integer> reporterIds = Report_DB.getReporterIdsByUserId(userId);
                    for (Integer reporterId : reporterIds) {
                        nw.saveNotificationToDatabase(reporterId, "Report on user " + username + " processed!", "");
                        nw.sendNotificationToClient(reporterId, "Report on user " + username + " processed!", "");
                    }
                } else {
                    msg = "Failed to ban the user.";
                }
                // Set msg attribute in session
                request.getSession().setAttribute("msg", msg);
                // Redirect to the profile page with the username
                response.sendRedirect(request.getContextPath() + "/profile?username=" + username);
                return; // Exit the method to prevent further processing
            } else if (action.equals("banPostByAd")) {
                int postId = Integer.parseInt(request.getParameter("postId"));
                int userId = Integer.parseInt(request.getParameter("userId"));
                String reason = request.getParameter("banReason");
                boolean postBanned = Report_DB.banPostByAd(postId, reason);
                String postContent = request.getParameter("postContent");
                if (postBanned) {
                    nw.saveNotificationToDatabase(userId, "Your post " + postContent + " has been banned for a reason " + reason, "/#");
                    nw.sendNotificationToClient(userId, "Your post " + postContent + " has been banned for a reason " + reason, "/#");
                    msg = "Post has been banned successfully.";
                } else {
                    msg = "Failed to ban the post.";
                }
                // Set msg attribute in session
                request.getSession().setAttribute("msg", msg);
                // Redirect to the post page with the postId
                response.sendRedirect(request.getContextPath() + "/post");
                return; // Exit the method to prevent further processing

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
            } else if (action.equals("setM")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean setM = Report_DB.setManager(userId);
                String username = request.getParameter("username");
                if (setM) {
                    msg = "Manager status has been set successfully.";
                } else {
                    msg = "Failed to set manager status.";
                }
                // Set msg attribute in session
                request.getSession().setAttribute("msg", msg);
                // Redirect to the profile page with the username
                response.sendRedirect(request.getContextPath() + "/profile?username=" + username);
                return; // Exit the method to prevent further processing  
            } else if (action.equals("revokeM")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean managerRevoked = Report_DB.revokeManager(userId);
                String username = request.getParameter("username");
                if (managerRevoked) {
                    msg = "Manager status has been revoked successfully.";
                } else {
                    msg = "Failed to revoke manager status.";
                }
                // Set msg attribute in session
                request.getSession().setAttribute("msg", msg);
                // Redirect to the profile page with the username
                response.sendRedirect(request.getContextPath() + "/profile?username=" + username);
                return; // Exit the method to prevent further processing
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
