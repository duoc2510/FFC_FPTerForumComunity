package controller;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
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
import model.DAO.User_DB;
import model.Post;
import model.User;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
@WebServlet(name = "AddPost", urlPatterns = {"/AddPost"})
public class AddPost extends HttpServlet {

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
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

        String username = user.getUsername();
        int userId;
        try {
            userId = User_DB.getUserIdByUsername(username);
            if (userId == -1) {
                response.sendRedirect(request.getContextPath() + "/auth/login.jsp?errorMessage=User not found");
                return;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddPost.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect(request.getContextPath() + "/user/profile.jsp?errorMessage=Database error");
            return;
        }

        String postStatus = request.getParameter("postStatus");
        String postTopic = request.getParameter("postTopic");
        String postGroup = request.getParameter("postGroup");
        String postContent = request.getParameter("postContent");

        int topicId = getTopicId(postTopic);
        int groupId = getGroupId(postGroup);

        String avatar = null; 
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

            avatar = uploadDirName + "/" + fileName;
        }

        Post post = new Post(userId, groupId, topicId, postContent, avatar, postStatus);
        try {
            Post_DB.addPost(post);
            response.sendRedirect(request.getContextPath() + "/user/profile.jsp?successMessage=Post added successfully!");
        } catch (SQLException ex) {
            Logger.getLogger(AddPost.class.getName()).log(Level.SEVERE, null, ex);
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

    @Override
    public String getServletInfo() {
        return "AddPostServlet handles post creation";
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
}
