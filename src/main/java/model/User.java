package model;

import java.util.Date;
import model.DAO.User_DB;
import org.mindrot.jbcrypt.BCrypt;

public class User {

    private int userId;
    private String userEmail;
    private String userPassword;
    private int userRole;
    private String username;
    private String userFullName;
    private double userWallet;
    private String userAvatar;
    private String userStory;
    private int userRank;
    private int userScore;
    private Date userCreateDate;
    private String userSex;
    private boolean userActiveStatus;
    private String usernameVip;

    public User() {
    }

    public User(int userId, String username, String userAvatar ) {
        this.userId = userId;
        this.username = username;
        this.userAvatar= userAvatar;
    }

   

    // Constructor
    public User(int userId, String userEmail, String userPassword, int userRole, String username, String userFullName, double userWallet, String userAvatar, String userStory, int userRank, int userScore, Date userCreateDate, String userSex, boolean userActiveStatus) {
        this.userId = userId;
        this.userEmail = userEmail;
        this.userPassword = userPassword;
        this.userRole = userRole;
        this.username = username;
        this.userFullName = userFullName;
        this.userWallet = userWallet;
        this.userAvatar = userAvatar;
        this.userStory = userStory;
        this.userRank = userRank;
        this.userScore = userScore;
        this.userCreateDate = userCreateDate;
        this.userSex = userSex;
        this.userActiveStatus = userActiveStatus;
    }

    public User(int userId, String userEmail, String userFullName, String userAvatar, boolean userActiveStatus) {
        this.userId = userId;
        this.userEmail = userEmail;
        this.userFullName = userFullName;
        this.userAvatar = userAvatar;
        this.userActiveStatus = userActiveStatus;
    }

    public User(String userEmail, String userPassword, String username) {
        this.userEmail = userEmail;
        this.userPassword = userPassword;
        this.username = username;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public int getUserRole() {
        return userRole;
    }

    public void setUserRole(int userRole) {
        this.userRole = userRole;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUserFullName() {
        return userFullName;
    }

    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    public double getUserWallet() {
        return userWallet;
    }

    public void setUserWallet(double userWallet) {
        this.userWallet = userWallet;
    }

    public String getUserAvatar() {
        return userAvatar;
    }

    public void setUserAvatar(String userAvatar) {
        this.userAvatar = userAvatar;
    }

    public String getUserStory() {
        return userStory;
    }

    public void setUserStory(String userStory) {
        this.userStory = userStory;
    }

    public int getUserRank() {
        return userRank;
    }

    public void setUserRank(int userRank) {
        this.userRank = userRank;
    }

    public int getUserScore() {
        return userScore;
    }

    public void setUserScore(int userScore) {
        this.userScore = userScore;
    }

    public Date getUserCreateDate() {
        return userCreateDate;
    }

    public void setUserCreateDate(Date userCreateDate) {
        this.userCreateDate = userCreateDate;
    }

    public String getUserSex() {
        return userSex;
    }

    public void setUserSex(String userSex) {
        this.userSex = userSex;
    }

    public boolean isUserActiveStatus() {
        return userActiveStatus;
    }

    public void setUserActiveStatus(boolean userActiveStatus) {
        this.userActiveStatus = userActiveStatus;
    }

    public static User login(String identify, String inputMatKhau) {
        User user = User_DB.getUserByEmailorUsername(identify);
        if (user != null) {
            String storedPassword = user.getUserPassword();
            // Kiểm tra nếu mật khẩu được lưu trữ là mật khẩu đã mã hóa bằng BCrypt
            if (storedPassword.startsWith("$2a$") || storedPassword.startsWith("$2b$") || storedPassword.startsWith("$2y$")) {
                // Kiểm tra mật khẩu đã mã hóa
                if (BCrypt.checkpw(inputMatKhau, storedPassword)) {
                    return user;
                }
            } else {
                // Kiểm tra mật khẩu thô cho các tài khoản ngoại lệ
                if (storedPassword.equals(inputMatKhau)) {
                    // Trả về người dùng nếu mật khẩu khớp
                    return user;
                }
            }
        }
        return null;
    }

}
