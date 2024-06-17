package model;

import java.sql.Timestamp;
import java.util.List;

public class Post {

    private int postId;
    private int userId;
    private int groupId;
    private int topicId;
    private String content;
    private String createDate;
    private String status;
    private String postStatus;
    private String reason;
    private String uploadPath;
    private String comment;
    private Timestamp commentDate; // Thêm trường commentDate
    private User user;
    private List<Comment> comments;
    private boolean hasReportPost;
    public Post() {
    }

    public Post(int postId, int userId, int groupId, String content, String createDate, String status) {
        this.postId = postId;
        this.userId = userId;
        this.groupId = groupId;
        this.content = content;
        this.createDate = createDate;
        this.status = status;
    }

    public Post(int postId, int userId, String content, String status) {
        this.postId = postId;
        this.userId = userId;
        this.content = content;
        this.status = status;
    }

 

    public Post(int userId, int groupId, String content, String createDate, String status, String postStatus, String uploadPath) {
        this.userId = userId;
        this.groupId = groupId;
        this.content = content;
        this.createDate = createDate;
        this.status = status;
        this.postStatus = postStatus;
        this.uploadPath = uploadPath;
    }

    // Constructors
    // Constructor cho trường hợp không có commentDate
    public Post(int userId, String content, String status, String postStatus, String uploadPath) {
        this.userId = userId;
        this.content = content;
        this.status = status;
        this.postStatus = postStatus;
        this.uploadPath = uploadPath;
    }

    public Post(int postId, int userId, int groupId, String content, String status, String postStatus, String uploadPath) {
        this.postId = postId;
        this.userId = userId;
        this.groupId = groupId;
        this.content = content;
        this.status = status;
        this.postStatus = postStatus;
        this.uploadPath = uploadPath;
    }

    // Constructor cho trường hợp có commentDate
    public Post(int postId, int userId, int groupId, int topicId, String content, String createDate, String status, String postStatus, String reason, String uploadPath, String comment, Timestamp commentDate) {
        this.postId = postId;
        this.userId = userId;
        this.groupId = groupId;
        this.topicId = topicId;
        this.content = content;
        this.createDate = createDate;
        this.status = status;
        this.postStatus = postStatus;
        this.reason = reason;
        this.uploadPath = uploadPath;
        this.comment = comment;
        this.commentDate = commentDate;
    }

    public Post(int postId, int userId, int groupId, int topicId, String content, String createDate, String status, String postStatus, String reason, String uploadPath) {
        this.postId = postId;
        this.userId = userId;
        this.groupId = groupId;
        this.topicId = topicId;
        this.content = content;
        this.createDate = createDate;
        this.status = status;
        this.postStatus = postStatus;
        this.reason = reason;
        this.uploadPath = uploadPath;
    }

    // Getters and Setters
    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Timestamp commentDate) {
        this.commentDate = commentDate;
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

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
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

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String uploadPath) {
        this.uploadPath = uploadPath;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public boolean isHasReportPost() {
        return hasReportPost;
    }

    public void setHasReportPost(boolean hasReportPost) {
        this.hasReportPost = hasReportPost;
    }

  


    
}
