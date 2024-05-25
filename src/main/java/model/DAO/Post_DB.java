package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Comment;
import model.Post;
import model.Upload;
import model.User;

public class Post_DB {

    public Post_DB() {
        try {
            Class.forName(DBinfo.driver);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    public static void addPostUser(Post post) throws SQLException {
        String insertPostQuery = "INSERT INTO Post (User_id, Content, Status, postStatus, Reason) VALUES (?, ?, ?, ?, ?)";
        String insertUploadQuery = "INSERT INTO Upload (Post_id, UploadPath) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtPost = con.prepareStatement(insertPostQuery, PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement pstmtUpload = con.prepareStatement(insertUploadQuery)) {

            // Chèn chi tiết bài đăng
            pstmtPost.setInt(1, post.getUserId());
            pstmtPost.setString(2, post.getContent());
            pstmtPost.setString(3, "Active");
            pstmtPost.setString(4, post.getPostStatus());
            pstmtPost.setString(5, post.getReason());

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
        String insertPostQuery = "INSERT INTO Post (User_id, Group_id, Content, Status, postStatus, Reason) VALUES (?, ?, ?, ?, ?, ?)";
        String insertUploadQuery = "INSERT INTO Upload (Post_id, UploadPath) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtPost = con.prepareStatement(insertPostQuery, PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement pstmtUpload = con.prepareStatement(insertUploadQuery)) {

            // Chèn chi tiết bài đăng
            pstmtPost.setInt(1, post.getUserId());
            pstmtPost.setInt(2, post.getGroupId());
            pstmtPost.setString(3, post.getContent());
            pstmtPost.setString(4, "Peding");
            pstmtPost.setString(5, post.getPostStatus());
            pstmtPost.setString(6, post.getReason());

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
        String insertPostQuery = "INSERT INTO Post (User_id, Topic_id, Content, Status, postStatus, Reason) VALUES (?, ?, ?, ?, ?, ?)";
        String insertUploadQuery = "INSERT INTO Upload (Post_id, UploadPath) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtPost = con.prepareStatement(insertPostQuery, PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement pstmtUpload = con.prepareStatement(insertUploadQuery)) {

            // Chèn chi tiết bài đăng
            pstmtPost.setInt(1, post.getUserId());
            pstmtPost.setInt(2, post.getTopicId());
            pstmtPost.setString(3, post.getContent());
            pstmtPost.setString(4, "Pending");
            pstmtPost.setString(5, post.getPostStatus());
            pstmtPost.setString(6, post.getReason());

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
                            Timestamp createDate = rsPost.getTimestamp("createDate");
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

    public static boolean addCommentToPost(int postId, int userId, String content) {
        String query = "INSERT INTO Comment (Post_id, User_id, Content) VALUES (?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, postId);
            stmt.setInt(2, userId);
            stmt.setString(3, content);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static List<Comment> getCommentsByPostId(int postId) {
        List<Comment> comments = new ArrayList<>();
        String query = "SELECT * FROM Comment WHERE Post_id = ?";
        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int commentId = rs.getInt("Comment_id");
                int userId = rs.getInt("User_id");
                String content = rs.getString("Content");
                Date date = rs.getDate("Date");

                User user = User_DB.getUserById(userId); // Get user information for the comment

                Comment comment = new Comment(commentId, postId, userId, content, date);
                comment.setUser(user); // Set user information to comment
                comments.add(comment);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return comments;
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
                    Date createDate = rsPost.getDate("createDate");
                    String status = rsPost.getString("Status");
                    String postStatus = rsPost.getString("postStatus");
                    String reason = rsPost.getString("Reason");
                    String uploadPath = rsPost.getString("UploadPath");

                    post = new Post(postId, userId, groupId, topicId, content, (Timestamp) createDate, status, postStatus, reason, uploadPath);
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
                Timestamp createDate = rs.getTimestamp("createDate"); // Sử dụng getTimestamp() thay vì getDate()
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
                    String usernameVip = rs.getString("usernameVip");

                    user = new User(userId, email, password, role, username, fullName, wallet, avatar, story, rank, score, createDate, sex, activeStatus, usernameVip);
                }
                System.out.println("getUserByPostId: Query executed successfully.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("getUserByPostId: Query execution failed.");
        }
        return user;
    }

}
