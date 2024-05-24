package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Post;

public class Post_DB {

    public Post_DB() {
        try {
            Class.forName(DBinfo.driver);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    public static void addPost(Post post) throws SQLException {
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

    public static List<Post> getPostsByUsername(String username) {
        List<Post> posts = new ArrayList<>();
        String selectUserQuery = "SELECT User_id FROM Users WHERE Username = ?";
        String selectPostQuery = "SELECT p.Post_id, p.User_id, p.Group_id, p.Topic_id, p.Content, p.createDate, p.Status, p.postStatus, p.Reason, p.Upload_id, p.Event_id, p.Shop_id, p.Comment_id, p.Product_id, p.UploadPath "
                + "FROM PostWithUploads p "
                + "JOIN Users u ON p.User_id = u.User_id "
                + "WHERE u.User_id = ?";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtUser = con.prepareStatement(selectUserQuery)) {
            // Fetch userId based on username
            pstmtUser.setString(1, username);
            int userId = -1;
            try (ResultSet rsUser = pstmtUser.executeQuery()) {
                if (rsUser.next()) {
                    userId = rsUser.getInt("User_id");
                }
            }
            if (userId != -1) {
                try (PreparedStatement pstmtPost = con.prepareStatement(selectPostQuery)) {
                    // Fetch posts based on userId
                    pstmtPost.setInt(1, userId);
                    try (ResultSet rsPost = pstmtPost.executeQuery()) {
                        while (rsPost.next()) {
                            int postId = rsPost.getInt("Post_id");
                            int groupId = rsPost.getInt("Group_id");
                            int topicId = rsPost.getInt("Topic_id");
                            String content = rsPost.getString("Content");
                            java.sql.Timestamp createDate = rsPost.getTimestamp("createDate");
                            String status = rsPost.getString("Status");
                            String postStatus = rsPost.getString("postStatus");
                            String reason = rsPost.getString("Reason");
                            String uploadPath = rsPost.getString("UploadPath");
                            // Create a new Post object
                            Post post = new Post(postId, userId, groupId, topicId, content, createDate, status, postStatus, reason, uploadPath);
                            posts.add(post);
                        }
                    }
                }
            } else {
                System.out.println("No user found with username: " + username);
            }
        } catch (SQLException ex) {
            System.out.println("Error fetching posts for username: " + username);
            ex.printStackTrace();
        }
        return posts;
    }
}
