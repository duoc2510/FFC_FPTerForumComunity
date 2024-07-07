package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import model.Upload;
import model.Event;
import org.json.JSONArray;
import org.json.JSONObject;

public class Event_DB {

    public Event_DB() {
        try {
            Class.forName(DBinfo.driver);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    public boolean addEvent(Event event, Upload upload) {
        String INSERT_EVENT_QUERY = "INSERT INTO Event (title, description, start_date, end_date, location, place, created_by, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        String INSERT_UPLOAD_QUERY = "INSERT INTO Upload (event_id, uploadPath) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtEvent = con.prepareStatement(INSERT_EVENT_QUERY, PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement pstmtUpload = con.prepareStatement(INSERT_UPLOAD_QUERY)) {

            con.setAutoCommit(false);

            pstmtEvent.setString(1, event.getTitle());
            pstmtEvent.setString(2, event.getDescription());
            pstmtEvent.setTimestamp(3, event.getStartDate());
            pstmtEvent.setTimestamp(4, event.getEndDate());
            pstmtEvent.setString(5, event.getLocation());
            pstmtEvent.setString(6, event.getPlace());
            pstmtEvent.setInt(7, event.getUserId());
            pstmtEvent.setTimestamp(8, event.getCreatedAt());

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

    public static List<Event> getAllEvents() {
        String SELECT_ALL_EVENTS_QUERY = "SELECT e.*, u.uploadPath FROM Event e LEFT JOIN Upload u ON e.Event_id = u.event_id";
        List<Event> eventList = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
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
                        rs.getString("Place"),
                        rs.getTimestamp("Created_at"),
                        rs.getString("uploadPath")
                );
                // Format the dates
                event.setFormattedStartDate(sdf.format(event.getStartDate()));
                event.setFormattedEndDate(sdf.format(event.getEndDate()));
                eventList.add(event);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return eventList;
    } 
    public static String getAllEventsAsJson() {
        String SELECT_ALL_EVENTS_QUERY = "SELECT e.*, u.uploadPath FROM Event e LEFT JOIN Upload u ON e.Event_id = u.event_id";
        List<Event> eventList = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

        // JSON array to hold events
        JSONArray jsonArray = new JSONArray();

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
                        rs.getString("Place"),
                        rs.getTimestamp("Created_at"),
                        rs.getString("uploadPath")
                );
                // Format the start date
                String formattedStartDate = sdf.format(event.getStartDate());

                // Create JSON object for each event
                JSONObject jsonEvent = new JSONObject();
                jsonEvent.put("title", event.getTitle());
                jsonEvent.put("start", formattedStartDate);

                // Add event object to JSON array
                jsonArray.put(jsonEvent);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        // Convert JSON array to string and return
        return jsonArray.toString();
    }

    public static List<Event> getAllEvents(int userId) {
        List<Event> eventList = new ArrayList<>();
        String GET_ALL_EVENTS_QUERY = "SELECT e.*, "
                + "(SELECT COUNT(*) FROM UserFollow uf WHERE uf.event_id = e.event_id AND uf.user_id = ?) as is_interested "
                + "FROM Event e";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(GET_ALL_EVENTS_QUERY)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Event event = new Event();
                    event.setEventId(rs.getInt("event_id"));
                    event.setTitle(rs.getString("title"));
                    event.setDescription(rs.getString("description"));
                    event.setStartDate(rs.getTimestamp("start_date"));
                    event.setEndDate(rs.getTimestamp("end_date"));
                    event.setLocation(rs.getString("location"));
                    event.setPlace(rs.getString("place"));
                    event.setUploadPath(rs.getString("upload_path"));
                    eventList.add(event);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return eventList;
    }

    public static boolean updateEvent(Event event, String newUploadPath) {
        boolean success = false;
        String updateEventQuery = "UPDATE Event SET title = ?, description = ?, start_date = ?, end_date = ?, location = ?, place = ?, created_by = ?, created_at = ? WHERE Event_id = ?";
        String updateUploadQuery = "UPDATE Upload SET uploadPath = ? WHERE event_id = ?";

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass)) {
            try {
                // Start transaction
                conn.setAutoCommit(false);

                // Update event details
                try (PreparedStatement updateEventStmt = conn.prepareStatement(updateEventQuery)) {
                    updateEventStmt.setString(1, event.getTitle());
                    updateEventStmt.setString(2, event.getDescription());
                    updateEventStmt.setTimestamp(3, event.getStartDate());
                    updateEventStmt.setTimestamp(4, event.getEndDate());
                    updateEventStmt.setString(5, event.getLocation());
                    updateEventStmt.setString(6, event.getPlace());
                    updateEventStmt.setInt(7, event.getUserId());

                    // Get the current timestamp and set it for created_at
                    Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
                    updateEventStmt.setTimestamp(8, currentTimestamp);

                    updateEventStmt.setInt(9, event.getEventId());

                    int rowsUpdatedEvent = updateEventStmt.executeUpdate();
                    success = (rowsUpdatedEvent > 0);
                }

                // If newUploadPath is not null, update the upload path
                if (newUploadPath != null) {
                    try (PreparedStatement updateUploadStmt = conn.prepareStatement(updateUploadQuery)) {
                        updateUploadStmt.setString(1, newUploadPath);
                        updateUploadStmt.setInt(2, event.getEventId());

                        int rowsUpdatedUpload = updateUploadStmt.executeUpdate();
                        success = success && (rowsUpdatedUpload > 0);
                    }
                }

                // Commit transaction if both updates are successful
                if (success) {
                    conn.commit();
                    System.out.println("Event with ID " + event.getEventId() + " was successfully updated.");
                } else {
                    conn.rollback();
                    System.out.println("Failed to update event with ID " + event.getEventId() + ".");
                }
            } catch (SQLException ex) {
                conn.rollback();
                ex.printStackTrace();
                System.out.println("Failed to update event with ID " + event.getEventId() + ".");
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Failed to update event with ID " + event.getEventId() + ".");
        }

        return success;
    }

    public static Event getEventById(int eventId) {
        String SELECT_EVENT_BY_ID_QUERY = "SELECT e.*, u.uploadPath FROM Event e LEFT JOIN Upload u ON e.Event_id = u.event_id WHERE e.Event_id = ?";
        Event event = null;
        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(SELECT_EVENT_BY_ID_QUERY)) {

            pstmt.setInt(1, eventId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                event = new Event(
                        rs.getInt("Event_id"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getTimestamp("Start_date"),
                        rs.getTimestamp("End_date"),
                        rs.getInt("Created_by"),
                        rs.getString("Location"),
                        rs.getString("Place"),
                        rs.getTimestamp("Created_at"),
                        rs.getString("uploadPath")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return event;
    }

    public boolean deleteEvent(int eventId) {
        String DELETE_UPLOAD_QUERY = "DELETE FROM Upload WHERE event_id = ?";
        String DELETE_USERFOLLOW_QUERY = "DELETE FROM UserFollow WHERE Event_id = ?";
        String DELETE_EVENT_QUERY = "DELETE FROM Event WHERE Event_id = ?";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtUpload = con.prepareStatement(DELETE_UPLOAD_QUERY); PreparedStatement pstmtUserFollow = con.prepareStatement(DELETE_USERFOLLOW_QUERY); PreparedStatement pstmtEvent = con.prepareStatement(DELETE_EVENT_QUERY)) {

            con.setAutoCommit(false);

            // Delete from Upload table first
            pstmtUpload.setInt(1, eventId);
            pstmtUpload.executeUpdate();

            // Delete from UserFollow table
            pstmtUserFollow.setInt(1, eventId);
            pstmtUserFollow.executeUpdate();

            // Delete from Event table
            pstmtEvent.setInt(1, eventId);
            int affectedRows = pstmtEvent.executeUpdate();

            if (affectedRows > 0) {
                con.commit();
                return true;
            } else {
                con.rollback();
                return false;
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static boolean checkUserInterest(int userId, int eventId) {
        String CHECK_USER_INTEREST_QUERY = "SELECT * FROM UserFollow WHERE user_id = ? AND event_id = ?";
        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(CHECK_USER_INTEREST_QUERY)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, eventId);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next(); // Returns true if a record is found, otherwise false
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static boolean addUserInterest(int userId, int eventId) {
        String INSERT_USER_INTEREST_QUERY = "INSERT INTO UserFollow (user_id, event_id) VALUES (?, ?)";
        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(INSERT_USER_INTEREST_QUERY)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, eventId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static boolean deleteUserInterest(int userId, int eventId) {
        String DELETE_USER_INTEREST_QUERY = "DELETE FROM UserFollow WHERE user_id = ? AND event_id = ?";
        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmt = con.prepareStatement(DELETE_USER_INTEREST_QUERY)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, eventId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

}
