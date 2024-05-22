package model;

public class User_payment {

    private int paymentId;         // id tự động tăng cho thanh toán
    private String paymentDetail;  // Chi tiết thanh toán, không được null
    private int userId;            // id của người dùng, không được null

    // Constructors
    public User_payment() {
        // Default constructor
    }

    public User_payment(int paymentId, String paymentDetail, int userId) {
        this.paymentId = paymentId;
        this.paymentDetail = paymentDetail;
        this.userId = userId;
    }

    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public String getPaymentDetail() {
        return paymentDetail;
    }

    public void setPaymentDetail(String paymentDetail) {
        this.paymentDetail = paymentDetail;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

}
