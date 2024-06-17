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
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import static model.DAO.DBinfo.dbPass;
import static model.DAO.DBinfo.dbURL;
import static model.DAO.DBinfo.dbUser;
import model.Post;
import model.Report;
import model.User;

/**
 *
 * @author PC
 */
public class Report_DB {

    public Report_DB() {
        try {
            Class.forName(DBinfo.driver);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    public static boolean insertReport(Report report) {
        String insertQuery = "INSERT INTO Report (Reporter_id, User_id, Shop_id, Post_id, Reason, Status) VALUES (?, ?, ?, ?, ?, 'pending')";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(insertQuery)) {

            // Thiết lập các giá trị cho câu lệnh SQL
            stmt.setInt(1, report.getReporter_id());

            if (report.getUserId() == 0) {
                stmt.setInt(2, Types.INTEGER);
            } else {
                stmt.setInt(2, report.getUserId());
            }
            if (report.getShopId() == 0) {
                stmt.setNull(3, Types.INTEGER); // Set giá trị null nếu shopId là 0
            } else {
                stmt.setInt(3, report.getShopId());
            }
            if (report.getPostId() == 0) {
                stmt.setNull(4, Types.INTEGER); // Set giá trị null nếu postId là 0
            } else {
                stmt.setInt(4, report.getPostId());
            }
            stmt.setString(5, report.getReason());

            // Thực thi câu lệnh SQL
            int rowsAffected = stmt.executeUpdate();

            // Kiểm tra nếu có ít nhất một hàng bị ảnh hưởng
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while inserting report", e);
            return false;
        }
    }

    public static List<Report> getAllReports() {
        List<Report> reports = new ArrayList<>();
        String selectQuery = "SELECT r.Report_id, r.Reporter_id, r.User_id, r.Post_id, r.Reason, r.Status, "
                + "p.Content AS PostContent, p.User_id AS PostUserId, "
                + "u.Username AS ReporterName, u2.Username AS ReportedUserName "
                + "FROM Report r "
                + "LEFT JOIN Post p ON r.Post_id = p.Post_id "
                + "JOIN Users u ON r.Reporter_id = u.User_id "
                + "JOIN Users u2 ON r.User_id = u2.User_id";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int reportId = rs.getInt("Report_id");
                int reporterId = rs.getInt("Reporter_id");
                int userId = rs.getInt("User_id");
                int postId = rs.getInt("Post_id");

                String reason = rs.getString("Reason");
                String status = rs.getString("Status");

                // Lấy thông tin từ bảng Post nếu có
                Post post = null;
                if (postId != 0) {
                    String postContent = rs.getString("PostContent");
                    int postUserId = rs.getInt("PostUserId");
                    post = new Post(postId, postUserId, postContent, status);
                }

                // Lấy thông tin từ bảng Users cho reporter
                String reporterName = rs.getString("ReporterName");
                User reporter = new User(reporterId, reporterName);

                // Lấy thông tin từ bảng Users cho người bị báo cáo
                String reportedUserName = rs.getString("ReportedUserName");
                User reportedUser = new User(userId, reportedUserName);

                // Tạo đối tượng Report từ các dữ liệu lấy được từ cơ sở dữ liệu
                Report report = new Report(reportId, reporterId, userId, postId, reason, status, post, reportedUser);
                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching reports", e);
        }

        return reports;
    }

