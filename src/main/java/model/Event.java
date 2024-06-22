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
    private String place;
    private Timestamp createdAt;
    private String uploadPath;
    private boolean isInterest;

    // Constructors
    public Event() {
    }

    public Event(int eventId, String title, String description, Timestamp startDate, Timestamp endDate, int userId) {
        this.eventId = eventId;
        this.title = title;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.userId = userId;
    }

    public Event(int eventId, String title, String description, Timestamp startDate, Timestamp endDate, int userId, String location,String place, Timestamp createdAt) {
        this.eventId = eventId;
        this.title = title;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.userId = userId;
        this.location = location;
        this.place = place;
        this.createdAt = createdAt;
    }

    public Event(int eventId, String title, String description, Timestamp startDate, Timestamp endDate, int userId, String location, String place, Timestamp createdAt, String uploadPath) {
        this.eventId = eventId;
        this.title = title;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.userId = userId;
        this.location = location;
        this.place = place;
        this.createdAt = createdAt;
        this.uploadPath = uploadPath;
    }

    public Event(int eventId, String title, String description, Timestamp startDate, Timestamp endDate, int userId, String location, String place, Timestamp createdAt, String uploadPath, boolean isInterest) {
        this.eventId = eventId;
        this.title = title;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.userId = userId;
        this.location = location;
        this.place = place;
        this.createdAt = createdAt;
        this.uploadPath = uploadPath;
        this.isInterest = isInterest;
    }

    
    // Getters and Setters
    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {    
        this.place = place;
    }

    public boolean isIsInterest() {
        return isInterest;
    }

    public void setIsInterest(boolean isInterest) {
        this.isInterest = isInterest;
    }

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
