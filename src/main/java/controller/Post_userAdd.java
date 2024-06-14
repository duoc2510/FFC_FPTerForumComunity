/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Comment;
import model.DAO.Comment_DB;
import model.DAO.Post_DB;
import model.DAO.User_DB;
import model.Post;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
public class Post_userAdd extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = user.getUserId();
        String postStatus = request.getParameter("postStatus");
        String postContent = request.getParameter("postContent");
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
        Post post = new Post();

        // Tạo bài đăng mới
        try {
            String groupIdStr = request.getParameter("groupId");
            if (groupIdStr != null && !groupIdStr.isEmpty()) {
                // Nếu groupId khác null, thêm bài đăng cho group
                int groupId = Integer.parseInt(groupIdStr);
                post.setUserId(userId);
                post.setGroupId(groupId);
                post.setContent(postContent);
                post.setUploadPath(uploadPath);
                Post_DB.addPostGroup(post);
                List<Post> posts = Post_DB.getPostsWithGroupId();
                for (Post p : posts) {
                    User author = Post_DB.getUserByPostId(p.getPostId());
                    p.setUser(author);
                    List<Comment> comments = Comment_DB.getCommentsByPostId(p.getPostId());
                    for (Comment comment : comments) {
                        User commentUser = User_DB.getUserById(comment.getUserId());
                        if (commentUser != null) {
                            comment.setUser(commentUser);
                        }
                    }
                    p.setComments(comments);
                }
                session.setAttribute("postsGroup", posts);
            } else {
                post.setUserId(userId);
                post.setContent(postContent);
                post.setPostStatus(postStatus);
                post.setUploadPath(uploadPath);
                Post_DB.addPostUser(post);
                List<Post> posts = Post_DB.getPostsWithoutGroupIdAndTopicId();
                for (Post p : posts) {
                    User author = Post_DB.getUserByPostId(p.getPostId());
                    p.setUser(author);
                    List<Comment> comments = Comment_DB.getCommentsByPostId(p.getPostId());
                    for (Comment comment : comments) {
                        User commentUser = User_DB.getUserById(comment.getUserId());
                        if (commentUser != null) {
                            comment.setUser(commentUser);
                        }
                    }
                    p.setComments(comments);
                }
                session.setAttribute("postsUser", posts);
            }
            String referer = request.getHeader("referer");
            response.sendRedirect(referer != null ? referer : "profile");
        } catch (SQLException ex) {
            Logger.getLogger(Post_userAdd.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect(request.getContextPath() + "/user/profile.jsp?errorMessage=Error adding post");
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
