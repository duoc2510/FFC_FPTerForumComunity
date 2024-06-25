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
import model.Ads_combo;
import model.DAO.Ads_DB;
import model.User;

/**
 *
 * @author mac
 */
public class Advertising_Campaign extends HttpServlet {

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
            out.println("<title>Servlet Advertising_Campaign</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Advertising_Campaign at " + request.getContextPath() + "</h1>");
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
        // Check if the user is logged in
        if (session != null && session.getAttribute("USER") != null) {
            // Retrieve the current user from the session
            User currentUser = (User) session.getAttribute("USER");

            // Get the list of all ads combo
            Ads_DB ads_DB = new Ads_DB();
            List<Ads_combo> allAdsCombo = ads_DB.getAllAdsComboByUserID(currentUser.getUserId());

            // Set the list of ads combo as an attribute in the request
            request.setAttribute("allAdsCombo", allAdsCombo);

            // Forward the request to the JSP page
            request.getRequestDispatcher("/advertising/campaignAds.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user from session
        User user = (User) request.getSession().getAttribute("USER");
        try {
            // Retrieve parameters from the form
            String title = request.getParameter("title");
            int budget = Integer.parseInt(request.getParameter("budget"));
            int maxView = Integer.parseInt(request.getParameter("maxView"));
            int durationDay = Integer.parseInt(request.getParameter("durationDay"));

            // Create Ads_combo object and populate it
            Ads_combo ads_combo = new Ads_combo();
            ads_combo.setTitle(title);
            ads_combo.setBudget(budget);
            ads_combo.setMaxView(maxView);
            ads_combo.setDurationDay(durationDay);
            ads_combo.setUser_id(user.getUserId());

            // Call Ads_DB method to create campaign
            Ads_DB adsDB = new Ads_DB();
            adsDB.createCampaign(ads_combo);

            // Redirect to the advertising page
            response.sendRedirect(request.getContextPath() + "/advertising/campaign");
        } catch (NumberFormatException | NullPointerException e) {
            e.printStackTrace(); // Log the exception for debugging
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameter format or missing parameter.");
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
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
