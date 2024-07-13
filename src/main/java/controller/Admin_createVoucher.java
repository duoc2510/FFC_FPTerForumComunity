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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import model.DAO.Shop_DB;
import model.DAO.User_DB;
import model.Discount;
import model.User;
import notifications.NotificationWebSocket;

/**
 *
 * @author Admin
 */
public class Admin_createVoucher extends HttpServlet {

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
            out.println("<title>Servlet Admin_createVoucher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_createVoucher at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/admin/createVoucher.jsp").forward(request, response);
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
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        NotificationWebSocket nw = new NotificationWebSocket();
        Shop_DB sdb = new Shop_DB();
        User_DB udb = new User_DB();
        ArrayList<User> userlist = udb.getAllUsers();

        try {
            String code = request.getParameter("discountCode");
            double discountPercent = Double.parseDouble(request.getParameter("discountPercent"));
            double discountConditionInput = Double.parseDouble(request.getParameter("discountConditionInput"));
            String validFromStr = request.getParameter("validFrom");
            String validToStr = request.getParameter("validTo");
            int usageLimit = Integer.parseInt(request.getParameter("usageLimit"));

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date validFrom = dateFormat.parse(validFromStr);
            Date validTo = dateFormat.parse(validToStr);

            Discount discount = new Discount(code, 0, 0, discountPercent, validFrom, validTo, usageLimit, discountConditionInput);
            sdb.addNewDiscount(discount);

            out.print("{\"status\":\"success\"}");
            for (User u : userlist) {
                nw.saveNotificationToDatabase(u.getUserId(), "Hot!Hot! System Voucher available! Hurry and buy now!", "/marketplace/allshop");
                nw.sendNotificationToClient(u.getUserId(), "Hot!Hot! System Voucher available! Hurry and buy now!", "/marketplace/allshop");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"status\":\"error\"}");
        } finally {
            out.close();
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
