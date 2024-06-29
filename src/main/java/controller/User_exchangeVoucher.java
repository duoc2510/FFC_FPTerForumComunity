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
import java.sql.Date;
import java.time.LocalDate;
import model.DAO.Shop_DB;
import model.DAO.User_DB;
import model.Discount;
import model.User;
import org.json.JSONObject;

/**
 *
 * @author Admin
 */
public class User_exchangeVoucher extends HttpServlet {

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
            out.println("<title>Servlet User_exchangeVoucher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_exchangeVoucher at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/rank/exchangeVoucher.jsp").forward(request, response);
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
        response.setCharacterEncoding("UTF-8");
        Shop_DB sdb = new Shop_DB();
        User_DB udb = new User_DB();

        // Retrieve user information
        User user = (User) request.getSession().getAttribute("USER");
        if (user == null) {
            sendErrorResponse(response, "User not logged in.");
            return;
        }

        // Retrieve reward ID from request
        String rewardIdStr = request.getParameter("rewardId");
        if (rewardIdStr == null || rewardIdStr.isEmpty()) {
            sendErrorResponse(response, "Invalid reward ID.");
            return;
        }

        int rewardId = Integer.parseInt(rewardIdStr);
        int discountPercent = 0;
        String code = "";
        int score = 0;

        // Determine discount percent based on reward ID
        switch (rewardId) {
            case 1:
                discountPercent = 30;
                code = "GIAM30%";
                score = 2000;
                break;
            case 2:
                discountPercent = 50;
                code = "GIAM50%";
                score = 3000;
                break;
            case 3:
                discountPercent = 70;
                code = "GIAM70%";
                score = 4000;
                break;
            default:
                sendErrorResponse(response, "Invalid reward ID.");
                return;
        }

        // Set validFrom to the current date
        Date validFrom = Date.valueOf(LocalDate.now());

        // Set validTo to 1/1/2025
        Date validTo = Date.valueOf(LocalDate.of(2025, 1, 1));

        // Define other discount attributes
        int usageLimit = 1; // Example usage limit
        double discountConditionInput = 100000.00; // Example condition, modify as needed

        // Create JSON response object
        JSONObject jsonResponse = new JSONObject();

        if (user.getUserScore() >= score) {
            // Create Discount object
            Discount discount = new Discount(code, user.getUserId(), 0, discountPercent, validFrom, validTo, usageLimit, discountConditionInput);

            try {
                // Deduct user score
                udb.updateScoreByEmail(user.getUserEmail(), user.getUserScore() - score);

                // Add the discount to the database
                sdb.addNewDiscount(discount);

                jsonResponse.put("success", true);
                jsonResponse.put("discount", discountPercent + "%");
            } catch (Exception e) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to add discount: " + e.getMessage());
            }
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Insufficient score.");
        }

        // Send response
        response.getWriter().write(jsonResponse.toString());
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", false);
        jsonResponse.put("message", message);
        response.getWriter().write(jsonResponse.toString());
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
