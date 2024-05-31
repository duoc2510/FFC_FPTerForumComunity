package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Post;
import model.User;

public class Post_DB implements DBinfo {

    public Post_DB() {
        try {
            Class.forName(DBinfo.driver);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    public static void addPostUser(Post post) throws SQLException {
        String insertPostQuery = "INSERT INTO Post (User_id, Content, Status, postStatus, Reason, createDate) VALUES (?, ?, ?, ?, ?, ?)";
        String insertUploadQuery = "INSERT INTO Upload (Post_id, UploadPath) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtPost = con.prepareStatement(insertPostQuery, PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement pstmtUpload = con.prepareStatement(insertUploadQuery)) {

            // Chèn chi tiết bài đăng
            pstmtPost.setInt(1, post.getUserId());
            pstmtPost.setString(2, post.getContent());
            pstmtPost.setString(3, "Active");
            pstmtPost.setString(4, post.getPostStatus());
            pstmtPost.setString(5, post.getReason());

            // Tạo ngày tạo với định dạng dd/mm/yyyy
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            String createDate = dateFormat.format(new Date());
            pstmtPost.setString(6, createDate);

            pstmtPost.executeUpdate();

            // Lấy Post_id vừa tạo ra
            int postId = -1;
            try (ResultSet generatedKeys = pstmtPost.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    postId = generatedKeys.getInt(1);
                }
            }

            // Chèn ảnh vào bảng Upload (nếu có)
            if (postId != -1 && post.getUploadPath() != null) {
                pstmtUpload.setInt(1, postId);
                pstmtUpload.setString(2, post.getUploadPath());
                pstmtUpload.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public static void addPostGroup(Post post) throws SQLException {
        String insertPostQuery = "INSERT INTO Post (User_id, Group_id, Content, Status, postStatus, Reason, createDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String insertUploadQuery = "INSERT INTO Upload (Post_id, UploadPath) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtPost = con.prepareStatement(insertPostQuery, PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement pstmtUpload = con.prepareStatement(insertUploadQuery)) {

            // Chèn chi tiết bài đăng
            pstmtPost.setInt(1, post.getUserId());
            pstmtPost.setInt(2, post.getGroupId());
            pstmtPost.setString(3, post.getContent());
            pstmtPost.setString(4, "Pending");
            pstmtPost.setString(5, "Private");
            pstmtPost.setString(6, post.getReason());

            // Tạo ngày tạo với định dạng dd/MM/yyyy
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            String createDate = dateFormat.format(new Date());
            pstmtPost.setString(7, createDate);

            pstmtPost.executeUpdate();

            // Lấy Post_id vừa tạo ra
            int postId = -1;
            try (ResultSet generatedKeys = pstmtPost.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    postId = generatedKeys.getInt(1);
                }
            }

            // Chèn ảnh vào bảng Upload (nếu có)
            if (postId != -1 && post.getUploadPath() != null) {
                pstmtUpload.setInt(1, postId);
                pstmtUpload.setString(2, post.getUploadPath());
                pstmtUpload.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public static void addPostTopic(Post post) throws SQLException {
        String insertPostQuery = "INSERT INTO Post (User_id, Topic_id, Content, Status, postStatus, Reason, createDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String insertUploadQuery = "INSERT INTO Upload (Post_id, UploadPath) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtPost = con.prepareStatement(insertPostQuery, PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement pstmtUpload = con.prepareStatement(insertUploadQuery)) {

            // Chèn chi tiết bài đăng
            pstmtPost.setInt(1, post.getUserId());
            pstmtPost.setInt(2, post.getTopicId());
            pstmtPost.setString(3, post.getContent());
            pstmtPost.setString(4, "Pending");
            pstmtPost.setString(5, "Public");
            pstmtPost.setString(6, post.getReason());

            // Tạo ngày tạo với định dạng dd/MM/yyyy
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            String createDate = dateFormat.format(new Date());
            pstmtPost.setString(7, createDate);

            pstmtPost.executeUpdate();

            // Lấy Post_id vừa tạo ra
            int postId = -1;
            try (ResultSet generatedKeys = pstmtPost.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    postId = generatedKeys.getInt(1);
                }
            }

            // Chèn ảnh vào bảng Upload (nếu có)
            if (postId != -1 && post.getUploadPath() != null) {
                pstmtUpload.setInt(1, postId);
                pstmtUpload.setString(2, post.getUploadPath());
                pstmtUpload.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public static List<Post> getPostsByUsername(String username) {
        List<Post> posts = new ArrayList<>();
        String selectUserQuery = "SELECT User_id FROM Users WHERE Username = ?";
        String selectPostQuery = "SELECT p.Post_id, p.User_id, p.Group_id, p.Topic_id, p.Content, p.createDate, p.Status, p.postStatus, p.Reason, u.UploadPath "
                + "FROM Post p "
                + "LEFT JOIN Upload u ON p.Post_id = u.Post_id "
                + "WHERE p.User_id = ?";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtUser = con.prepareStatement(selectUserQuery)) {
            // Lấy userId dựa trên username
            pstmtUser.setString(1, username);
            int userId = -1;
            try (ResultSet rsUser = pstmtUser.executeQuery()) {
                if (rsUser.next()) {
                    userId = rsUser.getInt("User_id");
                }
            }
            if (userId != -1) {
                try (PreparedStatement pstmtPost = con.prepareStatement(selectPostQuery)) {
                    // Lấy bài viết dựa trên userId
                    pstmtPost.setInt(1, userId);
                    try (ResultSet rsPost = pstmtPost.executeQuery()) {
                        while (rsPost.next()) {
                            int postId = rsPost.getInt("Post_id");
                            int groupId = rsPost.getInt("Group_id");
                            int topicId = rsPost.getInt("Topic_id");
                            String content = rsPost.getString("Content");
                            // Thay đổi ở đây: Sử dụng getTimestamp() thay vì getDate()
                            String createDate = rsPost.getString("createDate");
                            String status = rsPost.getString("Status");
                            String postStatus = rsPost.getString("postStatus");
                            String reason = rsPost.getString("Reason");
                            String uploadPath = rsPost.getString("UploadPath");
                            Post post = new Post(postId, userId, groupId, topicId, content, createDate, status, postStatus, reason, uploadPath);
                            posts.add(post);
                        }
                    }
                }
            } else {
                System.out.println("Không tìm thấy người dùng với tên người dùng: " + username);
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi khi lấy bài viết cho tên người dùng: " + username);
            ex.printStackTrace();
        }
        return posts;
    }

    public static Post getPostById(int postId) {
        Post post = null;
        String selectPostQuery = "SELECT Post_id, User_id, Group_id, Topic_id, Content, createDate, Status, postStatus, Reason, UploadPath "
                + "FROM Post WHERE Post_id = ?";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtPost = con.prepareStatement(selectPostQuery)) {
            pstmtPost.setInt(1, postId);
            try (ResultSet rsPost = pstmtPost.executeQuery()) {
                if (rsPost.next()) {
                    int userId = rsPost.getInt("User_id");
                    int groupId = rsPost.getInt("Group_id");
                    int topicId = rsPost.getInt("Topic_id");
                    String content = rsPost.getString("Content");
                    String createDate = rsPost.getString("createDate");
                    String status = rsPost.getString("Status");
                    String postStatus = rsPost.getString("postStatus");
                    String reason = rsPost.getString("Reason");
                    String uploadPath = rsPost.getString("UploadPath");

                    post = new Post(postId, userId, groupId, topicId, content, createDate, status, postStatus, reason, uploadPath);
                }
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi khi lấy bài viết cho postId: " + postId);
            ex.printStackTrace();
        }
        return post;
    }

    public static List<Post> getPostsWithUploadPath() {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT p.*, u.UploadPath "
                + "FROM Post p "
                + "LEFT JOIN Upload u ON p.Post_id = u.Post_id";
        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int postId = rs.getInt("Post_id");
                int userId = rs.getInt("User_id");
                int groupId = rs.getInt("Group_id");
                int topicId = rs.getInt("Topic_id");
                String content = rs.getString("Content");
                String createDate = rs.getString("createDate");
                // Sử dụng getTimestamp() thay vì getDate()
                String status = rs.getString("Status");
                String postStatus = rs.getString("postStatus");
                String reason = rs.getString("Reason");
                String uploadPath = rs.getString("UploadPath");

                Post post = new Post(postId, userId, groupId, topicId, content, createDate, status, postStatus, reason, uploadPath);
                posts.add(post);
            }
            System.out.println("getPostsWithUploadPath: Query executed successfully.");
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("getPostsWithUploadPath: Query execution failed.");
        }
        return posts;
    }

    public static User getUserByPostId(int postId) {
        User user = null;
        String query = "SELECT u.* "
                + "FROM Users u "
                + "INNER JOIN Post p ON u.User_id = p.User_id "
                + "WHERE p.Post_id = ?";

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, postId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int userId = rs.getInt("User_id");
                    String email = rs.getString("User_email");
                    String password = rs.getString("User_password");
                    int role = rs.getInt("User_role");
                    String username = rs.getString("Username");
                    String fullName = rs.getString("User_fullName");
                    Double wallet = rs.getDouble("User_wallet");
                    String avatar = rs.getString("User_avatar");
                    String story = rs.getString("User_story");
                    int rank = rs.getInt("User_rank");
                    int score = rs.getInt("User_score");
                    Date createDate = rs.getDate("User_createDate");
                    String sex = rs.getString("User_sex");
                    boolean activeStatus = rs.getBoolean("User_activeStatus");

                    user = new User(userId, email, password, role, username, fullName, wallet, avatar, story, rank, score, createDate, sex, activeStatus);
                }
                System.out.println("getUserByPostId: Query executed successfully.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("getUserByPostId: Query execution failed.");
        }
        return user;
    }

    public static boolean deletePost(int postId) {
        boolean success = false;
        String deleteCommentsQuery = "DELETE FROM Comment WHERE Post_id = ?";
        String deleteUploadsQuery = "DELETE FROM Upload WHERE Post_id = ?";
        String deleteRateQuery = "DELETE FROM Rate WHERE Post_id = ?";
        String deletePostQuery = "DELETE FROM Post WHERE Post_id = ?";

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass)) {
            // Xoá các comment liên quan
            try (PreparedStatement deleteCommentsStmt = conn.prepareStatement(deleteCommentsQuery)) {
                deleteCommentsStmt.setInt(1, postId);
                int commentsDeleted = deleteCommentsStmt.executeUpdate();
                System.out.println("Deleted " + commentsDeleted + " comments related to post with ID " + postId);
            }

            // Xoá các tệp đính kèm (nếu có)
            try (PreparedStatement deleteUploadsStmt = conn.prepareStatement(deleteUploadsQuery)) {
                deleteUploadsStmt.setInt(1, postId);
                int uploadsDeleted = deleteUploadsStmt.executeUpdate();
                System.out.println("Deleted " + uploadsDeleted + " uploads related to post with ID " + postId);
            }

            // Xoá các rate liên quan
            try (PreparedStatement deleteRateStmt = conn.prepareStatement(deleteRateQuery)) {
                deleteRateStmt.setInt(1, postId);
                int ratesDeleted = deleteRateStmt.executeUpdate();
                System.out.println("Deleted " + ratesDeleted + " rates related to post with ID " + postId);
            }

            // Xoá bài đăng
            try (PreparedStatement deletePostStmt = conn.prepareStatement(deletePostQuery)) {
                deletePostStmt.setInt(1, postId);
                int rowsDeleted = deletePostStmt.executeUpdate();
                success = (rowsDeleted > 0);

                if (success) {
                    System.out.println("Post with ID " + postId + " and its comments, uploads, and rates deleted successfully.");
                } else {
                    System.out.println("Failed to delete post with ID " + postId + " and its comments, uploads, and rates.");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Failed to delete post with ID " + postId + " and its comments, uploads, and rates.");
        }

        return success;
    }

    public static List<Post> getPostsWithUploadPathByTopic(int topicId) {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT p.*, u.UploadPath "
                + "FROM Post p "
                + "LEFT JOIN Upload u ON p.Post_id = u.Post_id "
                + "WHERE p.Topic_id = ?";
        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, topicId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int postId = rs.getInt("Post_id");
                    int userId = rs.getInt("User_id");
                    int groupId = rs.getInt("Group_id");
                    String content = rs.getString("Content");
                    String createDate = rs.getString("createDate");
                    // Sử dụng getTimestamp() thay vì getDate()
                    String status = rs.getString("Status");
                    String postStatus = rs.getString("postStatus");
                    String reason = rs.getString("Reason");
                    String uploadPath = rs.getString("UploadPath");

                    Post post = new Post(postId, userId, groupId, topicId, content, createDate, status, postStatus, reason, uploadPath);
                    posts.add(post);
                }
                System.out.println("getPostsWithUploadPathByTopic: Query executed successfully.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("getPostsWithUploadPathByTopic: Query execution failed.");
        }
        return posts;
    }

}
