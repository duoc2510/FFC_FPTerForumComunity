package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Topic;

public class Topic_DB implements DBinfo {

    public Topic_DB() {
        try {
            Class.forName(DBinfo.driver);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    public static List<Topic> getAllTopics() {
        List<Topic> topics = new ArrayList<>();
        String sql = "SELECT * FROM Topic";
        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Topic topic = new Topic();
                topic.setTopicId(rs.getInt("Topic_id"));
                topic.setTopicName(rs.getString("Topic_name"));
                topic.setDescription(rs.getString("Description"));
                topics.add(topic);
            }

            // Kiểm tra và in ra danh sách các chủ đề
            if (!topics.isEmpty()) {
                for (Topic topic : topics) {
                    System.out.println("Topic ID: " + topic.getTopicId());
                    System.out.println("Topic Name: " + topic.getTopicName());
                    System.out.println("Description: " + topic.getDescription());
                    System.out.println("---------------------------");
                }
            } else {
                System.out.println("No topics found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return topics;
    }

    public static boolean addTopic(Topic topic) {
        String insertQuery = "INSERT INTO Topic (Topic_name, Description) VALUES (?, ?)";
        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(insertQuery)) {

            pstmt.setString(1, topic.getTopicName());
            pstmt.setString(2, topic.getDescription());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Topic_DB.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static boolean deleteTopic(int topicId) {
        String deleteUserFollowQuery = "DELETE FROM UserFollow WHERE Topic_id = ?";
        String deletePostQuery = "DELETE FROM Post WHERE Topic_id = ?";
        String deleteTopicQuery = "DELETE FROM Topic WHERE Topic_id = ?";
        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtUserFollow = con.prepareStatement(deleteUserFollowQuery); PreparedStatement pstmtPost = con.prepareStatement(deletePostQuery); PreparedStatement pstmtTopic = con.prepareStatement(deleteTopicQuery)) {

            // Xóa dữ liệu từ bảng UserFollow có chứa Topic_id
            pstmtUserFollow.setInt(1, topicId);
            pstmtUserFollow.executeUpdate();

            // Xóa dữ liệu từ bảng Post có chứa Topic_id
            pstmtPost.setInt(1, topicId);
            pstmtPost.executeUpdate();

            // Xóa dữ liệu từ bảng Topic có Topic_id tương ứng
            pstmtTopic.setInt(1, topicId);
            int rowsAffected = pstmtTopic.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Topic_DB.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // Method to follow a topic
    public static boolean followTopic(int userId, int topicId) {
        String sql = "INSERT INTO UserFollow (User_id, Topic_id) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.setInt(2, topicId);

            pstmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.err.println("SQL error: " + e.getMessage());
            return false;
        }
    }

    // Method to unfollow a topic
    public static boolean unfollowTopic(int userId, int topicId) {
        String sql = "DELETE FROM UserFollow WHERE User_id = ? AND Topic_id = ?";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.setInt(2, topicId);

            pstmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.err.println("SQL error: " + e.getMessage());
            return false;
        }
    }

    public static boolean isFollowingTopic(int userId, int topicId) {
        String sql = "SELECT COUNT(*) FROM UserFollow WHERE User_id = ? AND Topic_id = ?";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.setInt(2, topicId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0; // Returns true if count is greater than 0, meaning the user is following the topic
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL error: " + e.getMessage());
        }
        return false; // Returns false if no record is found or if an SQL error occurs
    }
}
