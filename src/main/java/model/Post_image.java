/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.Date;

public class Post_image extends Post {

    private int postImageId;
    private String imagePath;

    // Constructor không tham số
    public Post_image(int postId, int userId, int groupId, int topicId, String content, Timestamp createDate, String image, String status, String postStatus, String reason) {
        super(postId, userId, groupId, topicId, content, createDate, image, status, postStatus, reason);
    }

    // Constructor với tất cả tham số
    public Post_image(int postImageId, String imagePath, int postId, int userId, int groupId, int topicId, String content, Timestamp createDate, String image, String status, String postStatus, String reason) {
        super(postId, userId, groupId, topicId, content, createDate, image, status, postStatus, reason);
        this.postImageId = postImageId;
        this.imagePath = imagePath;
    }

    
    // Getter và Setter cho các thuộc tính
    public int getPostImageId() {
        return postImageId;
    }

    public void setPostImageId(int postImageId) {
        this.postImageId = postImageId;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

}
