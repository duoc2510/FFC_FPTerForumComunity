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
import model.DAO.User_DB;
import model.User;

/**
 *
 * @author PC
 */
public class User_friendHandel extends HttpServlet {

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
            out.println("<title>Servlet User_friendHandel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_friendHandel at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);

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
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("USER");
        int userId = user.getUserId();
        int friendId = Integer.parseInt(request.getParameter("friendId"));
        String friendName = request.getParameter("friendName");
        boolean success = false;
        String redirectUrl = "";

        switch (action) {
            case "add":
                success = User_DB.addFriendRequest(userId, friendId);
                redirectUrl = request.getContextPath() + "/profile?username=" + friendName;
                break;
            case "unfriendProfile":
                success = User_DB.unFriend(userId, friendId);

                redirectUrl = request.getContextPath() + "/profile?username=" + friendName;
                break;
            case "unfriend":
                success = User_DB.unFriend(userId, friendId);

                redirectUrl = request.getContextPath() + "/friends";
                break;
            case "cancel":
                success = User_DB.cancelFriendRequest(userId, friendId);
                redirectUrl = request.getContextPath() + "/profile?username=" + friendName;
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                return;
        }

        if (success) {
        {
            response.sendRedirect(redirectUrl); // Điều hướng đến trang thành công hoặc trang viewProfile
        }
    } else {
       request.getRequestDispatcher("/user/error.jsp").forward(request, response); // Điều hướng đến trang lỗi
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
