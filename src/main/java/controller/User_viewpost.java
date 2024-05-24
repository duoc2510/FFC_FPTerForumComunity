///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package controller;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.util.List;
//import java.util.logging.Logger;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import model.DAO.Post_DB;
//import model.DAO.User_DB;
//import model.Post;
//import model.User;
//
///**
// *
// * @author Admin
// */
//public class User_viewpost extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet viewPost</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet viewPost at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("USER");
//
//        if (user == null) {
//            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?errorMessage=You must be logged in to view posts");
//            return;
//        }
//
//        String userEmail = user.getUserEmail();
//        User userInfo = User_DB.getUserByEmailorUsername(userEmail);
//
//        if (userInfo == null) {
//            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?errorMessage=You must be logged in to view posts");
//            return;
//        }
//
//        String username = user.getUsername();
//        List<Post> posts = Post_DB.getPostsByUsername(username);
//
//        request.setAttribute("userInfo", userInfo);
//        request.setAttribute("posts", posts);
//        request.getRequestDispatcher("/user/viewPost.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        doGet(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
