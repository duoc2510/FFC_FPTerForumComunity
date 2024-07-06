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
import java.util.List;
import model.DAO.Payment_DB;
import model.Payment;
import notifications.NotificationWebSocket;

/**
 *
 * @author ThanhDuoc
 */
public class Admin_transaction extends HttpServlet {

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
            out.println("<title>Servlet Admin_transaction</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_transaction at " + request.getContextPath() + "</h1>");
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
        List<Payment> payments = Payment_DB.getAllPayments();
        request.setAttribute("payments", payments);
        request.getRequestDispatcher("/admin/transaction.jsp").forward(request, response);
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
        int paymentId = Integer.parseInt(request.getParameter("paymentId"));
        String newStatus = request.getParameter("newStatus");

        // Update payment status in the database
        boolean updateSuccess = Payment_DB.updatePaymentStatus(paymentId, newStatus);

        if (updateSuccess) {
            // Optional: Send notification to user based on new status
            sendNotificationToUser(paymentId, newStatus);

            // Redirect back to the transaction page or update attributes as needed
            response.sendRedirect(request.getContextPath() + "/admin/transaction");
        } else {
            // Handle error case if update fails
            System.out.println("Failed to update payment status.");
            // You may redirect to an error page or display an error message
        }
    }

    private void sendNotificationToUser(int paymentId, String newStatus) {
        Payment payment = Payment_DB.getPaymentById(paymentId);
        int userId = payment.getUserId();

        String notificationMessage = "";
        if (newStatus.equals("Accept")) {
            notificationMessage = "Giao dịch thanh toán có mã số " + paymentId + " đã được hoàn thành.";
        } else if (newStatus.equals("Denied")) {
            notificationMessage = "Giao dịch thanh toán có mã số " + paymentId + " đã bị từ chối.";
        }

        // Send notification to user using NotificationWebSocket or other methods
        NotificationWebSocket nw = new NotificationWebSocket();
        nw.saveNotificationToDatabaseWithStatusIsBalance(userId, notificationMessage, "/walletbalance");
        nw.sendNotificationToClient(userId, notificationMessage, "/walletbalance");
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
