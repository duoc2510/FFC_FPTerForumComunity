package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Ads;
import model.Ads_combo;
import model.Event;
import model.Upload;

public class Ads_DB implements DBinfo {

    public Ads_DB() {
        try {
            Class.forName(DBinfo.driver);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

//    ADS CLASS MODAL ====================================
    public static List<Ads_combo> getAllAdsCombo() {
        List<Ads_combo> allAdsCombo = new ArrayList<>();
        String query = "SELECT [Adsdetail_id], [Content], [budget], [maxView] FROM Combo_ads ORDER BY [Adsdetail_id] DESC";

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Ads_combo adsCombo = new Ads_combo();
                adsCombo.setAdsDetailId(rs.getInt("Adsdetail_id"));
                adsCombo.setContent(rs.getString("Content"));
                adsCombo.setBudget(rs.getDouble("budget"));
                adsCombo.setMaxView(rs.getInt("maxView"));
                allAdsCombo.add(adsCombo);
            }
            System.out.println("getAllCombo: Query executed successfully.");
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("getAllCombo: Query execution failed.");
        }
        return allAdsCombo;
    }

//    ADS CLASS MODAL ====================================
    public static List<Ads> getAllAdsByUserID(int userId) {
        List<Ads> allAds = new ArrayList<>();
        String query = "SELECT [Ads_id], [Adsdetail_id], [Content], [Image], [User_id], [currentView], [location], [URI] FROM Ads WHERE [User_id] = ?";

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Ads ads = new Ads();
                    ads.setAds_id(rs.getInt("Ads_id"));
                    ads.setAdsDetail_id(rs.getInt("Adsdetail_id"));
                    ads.setContent(rs.getString("Content"));
                    ads.setImage(rs.getString("Image"));
                    ads.setUser_id(rs.getInt("User_id"));
                    ads.setCurrentView(rs.getString("currentView"));
                    ads.setLocation(rs.getString("location"));
                    ads.setURI(rs.getString("URI"));
                    allAds.add(ads);
                }
            }
            System.out.println("getAllAdsByUserID: Query executed successfully.");
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("getAllAdsByUserID: Query execution failed.");
        }
        return allAds;
    }

    public boolean boostAdsvertising(Ads ads, Upload upload) {
        // SQL Queries
        String INSERT_ADS_QUERY = "INSERT INTO Ads (Adsdetail_id, Content, Image, User_id, currentView, location, URI) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String INSERT_UPLOAD_QUERY = "INSERT INTO Upload (Upload_id, UploadPath) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement pstmtEvent = con.prepareStatement(INSERT_ADS_QUERY, PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement pstmtUpload = con.prepareStatement(INSERT_UPLOAD_QUERY)) {

            con.setAutoCommit(false); // Begin transaction

            // Set parameters for Ads table insertion
            pstmtEvent.setInt(1, ads.getAdsDetail_id());
            pstmtEvent.setString(2, ads.getContent());
            pstmtEvent.setString(3, ads.getImage());
            pstmtEvent.setInt(4, ads.getUser_id());
            pstmtEvent.setString(5, ads.getCurrentView());
            pstmtEvent.setString(6, ads.getLocation());
            pstmtEvent.setString(7, ads.getURI());

            // Execute insertion into Ads table
            int affectedRows = pstmtEvent.executeUpdate();
            if (affectedRows == 0) {
                con.rollback();
                return false;
            }

            // Retrieve the auto-generated Ads_id
            ResultSet generatedKeys = pstmtEvent.getGeneratedKeys();
            int adsId;
            if (generatedKeys.next()) {
                adsId = generatedKeys.getInt(1);
            } else {
                con.rollback();
                return false;
            }

            // Set parameters for Upload table insertion
            pstmtUpload.setInt(1, adsId);
            pstmtUpload.setString(2, upload.getUploadPath());

            // Execute insertion into Upload table
            pstmtUpload.executeUpdate();

            // Commit the transaction if everything is successful
            con.commit();
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

}
