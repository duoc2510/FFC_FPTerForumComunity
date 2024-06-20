package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Comment;
import model.DAO.Comment_DB;
import model.DAO.Post_DB;
import model.DAO.Rate_DB;
import model.DAO.User_DB;
import model.Post;
import model.User;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
public class Post_postView extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Post> posts = Post_DB.getPostsWithoutGroupIdAndTopicId();
        int userId = user.getUserId(); // Lấy userId từ session
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

            // Kiểm tra xem người dùng đã like bài viết này chưa và cập nhật trường likedByCurrentUser
            boolean likedByCurrentUser = false;
            try {
                likedByCurrentUser = Rate_DB.checkIfLiked(post.getPostId(), userId);
            } catch (SQLException ex) {
                Logger.getLogger(Post_postView.class.getName()).log(Level.SEVERE, null, ex);
            }
            post.setLikedByCurrentUser(likedByCurrentUser);

            // Lấy số lượt thích của bài viết và cập nhật vào đối tượng Post
            int likeCount = 0;
            try {
                likeCount = Rate_DB.getLikes(post.getPostId());
            } catch (SQLException ex) {
                Logger.getLogger(Post_postView.class.getName()).log(Level.SEVERE, null, ex);
            }
            post.setLikeCount(likeCount);
        }

        session.setAttribute("postsUser", posts);
        request.getRequestDispatcher("/user/newsfeed.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("text/html;charset=UTF-8");
        int postId;
        boolean success = false;
        String message = "";

        if (action != null) {
            postId = Integer.parseInt(request.getParameter("postId"));

            if ("editPost".equals(action)) {
                success = handleEditPost(request, postId);
                message = success ? "Post edited successfully." : "Failed to edit post.";
            } else if ("deletePost".equals(action)) {
                success = handleDeletePost(postId);
                message = success ? "Post deleted successfully." : "Failed to delete post.";
            }

            // Nếu hành động thành công, cập nhật lại danh sách bài đăng trong session
            if (success) {
                updatePostsInSession(request.getSession());
            }
        } else {
            message = "Action is missing.";
        }

        if (success) {
            String referer = request.getHeader("referer");
            response.sendRedirect(referer);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, message);
        }
    }

    private boolean handleEditPost(HttpServletRequest request, int postId) throws IOException, ServletException {
        String newContent = request.getParameter("newContent");
        String newStatus = request.getParameter("newStatus");
        String existingUploadPath = request.getParameter("existingUploadPath");

        // Kiểm tra xem có file mới được upload không
        Part filePart = request.getPart("newUploadPath");
        String newUploadPath = null;
        if (filePart != null && filePart.getSize() > 0) {
            // Xử lý file upload
            newUploadPath = handleUpload(request);
        } else {
            // Sử dụng đường dẫn cũ nếu không có file mới được upload
            newUploadPath = (existingUploadPath != null && !existingUploadPath.equals("null") && !existingUploadPath.isEmpty()) ? existingUploadPath : null;
        }

        // Thực hiện chỉnh sửa bài đăng
        return Post_DB.editPost(postId, newContent, newStatus, newUploadPath);
    }

    private boolean handleDeletePost(int postId) {
        // Thực hiện xóa bài đăng
        return Post_DB.deletePost(postId);
    }

    private void updatePostsInSession(HttpSession session) {
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

    private String handleUpload(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("newUploadPath");
        if (filePart != null && filePart.getSize() > 0) {
            // Xử lý file upload
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadDirName = "imPost";
            String uploadFilePath = applicationPath + File.separator + uploadDirName;
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = getFileName(filePart);
            try {
                filePart.write(uploadFilePath + File.separator + fileName);
                return uploadDirName + "/" + fileName;
            } catch (IOException e) {
                e.printStackTrace();
                return null;
            }
        } else {
            // Không có file được upload
            return null;
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
}
