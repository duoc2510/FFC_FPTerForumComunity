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
import java.util.ArrayList;
import java.util.List;
import model.DAO.Report_DB;
import model.DAO.User_DB;
import static model.DAO.User_DB.getAllUsers;
import model.ManagerRegistr;
import model.User;
import notifications.NotificationWebSocket;

/**
 *
 * @author PC
 */
public class Admin_ManageUsers extends HttpServlet {

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
            out.println("<title>Servlet Admin_ManageUsers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_ManageUsers at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        NotificationWebSocket nw = new NotificationWebSocket();
        if ("allUser".equals(action)) {
            // Xử lý lấy danh sách tất cả người dùng
            List<User> allUsers = getAllUsers();

            // Lọc danh sách người dùng có userRole khác 3
            List<User> filteredUsers = new ArrayList<>();
            for (User user : allUsers) {
                if (user.getUserRole() != 3) {
                    filteredUsers.add(user);
                }
            }
            request.setAttribute("allUsers", filteredUsers);

            // Chuyển hướng tới trang allUser.jsp để hiển thị
            request.getRequestDispatcher("/admin/allUser.jsp").forward(request, response);
        } else if ("unBanUser".equals(action)) {
            // Xử lý lấy danh sách người dùng không bị cấm (userRole = 0)
            List<User> BannedUsers = getAllUsers();
            List<User> Banned = new ArrayList<>();

            // Lọc danh sách người dùng có userRole = 0
            for (User user : BannedUsers) {
                if (user.getUserRole() == 0) {
                    Banned.add(user);
                }
            }

            // Lưu danh sách vào request attribute để truyền cho JSP
            request.setAttribute("Banned", Banned);

            // Chuyển hướng tới trang unBanUser.jsp để hiển thị
            request.getRequestDispatcher("/admin/unBanUser.jsp").forward(request, response);
        } else if ("approveManager".equals(action)) {

            List<ManagerRegistr> pendingRegistrations = User_DB.getAllRegisterM();

            List<ManagerRegistr> pendingApprovals = new ArrayList<>();
            for (ManagerRegistr registr : pendingRegistrations) {
                if ("pending".equals(registr.getStatus())) {
                    pendingApprovals.add(registr);
                }
            }

            // Đặt danh sách đã lọc vào request attribute để truyền cho JSP
            request.setAttribute("pendingApprovals", pendingApprovals);

            // Chuyển hướng tới trang approveManager.jsp để hiển thị danh sách chờ phê duyệt
            request.getRequestDispatcher("/admin/approveManager.jsp").forward(request, response);

        } else if ("listManager".equals(action)) {
            // Xử lý lấy danh sách người dùng là quản lý (userRole = 2)
            List<User> managerUsers = getAllUsers();
            List<User> managers = new ArrayList<>();

            // Lọc danh sách người dùng có userRole = 2
            for (User user : managerUsers) {
                if (user.getUserRole() == 2) {
                    managers.add(user);
                }
            }

            // Lưu danh sách vào request attribute để truyền cho JSP
            request.setAttribute("managers", managers);

            // Chuyển hướng tới trang managers.jsp để hiển thị
            request.getRequestDispatcher("/admin/allManagers.jsp").forward(request, response);
        } else {
            // Nếu không có action hoặc action không hợp lệ, có thể xử lý bổ sung ở đây
            response.sendRedirect(request.getContextPath() + "/admin/reportManager"); // Chuyển hướng về trang quản lý báo cáo
        }
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
        NotificationWebSocket nw = new NotificationWebSocket();
        if ("banUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean userBanned = Report_DB.banUser(userId);

            if (userBanned) {
                request.getSession().setAttribute("msg", "User has been banned successfully.");
            } else {
                request.getSession().setAttribute("msg", "Failed to ban the user.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/ManageUsers?action=listManager");
        } else if ("banUserInAllUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean userBanned = Report_DB.banUser(userId);

            if (userBanned) {
                request.getSession().setAttribute("msg", "User role has been banned successfully.");
            } else {
                request.getSession().setAttribute("msg", "Failed to ban manager role.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/ManageUsers?action=allUser");
        } else if ("revokeMInAllUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean managerRevoked = Report_DB.revokeManager(userId);

            if (managerRevoked) {
                nw.saveNotificationToDatabase(userId,  " Bạn đã bị thu hồi quyền manager!", "/#");
            nw.saveNotificationToDatabase(userId,  " Bạn đã bị thu hồi quyền manager!", "/#");
                request.getSession().setAttribute("msg", "Manager role has been revoked successfully.");
            } else {
                request.getSession().setAttribute("msg", "Failed to revoke manager role.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/ManageUsers?action=allUser");
        } else if ("revokeM".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean managerRevoked = Report_DB.revokeManager(userId);

            if (managerRevoked) {
                nw.saveNotificationToDatabase(userId,  " Bạn đã bị thu hồi quyền manager!", "/#");
            nw.saveNotificationToDatabase(userId,  " Bạn đã bị thu hồi quyền manager!", "/#");
                request.getSession().setAttribute("msg", "Manager role has been revoked successfully.");
            } else {
                request.getSession().setAttribute("msg", "Failed to revoke manager role.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/ManageUsers?action=listManager");

        } else if ("setM".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean setM = Report_DB.setManager(userId);

            if (setM) {
            nw.saveNotificationToDatabase(userId,  " Chúc mừng bạn đã trở thành Manager! Hãy bấm vào thông báo này để được cập nhật lại quyền của bạn nhé", "/#");
            nw.sendNotificationToClient(userId,  " Chúc mừng bạn đã trở thành Manager! Hãy bấm vào thông báo này để được cập nhật lại quyền của bạn nhé", "/#");
                request.getSession().setAttribute("msg", "User role has been set successfully.");
            } else {
                request.getSession().setAttribute("msg", "Failed to set manager role.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/ManageUsers?action=listManager");
        } else if ("setMInAllUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean setMInAllUser = Report_DB.setManager(userId);
            
            if (setMInAllUser) {
            nw.saveNotificationToDatabase(userId,  " Chúc mừng bạn đã trở thành Manager! Hãy bấm vào thông báo này để được cập nhật lại quyền của bạn nhé", "/#");
           nw.sendNotificationToClient(userId,  " Chúc mừng bạn đã trở thành Manager! Hãy bấm vào thông báo này để được cập nhật lại quyền của bạn nhé", "/#");
                request.getSession().setAttribute("msg", "User role has been set successfully.");
            } else {
                request.getSession().setAttribute("msg", "Failed to set manager role.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/ManageUsers?action=allUser");
        } else if ("unbanUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean unBan = Report_DB.unBanUser(userId);

            if (unBan) {
                request.getSession().setAttribute("msg", "User role has been unban successfully.");
            } else {
                request.getSession().setAttribute("msg", "Failed to unban.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/ManageUsers?action=unBanUser");
        } else if ("unBanInAllUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean unBanInAllUser = Report_DB.unBanUser(userId);

            if (unBanInAllUser) {
                request.getSession().setAttribute("msg", "User role has been unban successfully.");
            } else {
                request.getSession().setAttribute("msg", "Failed to unban.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/ManageUsers?action=allUser");
        } else if ("approveM".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean approveSuccess = Report_DB.approveManager(userId);
            nw.saveNotificationToDatabase(userId,  " Đơn đăng kí của bạn đã được duyệt.Chúc mừng bạn đã trở thành Manager! Hãy bấm vào thông báo này để được cập nhật lại quyền của bạn nhé", "/#");
            nw.sendNotificationToClient(userId,  " Đơn đăng kí của bạn đã được duyệt.Chúc mừng bạn đã trở thành Manager! Hãy bấm vào thông báo này để được cập nhật lại quyền của bạn nhé", "/#");
            if (approveSuccess) {
                request.getSession().setAttribute("msg", "User has been approved as manager successfully.");
            } else {
                request.getSession().setAttribute("msg", "Failed to approve user as manager.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/ManageUsers?action=approveManager");
        } else if ("cancelApprove".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean cancelApproveSuccess = Report_DB.cancelApproveManager(userId);

            if (cancelApproveSuccess) {
                request.getSession().setAttribute("msg", "Manager approval has been cancelled successfully.");
            } else {
                request.getSession().setAttribute("msg", "Failed to cancel manager approval.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/ManageUsers?action=approveManager");
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
