/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ThanhDuoc
 */
public class Topic_user {
    private int userTopicId;
    private int userId;
    private int topicId;

    public Topic_user() {
    }
    
    public Topic_user(int userTopicId, int userId, int topicId) {
        this.userTopicId = userTopicId;
        this.userId = userId;
        this.topicId = topicId;
    }

    public int getUserTopicId() {
        return userTopicId;
    }

    public void setUserTopicId(int userTopicId) {
        this.userTopicId = userTopicId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTopicId() {
        return topicId;
    }

    public void setTopicId(int topicId) {
        this.topicId = topicId;
    }
}
