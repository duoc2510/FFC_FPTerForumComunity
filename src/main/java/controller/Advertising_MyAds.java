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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Ads;
import model.Ads_combo;
import model.DAO.Ads_DB;
import model.User;

/**
 *
 * @author Admin
 */
public class Advertising_MyAds extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the session, do not create a new one if it doesn't exist
        HttpSession session = request.getSession(false);

        // Check if the user is logged in
        if (session != null && session.getAttribute("USER") != null) {
            // Retrieve the current user from the session
            User currentUser = (User) session.getAttribute("USER");
            

            // Fetch the list of ads for the current user
            Ads_DB adsDB = new Ads_DB();
            List<Ads> allAds = adsDB.getAllAdsByUserID(currentUser.getUserId());

            // Fetch all combo data
            List<Ads_combo> allComboAds = adsDB.getAllComboAds();

            // Create a map of Adsdetail_id to ComboAds
            Map<Integer, Ads_combo> comboAdsMap = new HashMap<>();
            for (Ads_combo combo : allComboAds) {
                comboAdsMap.put(combo.getAdsDetailId(), combo);
            }

            // Associate each ad with its combo data
            Map<Ads, Ads_combo> adsWithComboData = new HashMap<>();
            for (Ads ad : allAds) {
                Ads_combo combo = comboAdsMap.get(ad.getAdsDetailId());
                adsWithComboData.put(ad, combo);
            }

            // Set the map of ads with combo data as an attribute in the request
            request.setAttribute("adsWithComboData", adsWithComboData);

            // Set the response content type and forward the request to the JSP page
            response.setContentType("text/html;charset=UTF-8");
            request.getRequestDispatcher("/advertising/index.jsp").forward(request, response);
        } else {
            // If the user is not logged in, redirect to the login page or show an error message
            response.sendRedirect("login.jsp");
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
