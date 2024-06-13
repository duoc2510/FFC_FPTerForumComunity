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
public class User_message {

    private int messageId;
    private int fromId;
    private int toId;
    private String messageText;
    private java.sql.Timestamp timeStamp;

    public User_message() {
    }

    public User_message(int messageId, int fromId, int toId, String messageText, Timestamp timeStamp) {
        this.messageId = messageId;
        this.fromId = fromId;
        this.toId = toId;
        this.messageText = messageText;
        this.timeStamp = timeStamp;
    }

    // Getters and Setters
    public int getMessageId() {
        return messageId;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public int getFromId() {
        return fromId;
    }

    public void setFromId(int fromId) {
        this.fromId = fromId;
    }

    public int getToId() {
        return toId;
    }

    public void setToId(int toId) {
        this.toId = toId;
    }

    public String getMessageText() {
        return messageText;
    }

    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }

    public java.sql.Timestamp getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(java.sql.Timestamp timeStamp) {
        this.timeStamp = timeStamp;
    }
}
