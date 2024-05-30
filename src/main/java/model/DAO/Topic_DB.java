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
        String insertQuery = "INSERT INTO Topic (topic_name, description) VALUES (?, ?)";
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
        String deleteQuery = "DELETE FROM Topic WHERE topic_id = ?";
        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass);
             PreparedStatement pstmt = con.prepareStatement(deleteQuery)) {
            pstmt.setInt(1, topicId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Topic_DB.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
