/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ThanhDuoc
 */
public class Upload {

    private int uploadId;
    private int postId;
    private int eventId;
    private int shopId;
    private int commentId;
    private int productId;
    private String uploadPath;

    public Upload() {
    }

    public Upload(int uploadId, int postId) {
        this.uploadId = uploadId;
        this.postId = postId;
    }

    public Upload(int uploadId, int postId, String uploadPath) {
        this.uploadId = uploadId;
        this.postId = postId;
        this.uploadPath = uploadPath;
    }

    public Upload(int uploadId, int postId, int eventId, int shopId, int commentId, int productId, String uploadPath) {
        this.uploadId = uploadId;
        this.postId = postId;
        this.eventId = eventId;
        this.shopId = shopId;
        this.commentId = commentId;
        this.productId = productId;
        this.uploadPath = uploadPath;
    }

    // Getters and setters
    public int getUploadId() {
        return uploadId;
    }

    public void setUploadId(int uploadId) {
        this.uploadId = uploadId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getShopId() {
        return shopId;
    }

    public void setShopId(int shopId) {
        this.shopId = shopId;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String uploadPath) {
        this.uploadPath = uploadPath;
    }
}
