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
import java.util.HashMap;
import java.util.Map;
import model.Ads;
import model.DAO.Ads_DB;
import static model.DAO.DBinfo.dbPass;
import model.DAO.User_DB;
import model.User;

/**
 *
 * @author mac
 */
public class Advertising_Show extends HttpServlet {

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
            out.println("<title>Servlet Advertising_Show</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Advertising_Show at " + request.getContextPath() + "</h1>");
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
        String comboType = request.getParameter("comboType");
        String targetSex = request.getParameter("targetSex");

        Ads_DB adsDB = new Ads_DB();
        Ads ad = adsDB.getRandomAdWithHighestRate(comboType, targetSex);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (ad != null) {
            User_DB userDB = new User_DB();
            User adUser = userDB.getUserById(ad.getUserId());

            // Combine ad and user details
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("ad", ad);
            responseData.put("user", adUser);

            Gson gson = new Gson();
            String jsonResponse = gson.toJson(responseData);
            response.getWriter().write(jsonResponse);
        } else {
            response.getWriter().write("{\"message\": \"No ad found matching the criteria.\"}");
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
