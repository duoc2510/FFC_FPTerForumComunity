/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ThanhDuoc
 */
import java.util.Date;

public class Comment {

    private int commentId; // id tự động tăng cho bình luận
    private int postId;    // id của bài viết mà bình luận thuộc về
    private int userId;    // id của người bình luận
    private String content; // Nội dung bình luận
    private String uploadPath;  // Hình ảnh đính kèm bình luận
    private Date date;     // Thời gian bình luận, mặc định là ngày hiện tại
    private User user;

    // Constructors
    public Comment() {
        // Default constructor
    }

    public Comment(int commentId, int postId, int userId, String content, Date date) {
        this.commentId = commentId;
        this.postId = postId;
        this.userId = userId;
        this.content = content;
        this.date = date;
    }

    public Comment(int commentId, int postId, int userId, String content, String uploadPath, Date date) {
        this.commentId = commentId;
        this.postId = postId;
        this.userId = userId;
        this.content = content;
        this.uploadPath = uploadPath;
        this.date = date;
    }

    // Getters and Setters
    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String uploadPath) {
        this.uploadPath = uploadPath;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
