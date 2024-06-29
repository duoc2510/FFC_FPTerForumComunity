/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PC
 */
public class Feedback {
    private int feedbackId; // Optional, as it is auto-generated
    private String feedbackDetail;
    private String feedbackTitle;
    private int userId;

    public Feedback(String feedbackDetail, String feedbackTitle, int userId) {
        this.feedbackDetail = feedbackDetail;
        this.feedbackTitle = feedbackTitle;
        this.userId = userId;
    }

    public Feedback(int feedbackId, String feedbackDetail, String feedbackTitle, int userId) {
        this.feedbackId = feedbackId;
        this.feedbackDetail = feedbackDetail;
        this.feedbackTitle = feedbackTitle;
        this.userId = userId;
    }

    // Getters and setters
    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public String getFeedbackDetail() {
        return feedbackDetail;
    }

    public void setFeedbackDetail(String feedbackDetail) {
        this.feedbackDetail = feedbackDetail;
    }

    public String getFeedbackTitle() {
        return feedbackTitle;
    }

    public void setFeedbackTitle(String feedbackTitle) {
        this.feedbackTitle = feedbackTitle;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
