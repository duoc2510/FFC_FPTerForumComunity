/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import model.DAO.Group_DB;
import model.Group;
import model.User;

/**
 *
 * @author PC
 */
public class User_groupList extends HttpServlet {

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
            out.println("<title>Servlet User_group</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_group at " + request.getContextPath() + "</h1>");
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
    User user = (User) request.getSession().getAttribute("USER");
    int userId = user.getUserId();

    // Retrieve all groups and filter out inactive ones
    List<Group> allGroups = Group_DB.getAllGroups();
    List<Group> groups = allGroups.stream()
                                  .filter(group -> !"inactive".equals(group.getStatus()))
                                  .collect(Collectors.toList());

    // Retrieve groups created by the user and filter out inactive ones
    List<Group> allGroupsCreated = Group_DB.getAllGroupsCreated(userId);
    List<Group> groupsCreated = allGroupsCreated.stream()
                                                .filter(group -> !"inactive".equals(group.getStatus()))
                                                .collect(Collectors.toList());

    // Retrieve groups joined by the user and filter out inactive ones
    List<Group> allGroupJoined = Group_DB.getAllGroupJoin(userId);
    List<Group> groupJoined = allGroupJoined.stream()
                                            .filter(group -> !"inactive".equals(group.getStatus()))
                                            .collect(Collectors.toList());

    // Filter out groups that the user has created or joined
    List<Integer> joinedGroupIds = groupJoined.stream()
                                              .map(Group::getGroupId)
                                              .collect(Collectors.toList());
    groups.removeIf(group -> group.getCreaterId() == userId || joinedGroupIds.contains(group.getGroupId()));

    // Check the status of each remaining group
    for (Group group : groups) {
        boolean isPending = Group_DB.isUserPendingApproval(userId, group.getGroupId());
        boolean isBanned = Group_DB.isUserBan(userId, group.getGroupId());
        group.setPending(isPending);
        group.setIsBanned(isBanned);
    }

    // Set attributes to be passed to JSP
    request.setAttribute("groupsJoined", groupJoined);
    request.setAttribute("groups", groups);
    request.setAttribute("groupsCreated", groupsCreated);
    request.getRequestDispatcher("/group/index.jsp").forward(request, response);
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
