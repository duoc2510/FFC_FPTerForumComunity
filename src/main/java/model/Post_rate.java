/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ThanhDuoc
 */
public class Post_rate {
    private int rateId; // id tự động tăng cho đánh giá
    private int postId; // id của bài viết được đánh giá
    private int userId; // id của người đánh giá
    private int typeRate; // Loại đánh giá

    // Constructors
    public Post_rate() {
        // Default constructor
    }

    public Post_rate(int rateId, int postId, int userId, int typeRate) {
        this.rateId = rateId;
        this.postId = postId;
        this.userId = userId;
        this.typeRate = typeRate;
    }

    // Getters and Setters
    public int getRateId() {
        return rateId;
    }

    public void setRateId(int rateId) {
        this.rateId = rateId;
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

    public int getTypeRate() {
        return typeRate;
    }

    public void setTypeRate(int typeRate) {
        this.typeRate = typeRate;
    }

}
