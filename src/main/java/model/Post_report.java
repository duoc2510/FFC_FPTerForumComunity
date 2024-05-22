/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ThanhDuoc
 */
public class Post_report {
       private int reportId;     // id tự động tăng cho báo cáo
    private int reporterId;   // id của người báo cáo
    private int postId;       // id của bài viết bị báo cáo
    private String reason;    // Lý do báo cáo
    private String status;    // Trạng thái của báo cáo

    // Constructors
    public Post_report() {
        // Default constructor
    }

    public Post_report(int reportId, int reporterId, int postId, String reason, String status) {
        this.reportId = reportId;
        this.reporterId = reporterId;
        this.postId = postId;
        this.reason = reason;
        this.status = status;
    }

    // Getters and Setters
    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getReporterId() {
        return reporterId;
    }

    public void setReporterId(int reporterId) {
        this.reporterId = reporterId;
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

}
