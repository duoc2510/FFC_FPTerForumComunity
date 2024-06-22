package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class User_payment implements DBinfo {

    public User_payment() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(User_payment.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

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

    public static boolean rutTien(int userId, String atmNumber, String bankName, double soTien) {
        String checkAtmQuery = "SELECT 1 FROM ATMInfo WHERE ATMNumber = ? AND BankName = ?";
        String checkUserQuery = "SELECT User_wallet FROM Users WHERE User_id = ?";
        String updateAdminQuery = "UPDATE ATMInfo SET Money = Money - ? WHERE ATMNumber = '25102003221'";
        String updateAtmQuery = "UPDATE ATMInfo SET Money = Money + ? WHERE ATMNumber = ? AND BankName = ?";
        String updateUserQuery = "UPDATE Users SET User_wallet = User_wallet - ? WHERE User_id = ?";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement atmCheckStmt = connection.prepareStatement(checkAtmQuery); PreparedStatement userCheckStmt = connection.prepareStatement(checkUserQuery); PreparedStatement updateAdminStmt = connection.prepareStatement(updateAdminQuery); PreparedStatement updateAtmStmt = connection.prepareStatement(updateAtmQuery); PreparedStatement updateUserStmt = connection.prepareStatement(updateUserQuery)) {

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

                                // Cập nhật số tiền vào tài khoản admin
                                updateAdminStmt.setDouble(1, soTien);
                                updateAdminStmt.executeUpdate();

                                // Cập nhật số tiền trong ATMInfo
                                updateAtmStmt.setDouble(1, soTien);
                                updateAtmStmt.setString(2, atmNumber);
                                updateAtmStmt.setString(3, bankName);
                                updateAtmStmt.executeUpdate();

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

}
