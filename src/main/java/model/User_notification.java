/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author ThanhDuoc
 */
public class User_notification {

    private int notificationId;
    private int userId;
    private String message;
    private java.sql.Timestamp date;
    private String status;
    private String notification_link;

    public User_notification() {
    }

    public User_notification(int notificationId, int userId, String message, Timestamp date, String status, String notification_link) {
        this.notificationId = notificationId;
        this.userId = userId;
        this.message = message;
        this.date = date;
        this.status = status;
        this.notification_link = notification_link;

    }

    // Getters and Setters
    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public java.sql.Timestamp getDate() {
        return date;
    }

    public void setDate(java.sql.Timestamp date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotification_link() {
        return notification_link;
    }

    public void setNotification_link(String notification_link) {
        this.notification_link = notification_link;
    }

    @Override
    public String toString() {
        return "User_notification{" + "notificationId=" + notificationId + ", userId=" + userId + ", message=" + message + ", date=" + date + ", status=" + status + ", notification_link=" + notification_link + '}';
    }

}
