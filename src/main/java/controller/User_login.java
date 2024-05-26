/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAO.User_DB;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
public class User_login extends HttpServlet {

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
            out.println("<title>Servlet User_login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_login at " + request.getContextPath() + "</h1>");
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
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
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
        String identify = request.getParameter("identify");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        User user = User.login(identify, password);
        User userInfo = User_DB.getUserByEmailorUsername(identify);
        if (user != null) {
            int userRole = user.getUserRole();
            String role = null;
            String message = null;
            switch (userRole) {
                case 0:
                    message = "Your account has been banned.";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
                    return;
                case 1:
                    role = "USER";
                    message = "Welcome, User!";
                    break;
                case 2:
                    role = "MANAGER";
                    message = "Welcome, Manager!";
                    break;
                case 3:
                    role = "HOST GROUP";
                    message = "Welcome, User!";
                    break;
                case 4:
                    role = "ADMIN";
                    message = "Welcome, Admin!";
                    break;
            }
            request.getSession().setAttribute("USER", user);
            request.getSession().setAttribute("ROLE", role);
            request.setAttribute("roleMessage", message);
            request.setAttribute("userInfo", userInfo);
            if ("true".equals(rememberMe)) {
                Cookie identifyCookie = new Cookie("identify", identify);
                Cookie passwordCookie = new Cookie("password", password);
                Cookie rememberMeCookie = new Cookie("rememberMe", "true");
                int cookieMaxAge = 7 * 24 * 60 * 60; // 7 days in seconds
                identifyCookie.setMaxAge(cookieMaxAge);
                passwordCookie.setMaxAge(cookieMaxAge);
                rememberMeCookie.setMaxAge(cookieMaxAge);
                response.addCookie(identifyCookie);
                response.addCookie(passwordCookie);
                response.addCookie(rememberMeCookie);
            } else {
                Cookie identifyCookie = new Cookie("identify", "");
                Cookie passwordCookie = new Cookie("password", "");
                Cookie rememberMeCookie = new Cookie("rememberMe", "");
                identifyCookie.setMaxAge(0); // Xóa cookie
                passwordCookie.setMaxAge(0); // Xóa cookie
                rememberMeCookie.setMaxAge(0); // Xóa cookie
                response.addCookie(identifyCookie);
                response.addCookie(passwordCookie);
                response.addCookie(rememberMeCookie);
            }

            // Lấy đường dẫn trước đó từ session và xoá nó sau khi đã sử dụng
            String redirectURL = (String) request.getSession().getAttribute("redirectURL");
            if (redirectURL != null && !redirectURL.isEmpty()) {
                request.getSession().removeAttribute("redirectURL");
                response.sendRedirect(response.encodeRedirectURL(redirectURL));
            } else {
                response.sendRedirect(response.encodeRedirectURL("home"));
            }
        } else {
            String msg = "Invalid email or password";
            request.setAttribute("message", msg);
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
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
