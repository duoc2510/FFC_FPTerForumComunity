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
import model.DAO.User_DB;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)

public class User_profileSetting extends HttpServlet {

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
            out.println("<title>Servlet User_profileSetting</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_profileSetting at " + request.getContextPath() + "</h1>");
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
        User user = (User) request.getSession().getAttribute("USER");
        String userEmail = user.getUserEmail();
        User userInfo = User_DB.getUserByEmailorUsername(userEmail);
        request.getSession().setAttribute("USER", userInfo);
        // Đặt danh sách người dùng vào thuộc tính của request
        request.setAttribute("userInfo", userInfo);
        // Chuyển hướng sang trang jsp để hiển thị thông tin người dùng32
        request.getRequestDispatcher("/user/settings.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Kiểm tra xem người dùng đã đăng nhập chưa
        User user = (User) request.getSession().getAttribute("USER");
        if (user != null) {
            // Lấy thông tin từ form
            String email = user.getUserEmail();
            String fullName = request.getParameter("fullName");
            String gender = request.getParameter("gender");
            String story = request.getParameter("story");

            // Sử dụng lại avatar cũ mặc định
            String avatar = request.getParameter("oldAvatar");

            // Xử lý tải ảnh lên nếu có
            Part filePart = request.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0) {
                // Xử lý tải ảnh lên
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

                File uploadDir = new File(uploadFilePath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String fileName = getFileName(filePart);
                filePart.write(uploadFilePath + File.separator + fileName);

                // Cập nhật đường dẫn avatar
                avatar = UPLOAD_DIR + "/" + fileName;
            }

            // Cập nhật thông tin người dùng trong cơ sở dữ liệu
            boolean updateSuccess = User_DB.updateUserByEmail(email, fullName, gender, avatar, story);
            if (updateSuccess) {
                request.setAttribute("message", "Thông tin cá nhân đã được cập nhật.");
            } else {
                request.setAttribute("message", "Cập nhật thông tin cá nhân thất bại.");
            }

            // Lấy lại thông tin người dùng sau khi cập nhật
            User updatedUser = User_DB.getUserByEmailorUsername(email);
            request.getSession().setAttribute("USER", updatedUser);
            request.setAttribute("userInfo", updatedUser);
            request.getRequestDispatcher("/user/settings.jsp").forward(request, response);
        } else {
            // Nếu người dùng chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login");
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
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
