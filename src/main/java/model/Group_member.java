/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ThanhDuoc
 */
public class Group_member {

    private int memberGroupId;
    private int userId;
    private int groupId;
    private String status;
    private User user;

    public Group_member() {
    }

    public Group_member(int memberGroupId, String status, User user) {
        this.memberGroupId = memberGroupId;
        this.status = status;
        this.user = user;
    }

    public Group_member(int memberGroupId, User user) {
        this.memberGroupId = memberGroupId;
        this.user = user;
    }

    public Group_member(int memberGroupId, String status) {
        this.memberGroupId = memberGroupId;
        this.status = status;
    }

    public Group_member(int memberGroupId, int userId, int groupId, String status) {
        this.memberGroupId = memberGroupId;
        this.userId = userId;
        this.groupId = groupId;
        this.status = status;
    }

    public int getMemberGroupId() {
        return memberGroupId;
    }

    public void setMemberGroupId(int memberGroupId) {
        this.memberGroupId = memberGroupId;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
