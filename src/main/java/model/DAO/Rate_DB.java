package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import static model.DAO.DBinfo.driver;

public class Rate_DB implements DBinfo {

    public Rate_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Group_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void addLike(int postId, int userId) throws SQLException {
        String query = "INSERT INTO Rate (Post_id, User_id, TypeRate) VALUES (?, ?, 1)";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, postId);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        }
    }

    public static void removeLike(int postId, int userId) throws SQLException {
        String query = "DELETE FROM Rate WHERE Post_id = ? AND User_id = ? AND TypeRate = 1";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, postId);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        }
    }

    public static boolean checkIfLiked(int postId, int userId) throws SQLException {
        String query = "SELECT COUNT(*) FROM Rate WHERE Post_id = ? AND User_id = ? AND TypeRate = 1";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, postId);
            stmt.setInt(2, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public static int getLikes(int postId) throws SQLException {
        String query = "SELECT COUNT(*) AS LikeCount FROM Rate WHERE Post_id = ? AND TypeRate = 1";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, postId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("LikeCount");
                }
            }
        }
        return 0;
    }
}
