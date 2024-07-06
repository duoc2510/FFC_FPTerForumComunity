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
import model.DAO.Shop_DB;
import model.DAO.User_DB;
import model.User;
import notifications.NotificationWebSocket;

/**
 *
 * @author Admin
 */
public class Shop_approve extends HttpServlet {

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
            out.println("<title>Servlet Shop_approve</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Shop_approve at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/admin/approveShop.jsp").forward(request, response);
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
        NotificationWebSocket nw = new NotificationWebSocket();
        String shopIdStr = request.getParameter("shopId");
        String action = request.getParameter("action");

        int shopId = Integer.parseInt(shopIdStr);
        User user = User_DB.getUserByShopId(shopId);
        boolean success = false;
        String message = "";

        try {
            if ("approve".equalsIgnoreCase(action)) {
                Shop_DB.setStatusIs1ByShopID(shopId);
                nw.saveNotificationToDatabase(user.getUserId(), "Shop của bạn đã được duyệt!", "/marketplace/myshop");
                nw.sendNotificationToClient(user.getUserId(), "Shop của bạn đã được duyệt!", "/marketplace/myshop");
                success = true;
                message = "Shop approved successfully.";
            } else if ("not-approve".equalsIgnoreCase(action)) {
                Shop_DB.setStatusIs0ByShopID(shopId);
                nw.saveNotificationToDatabase(user.getUserId(), "Shop của bạn không được duyệt vì 1 số lí do!", "/marketplace/myshop");
                nw.sendNotificationToClient(user.getUserId(), "Shop của bạn không được duyệt vì 1 số lí do!", "/marketplace/myshop");

                // Deduct money from the buyer
                boolean updateSuccess = User_DB.updateWalletByEmail(user.getUserEmail(), user.getUserWallet() + 50000);
                nw.saveNotificationToDatabaseWithStatusIsBalance(user.getUserId(), "Trả lại tiền tạo shop không thành công : 50000đ!", "/walletbalance");
                if (!updateSuccess) {
                    throw new Exception("Failed to update user wallet.");
                }
                success = true;
                message = "Shop not approved.";
            }
        } catch (Exception e) {
            message = "An error occurred: " + e.getMessage();
            e.printStackTrace(); // Log the exception
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"success\": " + success + ", \"message\": \"" + message + "\"}");
        out.flush();
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
