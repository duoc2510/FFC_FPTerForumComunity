package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Comment;
import static model.DAO.DBinfo.dbPass;
import static model.DAO.DBinfo.dbURL;
import static model.DAO.DBinfo.dbUser;
import static model.DAO.DBinfo.driver;
import model.User;

public class Comment_DB {

    public Comment_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Comment_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static boolean addCommentToPost(int postId, int userId, String content) {
        String query = "INSERT INTO Comment (Post_id, User_id, Content) VALUES (?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
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
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
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

    public static boolean deleteCommentById(int commentId, int userId) {
        String query = "DELETE FROM Comment WHERE Comment_id = ? AND User_id = ?";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, commentId);
            stmt.setInt(2, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static boolean editComment(int commentId, String newContent) {
        boolean success = false;
        String query = "UPDATE Comment SET Content = ? WHERE Comment_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, newContent);
            stmt.setInt(2, commentId);

            int rowsUpdated = stmt.executeUpdate();
            success = (rowsUpdated > 0);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return success;
    }
}
