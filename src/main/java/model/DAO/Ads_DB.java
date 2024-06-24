package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Ads;
import model.Ads_combo;
import model.Upload;

public class Ads_DB implements DBinfo {

    public Ads_DB() {
        try {
            Class.forName(DBinfo.driver);
        } catch (ClassNotFoundException ex) {
            System.err.println("Error loading database driver: " + ex.getMessage());
        }
    }

    // Retrieve all AdsCombo records
    public List<Ads_combo> getAllAdsCombo() {
        List<Ads_combo> allAdsCombo = new ArrayList<>();
        String query = "SELECT * FROM Combo_ads ORDER BY Adsdetail_id DESC";

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Ads_combo adsCombo = new Ads_combo();
                adsCombo.setAdsDetailId(rs.getInt("Adsdetail_id"));
                adsCombo.setContent(rs.getString("Content"));
                adsCombo.setBudget(rs.getDouble("budget"));
                adsCombo.setMaxView(rs.getInt("maxView"));
                allAdsCombo.add(adsCombo);
            }
            System.out.println("getAllAdsCombo: Query executed successfully.");
        } catch (SQLException ex) {
            System.err.println("getAllAdsCombo: Query execution failed - " + ex.getMessage());
        }
        return allAdsCombo;
    }

    // Method to get all ads and their corresponding combo data
    public Map<Ads, Ads_combo> getAllAdsWithComboData() {
        Map<Ads, Ads_combo> adsWithComboData = new HashMap<>();

        // Get all ads from the Ads table
        List<Ads> allAds = getAllAds();

        // Get all combo data from the Combo_ads table
        List<Ads_combo> allComboAds = getAllComboAds();

        // Create a map of Adsdetail_id to ComboAds
        Map<Integer, Ads_combo> comboAdsMap = new HashMap<>();
        for (Ads_combo combo : allComboAds) {
            comboAdsMap.put(combo.getAdsDetailId(), combo);
        }

        // Associate each ad with its combo data
        for (Ads ad : allAds) {
            Ads_combo combo = comboAdsMap.get(ad.getAdsDetailId());
            adsWithComboData.put(ad, combo);
        }

        return adsWithComboData;
    }

    // Implement method to retrieve all ads
    public List<Ads> getAllAds() {
        List<Ads> allAds = new ArrayList<>();
        String query = "SELECT * FROM Ads";

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Ads ads = new Ads();
                ads.setAdsId(rs.getInt("Ads_id"));
                ads.setAdsDetailId(rs.getInt("Adsdetail_id"));
                ads.setContent(rs.getString("Content"));
                ads.setImage(rs.getString("Image"));
                ads.setUserId(rs.getInt("User_id"));
                ads.setCurrentView(rs.getInt("currentView"));
                ads.setLocation(rs.getString("location"));
                ads.setTitle(rs.getString("Title"));
                ads.setUri(rs.getString("URI"));
                ads.setUploadPath(rs.getString("UploadPath"));
                ads.setIsActive(rs.getInt("isActive"));
                allAds.add(ads);
            }
            System.out.println("getAllAds: Query executed successfully.");
        } catch (SQLException ex) {
            System.err.println("getAllAds: Query execution failed - " + ex.getMessage());
        }
        return allAds;
    }

    public List<Ads_combo> getAllComboAds() {
        return getAllAdsCombo();
    }

    // Retrieve all Ads records by User ID
    public static List<Ads> getAllAdsByUserID(int userId) {
        List<Ads> allAds = new ArrayList<>();
        String query = "SELECT * FROM Ads WHERE User_id = ?";

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Ads ads = new Ads();
                    ads.setAdsId(rs.getInt("Ads_id"));
                    ads.setAdsDetailId(rs.getInt("Adsdetail_id"));
                    ads.setContent(rs.getString("Content"));
                    ads.setImage(rs.getString("Image"));
                    ads.setUserId(rs.getInt("User_id"));
                    ads.setCurrentView(rs.getInt("currentView"));
                    ads.setLocation(rs.getString("location"));
                    ads.setUri(rs.getString("URI"));
                    ads.setIsActive(rs.getInt("isActive"));

                    allAds.add(ads);
                }
            }
            System.out.println("getAllAdsByUserID: Query executed successfully.");
        } catch (SQLException ex) {
            System.err.println("getAllAdsByUserID: Query execution failed - " + ex.getMessage());
        }
        return allAds;
    }

    // Boost advertising by inserting records into Ads and Upload tables
    public static void boostAdvertising(Ads ads) {

        String insertQuery = "INSERT INTO Ads (Adsdetail_id, Content, Image, User_id, currentView, location, URI, UploadPath,isActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(insertQuery)) {
            // Set parameters for Ads table insertion
            pstmt.setInt(1, ads.getAdsDetailId());
            pstmt.setString(2, ads.getContent());
            pstmt.setString(3, ads.getImage());
            pstmt.setInt(4, ads.getUserId());
            pstmt.setInt(5, ads.getCurrentView());
            pstmt.setString(6, ads.getLocation());
            pstmt.setString(7, ads.getUri());
            pstmt.setString(8, ads.getUploadPath());
            pstmt.setInt(9, 1); // active 
            // Execute insertion into Ads table
            pstmt.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(Ads_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changeActive(int adsId, int isActive) {
        String sql = "UPDATE Ads SET isActive = ? WHERE Ads_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, isActive);
            pstmt.setInt(2, adsId);

            pstmt.executeUpdate();
            System.out.println("Advertising status updated successfully.");
        } catch (SQLException ex) {
            Logger.getLogger(Ads_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

   

}
