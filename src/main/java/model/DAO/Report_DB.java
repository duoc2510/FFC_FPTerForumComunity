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
        String selectQuery = "SELECT Report_id FROM Report "
                + "WHERE Reporter_id = ? "
                + "  AND User_id = ? "
                + "  AND Shop_id = ? "
                + "  AND Post_id = ?";

        String updateQuery = "UPDATE Report SET Status = ?, Reason = ? "
                + "WHERE Reporter_id = ? "
                + "  AND User_id = ? "
                + "  AND Shop_id = ? "
                + "  AND Post_id = ?";

        String insertQuery = "INSERT INTO Report (Reporter_id, User_id, Shop_id, Post_id, Reason, Status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement selectStmt = conn.prepareStatement(selectQuery); PreparedStatement updateStmt = conn.prepareStatement(updateQuery); PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {

            // Thiết lập các giá trị cho câu lệnh SELECT
            selectStmt.setInt(1, report.getReporter_id());
            selectStmt.setInt(2, report.getUserId());
            selectStmt.setInt(3, report.getShopId());
            selectStmt.setInt(4, report.getPostId());

            // Thực thi câu lệnh SELECT để kiểm tra sự tồn tại của báo cáo
            try (ResultSet rs = selectStmt.executeQuery()) {
                if (rs.next()) {
                    // Báo cáo đã tồn tại, cập nhật trạng thái và lý do
                    updateStmt.setString(1, report.getStatus());
                    updateStmt.setString(2, report.getReason());
                    updateStmt.setInt(3, report.getReporter_id());
                    updateStmt.setInt(4, report.getUserId());
                    updateStmt.setInt(5, report.getShopId());
                    updateStmt.setInt(6, report.getPostId());

                    int rowsUpdated = updateStmt.executeUpdate();
                    return rowsUpdated > 0;
                } else {
                    // Báo cáo chưa tồn tại, thêm mới báo cáo
                    insertStmt.setInt(1, report.getReporter_id());

                    // Xử lý userId
                    if (report.getUserId() == 0) {
                        insertStmt.setNull(2, Types.INTEGER);
                    } else {
                        insertStmt.setInt(2, report.getUserId());
                    }

                    // Xử lý shopId
                    if (report.getShopId() == 0) {
                        insertStmt.setNull(3, Types.INTEGER);
                    } else {
                        insertStmt.setInt(3, report.getShopId());
                    }

                    // Xử lý postId
                    if (report.getPostId() == 0) {
                        insertStmt.setNull(4, Types.INTEGER);
                    } else {
                        insertStmt.setInt(4, report.getPostId());
                    }

                    // Thiết lập lý do và trạng thái
                    insertStmt.setString(5, report.getReason());
                    insertStmt.setString(6, report.getStatus());

                    int rowsInserted = insertStmt.executeUpdate();
                    return rowsInserted > 0;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while inserting or updating report", e);
            return false;
        }
    }

    public static List<Report> getAllReports() {
        List<Report> reports = new ArrayList<>();
        String selectQuery = "SELECT r.Report_id, r.Reporter_id, r.User_id,u.User_avatar, r.Post_id, r.Reason, r.Status, "
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
                String userAvatar = rs.getString("User_avatar");
                if (userAvatar == null) {
                    userAvatar = "static/images/user-default.webp";
                }
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
                User reportedUser = new User(userId, reportedUserName, userAvatar);

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
        String selectQuery = "SELECT p.Post_id, p.User_id as PostUserId, p.Content, p.Status, u.Username as PostUsername, u.User_role, u.User_avatar, r.Status as rpStatus, "
                + "COUNT(r.Report_id) as ReportCount, STRING_AGG(r.Reason, '; ') as Reasons "
                + "FROM Report r "
                + "JOIN Post p ON r.Post_id = p.Post_id "
                + "JOIN Users u ON p.User_id = u.User_id "
                + "GROUP BY p.Post_id, p.User_id, p.Content, p.Status, u.Username, u.User_role, u.User_avatar, r.Status "
                + "HAVING COUNT(r.Report_id) >= 3";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {

                int postId = rs.getInt("Post_id");
                int postUserId = rs.getInt("PostUserId");
                String content = rs.getString("Content");
                String postUsername = rs.getString("PostUsername");
                String userAvatar = rs.getString("User_avatar");
                if (userAvatar == null) {
                    userAvatar = "static/images/user-default.webp";
                }
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
        String selectQuery = "SELECT u.User_id, u.Username, u.User_role, u.User_avatar, COUNT(r.Report_id) as ReportCount, STRING_AGG(r.Reason, '; ') as Reasons, r.Status as rpStatus "
                + "FROM Report r "
                + "JOIN Users u ON r.User_id = u.User_id "
                + "WHERE r.Post_id IS NULL " // Loại bỏ các báo cáo từ bài viết
                + "GROUP BY u.User_id, u.Username, u.User_role, u.User_avatar, r.Status "
                + "HAVING COUNT(r.Report_id) >= 3";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {

                int userId = rs.getInt("User_id");
                String userAvatar = rs.getString("User_avatar");
                if (userAvatar == null) {
                    userAvatar = "static/images/user-default.webp";
                }
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

    public static boolean userReportedAtLeastThreeTimes(int userId) {
        System.out.println("Checking if user with ID " + userId + " has been reported at least three times.");

        String selectQuery = "SELECT COUNT(*) as ReportCount "
                + "FROM Report "
                + "WHERE User_id = ? "
                + "  AND Post_id IS NULL "
                + "  AND Status = 'pending'"; // Thêm điều kiện Status = 'pending'

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery)) {

            System.out.println("Database connection established.");

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                System.out.println("SQL query executed.");

                if (rs.next()) {
                    int reportCount = rs.getInt("ReportCount");
                    System.out.println("User with ID " + userId + " has " + reportCount + " reports.");
                    return reportCount >= 3;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error occurred while checking report count for user with ID " + userId);
        }

        return false;
    }

    public static boolean banUser(int userId) {
        String updateQuery = "UPDATE Users SET User_role = 0 WHERE User_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Update status in the report table where Post_id is null
                String updateReportQuery = "UPDATE Report SET Status = 'Processed' WHERE User_id = ? AND Post_id IS NULL";
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

    public static boolean revokeManagerPrivileges(int userId) {
        String updateQuery = "UPDATE Users SET User_role = 1 WHERE User_id = ?";

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

    public static boolean revokeManager(int userId) {
        String updateQuery = "UPDATE Users SET User_role = 1 WHERE User_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean banUserByAd(int userId) {
        String updateQuery = "UPDATE Users SET User_role = 0 WHERE User_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean unBanUser(int userId) {
        String updateQuery = "UPDATE Users SET User_role = 1 WHERE User_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean setManager(int userId) {
        String updateQuery = "UPDATE Users SET User_role = 2 WHERE User_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean approveManager(int userId) {
        String updateQuery = "UPDATE Users SET User_role = 2 WHERE User_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                // Update status in the report table
                String updateApproveQuery = "UPDATE managerRegistr SET Status = 'Approved' WHERE User_id = ?";
                try (PreparedStatement updateReportStmt = conn.prepareStatement(updateApproveQuery)) {
                    updateReportStmt.setInt(1, userId);
                    updateReportStmt.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Handle exception if needed
                    System.err.println("Error updating managerRegistr table: " + e.getMessage());
                }
            }
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Database error: " + e.getMessage());
            return false;
        }
    }

    public static List<Integer> getReporterIdsByUserId(int userId) {
        List<Integer> reporterIds = new ArrayList<>();
        String selectQuery = "SELECT Reporter_id FROM Report WHERE User_id = ? AND Post_id IS NULL";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int reporterId = rs.getInt("Reporter_id");
                    reporterIds.add(reporterId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching reporter IDs by user ID", e);
        }

        return reporterIds;
    }

    public static List<Integer> getReporterIdsByPostId(int postId) {
        List<Integer> reporterIds = new ArrayList<>();
        String selectQuery = "SELECT Reporter_id FROM Report WHERE Post_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery)) {
            stmt.setInt(1, postId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int reporterId = rs.getInt("Reporter_id");
                    reporterIds.add(reporterId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching reporter IDs by post ID", e);
        }

        return reporterIds;
    }

    public static boolean cancelApproveManager(int userId) {
        String query = "UPDATE managerRegistr SET Status = 'cancelled' WHERE User_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một dòng được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Database error: " + e.getMessage());
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public static boolean banPost(int postId, String banReason) {
        String updateQuery = "UPDATE Post SET Status = 'banned', Reason = ? WHERE Post_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setString(1, banReason);
            stmt.setInt(2, postId);

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

    public static boolean banPostByAd(int postId, String banReason) {
        String updateQuery = "UPDATE Post SET Status = 'banned', Reason = ? WHERE Post_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setString(1, banReason);
            stmt.setInt(2, postId);

            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean hasReported(int reporterId, String username) {
        String query = "SELECT COUNT(*) FROM Report "
                + "WHERE Reporter_id = ? AND (Status = 'pending' OR Status = 'pendingM') "
                + "AND User_id = (SELECT User_id FROM Users WHERE Username = ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, reporterId);
            stmt.setString(2, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while checking report status", e);
        }
        return false;
    }

    public static boolean hasReportedPost(int reporterId, int postId) {
        String query = "SELECT COUNT(*) FROM Report WHERE Reporter_id = ? AND Post_id = ? AND (Status = 'pending' OR Status = 'pendingM')";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {

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

    public static boolean cancelReport(int reporterId, int postId) {
        String updateQuery = "UPDATE Report SET Status = 'cancelled' "
                + "WHERE Reporter_id = ? AND Post_id = ? AND (Status = 'pending' OR Status = 'pendingM')";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, reporterId);
            stmt.setInt(2, postId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while cancelling report", e);
            return false;
        }
    }

    public static boolean editReport(int reporterId, int postId, String newReason) {
        String updateQuery = "UPDATE Report SET Reason = ? "
                + "WHERE Reporter_id = ? AND Post_id = ? AND (Status = 'pending' OR Status = 'pendingM')";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setString(1, newReason);
            stmt.setInt(2, reporterId);
            stmt.setInt(3, postId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while editing report", e);
            return false;
        }
    }

    public static boolean cancelReportUser(int reporterId, int userId) {
        String updateQuery = "UPDATE Report SET Status = 'cancelled' "
                + "WHERE Reporter_id = ? AND User_id = ? AND (Status = 'pending' OR Status = 'pendingM')";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, reporterId);
            stmt.setInt(2, userId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while cancelling report", e);
            return false;
        }
    }

    public static boolean editReportUser(int reporterId, int userId, String newReason) {
        String updateQuery = "UPDATE Report SET Reason = ? "
                + "WHERE Reporter_id = ? AND User_id = ? AND (Status = 'pending' OR Status = 'pendingM')";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setString(1, newReason);
            stmt.setInt(2, reporterId);
            stmt.setInt(3, userId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while editing report", e);
            return false;
        }
    }

    public static boolean cancelReportMgU(int userId) {
        String updateQuery = "UPDATE Report SET Status = 'cancelled' WHERE User_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while cancelling report", e);
            return false;
        }
    }

    public static boolean cancelReportMgP(int postId) {
        String updateQuery = "UPDATE Report SET Status = 'cancelled' WHERE Post_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

            stmt.setInt(1, postId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while cancelling report", e);
            return false;
        }
    }

    public static boolean postReportedAtLeastThreeTimes(int postId) {
        System.out.println("Checking if post with ID " + postId + " has been reported at least three times.");

        String selectQuery = "SELECT COUNT(*) as ReportCount "
                + "FROM Report "
                + "WHERE Post_id = ? "
                + "  AND Status = 'pending'"; // Thêm điều kiện Status = 'pending'

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery)) {

            System.out.println("Database connection established.");

            stmt.setInt(1, postId);

            try (ResultSet rs = stmt.executeQuery()) {
                System.out.println("SQL query executed.");

                if (rs.next()) {
                    int reportCount = rs.getInt("ReportCount");
                    System.out.println("Post with ID " + postId + " has " + reportCount + " reports.");
                    return reportCount >= 3;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error occurred while checking report count for post with ID " + postId);
        }

        return false;
    }

    public static List<Report> getReportsByUserId(int userId) {
        List<Report> reports = new ArrayList<>();
        String selectQuery = "SELECT * FROM Report WHERE User_id = ? AND Post_id IS NULL";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Report report = new Report(
                            rs.getInt("Report_id"),
                            rs.getInt("Reporter_id"),
                            rs.getInt("User_id"),
                            rs.getInt("Post_id"),
                            rs.getString("Reason"),
                            rs.getString("Status")
                    );
                    reports.add(report);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching reports by user ID", e);
        }

        return reports;
    }

    public static List<Report> getReportsByPostId(int postId) {
        List<Report> reports = new ArrayList<>();
        String selectQuery = "SELECT * FROM Report WHERE Post_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery)) {
            stmt.setInt(1, postId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Report report = new Report(
                            rs.getInt("Report_id"),
                            rs.getInt("Reporter_id"),
                            rs.getInt("User_id"),
                            rs.getInt("Post_id"),
                            rs.getString("Reason"),
                            rs.getString("Status")
                    );
                    reports.add(report);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(Report_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching reports by post ID", e);
        }

        return reports;
    }

    public static void main(String[] args) {
        int userId = 4;
        List<Report> reports = getReportsByUserId(userId);
        List<Integer> reporterIds = new ArrayList<>();

        for (Report report : reports) {
            if ("pending".equals(report.getStatus())) {
                reporterIds.add(report.getReporter_id());
            }
        }

        System.out.println("Reporter IDs with status 'pending' for user ID " + userId + ": " + reporterIds);
    }
}
