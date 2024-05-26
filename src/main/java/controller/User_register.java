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
import java.util.ArrayList;
import java.util.Random;
import model.DAO.User_DB;
import model.User;
import util.Email;
import static util.Email.sendEmail;

/**
 *
 * @author ThanhDuoc
 */
public class User_register extends HttpServlet {

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
            out.println("<title>Servlet User_register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_register at " + request.getContextPath() + "</h1>");
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
        // Kiểm tra xem người dùng đã đăng nhập hay chưa
        if (request.getSession().getAttribute("USER") != null) {
            // Nếu đã đăng nhập, chuyển hướng đến trang chính
            response.sendRedirect(response.encodeRedirectURL("home"));
        } else {
            // Nếu chưa đăng nhập, hiển thị trang đăng nhập
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("userEmail");
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("rePassword");
        User_DB userDB = new User_DB();
        ArrayList<User> userlist = userDB.getAllUsers();
        boolean checkMail = true;
        boolean checkUsername = true;
        for (User us : userlist) {
            if (us.getUserEmail().equals(email)) {
                checkMail = false;
                break;
            }
        }
        for (User us : userlist) {
            if (us.getUsername().equals(userName)) {
                checkUsername = false;
                break;
            }
        }
        String msg;
        if (!password.equals(confirmPassword)) {
            msg = "Mật khẩu xác nhận không khớp.";
            request.setAttribute("message", msg);
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        } else {
            if (!checkMail && checkUsername) {
                msg = "Email này đã tồn tại.";
                request.setAttribute("message", msg);
                request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            }
            if (checkMail && !checkUsername) {
                msg = "Tên người dùng đã tồn tại.";
                request.setAttribute("message", msg);
                request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            }
            if (!checkMail && !checkUsername) {
                msg = "Email và Tên người dùng đã tồn tại.";
                request.setAttribute("message", msg);
                request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            }
            if (checkMail && checkUsername) {
                int x = new Random().nextInt(90000) + 10000;
                Email.sendEmail(email, x);
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
