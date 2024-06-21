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
import static model.DAO.DBinfo.dbPass;
import static model.DAO.DBinfo.dbURL;
import static model.DAO.DBinfo.dbUser;
import model.*;
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

    public static boolean addFriendRequest(int userId, int friendId) {
        String checkQuery = "SELECT COUNT(*) FROM FriendShip WHERE (User_id = ? AND Friend_id = ?) OR (User_id = ? AND Friend_id = ?)";
        String insertQuery = "INSERT INTO FriendShip (User_id, Friend_id, Request_status) VALUES (?, ?, 'pending'), (?, ?, 'pending')";
        String updateQuery = "UPDATE FriendShip SET Request_status = 'pending' WHERE User_id = ? AND Friend_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {

            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, friendId);
            checkStmt.setInt(3, friendId);
            checkStmt.setInt(4, userId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                // Yêu cầu kết bạn đã tồn tại, cập nhật trạng thái thành "pending"
                try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                    updateStmt.setInt(1, userId);
                    updateStmt.setInt(2, friendId);
                    int rowsAffected = updateStmt.executeUpdate();
                    return rowsAffected > 0;
                }
            }

            // Thêm yêu cầu kết bạn mới
            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, friendId);
                insertStmt.setInt(3, friendId);
                insertStmt.setInt(4, userId);
                int rowsAffected = insertStmt.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error occurred while adding friend request", e);
            return false;
        }
    }

    public static boolean acceptFriendRequest(int userId, int friendId) {
        String query = "UPDATE FriendShip SET Request_status = ? WHERE (User_id = ? AND Friend_id = ?) OR (User_id = ? AND Friend_id = ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "accepted");
            stmt.setInt(2, userId);
            stmt.setInt(3, friendId);
            stmt.setInt(4, friendId);
            stmt.setInt(5, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public static boolean rejectFriendRequest(int userId, int friendId) {
        String query = "UPDATE FriendShip SET Request_status = ? WHERE (User_id = ? AND Friend_id = ?) OR (User_id = ? AND Friend_id = ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "deny");
            stmt.setInt(2, userId);
            stmt.setInt(3, friendId);
            stmt.setInt(4, friendId);
            stmt.setInt(5, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public static boolean unFriend(int userId, int friendId) {
        String query = "UPDATE FriendShip SET Request_status = ? WHERE (User_id = ? AND Friend_id = ?) OR (User_id = ? AND Friend_id = ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "deny");
            stmt.setInt(2, userId);
            stmt.setInt(3, friendId);
            stmt.setInt(4, friendId);
            stmt.setInt(5, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public static boolean cancelFriendRequest(int userId, int friendId) {
        String query = "UPDATE FriendShip SET Request_status = 'cancelled' WHERE User_id = ? AND Friend_id = ? AND Request_status = 'pending'";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, friendId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
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

        // Câu truy vấn SQL để lấy các người bạn mà người dùng đã gửi lời mời và trạng thái là "pending"
        String getPendingRequestsQuery = "SELECT u.User_id, u.Username, u.User_avatar FROM Users u "
                + "INNER JOIN FriendShip f ON u.User_id = f.User_id  "
                + "WHERE f.Friend_id = ? AND f.Request_status = 'pending'";

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

    public static List<User> getAcceptedFriendsOrderByLatestMessage(int userId) {
        List<User> acceptedFriends = new ArrayList<>();
        Set<Integer> uniqueFriendIds = new HashSet<>(); // Dùng Set để lưu trữ các friendId duy nhất

        // Câu truy vấn SQL để lấy danh sách các bạn bè đã chấp nhận của người dùng từ cả hai phía và sắp xếp theo thứ tự tin nhắn mới nhất
        String getAcceptedFriendsQuery = "SELECT u.User_id, u.Username, u.User_avatar, MAX(m.TimeStamp) AS LatestMessageTime "
                + "FROM Users u "
                + "INNER JOIN FriendShip f ON (u.User_id = f.Friend_id OR u.User_id = f.User_id) "
                + "LEFT JOIN Message m ON (u.User_id = m.From_id AND f.User_id = m.To_id) "
                + "                      OR (u.User_id = m.To_id AND f.User_id = m.From_id) "
                + "WHERE (f.User_id = ? OR f.Friend_id = ?) AND f.Request_status = 'accepted' AND u.User_id != ? "
                + "GROUP BY u.User_id, u.Username, u.User_avatar "
                + "ORDER BY LatestMessageTime DESC";

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
                + "WHERE f.Friend_id = ? AND u.Username = ? AND f.Request_status = 'pending'";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement checkStmt = conn.prepareStatement(checkRequestQuery)) {

            checkStmt.setInt(1, userId);
            checkStmt.setString(2, friendName);

            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                // Người dùng đã nhận yêu cầu kết bạn từ người dùng có tên là friendName
                return true;
            } else {
                // Người dùng chưa nhận yêu cầu kết bạn hoặc yêu cầu đã được chấp nhận
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, "Error occurred while checking friend request status", e);
            return false;
        }
    }

}
