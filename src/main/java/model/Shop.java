/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PC
 */
public class Shop {
    private int shopId;
    private String shopName;
    private String shopPhone;
    private String shopCampus;
    private String shopDescription;
    private int userId;

    public Shop() {
    }

    public Shop(int shopId, String shopName, String shopPhone, String shopCampus, String shopDescription, int userId) {
        this.shopId = shopId;
        this.shopName = shopName;
        this.shopPhone = shopPhone;
        this.shopCampus = shopCampus;
        this.shopDescription = shopDescription;
        this.userId = userId;
    }

    public int getShopId() {
        return shopId;
    }

    public void setShopId(int shopId) {
        this.shopId = shopId;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getShopPhone() {
        return shopPhone;
    }

    public void setShopPhone(String shopPhone) {
        this.shopPhone = shopPhone;
    }

    public String getShopCampus() {
        return shopCampus;
    }

    public void setShopCampus(String shopCampus) {
        this.shopCampus = shopCampus;
    }

    public String getShopDescription() {
        return shopDescription;
    }

    public void setShopDescription(String shopDescription) {
        this.shopDescription = shopDescription;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}