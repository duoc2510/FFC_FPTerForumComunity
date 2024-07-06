/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletRequest;
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
import model.DAO.Group_DB;
import model.DAO.Shop_DB;
import model.DAO.User_DB;

import model.Group;
import model.Product;
import model.Shop;
import model.User;

/**
 *
 * @author PC
 */
public class User_search extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String query = request.getParameter("query");

        if (query == null || query.trim().isEmpty()) {
            query = (String) session.getAttribute("query");
            if (query == null || query.trim().isEmpty()) {
                query = "";
            }
        }

        User userPersonal = (User) session.getAttribute("USER");
        if (userPersonal == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = userPersonal.getUserId();

        String lowercaseQuery = removeDiacritics(query.toLowerCase());

        List<User> allUsers = User_DB.getAllUsers();
        List<Group> allGroups = Group_DB.getAllGroups();
        List<Shop> allShops = Shop_DB.getAllShop();
        List<Product> allProducts = Shop_DB.getAllProduct();

        List<User> filteredUsers = allUsers.stream()
                .filter(user -> removeDiacritics(user.getUserFullName().toLowerCase()).contains(lowercaseQuery))
                .collect(Collectors.toList());

        List<User> filteredUsername = allUsers.stream()
                .filter(user -> removeDiacritics(user.getUsername().toLowerCase()).contains(lowercaseQuery))
                .collect(Collectors.toList());

        List<Group> filteredGroups = allGroups.stream()
                .filter(group -> removeDiacritics(group.getGroupName().toLowerCase()).contains(lowercaseQuery) && !"inactive".equalsIgnoreCase(group.getStatus()))
                .collect(Collectors.toList());

        List<Shop> filteredShops = allShops.stream()
                .filter(shop -> removeDiacritics(shop.getName().toLowerCase()).contains(lowercaseQuery) && shop.getStatus() == 1)
                .collect(Collectors.toList());
        List<Product> filteredProducts = allProducts.stream()
                .filter(product -> removeDiacritics(product.getName().toLowerCase()).contains(lowercaseQuery))
                .collect(Collectors.toList());

        for (Group group : filteredGroups) {
            boolean isPending = Group_DB.isUserPendingApproval(userId, group.getGroupId());
            boolean isBanned = Group_DB.isUserBan(userId, group.getGroupId());
            boolean isApproved = Group_DB.isUserApproved(userId, group.getGroupId());
            group.setPending(isPending);
            group.setIsBanned(isBanned);
            group.setIsApproved(isApproved);
        }

        for (User user : filteredUsers) {
            String requestStatus = User_DB.getFriendRequestStatus(userId, user.getUsername());
            if (requestStatus != null) {
                user.setIsPending(requestStatus.equals("sent"));
                user.setIsApproved(requestStatus.equals("accepted"));
                user.setIsCancelled(requestStatus.equals("cancelled"));
                user.setIsPendingRq(requestStatus.equals("received"));
            }
        }

        for (User user : filteredUsername) {
            String requestStatus = User_DB.getFriendRequestStatus(userId, user.getUsername());
            if (requestStatus != null) {
                user.setIsPending(requestStatus.equals("sent"));
                user.setIsApproved(requestStatus.equals("accepted"));
                user.setIsCancelled(requestStatus.equals("cancelled"));
                user.setIsPendingRq(requestStatus.equals("received"));
            }
        }

        Set<String> userFullNames = new HashSet<>();
        List<User> uniqueFilteredUsers = new ArrayList<>();

        for (User user : filteredUsers) {
            if (userFullNames.add(user.getUserFullName())) {
                uniqueFilteredUsers.add(user);
            }
        }

        for (User user : filteredUsername) {
            if (userFullNames.add(user.getUserFullName())) {
                uniqueFilteredUsers.add(user);
            }
        }

        session.setAttribute("query", query);
        session.setAttribute("filteredProducts", filteredProducts);
        session.setAttribute("filteredShops", filteredShops);
        session.setAttribute("filteredUsers", uniqueFilteredUsers);
        session.setAttribute("filteredGroups", filteredGroups);

        request.getRequestDispatcher("/user/searchResult.jsp").forward(request, response);
    }

    public static String removeDiacritics(String s) {
        String normalized = Normalizer.normalize(s, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(normalized).replaceAll("");
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
