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

public class Post_comment {
    private int commentId; // id tự động tăng cho bình luận
    private int postId;    // id của bài viết mà bình luận thuộc về
    private int userId;    // id của người bình luận
    private String content; // Nội dung bình luận
    private String image;  // Hình ảnh đính kèm bình luận
    private Date date;     // Thời gian bình luận, mặc định là ngày hiện tại

    // Constructors
    public Post_comment() {
        // Default constructor
    }

    public Post_comment(int commentId, int postId, int userId, String content, String image, Date date) {
        this.commentId = commentId;
        this.postId = postId;
        this.userId = userId;
        this.content = content;
        this.image = image;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}