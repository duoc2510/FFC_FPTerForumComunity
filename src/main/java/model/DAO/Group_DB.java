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
public class Group_DB  implements DBinfo{
     public Group_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Group_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
     public static boolean addGroup(Group group) {
        String insertQuery = "INSERT INTO [Group] (Creater_id, Group_name, Group_description) VALUES (?, ?, ?)";
        
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); 
             PreparedStatement pstmt = con.prepareStatement(insertQuery)) {
             
            pstmt.setInt(1, group.getCreaterId());
            pstmt.setString(2, group.getGroupName());
            pstmt.setString(3, group.getGroupDescription());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(Group_DB.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
  public static Group viewGroup(int userId, int groupId) {
    Group group = null;
    String sql = "SELECT Group_id, Creater_id, Group_name, Group_description,image, memberCount " +
                 "MemberGroup_id, User_id, User_email, User_fullName, " +
                 "User_avatar, User_activeStatus, Post_id, Post_user_id, " +
                 "Post_group_id, Post_content, Post_createDate, Post_status, " +
                 "Comment_id, Comment_post_id, Comment_user_id, Comment_content, " +
                 "Comment_date, Upload_id, Upload_post_id " +
                 "FROM GroupView WHERE Group_id = ? AND User_id = ?";

    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setInt(1, groupId); // Thiết lập giá trị cho tham số Group_id trong truy vấn
        pstmt.setInt(2, userId);  // Thiết lập giá trị cho tham số User_id trong truy vấn
        
        try (ResultSet rs = pstmt.executeQuery()) {
            List<Group_member> groupMembers = new ArrayList<>();
            List<Post> posts = new ArrayList<>();
            List<Comment> comments = new ArrayList<>();
            List<Upload> uploads = new ArrayList<>();

            while (rs.next()) {
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
                    user
                );
                groupMembers.add(groupMember);

                // Collect post information
                Post post = new Post(
                    rs.getInt("Post_id"),
                    rs.getInt("Post_user_id"),
                    rs.getInt("Post_group_id"),
                    rs.getString("Post_content"),
                    rs.getTimestamp("Post_createDate"),
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
                    rs.getInt("Upload_post_id")
                );
                uploads.add(upload);
            }

            // Tạo đối tượng Group từ thông tin thu thập được
            group = new Group(
                groupId,                               // Group_id
                rs.getInt("Creater_id"),               // Creater_id
                rs.getString("Group_name"),            // Group_name
                rs.getString("Group_description"),     // Group_description
                groupMembers,
                posts,
                comments,
                uploads,
                rs.getString("image"),
                rs.getInt("memberCount")
            );
        }
    } catch (SQLException e) {
        System.out.println(e.getMessage());
    }
    return group;
}


     public static List<Group> getAllGroups() {
        List<Group> groups = new ArrayList<>();
     String sql = "SELECT g.Group_id, g.Creater_id, g.Group_name, g.Group_description, g.image, " +
             "COUNT(DISTINCT CASE WHEN mg.Status = 'Approved' THEN mg.MemberGroup_id END) + 1 AS memberCount " +
             "FROM [Group] g " +
             "LEFT JOIN MemberGroup mg ON g.Group_id = mg.Group_id " +
             "GROUP BY g.Group_id, g.Creater_id, g.Group_name, g.Group_description, g.image";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

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
                     rs.getInt("memberCount")              
                );
                groups.add(group);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groups;
    }
    public static boolean joinGroup(int userId, int groupId) {
        String sql = "INSERT INTO MemberGroup (User_id, Group_id, Status) VALUES (?, ?, 'pending')";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

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
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement stmt = conn.prepareStatement(query)) {
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
    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
         PreparedStatement stmt = conn.prepareStatement(query)) {
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
    String sql = "SELECT g.Group_id, g.Creater_id, g.Group_name, g.Group_description, g.image, " +
                 "COUNT(DISTINCT CASE WHEN mg.Status = 'Approved' THEN mg.MemberGroup_id END) + 1 AS memberCount " +
                 "FROM [Group] g " +
                 "LEFT JOIN MemberGroup mg ON g.Group_id = mg.Group_id " +
                 "WHERE g.Creater_id = ? " +
                 "GROUP BY g.Group_id, g.Creater_id, g.Group_name, g.Group_description, g.image";
    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
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
                    rs.getInt("memberCount")
                );
                groups.add(group);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return groups;
}

}
