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
import java.sql.Timestamp;
import model.DAO.Event_DB;
import model.Upload;
import model.User;
import model.User_event;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)

/**
 *
 * @author Admin
 */
public class Advertising_boost extends HttpServlet {

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
            out.println("<title>Servlet Advertising_boost</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Advertising_boost at " + request.getContextPath() + "</h1>");
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
                request.getRequestDispatcher("/advertising/boost.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String UPLOAD_DIR = "Advertising_Upload";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           String title = request.getParameter("title");
        String description = request.getParameter("description");
        Timestamp startDate = Timestamp.valueOf(request.getParameter("start_date"));
        Timestamp endDate = Timestamp.valueOf(request.getParameter("end_date"));

        int userId = ((User) request.getSession().getAttribute("USER")).getUserId(); // Thay đổi từ "userID" sang "USER" và sử dụng phương thức getUserId()

        Part filePart = request.getPart("upload_path");
//        String fileName = extractFileName(filePart);

        // Tạo thư mục lưu trữ nếu chưa tồn tại
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        File uploadFolder = new File(uploadFilePath);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

//        String savePath = uploadFilePath + File.separator + fileName;
//        filePart.write(savePath);

        // Đường dẫn lưu trong cơ sở dữ liệu
//        String filePathForDatabase = UPLOAD_DIR + File.separator + fileName;

        User_event event = new User_event(0, title, description, startDate, endDate, userId);
//        Upload upload = new Upload(0, 0, 0, 0, filePathForDatabase); // Thay đổi savePath thành filePathForDatabase

        Event_DB eventDB = new Event_DB();
//        if (eventDB.addEvent(event, upload)) {
//            request.setAttribute("message", "Event added successfully!");
//        } else {
//            request.setAttribute("message", "Error adding event.");
//        }
        request.getRequestDispatcher("/advertising/boost.jsp").forward(request, response);

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
