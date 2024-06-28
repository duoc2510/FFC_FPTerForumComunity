/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author mac
 */
public class Ads_combo {

    private int adsDetailId;
    private String title;
    private int budget;
    private int maxReact;
    private int durationDay;
    private int User_id;
    private String comboType;
    private int totalReact;
    private Date createDate;

    public Ads_combo() {
    }

    //view
    public Ads_combo(int adsDetailId, String title, int budget, int maxReact, int durationDay, int User_id, String comboType, int totalReact, Date createDate) {
        this.adsDetailId = adsDetailId;
        this.title = title;
        this.budget = budget;
        this.maxReact = maxReact;
        this.durationDay = durationDay;
        this.User_id = User_id;
        this.comboType = comboType;
        this.totalReact = totalReact;
        this.createDate = createDate;
    }

    //add
    public Ads_combo(int adsDetailId, String title, int budget, int maxReact, int durationDay, int User_id, String comboType, Date createDate) {
        this.adsDetailId = adsDetailId;
        this.title = title;
        this.budget = budget;
        this.maxReact = maxReact;
        this.durationDay = durationDay;
        this.User_id = User_id;
        this.comboType = comboType;
        this.createDate = createDate;
    }

    public int getAdsDetailId() {
        return adsDetailId;
    }

    public void setAdsDetailId(int adsDetailId) {
        this.adsDetailId = adsDetailId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getBudget() {
        return budget;
    }

    public void setBudget(int budget) {
        this.budget = budget;
    }

    public int getMaxReact() {
        return maxReact;
    }

    public void setMaxReact(int maxReact) {
        this.maxReact = maxReact;
    }

    public int getDurationDay() {
        return durationDay;
    }

    public void setDurationDay(int durationDay) {
        this.durationDay = durationDay;
    }

    public int getUser_id() {
        return User_id;
    }

    public void setUser_id(int User_id) {
        this.User_id = User_id;
    }

    public String getComboType() {
        return comboType;
    }

    public void setComboType(String comboType) {
        this.comboType = comboType;
    }

    public int getTotalReact() {
        return totalReact;
    }

    public void setTotalReact(int totalReact) {
        this.totalReact = totalReact;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    @Override
    public String toString() {
        return "Ads_combo{" + "adsDetailId=" + adsDetailId + ", title=" + title + ", budget=" + budget + ", maxReact=" + maxReact + ", durationDay=" + durationDay + ", User_id=" + User_id + ", comboType=" + comboType + ", totalReact=" + totalReact + ", createDate=" + createDate + '}';
    }

}
