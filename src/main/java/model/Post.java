/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

public class Post {

    private int postId;
    private int userId;
    private int groupId;
    private int topicId;
    private String content;
    private Timestamp createDate;
    private String upload;
    private String status;
    private String postStatus;
    private String reason;

    public Post() {
    }

    public Post(int postId, int userId, int groupId, int topicId, String content, Timestamp createDate, String upload, String status, String postStatus, String reason) {
        this.postId = postId;
        this.userId = userId;
        this.groupId = groupId;
        this.topicId = topicId;
        this.content = content;
        this.createDate = createDate;
        this.upload = upload;
        this.status = status;
        this.postStatus = postStatus;
        this.reason = reason;
    }

    public Post(int userId, int groupId, int topicId, String content, Timestamp createDate, String upload, String status, String postStatus, String reason) {
        this.userId = userId;
        this.groupId = groupId;
        this.topicId = topicId;
        this.content = content;
        this.createDate = createDate;
        this.upload = upload;
        this.status = status;
        this.postStatus = postStatus;
        this.reason = reason;
    }

    public String getUpload() {
        return upload;
    }

    public void setUpload(String upload) {
        this.upload = upload;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getTopicId() {
        return topicId;
    }

    public void setTopicId(int topicId) {
        this.topicId = topicId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPostStatus() {
        return postStatus;
    }

    public void setPostStatus(String postStatus) {
        this.postStatus = postStatus;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
