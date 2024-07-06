/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
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
import model.DAO.User_DB;
import model.User;

/**
 *
 * @author mac
 */
public class Advertising_Library extends HttpServlet {

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
            out.println("<title>Servlet Advertising_Library</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Advertising_Library at " + request.getContextPath() + "</h1>");
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

        if (session != null && session.getAttribute("USER") != null) {
            User currentUser = (User) session.getAttribute("USER");

            Ads_DB adsDB = new Ads_DB();
            List<Ads> allAds = adsDB.getAllAds();
            List<Ads_combo> allComboAds = adsDB.getAllComboAds();

            Map<Integer, Ads_combo> comboAdsMap = new HashMap<>();
            for (Ads_combo combo : allComboAds) {
                comboAdsMap.put(combo.getAdsDetailId(), combo);
            }

            Map<Ads, Ads_combo> adsWithComboData = new HashMap<>();
            for (Ads ad : allAds) {
                Ads_combo combo = comboAdsMap.get(ad.getAdsDetailId());
                adsWithComboData.put(ad, combo);
            }

            Map<Integer, User> adUserMap = new HashMap<>();
            for (Ads ad : allAds) {
                User adUser = User_DB.getUserById(ad.getUserId());
                adUserMap.put(ad.getAdsDetailId(), adUser);
            }
            response.setContentType("text/html;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");

            Gson gson = new Gson();
            String adsWithComboDataJson = gson.toJson(adsWithComboData);
            String adUserMapJson = gson.toJson(adUserMap);

            // Set the maps of ads with combo data and user data as attributes in the request
            request.setAttribute("adsWithComboDataJson", adsWithComboDataJson); // Make sure this variable is defined in your servlet
            request.setAttribute("adUserMapJson", adUserMapJson); // Make sure this variable is defined in your servlet

            request.getRequestDispatcher("/advertising/libraryAds.jsp").forward(request, response);

        } else {
            response.sendRedirect("/login");
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
