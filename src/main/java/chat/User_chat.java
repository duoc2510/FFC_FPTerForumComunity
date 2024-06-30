/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package chat;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import model.DAO.DBinfo;
import model.DAO.User_DB;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
public class User_chat extends HttpServlet {

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
            out.println("<title>Servlet User_chat</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_chat at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển hướng sang trang chat.jsp để hiển thị danh sách bạn bè và khung chat
        RequestDispatcher dispatcher = request.getRequestDispatcher("test.jsp");
        dispatcher.forward(request, response);
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
        // Lấy dữ liệu từ session
        HttpSession session = request.getSession(false); // Không tạo session mới nếu chưa có
        if (session == null || session.getAttribute("USER") == null) {
            // Xử lý khi không có session hoặc người dùng chưa đăng nhập
            response.sendRedirect(request.getContextPath() + "/login"); // Chuyển hướng đến trang đăng nhập
            return;
        }

        // Lấy thông tin người dùng hiện tại từ session
        User currentUser = (User) session.getAttribute("USER");
        int fromId = currentUser.getUserId(); // Lấy ID của người gửi từ session
        String fromUsername = currentUser.getUsername();

        // Lấy toId và messageText từ request
        int toId = Integer.parseInt(request.getParameter("toId"));
        String messageText = request.getParameter("messageText");
        try {
            // Lưu tin nhắn vào cơ sở dữ liệu
            saveMessageToDatabase(fromId, toId, messageText, fromUsername); // Gọi phương thức lưu tin nhắn

            // Chuyển hướng về trang messenger
            response.sendRedirect(request.getContextPath() + "/messenger");
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý khi có lỗi, ví dụ: thông báo lỗi và chuyển hướng về trang trước đó
            response.sendRedirect(request.getHeader("referer"));
        }
    }

    void saveMessageToDatabase(int fromId, int toId, String messageText, String fromUsername) throws Exception {
        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass)) {
            String insertMessageQuery = "INSERT INTO Message (From_id, To_id, MessageText, FromUsername) VALUES (?, ?, ?, ?)";
            try (PreparedStatement insertMessageStmt = conn.prepareStatement(insertMessageQuery)) {
                insertMessageStmt.setInt(1, fromId);
                insertMessageStmt.setInt(2, toId);
                String encryptedMessage = AESUtil.encrypt(messageText);
                insertMessageStmt.setString(3, encryptedMessage);
                insertMessageStmt.setString(4, fromUsername);
                insertMessageStmt.executeUpdate();
            }
            System.out.println("Message saved to database successfully.");
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
