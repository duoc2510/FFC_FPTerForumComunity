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
                // Assuming Ads_combo has appropriate setters to set these fields
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

}
