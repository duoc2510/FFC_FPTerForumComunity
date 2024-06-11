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
import java.util.ArrayList;
import java.util.List;
import model.DAO.DBinfo;
import model.Upload;
import model.User_event;

public class Event_DB implements DBinfo {

    public Event_DB() {
        try {
            Class.forName(DBinfo.driver);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    public boolean addEvent(User_event event, Upload upload) {
        String insertEventQuery = "INSERT INTO User_event (title, description, start_date, end_date, user_id) VALUES (?, ?, ?, ?, ?)";
        String insertUploadQuery = "INSERT INTO Upload (event_id, uploadPath) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtEvent = con.prepareStatement(insertEventQuery, PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement pstmtUpload = con.prepareStatement(insertUploadQuery)) {
            con.setAutoCommit(false);
            pstmtEvent.setString(1, event.getTitle());
            pstmtEvent.setString(2, event.getDescription());
            pstmtEvent.setTimestamp(3, event.getStartDate());
            pstmtEvent.setTimestamp(4, event.getEndDate());
            pstmtEvent.setInt(5, event.getUserId());

            int affectedRows = pstmtEvent.executeUpdate();
            if (affectedRows == 0) {
                con.rollback();
                return false;
            }

            ResultSet generatedKeys = pstmtEvent.getGeneratedKeys();
            int eventId;
            if (generatedKeys.next()) {
                eventId = generatedKeys.getInt(1);
            } else {
                con.rollback();
                return false;
            }

            pstmtUpload.setInt(1, eventId);
            pstmtUpload.setString(2, upload.getUploadPath());
            pstmtUpload.executeUpdate();

            con.commit();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static List<User_event> getAllEvents() {
        List<User_event> events = new ArrayList<>();
        String query = "SELECT event_id, title, description, start_date, end_date, user_id FROM User_event";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                User_event event = new User_event();
                event.setEventId(rs.getInt("event_id"));
                event.setTitle(rs.getString("title"));
                event.setDescription(rs.getString("description"));
                event.setStartDate(rs.getTimestamp("start_date"));
                event.setEndDate(rs.getTimestamp("end_date"));
                event.setUserId(rs.getInt("user_id"));

                // Fetch image paths for the event
                List<String> imagePaths = getImagePathsForEvent(event.getEventId());
                event.setImagePaths(imagePaths);

                events.add(event);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return events;
    }

    // Helper method to fetch image paths for a specific event
    public static List<String> getImagePathsForEvent(int eventId) {
        List<String> imagePaths = new ArrayList<>();
        String query = "SELECT uploadPath FROM Upload WHERE event_id = ?";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, eventId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    imagePaths.add(rs.getString("uploadPath"));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return imagePaths;
    }

}
