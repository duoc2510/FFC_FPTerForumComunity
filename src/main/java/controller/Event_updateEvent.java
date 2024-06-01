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
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.DAO.Event_DB;
import model.Event;
import model.Upload;

/**
 *
 * @author Admin
 */
public class Event_updateEvent extends HttpServlet {

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
            out.println("<title>Servlet Event_updateEvent</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Event_updateEvent at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startDateString = request.getParameter("start_date");
        String endDateString = request.getParameter("end_date");
        String location = request.getParameter("location");
        String uploadPath = request.getParameter("upload_path");

        // Debug: In tất cả các tham số
        System.out.println("Title: " + title);
        System.out.println("Description: " + description);
        System.out.println("Start Date: " + startDateString);
        System.out.println("End Date: " + endDateString);
        System.out.println("Location: " + location);
        System.out.println("Upload Path: " + uploadPath);

        Timestamp startDate = null;
        Timestamp endDate = null;

        // Sử dụng DateTimeFormatter để định dạng lại chuỗi datetime-local thành định dạng Timestamp yêu cầu
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        if (startDateString != null && !startDateString.isEmpty()) {
            LocalDateTime localDateTime = LocalDateTime.parse(startDateString, formatter);
            startDate = Timestamp.valueOf(localDateTime);
        }

        if (endDateString != null && !endDateString.isEmpty()) {
            LocalDateTime localDateTime = LocalDateTime.parse(endDateString, formatter);
            endDate = Timestamp.valueOf(localDateTime);
        }
        Event event = new Event(1, title, description, startDate, endDate, 0, location, null); // UserId và CreatedAt sẽ được cập nhật trong DB
        Upload upload = new Upload(1, uploadPath);

        boolean success = Event_DB.updateEvent(event, upload);

        if (success) {
            request.setAttribute("message", "Event updated successfully!");
        } else {
            request.setAttribute("message", "Error updating event.");
        }
        request.getRequestDispatcher("/event/index.jsp").forward(request, response);
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
