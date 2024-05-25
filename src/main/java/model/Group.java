/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author ThanhDuoc
 */
public class Group {
    private int groupId;
    private int createrId;
    private String groupName;
    private String groupDescription;
    private List<Group_member> groupMember;
    private List<Post> post;
    private List<Comment> comments;
    private List<Upload> upload;

    public Group(int groupId, int createrId, String groupName, String groupDescription, List<Group_member> groupMember, List<Post> post, List<Comment> comments, List<Upload> upload) {
        this.groupId = groupId;
        this.createrId = createrId;
        this.groupName = groupName;
        this.groupDescription = groupDescription;
        this.groupMember = groupMember;
        this.post = post;
        this.comments = comments;
        this.upload = upload;
    }

   
         
    public Group() {
    }

    public Group(int createrId, String groupName, String groupDescription) {
        this.createrId = createrId;
        this.groupName = groupName;
        this.groupDescription = groupDescription;
    }

    public Group(int groupId, int createrId, String groupName, String groupDescription) {
        this.groupId = groupId;
        this.createrId = createrId;
        this.groupName = groupName;
        this.groupDescription = groupDescription;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getCreaterId() {
        return createrId;
    }

    public void setCreaterId(int createrId) {
        this.createrId = createrId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getGroupDescription() {
        return groupDescription;
    }

    public void setGroupDescription(String groupDescription) {
        this.groupDescription = groupDescription;
    }
}
