package controller;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import model.DAO.Post_DB;
import model.Post;
import model.User;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
public class Post_addpost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddPost at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?errorMessage=You must be logged in to add a post");
            return;
        }

        int userId = user.getUserId(); // Sử dụng user.getId() thay vì User_DB.getUserIdByUsername(username)
        String status = request.getParameter("status");
        String postStatus = request.getParameter("postStatus");
        String postTopic = request.getParameter("postTopic");
        String postGroup = request.getParameter("postGroup");
        String postContent = request.getParameter("postContent");

        int topicId = getTopicId(postTopic);
        int groupId = getGroupId(postGroup);

        String uploadPath = null;
        Part filePart = request.getPart("postImage");
        if (filePart != null && filePart.getSize() > 0) {
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadDirName = "imPost";
            String uploadFilePath = applicationPath + File.separator + uploadDirName;
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = getFileName(filePart);
            filePart.write(uploadFilePath + File.separator + fileName);

            uploadPath = uploadDirName + "/" + fileName;
        }

        // Tạo bài đăng mới
        Post post = new Post(userId, groupId, topicId, postContent,status, postStatus, uploadPath);

        try {
            Post_DB.addPost(post);
            response.sendRedirect(request.getContextPath() + "/user/profile.jsp?successMessage=Post added successfully!");
        } catch (SQLException ex) {
            Logger.getLogger(Post_addpost.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect(request.getContextPath() + "/user/profile.jsp?errorMessage=Error adding post");
        }
    }

    private int getTopicId(String topic) {
        switch (topic) {
            case "Technology":
                return 1;
            case "Economics":
                return 2;
            case "Politics":
                return 3;
            case "Language":
                return 4;
            default:
                return 0;
        }
    }

    private int getGroupId(String group) {
        switch (group) {
            case "IT":
                return 1;
            case "Business":
                return 2;
            case "Language":
                return 3;
            default:
                return 0;
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

    @Override
    public String getServletInfo() {
        return "AddPostServlet handles post creation";
    }

}
