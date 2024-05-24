//package model.DAO;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.SQLException;
//import java.sql.ResultSet;
//import java.util.ArrayList;
//import java.util.List;
//import model.Post;
//
//public class Post_DB {
//
//    public Post_DB() {
//        try {
//            Class.forName(DBinfo.driver);
//        } catch (ClassNotFoundException ex) {
//            ex.printStackTrace();
//        }
//    }
//
//    public static void addPost(Post post) throws SQLException {
//        String insertPostQuery = "INSERT INTO Post (User_id, Group_id, Topic_id, Content, Status, postStatus, Reason) VALUES (?, ?, ?, ?, ?, ?, ?)";
//        String insertUploadQuery = "INSERT INTO Upload (Post_id, UploadPath) VALUES (?, ?)";
//
//        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtPost = con.prepareStatement(insertPostQuery, PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement pstmtUpload = con.prepareStatement(insertUploadQuery)) {
//
//            // Insert post details
//            pstmtPost.setInt(1, post.getUserId());
//            pstmtPost.setInt(2, post.getGroupId());
//            pstmtPost.setInt(3, post.getTopicId());
//            pstmtPost.setString(4, post.getContent());
//            pstmtPost.setString(5, post.getStatus());
//            pstmtPost.setString(6, post.getPostStatus());
//            pstmtPost.setString(7, post.getReason());
//
//            pstmtPost.executeUpdate();
//
//            // Retrieve the generated Post_id
//            int postId = -1;
//            try (ResultSet generatedKeys = pstmtPost.getGeneratedKeys()) {
//                if (generatedKeys.next()) {
//                    postId = generatedKeys.getInt(1);
//                }
//            }
//
//            if (postId != -1 && post.getImage() != null) {
//                // Insert image into Upload table
//                pstmtUpload.setInt(1, postId);
//                pstmtUpload.setString(2, post.getImage());
//                pstmtUpload.executeUpdate();
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//            throw ex;
//        }
//    }
//
//    public static List<Post> getPostsByUsername(String username) {
//        List<Post> posts = new ArrayList<>();
//        String selectUserQuery = "SELECT User_id FROM Users WHERE Username = ?";
//        String selectPostQuery = "SELECT pv.Post_id, pv.Content, pv.UploadPath, pv.Status, pv.createDate "
//                + "FROM PostUploadView pv "
//                + "JOIN Users u ON pv.User_id = u.User_id "
//                + "WHERE u.User_id = ?";
//
//        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtUser = con.prepareStatement(selectUserQuery)) {
//
//            // Fetch userId based on username
//            pstmtUser.setString(1, username);
//            int userId = -1;
//            try (ResultSet rsUser = pstmtUser.executeQuery()) {
//                if (rsUser.next()) {
//                    userId = rsUser.getInt("User_id");
//                }
//            }
//
//            if (userId != -1) {
//                try (PreparedStatement pstmtPost = con.prepareStatement(selectPostQuery)) {
//                    // Fetch posts based on userId
//                    pstmtPost.setInt(1, userId);
//                    try (ResultSet rsPost = pstmtPost.executeQuery()) {
//                        while (rsPost.next()) {
//                            int postId = rsPost.getInt("Post_id");
//                            String content = rsPost.getString("Content");
//                            String uploadPath = rsPost.getString("UploadPath");
//                            String status = rsPost.getString("Status");
//                            java.sql.Timestamp createDate = rsPost.getTimestamp("createDate");
//
//                            // Create a new Post object
////                            Post post = new Post(userId, content, createDate, uploadPath, status);
////                            posts.add(post);
//
//                            // Print the required fields
//                            System.out.println("PostID: " + postId);
//                            System.out.println("UserID: " + userId);
//                            System.out.println("Content: " + content);
//                            System.out.println("Status: " + status);
//                            System.out.println("UploadPath: " + uploadPath);
//                            System.out.println("CreateDate: " + createDate);
//                            System.out.println("-----------");
//                        }
//                    }
//                }
//            } else {
//                System.out.println("No user found with username: " + username);
//            }
//        } catch (SQLException ex) {
//            System.out.println("Error fetching posts for username: " + username);
//            ex.printStackTrace();
//        }
//        return posts;
//    }
//}
