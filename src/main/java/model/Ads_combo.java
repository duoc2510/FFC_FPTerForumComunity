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
    private String content;
    private double budget;
    private int maxView;

    public Ads_combo() {
    }

    public Ads_combo(int adsDetailId, String content, double budget, int maxView) {
        this.adsDetailId = adsDetailId;
        this.content = content;
        this.budget = budget;
        this.maxView = maxView;
    }

    // Getters and Setters

    public int getAdsDetailId() {
        return adsDetailId;
    }

    public void setAdsDetailId(int adsDetailId) {
        this.adsDetailId = adsDetailId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public double getBudget() {
        return budget;
    }

    public void setBudget(double budget) {
        this.budget = budget;
    }

    public int getMaxView() {
        return maxView;
    }

    public void setMaxView(int maxView) {
        this.maxView = maxView;
    }

    
}
