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
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAO.Shop_DB;
import model.DAO.User_DB;
import model.Order;
import model.User;

/**
 *
 * @author Admin
 */
public class User_emailVerify extends HttpServlet {

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
            out.println("<title>Servlet User_VerifyEmail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_VerifyEmail at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/auth/verifyemail.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        String status = request.getParameter("status");
        String email = request.getParameter("email");
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String x = request.getParameter("x");
        String number = request.getParameter("number");
        User_DB userDB = new User_DB();
        Shop_DB sdb = new Shop_DB();
        HttpSession session = request.getSession();

        String msg;
        if (status.equals("lostaccount")) {
            if (Integer.parseInt(x) == Integer.parseInt(number)) {
                request.setAttribute("email", email);
                request.getRequestDispatcher("/auth/newpass.jsp").forward(request, response);
            } else {
                msg = "Verify Code Is Wrong!";
                request.setAttribute("message", msg);
                request.setAttribute("x", x);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/auth/verifyemail.jsp").forward(request, response);
            }
        } else {
            if (Integer.parseInt(x) == Integer.parseInt(number)) {
                // Passwords match, proceed to add new staff
                User newUser = new User(email, password, userName);
                try {
                    userDB.addUser(newUser);
                } catch (ParseException ex) {
                    Logger.getLogger(User_emailVerify.class.getName()).log(Level.SEVERE, null, ex);
                }
                User u = userDB.getUserByEmailorUsername(newUser.getUserEmail());
                Order o = new Order(u.getUserId(), 1, null, "null", 0, null, null, 5, null, null);
                sdb.addOrder(o);
                msg = "Registration Success";
//                request.setAttribute("message", msg);
                session.setAttribute("message", msg);
//                request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
                response.sendRedirect("logingooglehandler?value=login");
            } else {
                msg = "Verify Code Is Wrong!";
                request.setAttribute("message", msg);
                request.setAttribute("x", x);
                request.setAttribute("userName", userName);
                request.setAttribute("email", email);
                request.setAttribute("password", password);
                request.getRequestDispatcher("/auth/verifyemail.jsp").forward(request, response);
            }
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
