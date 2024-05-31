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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import model.Comment;
import model.DAO.Comment_DB;
import model.DAO.Post_DB;
import model.DAO.User_DB;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
public class Post_comment extends HttpServlet {

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
            out.println("<title>Servlet Post_comment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Post_comment at " + request.getContextPath() + "</h1>");
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String referer = request.getHeader("referer");

        if (null != action) {
            switch (action) {
                case "addComment": {
                    // Thêm comment
                    int postId = Integer.parseInt(request.getParameter("postId"));
                    HttpSession session = request.getSession(false);
                    if (session != null && session.getAttribute("USER") != null) {
                        User user = (User) session.getAttribute("USER");
                        int userId = user.getUserId(); // Lấy userId từ session

                        String content = request.getParameter("content");

                        boolean success = Comment_DB.addCommentToPost(postId, userId, content);

                        if (success) {
                            User_DB.updateScore(userId);
                            // Nếu thành công, chuyển hướng đến trang trước đó
                            response.sendRedirect(referer);
                        } else {
                            // Nếu thất bại, gửi mã lỗi 500
                            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add comment.");
                        }
                    } else {
                        // Nếu không có session hoặc USER không tồn tại trong session, chuyển hướng đến trang login
                        response.sendRedirect("login");
                    }
                    break;
                }
                case "deleteComment": {
                    // Xóa comment
                    int commentId = Integer.parseInt(request.getParameter("commentId"));
                    HttpSession session = request.getSession(false);
                    if (session != null && session.getAttribute("USER") != null) {
                        User user = (User) session.getAttribute("USER");
                        int userId = user.getUserId(); // Lấy userId từ session

                        boolean success = Comment_DB.deleteCommentById(commentId, userId);

                        if (success) {
                            // Nếu thành công, chuyển hướng đến trang trước đó
                            response.sendRedirect(referer);
                        } else {
                            // Nếu thất bại, gửi mã lỗi 500
                            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete comment.");
                        }
                    } else {
                        // Nếu không có session hoặc USER không tồn tại trong session, chuyển hướng đến trang login
                        response.sendRedirect("login");
                    }
                    break;
                }
                case "editComment": {
                    // Sửa comment
                    int commentId = Integer.parseInt(request.getParameter("commentId"));
                    String newContent = request.getParameter("newContent");
                    boolean success = Comment_DB.editComment(commentId, newContent);
                    if (success) {
                        // Nếu thành công, chuyển hướng đến trang trước đó
                        response.sendRedirect(referer);
                    } else {
                        // Nếu thất bại, gửi mã lỗi 500
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to edit comment.");
                    }
                    break;
                }
                default:
                    break;
            }
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
