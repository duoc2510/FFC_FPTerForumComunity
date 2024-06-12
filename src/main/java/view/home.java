/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package view;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import model.DAO.Post_DB;
import model.DAO.Topic_DB;
import model.DAO.User_DB;
import model.Post;
import model.Topic;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
public class home extends HttpServlet {

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
            out.println("<title>Servlet home</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet home at " + request.getContextPath() + "</h1>");
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

        // Fetch the list of topics from the database or any other data source
        List<Topic> topics = Topic_DB.getAllTopics();
        // Set the topics as a request attribute
        request.setAttribute("topics", topics);

        // Assuming 'user' is the attribute used to store user information in the session or request
        User user = (User) request.getSession().getAttribute("USER");
        if (user != null) {
            String userEmail = user.getUserEmail();
            User userInfo = User_DB.getUserByEmailorUsername(userEmail);
            // Đặt danh sách người dùng vào thuộc tính của request
            request.setAttribute("userInfo", userInfo);
        }
        // Lấy danh sách tất cả các bài viết
        List<Post> posts = Post_DB.getPostsWithUploadPath();

        for (Post post : posts) {
            // Lấy thông tin người đăng cho bài viết
            User author = Post_DB.getUserByPostId(post.getPostId());
            post.setUser(author); // Đặt thông tin người đăng vào thuộc tính user của bài viết
        }

        request.setAttribute("posts", posts);

        // Forward the request to the determined JSP
        request.getRequestDispatcher("index.jsp").forward(request, response);
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
        // Nhận dữ liệu từ form
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        int userId = user.getUserId();
        int topicId = Integer.parseInt(request.getParameter("topicId"));
        String content = request.getParameter("content");

        // Tạo đối tượng Post
        Post post = new Post();
        post.setUserId(userId);
        post.setTopicId(topicId);
        post.setContent(content);

        // Gọi phương thức addPostTopic của DAO
        try {
            Post_DB.addPostTopic(post);
            response.sendRedirect("home"); // Chuyển hướng sau khi thêm bài đăng thành công
        } catch (SQLException e) {
            e.printStackTrace();
            // Xử lý lỗi nếu cần thiết
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
