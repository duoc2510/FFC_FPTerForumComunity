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
import java.util.List;
import model.Ads;
import model.Ads_combo;
import model.DAO.Ads_DB;
import model.User;

/**
 *
 * @author mac
 */
public class Advertising_Campaign_Detail extends HttpServlet {

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
            out.println("<title>Servlet Advertising_Campaign_Detail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Advertising_Campaign_Detail at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false);

        String idComboParam = request.getParameter("id");
        int idCombo = 0; // default value or you can handle it differently

        if (idComboParam != null) {
            try {
                idCombo = Integer.parseInt(idComboParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                // Handle the exception, e.g., set an error message or set a default value
            }
        }

        // Check if the user is logged in
        if (session != null && session.getAttribute("USER") != null) {
            // Set the response content type and forward the request to the JSP page
            User currentUser = (User) session.getAttribute("USER");

            // Get the list of all ads combo
            Ads_DB ads_DB = new Ads_DB();
            
//            List<Ads_combo> allAdsCombo = ads_DB.getAllAdsComboSystem();

            // Set the list of ads combo as an attribute in the request
//            request.setAttribute("allAdsCombo", allAdsCombo);

            request.setAttribute("AdsComboID", idCombo);
            List<Ads_combo> comboInformation = ads_DB.getComboByID(idCombo);
            request.setAttribute("comboInformation", comboInformation);

            List<Ads> allAdsUserInCombo = ads_DB.getAllAdsUserInComboID(currentUser.getUserId(), idCombo);

            // Set the list of ads combo as an attribute in the request
            request.setAttribute("allAdsUserInCombo", allAdsUserInCombo);

            // Forward the request to the JSP page
            response.setContentType("text/html;charset=UTF-8");
            request.getRequestDispatcher("/advertising/campaignDetailAds.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp"); // Redirect to login page if not logged in
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
        processRequest(request, response);
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
