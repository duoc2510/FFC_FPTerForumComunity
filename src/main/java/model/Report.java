package model;

import java.util.List;

public class Report {

    private int report_id;
    private int reporter_id;
    private int userId;
    private int shopId;
    private int postId;
    private String reason;
    private String status;
    private Post post;
    private User user;
    public Report() {
    }

    public Report(int report_id, int reporter_id, int userId, int postId, String reason, String status, Post post, User user) {
        this.report_id = report_id;
        this.reporter_id = reporter_id;
        this.userId = userId;
        this.postId = postId;
        this.reason = reason;
        this.status = status;
        this.post = post;
        this.user = user;
    }

    public Report( String reason, Post post, User user,String status ) {
       
        this.reason = reason;
        this.post = post;
        this.user = user;
        this.status = status;
    }

   

    public Report( String reason, User user,String status) {
       
        this.reason = reason;
        this.user = user;
        this.status = status;
    }

   

   

    public Report(int report_id, int reporter_id, int userId, int shopId, int postId, String reason, String status) {
        this.report_id = report_id;
        this.reporter_id = reporter_id;
        this.userId = userId;
        this.shopId = shopId;
        this.postId = postId;
        this.reason = reason;
        this.status = status;
    }

    public Report(int report_id, int reporter_id, int userId, int postId, String reason, String status) {
        this.report_id = report_id;
        this.reporter_id = reporter_id;
        this.userId = userId;
        this.postId = postId;
        this.reason = reason;
        this.status = status;
    }


    public int getReport_id() {
        return report_id;
    }

    public void setReport_id(int report_id) {
        this.report_id = report_id;
    }

    public int getReporter_id() {
        return reporter_id;
    }

    public void setReporter_id(int reporter_id) {
        this.reporter_id = reporter_id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getShopId() {
        return shopId;
    }

    public void setShopId(int shopId) {
        this.shopId = shopId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
