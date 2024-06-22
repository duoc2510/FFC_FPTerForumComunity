package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
public class Post_comment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "addComment":
                    handleAddComment(request, response);
                    break;
                case "deleteComment":
                    handleDeleteComment(request, response);
                    break;
                case "editComment":
                    handleEditComment(request, response);
                    break;
                default:
                    break;
            }
        }
    }

    private void handleAddComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("USER");
        int userId = user.getUserId();
        String content = request.getParameter("content");
        boolean success = Comment_DB.addCommentToPost(postId, userId, content);
        if (success) {
            User_DB.updateScore(userId);
            updatePostsInSession(session);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add comment.");
        }
        response.sendRedirect(request.getContextPath() + "/post/detail?postId=" + postId);
    }

    private void handleDeleteComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int commentId = Integer.parseInt(request.getParameter("commentId"));
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("USER");
        int userId = user.getUserId();
        boolean success = Comment_DB.deleteCommentById(commentId, userId);
        if (success) {
            updatePostsInSession(session);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete comment.");
        }
        sendRedirectBack(request, response);
    }

    private void handleEditComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int commentId = Integer.parseInt(request.getParameter("commentId"));
        String newContent = request.getParameter("newContent");
        boolean success = Comment_DB.editComment(commentId, newContent);
        if (success) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                updatePostsInSession(session);
            }
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to edit comment.");
        }
        sendRedirectBack(request, response);
    }

    private void updatePostsInSession(HttpSession session) {
        User user = (User) session.getAttribute("USER");
        if (user != null) {
            List<Post> posts;
            Integer groupId = (Integer) session.getAttribute("groupId");
            Integer topicId = (Integer) session.getAttribute("topicId");
            if (groupId != null) {
                posts = Post_DB.getPostsWithGroupId();
                session.setAttribute("postsGroup", posts);
            } else if (topicId != null) {
                posts = Post_DB.getPostsWithTopicId();
                session.setAttribute("postsTopic", posts);
            } else {
                posts = Post_DB.getPostsWithoutGroupIdAndTopicId();
                session.setAttribute("postsUser", posts);
            }
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
        }
    }

    private void sendRedirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String referer = request.getHeader("referer");
        response.sendRedirect(referer != null ? referer : "profile");
    }
}
