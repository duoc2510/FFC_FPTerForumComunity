/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import model.DAO.User_DB;
import model.User;

/**
 *
 * @author PC
 */
public class User_SearchSuggestion extends HttpServlet {

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
            out.println("<title>Servlet User_SearchSuggestion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_SearchSuggestion at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
         request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
        User userPersonal = (User) session.getAttribute("USER");
        if (userPersonal == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String query = request.getParameter("query");
        if (query == null || query.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String lowercaseQuery = removeDiacritics(query.toLowerCase());

        List<User> allUsers = User_DB.getAllUsers();

        List<User> filteredUsers = allUsers.stream()
                .filter(user -> removeDiacritics(user.getUserFullName().toLowerCase()).contains(lowercaseQuery))
                .collect(Collectors.toList());

       List<User> uniqueFilteredUsers = new ArrayList<>();
    Set<String> userFullNames = new HashSet<>();

        for (User user : filteredUsers) {
        if (userFullNames.add(user.getUserFullName())) {
            User userInfo = new User(user.getUsername(), user.getUserFullName());
            uniqueFilteredUsers.add(userInfo);
        }
    }

        String jsonResponse = new Gson().toJson(uniqueFilteredUsers);
        System.out.println("JSON Response: " + jsonResponse); // Log dữ liệu trả về
        response.getWriter().write(jsonResponse);
    }

    public static String removeDiacritics(String s) {
        String normalized = Normalizer.normalize(s, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(normalized).replaceAll("");
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
