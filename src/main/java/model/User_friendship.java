/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ThanhDuoc
 */
public class User_friendship {
     private int friendshipId;
    private int userId;
    private int friendId;
    private String requestStatus;

    public User_friendship() {
    }

    public User_friendship(int friendshipId, int userId, int friendId, String requestStatus) {
        this.friendshipId = friendshipId;
        this.userId = userId;
        this.friendId = friendId;
        this.requestStatus = requestStatus;
    }

    // Getters and Setters
    public int getFriendshipId() {
        return friendshipId;
    }

    public void setFriendshipId(int friendshipId) {
        this.friendshipId = friendshipId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getFriendId() {
        return friendId;
    }

    public void setFriendId(int friendId) {
        this.friendId = friendId;
    }

    public String getRequestStatus() {
        return requestStatus;
    }

    public void setRequestStatus(String requestStatus) {
        this.requestStatus = requestStatus;
    }
}
