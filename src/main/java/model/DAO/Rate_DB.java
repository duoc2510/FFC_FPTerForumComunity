/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import static model.DAO.DBinfo.driver;

/**
 *
 * @author ThanhDuoc
 */
public class Rate_DB implements DBinfo {

    public Rate_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Group_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static int getLikes(int postId) {
        int likeCount = 0;
        String query = "SELECT COUNT(*) AS LikeCount FROM Rate WHERE Post_id = ? AND TypeRate = 1";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                likeCount = rs.getInt("LikeCount");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return likeCount;
    }

    public static void addLike(int postId, int userId) throws SQLException {
        String checkQuery = "SELECT 1 FROM Rate WHERE Post_id = ? AND User_id = ? AND TypeRate = 1";
        String insertQuery = "INSERT INTO Rate (Post_id, User_id, TypeRate) VALUES (?, ?, 1)";
        String updateLikeCountQuery = "UPDATE Post SET likeCount = (SELECT COUNT(*) FROM Rate WHERE Post_id = ? AND TypeRate = 1) WHERE Post_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement checkStmt = conn.prepareStatement(checkQuery); PreparedStatement insertStmt = conn.prepareStatement(insertQuery); PreparedStatement updateStmt = conn.prepareStatement(updateLikeCountQuery)) {

            conn.setAutoCommit(false); // Bắt đầu giao dịch
            try {
                // Kiểm tra xem người dùng đã like bài viết này chưa
                checkStmt.setInt(1, postId);
                checkStmt.setInt(2, userId);
                ResultSet rs = checkStmt.executeQuery();

                if (!rs.next()) {
                    // Nếu chưa like, thêm like vào bảng Rate
                    insertStmt.setInt(1, postId);
                    insertStmt.setInt(2, userId);
                    insertStmt.executeUpdate();

                    // Cập nhật số lượt like trong bảng Post từ bảng Rate
                    updateStmt.setInt(1, postId);
                    updateStmt.setInt(2, postId);
                    updateStmt.executeUpdate();

                    conn.commit(); // Commit giao dịch
                } else {
                    System.out.println("User has already liked this post.");
                }
            } catch (SQLException ex) {
                conn.rollback(); // Rollback nếu có lỗi
                throw ex;
            } finally {
                conn.setAutoCommit(true); // Quay về chế độ tự động commit
            }
        }
    }

    public static void removeLike(int postId, int userId) {
        String deleteQuery = "DELETE FROM Rate WHERE Post_id = ? AND User_id = ? AND TypeRate = 1";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {

            deleteStmt.setInt(1, postId);
            deleteStmt.setInt(2, userId);
            int rowsAffected = deleteStmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Like removed successfully.");
            } else {
                System.out.println("Like does not exist.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean checkIfLiked(int postId, int userId) {
        String query = "SELECT COUNT(*) AS LikeCount FROM Rate WHERE Post_id = ? AND User_id = ? AND TypeRate = 1";
        boolean liked = false;

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, postId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int likeCount = rs.getInt("LikeCount");
                liked = likeCount > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return liked;
    }
}
