package model;

import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class Order {

    private int userID;
    private int order_ID;
    private java.sql.Timestamp orderDate;
    private String status;
    private double total;
    private String note;
    private String feedback;
    private int star; // New field
    private String receiverPhone;
    private String payment_status;

    public Order() {
    }

    public Order(int userID, int order_ID, Timestamp orderDate, String status, double total, String note, String feedback, int star, String receiverPhone, String payment_status) {
        this.userID = userID;
        this.order_ID = order_ID;
        this.orderDate = orderDate;
        this.status = status;
        this.total = total;
        this.note = note;
        this.feedback = feedback;
        this.star = star;
        this.receiverPhone = receiverPhone;
        this.payment_status = payment_status;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getOrder_ID() {
        return order_ID;
    }

    public void setOrder_ID(int order_ID) {
        this.order_ID = order_ID;
    }

    public java.sql.Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(java.sql.Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getPayment_status() {
        return payment_status;
    }

    public void setPayment_status(String payment_status) {
        this.payment_status = payment_status;
    }

    @Override
    public String toString() {
        return "Order{" + "userID=" + userID + ", order_ID=" + order_ID + ", orderDate=" + orderDate + ", status=" + status + ", total=" + total + ", note=" + note + ", feedback=" + feedback + ", star=" + star + ", receiverPhone=" + receiverPhone + ", payment_status=" + payment_status + '}';
    }
}
