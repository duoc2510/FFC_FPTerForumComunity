package controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import model.Comment;
import model.DAO.Comment_DB;
import model.DAO.Post_DB;
import model.DAO.User_DB;
import model.Post;
import model.User;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
public class Post_postView extends HttpServlet {

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
            out.println("<title>Servlet viewPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet viewPost at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("USER") != null) {
            request.getRequestDispatcher("/user/newsfeed.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
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
                success = Post_DB.editPost(postId, newContent, newStatus, newUploadPath);
                message = success ? "Post edited successfully." : "Failed to edit post.";
                // Nếu chỉnh sửa thành công, cập nhật lại danh sách bài đăng trong session
                if (success) {
                    updatePostsInSession(request.getSession());
                }
            } else if ("deletePost".equals(action)) {
                // Thực hiện xóa bài đăng
                success = Post_DB.deletePost(postId);
                message = success ? "Post deleted successfully." : "Failed to delete post.";
                // Nếu xóa thành công, cập nhật lại danh sách bài đăng trong session
                if (success) {
                    updatePostsInSession(request.getSession());
                }
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

// Phương thức để cập nhật lại danh sách bài đăng trong session
    private void updatePostsInSession(HttpSession session) {
        List<Post> posts = Post_DB.getPostsWithUploadPath();
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
        session.setAttribute("posts", posts);
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
