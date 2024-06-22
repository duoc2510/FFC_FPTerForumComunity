/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ThanhDuoc
 */
public class User_follow {

    private int userFollowId;
    private int userId;
    private Integer eventId; // Using Integer for nullable field
    private Integer topicId; // Using Integer for nullable field

    public User_follow() {
    }

    public User_follow(int userFollowId, int userId, Integer eventId, Integer topicId) {
        this.userFollowId = userFollowId;
        this.userId = userId;
        this.eventId = eventId;
        this.topicId = topicId;
    }

    // Getters and Setters
    public int getUserFollowId() {
        return userFollowId;
    }

    public void setUserFollowId(int userFollowId) {
        this.userFollowId = userFollowId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Integer getEventId() {
        return eventId;
    }

    public void setEventId(Integer eventId) {
        this.eventId = eventId;
    }

    public Integer getTopicId() {
        return topicId;
    }

    public void setTopicId(Integer topicId) {
        this.topicId = topicId;
    }
}
