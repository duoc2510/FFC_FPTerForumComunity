/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAO.Topic_DB;
import model.Topic;

/**
 *
 * @author Admin
 */
public class Topic_deleteTopic extends HttpServlet {

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
            out.println("<title>Servlet Topic_deleteTopic</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Topic_deleteTopic at " + request.getContextPath() + "</h1>");
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
        int topicId = Integer.parseInt(request.getParameter("topicId"));
        boolean success = Topic_DB.deleteTopic(topicId);
        if (success) {
            request.setAttribute("successMessage", "Topic delete successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to delete topic!");
        }
        if (success) {
            request.getRequestDispatcher("/index_admin.jsp").forward(request, response);
        } else {
            // Xử lý khi xóa thất bại, có thể hiển thị thông báo lỗi hoặc thực hiện các hành động khác
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            out.println("<html><head><title>Delete Topic</title></head><body>");
            out.println("<h3>Failed to delete topic</h3>");
            out.println("<p>There was an error while deleting the topic. Please try again later.</p>");
            out.println("</body></html>");
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        int topicId = Integer.parseInt(request.getParameter("topicId"));
        boolean success = Topic_DB.deleteTopic(topicId);

        String message = success ? "Topic deleted successfully!" : "Failed to delete topic.";
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(new Response(success, message));

        PrintWriter out = response.getWriter();
        out.write(jsonResponse);
        out.flush();
        System.out.println("doPost method called. Topic ID: " + topicId);

}

    private static class Response {

    boolean success;
    String message;

    Response(boolean success, String message) {
        this.success = success;
        this.message = message;
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
