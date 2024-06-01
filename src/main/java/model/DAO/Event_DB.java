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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import model.DAO.DBinfo;
import model.Upload;
import model.Event;

public class Event_DB implements DBinfo {

    public Event_DB() {
        try {
            Class.forName(DBinfo.driver);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    public boolean addEvent(Event event, Upload upload) {
        String INSERT_EVENT_QUERY = "INSERT INTO Event (title, description, start_date, end_date, location, created_by, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String INSERT_UPLOAD_QUERY = "INSERT INTO Upload (event_id, uploadPath) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtEvent = con.prepareStatement(INSERT_EVENT_QUERY, PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement pstmtUpload = con.prepareStatement(INSERT_UPLOAD_QUERY)) {

            con.setAutoCommit(false);

            pstmtEvent.setString(1, event.getTitle());
            pstmtEvent.setString(2, event.getDescription());
            pstmtEvent.setTimestamp(3, event.getStartDate());
            pstmtEvent.setTimestamp(4, event.getEndDate());
            pstmtEvent.setString(5, event.getLocation());
            pstmtEvent.setInt(6, event.getUserId()); // Đặt userId (created_by) vào cột created_by
            pstmtEvent.setTimestamp(7, event.getCreatedAt());

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

    public List<Event> getAllEvents() {
        String SELECT_ALL_EVENTS_QUERY = "SELECT e.*, u.uploadPath FROM Event e LEFT JOIN Upload u ON e.Event_id = u.event_id";
        List<Event> eventList = new ArrayList<>();
        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(SELECT_ALL_EVENTS_QUERY)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("Event_id"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getTimestamp("Start_date"),
                        rs.getTimestamp("End_date"),
                        rs.getInt("Created_by"),
                        rs.getString("Location"),
                        rs.getTimestamp("Created_at")
                );
                // Lấy đường dẫn ảnh từ ResultSet
                String imagePath = rs.getString("uploadPath");
                // Kiểm tra nếu đường dẫn ảnh không rỗng thì thêm vào danh sách đường dẫn của Event
                if (imagePath != null && !imagePath.isEmpty()) {
                    event.setImagePaths(Collections.singletonList(imagePath));
                }
                eventList.add(event);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return eventList;
    }

    public static boolean updateEvent(Event event, Upload upload) {
        String UPDATE_EVENT_QUERY = "UPDATE Event SET title=?, description=?, start_date=?, end_date=?, location=?, created_by=?, created_at=? WHERE Event_id=?";
        String UPDATE_UPLOAD_QUERY = "UPDATE Upload SET uploadPath=? WHERE event_id=?";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtEvent = con.prepareStatement(UPDATE_EVENT_QUERY); PreparedStatement pstmtUpload = con.prepareStatement(UPDATE_UPLOAD_QUERY)) {

            con.setAutoCommit(false);

            pstmtEvent.setString(1, event.getTitle());
            pstmtEvent.setString(2, event.getDescription());
            pstmtEvent.setTimestamp(3, event.getStartDate());
            pstmtEvent.setTimestamp(4, event.getEndDate());
            pstmtEvent.setString(5, event.getLocation());
            pstmtEvent.setInt(6, event.getUserId());
            pstmtEvent.setTimestamp(7, event.getCreatedAt());
            pstmtEvent.setInt(8, event.getEventId());

            int affectedRows = pstmtEvent.executeUpdate();
            if (affectedRows == 0) {
                con.rollback();
                return false;
            }

            pstmtUpload.setString(1, upload.getUploadPath());
            pstmtUpload.setInt(2, event.getEventId());
            pstmtUpload.executeUpdate();

            con.commit();
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static Event getEventById(int eventId) {
        String SELECT_EVENT_BY_ID_QUERY = "SELECT e.*, u.uploadPath FROM Event e LEFT JOIN Upload u ON e.Event_id = u.event_id WHERE e.Event_id = ?";
        Event event = null;
        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(SELECT_EVENT_BY_ID_QUERY)) {

            pstmt.setInt(1, eventId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                if (event == null) {
                    event = new Event(
                            rs.getInt("Event_id"),
                            rs.getString("Title"),
                            rs.getString("Description"),
                            rs.getTimestamp("Start_date"),
                            rs.getTimestamp("End_date"),
                            rs.getInt("Created_by"),
                            rs.getString("Location"),
                            rs.getTimestamp("Created_at")
                    );
                    event.setImagePaths(new ArrayList<>());
                }
                String imagePath = rs.getString("uploadPath");
                if (imagePath != null && !imagePath.isEmpty()) {
                    event.getImagePaths().add(imagePath);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return event;
    }
}
