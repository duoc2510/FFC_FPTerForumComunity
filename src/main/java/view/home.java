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
import model.Comment;
import model.DAO.Comment_DB;
import model.DAO.Post_DB;
import model.DAO.Report_DB;
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
       
        // Kiểm tra nếu topics đã có trong session
        List<Topic> topics = (List<Topic>) session.getAttribute("topics");
        if (topics == null) {
            topics = Topic_DB.getAllTopics();
            session.setAttribute("topics", topics);
        }
        // Kiểm tra nếu posts đã có trong session
        List<Post> posts = (List<Post>) session.getAttribute("posts");
        if (posts == null) {
            posts = Post_DB.getPostsWithUploadPath();
            for (Post post : posts) {
                User author = Post_DB.getUserByPostId(post.getPostId());
                post.setUser(author);
                
                List<Comment> comments = Comment_DB.getCommentsByPostId(post.getPostId());
                for (Comment comment : comments) {
                    User commentUser = User_DB.getUserById(comment.getUserId());
                    if (commentUser != null) {
                        comment.setUser(commentUser);
                    }
                }
                post.setComments(comments);
            }
            session.setAttribute("posts", posts);
        }
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");

        // Kiểm tra xem người dùng đã đăng nhập hay chưa
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if ("addtopic".equalsIgnoreCase(action)) {
            addTopic(request, response, session);
        } else if ("addpost".equalsIgnoreCase(action)) {
            addPost(request, response, session, user);
        } else if ("deletetopic".equalsIgnoreCase(action)) {
            deleteTopic(request, response, session);
        } else {
            response.sendRedirect("home");
        }
    }

    private void addTopic(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        String topicName = request.getParameter("topicName");
        String description = request.getParameter("description");

        Topic newTopic = new Topic();
        newTopic.setTopicName(topicName);
        newTopic.setDescription(description);

        boolean isAdded = Topic_DB.addTopic(newTopic);

        if (isAdded) {
            session.setAttribute("msg", "Chủ đề đã được thêm thành công.");
            session.removeAttribute("topics");
        } else {
            session.setAttribute("msg", "Có lỗi xảy ra khi thêm chủ đề.");
        }
        response.sendRedirect("home");
    }

    private void addPost(HttpServletRequest request, HttpServletResponse response, HttpSession session, User user) throws IOException {
        int userId = user.getUserId();
        String topicIdStr = request.getParameter("topicId");
        String content = request.getParameter("content");

        int topicId = Integer.parseInt(topicIdStr);

        // Tạo đối tượng Post
        Post post = new Post();
        post.setUserId(userId);
        post.setTopicId(topicId);
        post.setContent(content);

        // Gọi phương thức addPostTopic của DAO
        try {
            Post_DB.addPostTopic(post);
            session.setAttribute("msg", "Bài đăng đã được thêm thành công.");
            session.removeAttribute("posts");
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("msg", "Có lỗi xảy ra khi thêm bài đăng.");
        }
        response.sendRedirect("home");
    }

    private void deleteTopic(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        int topicId = Integer.parseInt(request.getParameter("topicId"));
        boolean deleteSuccess = Topic_DB.deleteTopic(topicId);

        if (deleteSuccess) {
            session.setAttribute("msg", "Chủ đề đã được xóa thành công.");
            session.removeAttribute("topics");

        } else {
            session.setAttribute("msg", "Có lỗi xảy ra khi xóa chủ đề.");
        }

        response.sendRedirect("home");
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
