/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.SQLException;
import model.DAO.Group_DB;
import model.DAO.User_DB;
import model.Group;
import model.User;

/**
 *
 * @author PC
 */
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
public class User_groupAdd extends HttpServlet {

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
            out.println("<title>Servlet User_groupSetting</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_groupSetting at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/group/groupCreate.jsp").forward(request, response);
        
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String UPLOAD_DIR = "Avatar_of_group";
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String groupName = request.getParameter("groupName");
    String groupDescription = request.getParameter("groupDescription");
    Part filePart = request.getPart("groupAvatar");

    User user = (User) request.getSession().getAttribute("USER");
    int creatorId = user.getUserId();

    // Tạo thư mục lưu trữ nếu chưa tồn tại
    String applicationPath = request.getServletContext().getRealPath("");
    String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
    File uploadFolder = new File(uploadFilePath);
    if (!uploadFolder.exists()) {
        uploadFolder.mkdirs();
    }

    // Lưu tệp vào thư mục đã tạo
    String fileName = filePart.getSubmittedFileName();
    String filePath = uploadFilePath + File.separator + fileName;
    filePart.write(filePath);

    // Đường dẫn lưu trong cơ sở dữ liệu
    String filePathForDatabase = UPLOAD_DIR + "/" + fileName;

    Group group = new Group(creatorId, groupName, groupDescription, filePathForDatabase);

    int groupId = Group_DB.addGroup(group); // Thay đổi kiểu dữ liệu trả về từ boolean sang int

    String message = "";
    if (groupId != -1) { // Kiểm tra nếu ID của nhóm là hợp lệ
        message = "Group created successfully!";
        request.setAttribute("message", message);
        // Chuyển hướng đến trang "inGroup" với ID của nhóm
        response.sendRedirect("inGroup?groupId=" + groupId);
    } else {
        message = "Failed to create group.";
        request.setAttribute("message", message);
        // Đặt thuộc tính message để hiển thị thông báo lỗi
         response.sendRedirect("listGroup");
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
