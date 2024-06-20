/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.Normalizer;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import model.DAO.Group_DB;
import model.DAO.User_DB;

import model.Group;
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet User_search</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_search at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        String query = request.getParameter("query"); // Lấy query từ yêu cầu HTTP

        if (query == null || query.trim().isEmpty()) {
            query = (String) session.getAttribute("query"); // Nếu không có query trong request, lấy từ session
            if (query == null || query.trim().isEmpty()) {
                query = "";
            }
        }

        User userPersonal = (User) session.getAttribute("USER");
        if (userPersonal == null) {
            // Chuyển hướng đến trang đăng nhập nếu người dùng chưa đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = userPersonal.getUserId();

        System.out.println("Original query: " + query);
        String lowercaseQuery = removeDiacritics(query.toLowerCase());
        System.out.println("Processed query: " + lowercaseQuery);

        List<User> allUsers = User_DB.getAllUsers(); // Giả sử phương thức này được thực hiện
        List<Group> allGroups = Group_DB.getAllGroups(); // Giả sử phương thức này được thực hiện

        List<User> filteredUsers = allUsers.stream()
                .filter(user -> removeDiacritics(user.getUserFullName().toLowerCase()).contains(lowercaseQuery))
                .collect(Collectors.toList());

        List<Group> filteredGroups = allGroups.stream()
                .filter(group -> removeDiacritics(group.getGroupName().toLowerCase()).contains(lowercaseQuery) && !"inactive".equalsIgnoreCase(group.getStatus()))
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
                user.setIsPending(requestStatus.equals("pending"));
                user.setIsApproved(requestStatus.equals("accepted"));
                user.setIsCancelled(requestStatus.equals("cancelled"));
                user.setIsPendingRq(User_DB.hasFriendRequestFromUser(userId, user.getUsername()));
            }
        }

        session.setAttribute("query", query); // Lưu query vào session
        session.setAttribute("filteredUsers", filteredUsers);
        session.setAttribute("filteredGroups", filteredGroups);

        request.getRequestDispatcher("/user/searchResult.jsp").forward(request, response);

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

        HttpSession session = request.getSession();
        String query = request.getParameter("query"); // Lấy query từ yêu cầu HTTP

        if (query == null || query.trim().isEmpty()) {
            query = (String) session.getAttribute("query"); // Nếu không có query trong request, lấy từ session
            if (query == null || query.trim().isEmpty()) {
                query = "";
            }
        }

        User userPersonal = (User) session.getAttribute("USER");
        if (userPersonal == null) {
            // Chuyển hướng đến trang đăng nhập nếu người dùng chưa đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = userPersonal.getUserId();

        System.out.println("Original query: " + query);
        String lowercaseQuery = removeDiacritics(query.toLowerCase());
        System.out.println("Processed query: " + lowercaseQuery);

        List<User> allUsers = User_DB.getAllUsers(); // Giả sử phương thức này được thực hiện
        List<Group> allGroups = Group_DB.getAllGroups(); // Giả sử phương thức này được thực hiện

        List<User> filteredUsers = allUsers.stream()
                .filter(user -> removeDiacritics(user.getUserFullName().toLowerCase()).contains(lowercaseQuery))
                .collect(Collectors.toList());

        List<Group> filteredGroups = allGroups.stream()
                .filter(group -> removeDiacritics(group.getGroupName().toLowerCase()).contains(lowercaseQuery) && !"inactive".equalsIgnoreCase(group.getStatus()))
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
                user.setIsPending(requestStatus.equals("pending"));
                user.setIsApproved(requestStatus.equals("accepted"));
                user.setIsCancelled(requestStatus.equals("cancelled"));
                user.setIsPendingRq(User_DB.hasFriendRequestFromUser(userId, user.getUsername()));
            }
        }

        session.setAttribute("query", query); // Lưu query vào session
        session.setAttribute("filteredUsers", filteredUsers);
        session.setAttribute("filteredGroups", filteredGroups);

        request.getRequestDispatcher("/user/searchResult.jsp").forward(request, response);
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
