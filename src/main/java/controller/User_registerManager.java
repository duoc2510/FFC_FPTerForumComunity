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
import jakarta.servlet.http.HttpSession;
import model.DAO.User_DB;
import model.ManagerRegistr;
import model.User;

/**
 *
 * @author PC
 */
public class User_registerManager extends HttpServlet {

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
            out.println("<title>Servlet User_registerManager</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_registerManager at " + request.getContextPath() + "</h1>");
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
    // Get parameters from the request
    HttpSession session = request.getSession(); 
    int userId = Integer.parseInt(request.getParameter("userId"));
    String contributions = request.getParameter("contributions");

    // Validate the input
    User currentUser = (User) session.getAttribute("USER");
  
    
    // Check if the user already has a pending registration
    boolean isRegister = User_DB.isManagerPending(currentUser.getUserId());
    if (isRegister) {
        session.setAttribute("msg", "Bạn đã đăng ký rồi, hãy đợi duyệt.");
    } else {
        // Process the registration (you need to implement the actual registration logic)
        ManagerRegistr managerRegistr = new ManagerRegistr(userId, contributions);
        boolean registrationSuccess = User_DB.registrManager(managerRegistr);
        
        if (registrationSuccess) {
            session.setAttribute("msg", "Đăng ký successfully!");
        } else {
            session.setAttribute("msg", "Đăng ký thất bại. Vui lòng thử lại.");
        }
    }
    
    // Redirect back to the referring page
    response.sendRedirect(request.getHeader("Referer"));
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
