package model;

public class User_report {

    private int reportUserId;
    private int userId;
    private int reportedId;
    private String status;
    private String reason;

    public User_report() {
    }

    public User_report(int reportUserId, int userId, int reportedId, String status, String reason) {
        this.reportUserId = reportUserId;
        this.userId = userId;
        this.reportedId = reportedId;
        this.status = status;
        this.reason = reason;
    }

    // Getters and Setters
    public int getReportUserId() {
        return reportUserId;
    }

    public void setReportUserId(int reportUserId) {
        this.reportUserId = reportUserId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getReportedId() {
        return reportedId;
    }

    public void setReportedId(int reportedId) {
        this.reportedId = reportedId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
