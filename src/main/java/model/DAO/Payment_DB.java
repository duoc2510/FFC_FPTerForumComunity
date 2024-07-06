package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Payment;

public class Payment_DB implements DBinfo {

    public Payment_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Payment_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Phương thức nạp tiền vào tài khoản
    public static boolean napTien(String atmNumber, int userId, String bankName, double soTien, int code) {
        String checkAtmQuery = "SELECT Money FROM ATMInfo WHERE ATMNumber = ? AND BankName = ? AND Status = 'Active' AND CODE = ?";
        String updateAdminQuery = "UPDATE ATMInfo SET Money = Money + ? WHERE ATMNumber = '25102003221'";
        String updateAtmQuery = "UPDATE ATMInfo SET Money = Money - ? WHERE ATMNumber = ? AND BankName = ?";
        String updateUserQuery = "UPDATE Users SET User_wallet = User_wallet + ? WHERE User_id = ?";

        try (
                Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement atmCheckStmt = connection.prepareStatement(checkAtmQuery); PreparedStatement updateAdminStmt = connection.prepareStatement(updateAdminQuery); PreparedStatement updateAtmStmt = connection.prepareStatement(updateAtmQuery); PreparedStatement updateUserStmt = connection.prepareStatement(updateUserQuery); PreparedStatement getAtmMoneyStmt = connection.prepareStatement("SELECT Money FROM ATMInfo WHERE ATMNumber = ?");) {
            connection.setAutoCommit(false);

            // Kiểm tra ATM có tồn tại, đang hoạt động và mã code chính xác
            atmCheckStmt.setString(1, atmNumber);
            atmCheckStmt.setString(2, bankName);
            atmCheckStmt.setInt(3, code);
            ResultSet atmResultSet = atmCheckStmt.executeQuery();

            if (atmResultSet.next()) {
                double atmMoney = atmResultSet.getDouble("Money");
                if (atmMoney >= soTien) {
                    // Cập nhật số tiền trong ATMInfo (giảm số tiền)
                    updateAtmStmt.setDouble(1, soTien);
                    updateAtmStmt.setString(2, atmNumber);
                    updateAtmStmt.setString(3, bankName);
                    updateAtmStmt.executeUpdate();

                    // Cập nhật số tiền vào tài khoản admin (tăng số tiền)
                    updateAdminStmt.setDouble(1, soTien);
                    updateAdminStmt.executeUpdate();

                    // Cập nhật số dư ví của người dùng (tăng số tiền)
                    updateUserStmt.setDouble(1, soTien);
                    updateUserStmt.setInt(2, userId);
                    updateUserStmt.executeUpdate();

                    connection.commit();
                    System.out.println("Nạp tiền thành công!");

                    // Log lại số tiền hiện tại của ATM sau khi nạp
                    getAtmMoneyStmt.setString(1, atmNumber);
                    ResultSet updatedAtmResultSet = getAtmMoneyStmt.executeQuery();
                    if (updatedAtmResultSet.next()) {
                        double updatedAtmMoney = updatedAtmResultSet.getDouble("Money");
                        System.out.println("Số tiền hiện tại của ATM (" + atmNumber + " - " + bankName + "): " + updatedAtmMoney);
                    }

                    return true;
                } else {
                    System.out.println("Số tiền trong ATM không đủ để thực hiện giao dịch!");
                }
            } else {
                System.out.println("ATM không tồn tại hoặc không hoạt động hoặc mã code không chính xác!");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức rút tiền từ tài khoản
    public static boolean rutTien(int userId, String atmNumber, String bankName, double soTien) {
        String checkAtmQuery = "SELECT 1 FROM ATMInfo WHERE ATMNumber = ? AND BankName = ?";
        String checkUserQuery = "SELECT User_wallet FROM Users WHERE User_id = ?";
        String updateUserQuery = "UPDATE Users SET User_wallet = User_wallet - ? WHERE User_id = ?";
        String insertPaymentQuery = "INSERT INTO Payment (ATMNumber, ATMName, ATMBank, Amount, Status, Reason, User_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement atmCheckStmt = connection.prepareStatement(checkAtmQuery); PreparedStatement userCheckStmt = connection.prepareStatement(checkUserQuery); PreparedStatement updateUserStmt = connection.prepareStatement(updateUserQuery); PreparedStatement insertPaymentStmt = connection.prepareStatement(insertPaymentQuery, Statement.RETURN_GENERATED_KEYS)) {

            connection.setAutoCommit(false);

            // Kiểm tra thông tin thẻ ATM
            atmCheckStmt.setString(1, atmNumber);
            atmCheckStmt.setString(2, bankName);
            try (ResultSet atmResultSet = atmCheckStmt.executeQuery()) {
                if (atmResultSet.next()) {
                    // Kiểm tra số dư ví của người dùng
                    userCheckStmt.setInt(1, userId);
                    try (ResultSet userResultSet = userCheckStmt.executeQuery()) {
                        if (userResultSet.next()) {
                            double userWallet = userResultSet.getDouble("User_wallet");
                            if (userWallet >= soTien) {
                                // Cập nhật số dư ví của người dùng
                                updateUserStmt.setDouble(1, soTien);
                                updateUserStmt.setInt(2, userId);
                                updateUserStmt.executeUpdate();
                                // Lấy tên chủ sở hữu thẻ ATM
                                String atmOwnerName = ""; // Thực hiện câu truy vấn để lấy tên chủ sở hữu từ bảng ATMInfo
                                String getAtmOwnerQuery = "SELECT username FROM ATMInfo WHERE ATMNumber = ?";
                                try (PreparedStatement getAtmOwnerStmt = connection.prepareStatement(getAtmOwnerQuery)) {
                                    getAtmOwnerStmt.setString(1, atmNumber);
                                    ResultSet ownerResultSet = getAtmOwnerStmt.executeQuery();
                                    if (ownerResultSet.next()) {
                                        atmOwnerName = ownerResultSet.getString("username");
                                    }
                                }

                                // Thêm thông tin thanh toán vào bảng Payment_DB
                                insertPaymentStmt.setString(1, atmNumber);
                                insertPaymentStmt.setString(2, atmOwnerName); // Sử dụng tên chủ sở hữu từ ATMInfo
                                insertPaymentStmt.setString(3, bankName);
                                insertPaymentStmt.setString(4, String.valueOf(soTien));
                                insertPaymentStmt.setString(5, "Pending");
                                insertPaymentStmt.setString(6, "Rút tiền thành công");
                                insertPaymentStmt.setInt(7, userId);
                                insertPaymentStmt.executeUpdate();

                                connection.commit();
                                System.out.println("Rút tiền thành công!");
                                return true;
                            } else {
                                System.out.println("Số dư trong ví không đủ để rút tiền!");
                            }
                        } else {
                            System.out.println("Người dùng không tồn tại!");
                        }
                    }
                } else {
                    System.out.println("Thông tin thẻ ATM không hợp lệ!");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public static List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String query = "SELECT p.*, u.username FROM Payment p JOIN Users u ON p.User_id = u.User_id ORDER BY p.Payment_id DESC";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement statement = connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                int paymentId = resultSet.getInt("Payment_id");
                String atmNumber = resultSet.getString("ATMNumber");
                String atmName = resultSet.getString("ATMName");
                String atmBank = resultSet.getString("ATMBank");
                double amount = resultSet.getDouble("Amount");
                String status = resultSet.getString("Status");
                String reason = resultSet.getString("Reason");
                int userId = resultSet.getInt("User_id");
                String username = resultSet.getString("username");

                Payment payment = new Payment(paymentId, atmNumber, atmName, atmBank, amount, status, reason, userId, username);
                payments.add(payment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payments;
    }
    // Phương thức cập nhật trạng thái của thanh toán

    public static boolean updatePaymentStatus(int paymentId, String newStatus) {
        String updateQuery = "UPDATE Payment SET Status = ? WHERE Payment_id = ?";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement statement = connection.prepareStatement(updateQuery)) {

            statement.setString(1, newStatus);
            statement.setInt(2, paymentId);

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public static Payment getPaymentById(int paymentId) {
        Payment payment = null;
        String query = "SELECT * FROM Payment WHERE Payment_id = ?";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, paymentId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String atmNumber = resultSet.getString("ATMNumber");
                String atmName = resultSet.getString("ATMName");
                String atmBank = resultSet.getString("ATMBank");
                double amount = resultSet.getDouble("Amount");
                String status = resultSet.getString("Status");
                String reason = resultSet.getString("Reason");
                int userId = resultSet.getInt("User_id");

                payment = new Payment(paymentId, atmNumber, atmName, atmBank, amount, status, reason, userId);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payment;
    }
}