    public static List<Report> getPostsReportedAtLeastThreeTimesWithReasons() {
        List<Report> reportedPosts = new ArrayList<>();
        String selectQuery = "SELECT p.Post_id, p.User_id as PostUserId, p.Content, p.Status, u.Username as PostUsername,u.User_role , u.User_avatar, r.Status as rpStatus, "
                + "COUNT(r.Report_id) as ReportCount, STRING_AGG(r.Reason, '; ') as Reasons "
                + "FROM Report r "
                + "JOIN Post p ON r.Post_id = p.Post_id "
                + "JOIN Users u ON p.User_id = u.User_id "
                + "GROUP BY p.Post_id, p.User_id, p.Content, p.Status, u.Username, u.User_role, u.User_avatar,r.Status "
                + "HAVING COUNT(r.Report_id) >= 3";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int postId = rs.getInt("Post_id");
                int postUserId = rs.getInt("PostUserId");
                String content = rs.getString("Content");
                String postUsername = rs.getString("PostUsername");
                String userAvatar = rs.getString("User_avatar");
                int userRole = rs.getInt("User_role");
                String reasons = rs.getString("Reasons");
                String status = rs.getString("Status");
                String rpStatus = rs.getString("rpStatus");
                User user = new User(postUserId, userRole, postUsername, userAvatar);
                Post post = new Post(postId, postUserId, content, status);
                Report reportedPost = new Report(reasons, post, user, rpStatus);
                reportedPosts.add(reportedPost);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching reported posts with reasons", e);
        }

        return reportedPosts;
    }

    public static List<Report> getUsersReportedAtLeastThreeTimesWithReasons() {
        List<Report> reportedUsers = new ArrayList<>();
        String selectQuery = "SELECT u.User_id, u.Username,u.User_role, u.User_avatar, COUNT(r.Report_id) as ReportCount, STRING_AGG(r.Reason, '; ') as Reasons, r.Status as rpStatus "
                + "FROM Report r "
                + "JOIN Users u ON r.User_id = u.User_id "
                + "GROUP BY u.User_id, u.Username,u.User_role, u.User_avatar,r.Status "
                + "HAVING COUNT(r.Report_id) >= 3";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int userId = rs.getInt("User_id");
                String userAvatar = rs.getString("User_avatar");
                String username = rs.getString("Username");
                String reasons = rs.getString("Reasons");
                int userRole = rs.getInt("User_role");
                String rpStatus = rs.getString("rpStatus");
                User user = new User(userId, userRole, username, userAvatar);
                Report reportedUser = new Report(reasons, user, rpStatus);
                reportedUsers.add(reportedUser);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching reported users with reasons", e);
        }

        return reportedUsers;
    }

    public static boolean banUser(int userId) {
        String updateQuery = "UPDATE Users SET User_role = 0 WHERE User_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Update status in the report table
                String updateReportQuery = "UPDATE Report SET Status = 'Processed' WHERE User_id = ?";
                try (PreparedStatement updateReportStmt = conn.prepareStatement(updateReportQuery)) {
                    updateReportStmt.setInt(1, userId);
                    updateReportStmt.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Handle exception if needed
                }
            }

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean banPost(int postId) {
        String updateQuery = "UPDATE Post SET Status = 'inactive' WHERE Post_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, postId);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Update status in the report table
                String updateReportQuery = "UPDATE Report SET Status = 'Processed' WHERE Post_id = ?";
                try (PreparedStatement updateReportStmt = conn.prepareStatement(updateReportQuery)) {
                    updateReportStmt.setInt(1, postId);
                    updateReportStmt.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Handle exception if needed
                }
            }

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
public static boolean hasReported(int reporterId, String username) {
    String query = "SELECT COUNT(*) FROM Report " +
                   "JOIN Users ON Report.User_id = Users.User_id " +
                   "WHERE Report.Reporter_id = ? AND Users.Username = ?";
    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
         PreparedStatement stmt = conn.prepareStatement(query)) {

        stmt.setInt(1, reporterId);
        stmt.setString(2, username);

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            int count = rs.getInt(1);
            return count > 0;
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

public static boolean hasReportedPost(int reporterId, int postId) {
    String query = "SELECT COUNT(*) FROM Report WHERE Reporter_id = ? AND Post_id = ?";
    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
         PreparedStatement stmt = conn.prepareStatement(query)) {

        stmt.setInt(1, reporterId);
        stmt.setInt(2, postId);

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            int count = rs.getInt(1);
            return count > 0;
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
    
}
