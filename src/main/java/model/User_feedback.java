/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ThanhDuoc
 */
public class User_feedback {

    private int feebackId;
    private String feebackDetail;
    private String feebackTitle;
    private int userId;

    public User_feedback() {
    }

    public User_feedback(int feebackId, String feebackDetail, String feebackTitle, int userId) {
        this.feebackId = feebackId;
        this.feebackDetail = feebackDetail;
        this.feebackTitle = feebackTitle;
        this.userId = userId;
    }

    // Getters and Setters
    public int getFeebackId() {
        return feebackId;
    }

    public void setFeebackId(int feebackId) {
        this.feebackId = feebackId;
    }

    public String getFeebackDetail() {
        return feebackDetail;
    }

    public void setFeebackDetail(String feebackDetail) {
        this.feebackDetail = feebackDetail;
    }

    public String getFeebackTitle() {
        return feebackTitle;
    }

    public void setFeebackTitle(String feebackTitle) {
        this.feebackTitle = feebackTitle;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
