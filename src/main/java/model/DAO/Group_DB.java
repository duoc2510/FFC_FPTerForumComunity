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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Comment;
import static model.DAO.DBinfo.dbPass;
import static model.DAO.DBinfo.dbURL;
import static model.DAO.DBinfo.dbUser;
import static model.DAO.DBinfo.driver;
import model.Group;
import model.Group_member;
import model.Post;
import model.Upload;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
public class Group_DB implements DBinfo {

    public Group_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Group_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static int addGroup(Group group) {
        String insertQuery = "INSERT INTO [Group] (Creater_id, Group_name, Group_description, Image) VALUES (?, ?, ?, ?)";
        int groupId = -1; // Khởi tạo groupId với giá trị mặc định là -1

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, group.getCreaterId());
            pstmt.setString(2, group.getGroupName());
            pstmt.setString(3, group.getGroupDescription());
            pstmt.setString(4, group.getImage());

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                // Lấy ID của nhóm vừa thêm vào
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        groupId = generatedKeys.getInt(1);
                        // Thêm người tạo nhóm vào bảng MemberGroup với trạng thái "Approved"
                        if (!joinGroup(group.getCreaterId(), groupId)) {
                            // Nếu thêm người tạo nhóm vào MemberGroup thất bại, đặt lại giá trị groupId về -1
                            groupId = -1;
                        }
                    }
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(Group_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return groupId; // Trả về ID của nhóm hoặc -1 nếu có lỗi
    }

    public static Group viewGroup(int groupId) {
        Group group = null;
        String sql = "SELECT Group_id, Creater_id, Group_name, Group_description, image, memberCount,Group_status, "
                + "MemberGroup_id, Status, User_id, User_email, User_fullName, User_avatar, User_activeStatus, "
                + "Post_id, Post_user_id, Post_group_id, Post_content, Post_createDate, Post_status, "
                + "Comment_id, Comment_post_id, Comment_user_id, Comment_content, Comment_date, "
                + "Upload_id, Upload_post_id, UploadPath "
                + "FROM GroupView WHERE Group_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, groupId);

            try (ResultSet rs = pstmt.executeQuery()) {
                List<Group_member> groupMembers = new ArrayList<>();
                List<Post> posts = new ArrayList<>();
                List<Comment> comments = new ArrayList<>();
                List<Upload> uploads = new ArrayList<>();
                // Kiểm tra xem ResultSet có dữ liệu không
                if (rs.next()) {
                    // Collect group member information
                    User user = new User(
                            rs.getInt("User_id"),
                            rs.getString("User_email"),
                            rs.getString("User_fullName"),
                            rs.getString("User_avatar"),
                            rs.getBoolean("User_activeStatus")
                    );
                    Group_member groupMember = new Group_member(
                            rs.getInt("MemberGroup_id"),
                            rs.getString("Status"),
                            user
                    );
                    groupMembers.add(groupMember);

                    // Collect post information
                    Post post = new Post(
                            rs.getInt("Post_id"),
                            rs.getInt("Post_user_id"),
                            rs.getInt("Post_group_id"),
                            rs.getString("Post_content"),
                            rs.getString("Post_createDate"),
                            rs.getString("Post_status")
                    );
                    posts.add(post);

                    // Collect comment information
                    Comment comment = new Comment(
                            rs.getInt("Comment_id"),
                            rs.getInt("Comment_post_id"),
                            rs.getInt("Comment_user_id"),
                            rs.getString("Comment_content"),
                            rs.getDate("Comment_date")
                    );
                    comments.add(comment);

                    // Collect upload information
                    Upload upload = new Upload(
                            rs.getInt("Upload_id"),
                            rs.getInt("Upload_post_id"),
                            rs.getString("UploadPath")
                    );
                    uploads.add(upload);

                    // Tạo đối tượng Group nếu ResultSet có dữ liệu
                    group = new Group(
                            groupId,
                            rs.getInt("Creater_id"),
                            rs.getString("Group_name"),
                            rs.getString("Group_description"),
                            groupMembers,
                            posts,
                            comments,
                            uploads,
                            rs.getString("image"),
                            rs.getInt("memberCount"),
                            rs.getString("Group_status")
                    );
                }
                System.out.println("Xem duoc");
            }
        } catch (SQLException e) {
            // Xử lý lỗi SQLException
            e.printStackTrace(); // In ra stack trace của lỗi
            // Hoặc xử lý lỗi một cách hợp lý khác tùy theo yêu cầu
        }
        return group;
    }

    public static List<Group> getAllGroups() {
        List<Group> groups = new ArrayList<>();
        String sql = "SELECT g.Group_id, g.Creater_id, g.Group_name, g.Group_description, g.image, g.Status,"
                + "COUNT(DISTINCT CASE WHEN mg.Status IN ('approved', 'host') THEN mg.MemberGroup_id END) AS memberCount "
                + "FROM [Group] g "
                + "LEFT JOIN MemberGroup mg ON g.Group_id = mg.Group_id "
                + "GROUP BY g.Group_id, g.Creater_id, g.Group_name, g.Group_description, g.image,g.Status";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Group group = new Group(
                        rs.getInt("Group_id"),
                        rs.getInt("Creater_id"),
                        rs.getString("Group_name"),
                        rs.getString("Group_description"),
                        null,
                        null,
                        null,
                        null,
                        rs.getString("image"),
                        rs.getInt("memberCount"),
                        rs.getString("Status")
                );
                groups.add(group);
            }
            System.out.println("Query executed successfully!"); // Thông báo thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groups;
    }

    public static boolean joinGroup(int userId, int groupId) {
        String sql;
        boolean isCreator = false;

        // Kiểm tra xem người tham gia có phải là người tạo nhóm không
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = conn.prepareStatement("SELECT Creater_id FROM [Group] WHERE Group_id = ?")) {

            pstmt.setInt(1, groupId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int createrId = rs.getInt("Creater_id");
                    isCreator = (createrId == userId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        // Xây dựng câu lệnh SQL phù hợp dựa vào trạng thái của người tham gia
        if (isCreator) {
            sql = "INSERT INTO MemberGroup (User_id, Group_id, Status) VALUES (?, ?, 'host')";
        } else {
            sql = "INSERT INTO MemberGroup (User_id, Group_id, Status) VALUES (?, ?, 'pending')";
        }

        // Thực hiện câu lệnh SQL
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.setInt(2, groupId);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean isUserPendingApproval(int userId, int groupId) {
        String query = "SELECT * FROM MemberGroup WHERE User_id = ? AND Group_id = ? AND Status = 'pending'";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, groupId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean isUserApproved(int userId, int groupId) {
        String query = "SELECT * FROM MemberGroup WHERE User_id = ? AND Group_id = ? AND Status = 'approved'";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, groupId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean isUserBan(int userId, int groupId) {
        String query = "SELECT * FROM MemberGroup WHERE User_id = ? AND Group_id = ? AND Status = 'banned'";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, groupId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Group> getAllGroupsCreated(int userId) {
        List<Group> groups = new ArrayList<>();
        String sql = "SELECT g.Group_id, g.Creater_id, g.Group_name, g.Group_description, g.image, g.Status, "
                + "COUNT(DISTINCT CASE WHEN mg.Status IN ('approved', 'host') THEN mg.MemberGroup_id END) AS memberCount "
                + "FROM [Group] g "
                + "LEFT JOIN MemberGroup mg ON g.Group_id = mg.Group_id "
                + "WHERE g.Creater_id = ? "
                + "GROUP BY g.Group_id, g.Creater_id, g.Group_name, g.Group_description, g.image,g.Status";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Group group = new Group(
                            rs.getInt("Group_id"),
                            rs.getInt("Creater_id"),
                            rs.getString("Group_name"),
                            rs.getString("Group_description"),
                            null,
                            null,
                            null,
                            null,
                            rs.getString("image"),
                            rs.getInt("memberCount"),
                            rs.getString("Status")
                    );
                    groups.add(group);
                }
                System.out.println("getAllGroupsCreated: Query executed successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groups;
    }

    public static List<Group_member> getAllMembersByGroupId(int groupId) {
        List<Group_member> members = new ArrayList<>();

        // Câu truy vấn SQL với JOIN bảng User
        String query = "SELECT mg.MemberGroup_id, mg.Group_id, mg.User_id, mg.Status, u.Username, u.User_avatar "
                + "FROM MemberGroup mg "
                + "JOIN Users u ON mg.User_id = u.User_id "
                + "WHERE mg.Group_id = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, groupId);
            ResultSet rs = pstmt.executeQuery();

            // Duyệt qua kết quả trả về và tạo đối tượng Group_member cho mỗi bản ghi
            while (rs.next()) {
                int memberId = rs.getInt("MemberGroup_id");
                int userId = rs.getInt("User_id");
                String status = rs.getString("Status");
                String username = rs.getString("Username");
                String userAvatar = rs.getString("User_avatar");
                User user = new User(userId, username, userAvatar);
                // Tạo đối tượng Group_member và thêm vào danh sách
                Group_member member = new Group_member(memberId, status, user);
                members.add(member);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return members;
    }

    public static boolean accept(int memberGroupId) {
        String query = "UPDATE MemberGroup SET Status = 'approved' WHERE MemberGroup_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, memberGroupId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean deny(int memberGroupId) {
        String query = "UPDATE MemberGroup SET Status = 'deny' WHERE MemberGroup_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, memberGroupId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static List<Group> getAllGroupJoin(int userId) {
        List<Group> groups = new ArrayList<>();
        String sql = "SELECT g.Group_id, g.Creater_id, g.Group_name, g.Group_description, g.image, g.Status, "
                + "COUNT(DISTINCT CASE WHEN mg.Status IN ('approved', 'host') THEN mg.MemberGroup_id END) AS memberCount "
                + "FROM [Group] g "
                + "JOIN MemberGroup mg ON g.Group_id = mg.Group_id "
                + "WHERE mg.User_id = ? AND mg.Status = 'approved' "
                + "GROUP BY g.Group_id, g.Creater_id, g.Group_name, g.Group_description, g.image, g.Status";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Group group = new Group(
                            rs.getInt("Group_id"),
                            rs.getInt("Creater_id"),
                            rs.getString("Group_name"),
                            rs.getString("Group_description"),
                            null,
                            null,
                            null,
                            null,
                            rs.getString("image"),
                            rs.getInt("memberCount"),
                            rs.getString("Status")
                    );
                    groups.add(group);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groups;
    }

    public static boolean updateGroup(int groupId, String groupName, String groupDescription, String image) {
        String updateQuery = "UPDATE [Group] SET Group_name = ?, Group_description = ?, Image = ? WHERE Group_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(updateQuery)) {

            pstmt.setString(1, groupName);
            pstmt.setString(2, groupDescription);
            pstmt.setString(3, image);
            pstmt.setInt(4, groupId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // Return true if update is successful, otherwise false

        } catch (SQLException ex) {
            Logger.getLogger(Group_DB.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static int countPostsInGroup(int groupId) {
        String countQuery = "SELECT COUNT(*) AS postCount FROM Post WHERE Group_id = ?";
        int postCount = 0;

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(countQuery)) {

            pstmt.setInt(1, groupId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    postCount = rs.getInt("postCount");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Group_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return postCount;
    }

    public static boolean leaveGroup(int groupId, int userId) {
        String sql = "UPDATE MemberGroup SET Status = 'left' WHERE Group_id = ? AND User_id = ?";
        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, groupId);
            statement.setInt(2, userId);
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có hàng nào được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public static boolean kickMember(int groupId, int userId) {
        String sql = "UPDATE MemberGroup SET Status = 'kicked' WHERE Group_id = ? AND User_id = ?";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, groupId);
            statement.setInt(2, userId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean banMember(int groupId, int userId) {
        String sql = "UPDATE MemberGroup SET Status = 'banned' WHERE Group_id = ? AND User_id = ?";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, groupId);
            statement.setInt(2, userId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean removeAllMember(int groupId) {
        String sql = "UPDATE MemberGroup SET Status = 'kicked' WHERE Group_id = ?";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, groupId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteGroup(int groupId) {
        String sqlUpdateStatus = "UPDATE [Group] SET Status = 'inactive' WHERE Group_id = ?";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement statement = connection.prepareStatement(sqlUpdateStatus)) {
            statement.setInt(1, groupId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Post> getUserPostsInGroup(int userId, int groupId) {
        List<Post> posts = new ArrayList<>();
        String query
                = "SELECT p.*, u.UploadPath "
                + "FROM Post p "
                + "LEFT JOIN Upload u ON p.Post_id = u.Post_id "
                + "WHERE p.User_id = ? AND p.Group_id = ? "
                + "ORDER BY p.Post_id DESC";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.setInt(2, groupId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {

                int postId = rs.getInt("Post_id");
                int topicId = rs.getInt("Topic_id");
                String content = rs.getString("Content");
                String createDate = rs.getString("createDate");
                String status = rs.getString("Status");
                String postStatus = rs.getString("postStatus");
                String reason = rs.getString("Reason");
                String uploadPath = rs.getString("UploadPath");

                Post post = new Post(postId, userId, groupId, topicId, content, createDate, status, postStatus, reason, uploadPath);
                posts.add(post);
            }
            System.out.println("getPostsWithUploadPath: Query executed successfully.");
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("getPostsWithUploadPath: Query execution failed.");
        }
        return posts;

    }
}
