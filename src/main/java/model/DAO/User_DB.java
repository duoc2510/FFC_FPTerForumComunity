/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.*;
import static model.DAO.DBinfo.dbPass;
import static model.DAO.DBinfo.dbURL;
import static model.DAO.DBinfo.dbUser;
import static model.DAO.DBinfo.driver;
import org.mindrot.jbcrypt.BCrypt;

public class User_DB implements DBinfo {

    public User_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static User getUserByEmailorUsername(String identifier) {
        User user = null;
        String query = "SELECT * FROM Users WHERE User_email = ? OR Username = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, identifier);
            pstmt.setString(2, identifier);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int userId = rs.getInt("User_id");
                    String userEmail = rs.getString("User_email");
                    String userPassword = rs.getString("User_password");
                    int userRole = rs.getInt("User_role");
                    String username = rs.getString("Username");
                    String userFullName = rs.getString("User_fullName");
                    double userWallet = rs.getDouble("User_wallet");
                    String userAvatar = rs.getString("User_avatar");
                    if (userAvatar == null) {
                        userAvatar = "static/images/user-default.webp";
                    }

                    String userStory = rs.getString("User_story");
                    int userRank = rs.getInt("User_rank");
                    int userScore = rs.getInt("User_score");
                    Date userCreateDate = rs.getDate("User_createDate");
                    String userSex = rs.getString("User_sex");
                    boolean userActiveStatus = rs.getBoolean("User_activeStatus");
                    user = new User(userId, userEmail, userPassword, userRole, username, userFullName, userWallet, userAvatar, userStory, userRank, userScore, userCreateDate, userSex, userActiveStatus);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public static ArrayList<User> getAllUsers() {
        ArrayList<User> users = new ArrayList<>();
        String query = "SELECT * FROM Users";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int userId = rs.getInt("User_id");
                String userEmail = rs.getString("User_email");
                String userPassword = rs.getString("User_password");
                int userRole = rs.getInt("User_role");
                String username = rs.getString("Username");
                String userFullName = rs.getString("User_fullName");
                double userWallet = rs.getDouble("User_wallet");
                String userAvatar = rs.getString("User_avatar");
                if (userAvatar == null) {
                    userAvatar = "static/images/user-default.webp";
                }

                String userStory = rs.getString("User_story");
                int userRank = rs.getInt("User_rank");
                int userScore = rs.getInt("User_score");
                Date userCreateDate = rs.getDate("User_createDate");
                String userSex = rs.getString("User_sex");
                boolean userActiveStatus = rs.getBoolean("User_activeStatus");

                User user = new User(userId, userEmail, userPassword, userRole, username, userFullName, userWallet, userAvatar, userStory, userRank, userScore, userCreateDate, userSex, userActiveStatus);
                users.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return users;
    }

    public static void addUser(User user) throws ParseException {
        String insertQuery = "INSERT INTO Users (User_password, User_email, Username, User_role, User_createDate) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(insertQuery)) {

            // Mã hóa mật khẩu
            String hashedPassword = BCrypt.hashpw(user.getUserPassword(), BCrypt.gensalt());

            // Lấy ngày hiện tại và định dạng theo dd/MM/yyyy
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            String currentDate = formatter.format(new Date());

            // Chuyển đổi lại ngày sang kiểu Date của SQL Server
            java.sql.Date sqlDate = new java.sql.Date(formatter.parse(currentDate).getTime());

            pstmt.setString(1, hashedPassword);
            pstmt.setString(2, user.getUserEmail());
            pstmt.setString(3, user.getUsername());
            pstmt.setInt(4, 1); // Giả định rằng 1 là vai trò người dùng mặc định
            pstmt.setDate(5, sqlDate); // Thêm ngày tạo

            pstmt.executeUpdate();

        } catch (SQLException | ParseException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static boolean changePass(String email, String newPassword) {
        String query = "UPDATE Users SET User_password = ? WHERE User_email = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            String hashedPassword = hashPassword(newPassword);
            pstmt.setString(1, hashedPassword);
            pstmt.setString(2, email);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error updating password for email: " + email, ex);
        }
        return false;
    }

    private static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    public static boolean checkCurrentPassword(String email, String currentPassword) {
        String storedPassword = getStoredPassword(email);
        if (storedPassword == null) {
            return false; // Không tìm thấy mật khẩu lưu trữ
        }
        if (storedPassword.equals(currentPassword)) {
            return true; // Trả về true nếu mật khẩu chưa được mã hóa
        }
        return BCrypt.checkpw(currentPassword, storedPassword); // Kiểm tra mật khẩu đã được mã hóa
    }

    private static String getStoredPassword(String email) {
        String query = "SELECT User_password FROM Users WHERE User_email = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("User_password");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error retrieving password for email: " + email, ex);
        }
        return null; // Trả về null nếu có lỗi xảy ra
    }

    public static User getUserById(int userId) {
        User user = null;
        String query = "SELECT * FROM Users WHERE User_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, userId); // Set the User_ID parameter in the query
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String userEmail = rs.getString("User_email");
                String userPassword = rs.getString("User_password");
                int userRole = rs.getInt("User_role");
                String username = rs.getString("Username");
                String userFullName = rs.getString("User_fullName");
                double userWallet = rs.getDouble("User_wallet");
                String userAvatar = rs.getString("User_avatar");
                if (userAvatar == null) {
                    userAvatar = "static/images/user-default.webp";
                }

                String userStory = rs.getString("User_story");
                int userRank = rs.getInt("User_rank");
                int userScore = rs.getInt("User_score");
                java.sql.Date userCreateDate = rs.getDate("User_createDate");
                String userSex = rs.getString("User_sex");
                boolean userActiveStatus = rs.getBoolean("User_activeStatus");
                user = new User(userId, userEmail, userPassword, userRole, username, userFullName, userWallet, userAvatar, userStory, userRank, userScore, userCreateDate, userSex, userActiveStatus);

                // In thông tin người dùng ra console
                System.out.println("User retrieved from database: " + user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public static User getUserByShopId(int shopId) {
        User user = null;
        String query = "SELECT u.* FROM Users u JOIN Shop s ON u.User_id = s.Owner_id WHERE s.Shop_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, shopId); // Set the Shop_id parameter in the query
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("User_id");
                String userEmail = rs.getString("User_email");
                String userPassword = rs.getString("User_password");
                int userRole = rs.getInt("User_role");
                String username = rs.getString("Username");
                String userFullName = rs.getString("User_fullName");
                double userWallet = rs.getDouble("User_wallet");
                String userAvatar = rs.getString("User_avatar");
                if (userAvatar == null) {
                    userAvatar = "static/images/user-default.webp";
                }

                String userStory = rs.getString("User_story");
                int userRank = rs.getInt("User_rank");
                int userScore = rs.getInt("User_score");
                java.sql.Date userCreateDate = rs.getDate("User_createDate");
                String userSex = rs.getString("User_sex");
                boolean userActiveStatus = rs.getBoolean("User_activeStatus");
                user = new User(userId, userEmail, userPassword, userRole, username, userFullName, userWallet, userAvatar, userStory, userRank, userScore, userCreateDate, userSex, userActiveStatus);

                // Log user information to console
                System.out.println("User retrieved from database: " + user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public static boolean updateUserByEmail(String email, String fullName, String gender, String avatar, String story) {
        String query = "UPDATE Users SET User_fullName = ?, User_sex = ?, User_avatar = ?, User_story = ? WHERE User_email = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, fullName);
            pstmt.setString(2, gender);
            pstmt.setString(3, avatar);
            pstmt.setString(4, story);
            pstmt.setString(5, email);
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class
                    .getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static boolean updatePasswordByEmail(String email, String newPassword) {
        String query = "UPDATE Users SET User_password = ? WHERE User_email = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            pstmt.setString(1, hashedPassword);
            pstmt.setString(2, email);
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class
                    .getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
     // Get usernames of all users interested in a specific event
    public static List<String> getUsersInterestedInEvent(int eventId) {
        List<String> usernames = new ArrayList<>();
        String query = "SELECT u.Username FROM Users u " +
                       "JOIN UserFollow uf ON u.User_id = uf.User_id " +
                       "WHERE uf.Event_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); 
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, eventId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    usernames.add(rs.getString("Username"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return usernames;
    }

    // Count the number of users interested in a specific event
    public static int countInterestedUsers(int eventId) {
        int userCount = 0;
        String query = "SELECT COUNT(*) FROM UserFollow WHERE Event_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); 
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, eventId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    userCount = rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userCount;
    }

    // R

    public static void updateScore(int userId) {
        String countCommentsQuery = "SELECT COUNT(*) FROM Comment WHERE User_id = ?";
        String countPostsQuery = "SELECT COUNT(*) FROM Post WHERE User_id = ? AND Status = 'Active' AND Topic_id IS NOT NULL";
        String updateScoreQuery = "UPDATE Users SET User_score = ? WHERE User_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement countCommentsStmt = con.prepareStatement(countCommentsQuery); PreparedStatement countPostsStmt = con.prepareStatement(countPostsQuery); PreparedStatement updateScoreStmt = con.prepareStatement(updateScoreQuery)) {

            // Đếm số lượng bình luận
            countCommentsStmt.setInt(1, userId);
            System.out.println("Executing query: " + countCommentsStmt);
            ResultSet rsComments = countCommentsStmt.executeQuery();
            rsComments.next();
            int commentCount = rsComments.getInt(1);
            System.out.println("Số lượng bình luận: " + commentCount);

            // Đếm số lượng bài viết
            countPostsStmt.setInt(1, userId);
            System.out.println("Executing query: " + countPostsStmt);
            ResultSet rsPosts = countPostsStmt.executeQuery();
            rsPosts.next();
            int postCount = rsPosts.getInt(1);
            System.out.println("Số lượng bài viết: " + postCount);

            // Tính điểm
            int score = commentCount * 1 + postCount * 2;
            System.out.println("Điểm tính được: " + score);

            // Cập nhật điểm
            updateScoreStmt.setInt(1, score);
            updateScoreStmt.setInt(2, userId);
            System.out.println("Executing query: " + updateScoreStmt);
            int rowsAffected = updateScoreStmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Cập nhật điểm thành công cho user ID: " + userId);
            } else {
                System.out.println("Không thể cập nhật điểm cho user ID: " + userId);
            }
        } catch (SQLException ex) {
            System.err.println("SQL Exception: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public static int countPost(String email) {
        int postCount = 0;
        String countPostsQuery = "SELECT COUNT(*) FROM Post WHERE User_id = (SELECT User_id FROM Users WHERE User_email = ?) AND Status = 'Active'";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement countPostsStmt = con.prepareStatement(countPostsQuery)) {

            countPostsStmt.setString(1, email);

            try (ResultSet rsPosts = countPostsStmt.executeQuery()) {
                if (rsPosts.next()) {
                    postCount = rsPosts.getInt(1);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return postCount;
    }

    public static int countPostByUserName(String username) {
        int postCount = 0;
        String countPostsQuery = "SELECT COUNT(*) FROM Post WHERE User_id = (SELECT User_id FROM Users WHERE Username = ?) AND Status = 'Active'";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement countPostsStmt = con.prepareStatement(countPostsQuery)) {

            countPostsStmt.setString(1, username);

            try (ResultSet rsPosts = countPostsStmt.executeQuery()) {
                if (rsPosts.next()) {
                    postCount = rsPosts.getInt(1);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return postCount;
    }

    public static int getUserIdByUsername(String identifier) throws SQLException {
        int userId = -1;
        String query = "SELECT User_id FROM Users WHERE Username = ?, User_email";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, identifier);
            ps.setString(2, identifier);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    userId = rs.getInt("User_id");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return userId;
    }

    public static boolean updateUser_activeStatusByEmail(String email, int activestatus) {
        String query = "UPDATE Users SET User_activeStatus = ? WHERE User_email = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setDouble(1, activestatus);
            pstmt.setString(2, email);
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static boolean updateWalletByEmail(String email, double wallet) {
        String query = "UPDATE Users SET User_wallet = ? WHERE User_email = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setDouble(1, wallet);
            pstmt.setString(2, email);
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static boolean updateScoreByEmail(String email, int score) {
        String query = "UPDATE Users SET User_score = ? WHERE User_email = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, score);
            pstmt.setString(2, email);
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static boolean updateRankByEmail(String email, int rank) {
        String query = "UPDATE Users SET User_rank = ? WHERE User_email = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, rank);
            pstmt.setString(2, email);
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static boolean addFriendRequest(int userId, int friendId) {
        String checkQuery = "SELECT COUNT(*) FROM FriendShip WHERE (User_id = ? AND Friend_id = ?) OR (User_id = ? AND Friend_id = ?)";
        String insertQuery = "INSERT INTO FriendShip (User_id, Friend_id, Request_status) VALUES (?, ?, 'sent'), (?, ?, 'received')";
        String updateQuery = "UPDATE FriendShip SET Request_status = CASE WHEN User_id = ? THEN 'sent' ELSE 'received' END WHERE (User_id = ? AND Friend_id = ?) OR (User_id = ? AND Friend_id = ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {

            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, friendId);
            checkStmt.setInt(3, friendId);
            checkStmt.setInt(4, userId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // Friend request already exists, update status to "sent" for sender and "received" for receiver
                try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                    updateStmt.setInt(1, userId);
                    updateStmt.setInt(2, userId);
                    updateStmt.setInt(3, friendId);
                    updateStmt.setInt(4, friendId);
                    updateStmt.setInt(5, userId);
                    int rowsAffected = updateStmt.executeUpdate();
                    return rowsAffected > 0;
                }
            } else {
                // Add new friend request
                try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                    insertStmt.setInt(1, userId);
                    insertStmt.setInt(2, friendId);
                    insertStmt.setInt(3, friendId);
                    insertStmt.setInt(4, userId);
                    int rowsAffected = insertStmt.executeUpdate();
                    return rowsAffected > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error occurred while adding friend request", e);
            return false;
        }
    }

    public static boolean acceptFriendRequest(int userId, int friendId) {
        String updateQuery = "UPDATE FriendShip SET Request_status = 'accepted' WHERE (User_id = ? AND Friend_id = ?) OR (User_id = ? AND Friend_id = ?)";
        String insertMessageQuery = "INSERT INTO Message (From_id, To_id, Friendship, TimeStamp) VALUES (?, ?, ?, GETDATE())";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
            // Step 1: Update FriendShip table
            try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                updateStmt.setInt(1, userId);
                updateStmt.setInt(2, friendId);
                updateStmt.setInt(3, friendId);
                updateStmt.setInt(4, userId);

                int rowsAffected = updateStmt.executeUpdate();
                if (rowsAffected > 0) {
                    int friendship = 1;

                    try (PreparedStatement insertStmt = conn.prepareStatement(insertMessageQuery)) {
                        insertStmt.setInt(1, userId);
                        insertStmt.setInt(2, friendId);
                        insertStmt.setInt(3, friendship);

                        int rowsInserted = insertStmt.executeUpdate();
                        if (rowsInserted > 0) {
                            System.out.println("Friend request accepted successfully. Message inserted into Message table.");
                            return true; // Return true if successfully accepted and message inserted
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false if any error occurred or no rows affected/inserted
    }

    public static boolean rejectFriendRequest(int userId, int friendId) {
        String query = "UPDATE FriendShip SET Request_status = 'rejected' WHERE (User_id = ? AND Friend_id = ?) OR (User_id = ? AND Friend_id = ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, friendId);
            stmt.setInt(3, friendId);
            stmt.setInt(4, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was updated
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    public static boolean unFriend(int userId, int friendId) {
        String query = "UPDATE FriendShip SET Request_status = 'unfriended' WHERE (User_id = ? AND Friend_id = ?) OR (User_id = ? AND Friend_id = ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, friendId);
            stmt.setInt(3, friendId);
            stmt.setInt(4, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was updated
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    public static boolean cancelFriendRequest(int userId, int friendId) {
        String query = "UPDATE FriendShip SET Request_status = 'cancelled' WHERE "
                + "((User_id = ? AND Friend_id = ? AND Request_status = 'sent') OR "
                + "(User_id = ? AND Friend_id = ? AND Request_status = 'received'))";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, friendId);
            stmt.setInt(3, friendId);
            stmt.setInt(4, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was updated
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    public static String getFriendRequestStatus(int userId, String userName) {
        String getUserIdQuery = "SELECT User_id FROM Users WHERE Username = ?";
        String getRequestStatusQuery = "SELECT Request_status FROM FriendShip WHERE User_id = ? AND Friend_id = ?";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement getUserStmt = conn.prepareStatement(getUserIdQuery)) {

            getUserStmt.setString(1, userName);
            ResultSet rsUser = getUserStmt.executeQuery();

            if (rsUser.next()) {
                int friendId = rsUser.getInt("User_id");

                try (PreparedStatement getRequestStatusStmt = conn.prepareStatement(getRequestStatusQuery)) {
                    getRequestStatusStmt.setInt(1, userId);
                    getRequestStatusStmt.setInt(2, friendId);
                    ResultSet rsStatus = getRequestStatusStmt.executeQuery();

                    if (rsStatus.next()) {
                        return rsStatus.getString("Request_status");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching friend request status", e);
        }
        return null; // Trả về null nếu không có kết quả
    }

    public static List<User> getPendingFriendRequests(int user_id) {
        List<User> pendingRequests = new ArrayList<>();

        // Câu truy vấn SQL để lấy các người bạn mà người dùng đã gửi lời mời và trạng thái là "received"
        String getPendingRequestsQuery = "SELECT u.User_id, u.Username, u.User_avatar FROM Users u "
                + "INNER JOIN FriendShip f ON u.User_id = f.User_id "
                + "WHERE f.Friend_id = ? AND f.Request_status = 'sent'";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement getPendingRequestsStmt = conn.prepareStatement(getPendingRequestsQuery)) {

            getPendingRequestsStmt.setInt(1, user_id);
            ResultSet rs = getPendingRequestsStmt.executeQuery();

            // Lặp qua kết quả của truy vấn và thêm người bạn vào danh sách pendingRequests
            while (rs.next()) {
                int friendId = rs.getInt("User_id");
                String userName = rs.getString("Username");
                String userAvatar = rs.getString("User_avatar");

                User friend = new User(friendId, userName, userAvatar); // Tạo đối tượng User từ kết quả truy vấn
                pendingRequests.add(friend);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching pending friend requests", e);
        }

        return pendingRequests;
    }

    public static List<User> getAcceptedFriends(int userId) {
        List<User> acceptedFriends = new ArrayList<>();
        Set<Integer> uniqueFriendIds = new HashSet<>(); // Dùng Set để lưu trữ các friendId duy nhất

        // Câu truy vấn SQL để lấy danh sách các bạn bè đã chấp nhận của người dùng từ cả hai phía
        String getAcceptedFriendsQuery = "SELECT u.User_id, u.Username, u.User_avatar FROM Users u "
                + "INNER JOIN FriendShip f ON (u.User_id = f.Friend_id OR u.User_id = f.User_id) "
                + "WHERE (f.User_id = ? OR f.Friend_id = ?) AND f.Request_status = 'accepted' AND u.User_id != ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement getAcceptedFriendsStmt = conn.prepareStatement(getAcceptedFriendsQuery)) {

            getAcceptedFriendsStmt.setInt(1, userId);
            getAcceptedFriendsStmt.setInt(2, userId);
            getAcceptedFriendsStmt.setInt(3, userId);
            ResultSet rs = getAcceptedFriendsStmt.executeQuery();

            // Lặp qua kết quả của truy vấn và thêm các bạn bè đã chấp nhận vào danh sách acceptedFriends
            while (rs.next()) {
                int friendId = rs.getInt("User_id");
                String userName = rs.getString("Username");
                String userAvatar = rs.getString("User_avatar");
                // Kiểm tra xem friendId đã tồn tại trong Set chưa
                if (!uniqueFriendIds.contains(friendId)) {
                    uniqueFriendIds.add(friendId); // Thêm friendId vào Set
                    User friend = new User(friendId, userName, userAvatar); // Tạo đối tượng User từ kết quả truy vấn
                    acceptedFriends.add(friend);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching accepted friends", e);
        }
        return acceptedFriends;
    }

    public static boolean areFriendsAccepted(int userId, String friendName) {
        boolean isFriend = false;

        String sql = "SELECT COUNT(*) "
                + "FROM FriendShip f "
                + "JOIN Users u1 ON f.User_id = u1.User_id "
                + "JOIN Users u2 ON f.Friend_id = u2.User_id "
                + "WHERE ((f.User_id = ? AND u2.Username = ?) OR (f.Friend_id = ? AND u1.Username = ?)) "
                + "AND f.Request_status = 'accepted'";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, friendName);
            ps.setInt(3, userId);
            ps.setString(4, friendName);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    if (count > 0) {
                        isFriend = true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isFriend;
    }

    public static boolean hasFriendRequestFromUser(int userId, String friendName) {
        String checkRequestQuery = "SELECT COUNT(*) FROM FriendShip f "
                + "JOIN Users u ON f.User_id = u.User_id "
                + "WHERE f.Friend_id = ? AND u.Username = ? AND f.Request_status = 'received'";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement checkStmt = conn.prepareStatement(checkRequestQuery)) {

            checkStmt.setInt(1, userId);
            checkStmt.setString(2, friendName);

            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error occurred while checking friend request status", e);
            return false;
        }
    }

    public static boolean registrManager(ManagerRegistr managerRegistr) {
        String sql = "INSERT INTO managerRegistr (User_id, RegistrationDate, Status, Remarks) VALUES (?, GETDATE(), 'pending', ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, managerRegistr.getUserId());
            statement.setString(2, managerRegistr.getRemarks());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<ManagerRegistr> getAllRegisterM() {
        List<ManagerRegistr> registrations = new ArrayList<>();

        String selectQuery = "SELECT "
                + "mr.managerRegistr_id, "
                + "mr.RegistrationDate, "
                + "mr.Status, "
                + "mr.Remarks, "
                + "u.User_id, "
                + "u.Username, "
                + "u.User_role, "
                + "u.User_fullName, "
                + "u.User_avatar, "
                + "u.User_rank, "
                + "u.User_score, "
                + "u.User_createDate, "
                + "u.User_sex "
                + "FROM managerRegistr mr "
                + "JOIN Users u ON mr.User_id = u.User_id";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int managerRegistrId = rs.getInt("managerRegistr_id");

                Date registrationDate = rs.getTimestamp("RegistrationDate");
                String status = rs.getString("Status");
                String remarks = rs.getString("Remarks");

                // User fields
                int userId = rs.getInt("User_id");
                String username = rs.getString("Username");
                int userRole = rs.getInt("User_role");
                String userFullName = rs.getString("User_fullName");
                String userAvatar = rs.getString("User_avatar");
                int userRank = rs.getInt("User_rank");
                int userScore = rs.getInt("User_score");
                Date userCreateDate = rs.getTimestamp("User_createDate");
                String userSex = rs.getString("User_sex");

                // Create User object
                User user = new User();
                user.setUserId(userId);
                user.setUsername(username);
                user.setUserRole(userRole);
                user.setUserFullName(userFullName);
                user.setUserAvatar(userAvatar);
                user.setUserRank(userRank);
                user.setUserScore(userScore);
                user.setUserCreateDate(userCreateDate);
                user.setUserSex(userSex);
                // Create ManagerRegistr object
                ManagerRegistr registration = new ManagerRegistr(status,
                        remarks, user);

                registrations.add(registration);
            }

        } catch (SQLException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return registrations;
    }

    public static boolean isManagerPending(int userId) {
        String query = "SELECT COUNT(*) FROM managerRegistr WHERE User_id = ? AND Status = 'pending'";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0; // Trả về true nếu có ít nhất một bản ghi thỏa mãn điều kiện
            }
            return false;

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Database error: " + e.getMessage());
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public static boolean addFeedback(Feedback feedback) {
        String query = "INSERT INTO Feedback (Feedback_detail, Feedback_title, User_id) VALUES (?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, feedback.getFeedbackDetail());
            stmt.setString(2, feedback.getFeedbackTitle());
            stmt.setInt(3, feedback.getUserId());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was inserted
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    public static List<Feedback> getAllFeedback() {
        List<Feedback> feedbackList = new ArrayList<>();
        String selectQuery = "SELECT Feedback_id, Feedback_title, Feedback_detail, User_id FROM Feedback";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(selectQuery); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int feedbackId = rs.getInt("Feedback_id");
                String feedbackTitle = rs.getString("Feedback_detail");
                String feedbackDetail = rs.getString("Feedback_title");
                int userId = rs.getInt("User_id");

                Feedback feedback = new Feedback(feedbackId, feedbackTitle, feedbackDetail, userId);
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching feedback", e);
        }

        return feedbackList;
    }

    public static boolean deleteFeedback(int feedbackId) {
        String deleteQuery = "DELETE FROM Feedback WHERE Feedback_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(deleteQuery)) {

            stmt.setInt(1, feedbackId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was deleted
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error occurred while deleting feedback", e);
            return false; // Return false if an error occurred
        }
    }

    public static List<User> getUsersWhoMessagedUserOrderByLatestMessage(int userId) {
        List<User> users = new ArrayList<>();
        Set<Integer> uniqueUserIds = new HashSet<>(); // Dùng Set để lưu trữ các userId duy nhất

        // Câu truy vấn SQL để lấy danh sách các người dùng có liên quan đến người dùng hiện tại, không phân biệt gửi hay nhận, sắp xếp theo thời gian tin nhắn gần nhất
        String query = "SELECT u.User_id, u.Username, u.User_avatar, MAX(m.TimeStamp) AS LatestMessageTime "
                + "FROM Users u "
                + "JOIN Message m ON u.User_id = m.From_id OR u.User_id = m.To_id "
                + "WHERE m.From_id = ? OR m.To_id = ? "
                + "GROUP BY u.User_id, u.Username, u.User_avatar "
                + "ORDER BY LatestMessageTime DESC";

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("User_id");
                    String username = rs.getString("Username");
                    String avatar = rs.getString("User_avatar");

                    // Kiểm tra xem userId đã tồn tại trong Set chưa
                    if (!uniqueUserIds.contains(id) && id != userId) { // Đảm bảo không thêm chính userId vào danh sách
                        uniqueUserIds.add(id); // Thêm userId vào Set
                        User user = new User();
                        user.setUserId(id);
                        user.setUsername(username);
                        user.setUserAvatar(avatar);
                        users.add(user);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error occurred while fetching users who messaged user", e);
        }

        // In ra danh sách người dùng
        System.out.println("List of users who messaged user with userId " + userId + ":");
        for (User user : users) {
            System.out.println("User ID: " + user.getUserId() + ", Username: " + user.getUsername() + ", Avatar: " + user.getUserAvatar());
        }

        return users;
    }

}
