/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PC
 */
public class UserFollow {
    private int userFollowId;
    private int userId;
    private Integer eventId;  // Dùng Integer để chấp nhận giá trị null
    private Integer topicId;  // Dùng Integer để chấp nhận giá trị null

    public UserFollow() {
    }

    public UserFollow(int userId, Integer eventId, Integer topicId) {
        this.userId = userId;
        this.eventId = eventId;
        this.topicId = topicId;
    }

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