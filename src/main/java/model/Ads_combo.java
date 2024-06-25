/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author mac
 */
public class Ads_combo {

    private int adsDetailId;
    private String title;
    private int budget;
    private int maxView;
    private int durationDay;
    private int User_id;

    public Ads_combo() {
    }

    public Ads_combo(int adsDetailId, String title, int budget, int maxView, int durationDay, int User_id) {
        this.adsDetailId = adsDetailId;
        this.title = title;
        this.budget = budget;
        this.maxView = maxView;
        this.durationDay = durationDay;
        this.User_id = User_id;
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

    public int getMaxView() {
        return maxView;
    }

    public void setMaxView(int maxView) {
        this.maxView = maxView;
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

    @Override
    public String toString() {
        return "Ads_combo{" + "adsDetailId=" + adsDetailId + ", title=" + title + ", budget=" + budget + ", maxView=" + maxView + ", durationDay=" + durationDay + ", User_id=" + User_id + '}';
    }

}
