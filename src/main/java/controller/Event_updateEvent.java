/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import model.DAO.Event_DB;
import model.Event;
import model.Upload;
import model.User;

/**
 *
 * @author Admin
 */
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("text/html;charset=UTF-8");

        User user = (User) request.getSession().getAttribute("USER");
        if (user == null) {
            // Xử lý khi người dùng không được xác định
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int userId = user.getUserId();

        // Debug: Print all parameters
        System.out.println("Received parameters:");
        request.getParameterMap().forEach((key, value) -> System.out.println(key + ": " + Arrays.toString(value)));

        int eventId;
        boolean success = false;
        String message = "";

        if (action != null) {
            eventId = Integer.parseInt(request.getParameter("eventId"));

            if ("editEvent".equals(action)) {
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String startDateString = request.getParameter("startDate");
                String endDateString = request.getParameter("endDate");
                String location = request.getParameter("location");
                String existingUploadPath = request.getParameter("existingUploadPath");

                // Debug: Print all parameters
                System.out.println("Title: " + title);
                System.out.println("Description: " + description);
                System.out.println("Start Date: " + startDateString);
                System.out.println("End Date: " + endDateString);
                System.out.println("Location: " + location);
                System.out.println("Existing Upload Path: " + existingUploadPath);

                // Use DateTimeFormatter to convert datetime-local string to Timestamp
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
                Timestamp startDate = null;
                Timestamp endDate = null;

                if (startDateString != null && !startDateString.isEmpty()) {
                    LocalDateTime localDateTime = LocalDateTime.parse(startDateString, formatter);
                    startDate = Timestamp.valueOf(localDateTime);
                }

                if (endDateString != null && !endDateString.isEmpty()) {
                    LocalDateTime localDateTime = LocalDateTime.parse(endDateString, formatter);
                    endDate = Timestamp.valueOf(localDateTime);
                }

                // Check if a new file is uploaded
                Part filePart = request.getPart("newUploadPath");
                String newUploadPath = null;
                if (filePart != null && filePart.getSize() > 0) {
                    // Handle file upload
                    newUploadPath = handleUpload(request);
                } else {
                    // Use existing upload path if no new file is uploaded
                    newUploadPath = (existingUploadPath != null && !existingUploadPath.isEmpty()) ? existingUploadPath : null;
                }

                // Perform event update
                Event event = new Event(eventId, title, description, startDate, endDate, userId, location, null); // UserId and CreatedAt will be updated in DB
                success = Event_DB.updateEvent(event, newUploadPath); // Use the outer success variable
                message = success ? "Event updated successfully." : "Failed to update event.";
            } else {
                message = "Action is missing.";
            }

            if (success) {
                String referer = request.getHeader("referer");
                response.sendRedirect(referer);
            } else {
                request.setAttribute("message", message);
                response.sendRedirect(request.getContextPath() + "/listEvent");
            }
        }
    }

    private String handleUpload(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("newUploadPath");
        if (filePart != null && filePart.getSize() > 0) {
            // Xử lý file upload
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadDirName = "imPost";
            String uploadFilePath = applicationPath + File.separator + uploadDirName;
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = getFileName(filePart);
            try {
                filePart.write(uploadFilePath + File.separator + fileName);
                return uploadDirName + "/" + fileName;
            } catch (IOException e) {
                e.printStackTrace();
                return null;
            }
        } else {
            // Không có file được upload
            return null;
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
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
