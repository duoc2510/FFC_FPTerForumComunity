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
    private String image;
    private int memberCount;
    private boolean isPending;
    private boolean isBanned;
    private boolean isApproved;
    private String status;

    public Group(int groupId, int createrId, String groupName, String groupDescription, List<Group_member> groupMember, List<Post> post, List<Comment> comments, List<Upload> upload, String image, int memberCount, String status) {
        this.groupId = groupId;
        this.createrId = createrId;
        this.groupName = groupName;
        this.groupDescription = groupDescription;
        this.groupMember = groupMember;
        this.post = post;
        this.comments = comments;
        this.upload = upload;
        this.image = image;
        this.memberCount = memberCount;
        this.status = status;
    }

    public Group(int createrId, String groupName, String groupDescription, String image) {
        this.createrId = createrId;
        this.groupName = groupName;
        this.groupDescription = groupDescription;
        this.image = image;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getMemberCount() {
        return memberCount;
    }

    public void setMemberCount(int memberCount) {
        this.memberCount = memberCount;
    }

    public List<Group_member> getGroupMember() {
        return groupMember;
    }

    public void setGroupMember(List<Group_member> groupMember) {
        this.groupMember = groupMember;
    }

    public List<Post> getPost() {
        return post;
    }

    public void setPost(List<Post> post) {
        this.post = post;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public List<Upload> getUpload() {
        return upload;
    }

    public void setUpload(List<Upload> upload) {
        this.upload = upload;
    }

    public boolean isPending() {
        return isPending;
    }

    public void setPending(boolean isPending) {
        this.isPending = isPending;
    }

    public boolean isIsBanned() {
        return isBanned;
    }

    public void setIsBanned(boolean isBanned) {
        this.isBanned = isBanned;
    }


    public boolean isIsApproved() {
        return isApproved;
    }

    public void setIsApproved(boolean isApproved) {
        this.isApproved = isApproved;
    }
    

    public String getStatus() {
        return status;
    }

    public void setStatus(String Status) {
        this.status = Status;
    }

}
