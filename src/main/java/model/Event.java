package model;

import java.sql.Timestamp;

public class Event {

    private int eventId;
    private String title;
    private String description;
    private Timestamp startDate;
    private Timestamp endDate;
    private int userId; // Đây là Created_by trong bảng Event
    private String location;
    private Timestamp createdAt;
    private String uploadPath;

    // Constructors
    public Event() {
    }

    public Event(int eventId, String title, String description, Timestamp startDate, Timestamp endDate, int userId, String location, Timestamp createdAt) {
        this.eventId = eventId;
        this.title = title;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.userId = userId;
        this.location = location;
        this.createdAt = createdAt;
    }
    
    

    public Event(int eventId, String title, String description, Timestamp startDate, Timestamp endDate, int userId, String location, Timestamp createdAt, String uploadPath) {
        this.eventId = eventId;
        this.title = title;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.userId = userId; // Sử dụng userId để đại diện cho Created_by
        this.location = location;
        this.createdAt = createdAt;
        this.uploadPath = uploadPath;
    }

    // Getters and Setters
    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String uploadPath) {
        this.uploadPath = uploadPath;
    }
}
