package model;

public class Payment {

    private int paymentId;         // id tự động tăng cho thanh toán
    private String atmNumber;      // Số thẻ ATM
    private String atmName;        // Tên chủ sở hữu thẻ ATM
    private String atmBank;        // Ngân hàng phát hành thẻ ATM
    private double amount;         // Số tiền thanh toán
    private String status;         // Trạng thái thanh toán
    private String reason;         // Lý do thanh toán
    private int userId;            // id của người dùng, không được null
    private String username;  // Field for username

    // Constructors
    public Payment() {
        // Default constructor
    }

    public Payment(int paymentId, String atmNumber, String atmName, String atmBank, double amount, String status, String reason, int userId, String username) {
        this.paymentId = paymentId;
        this.atmNumber = atmNumber;
        this.atmName = atmName;
        this.atmBank = atmBank;
        this.amount = amount;
        this.status = status;
        this.reason = reason;
        this.userId = userId;
        this.username = username;
    }

    public Payment(int paymentId, String atmNumber, String atmName, String atmBank, double amount, String status, String reason, int userId) {
        this.paymentId = paymentId;
        this.atmNumber = atmNumber;
        this.atmName = atmName;
        this.atmBank = atmBank;
        this.amount = amount;
        this.status = status;
        this.reason = reason;
        this.userId = userId;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public String getAtmNumber() {
        return atmNumber;
    }

    public void setAtmNumber(String atmNumber) {
        this.atmNumber = atmNumber;
    }

    public String getAtmName() {
        return atmName;
    }

    public void setAtmName(String atmName) {
        this.atmName = atmName;
    }

    public String getAtmBank() {
        return atmBank;
    }

    public void setAtmBank(String atmBank) {
        this.atmBank = atmBank;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

}
