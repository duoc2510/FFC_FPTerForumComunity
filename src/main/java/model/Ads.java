/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author mac
 */
public class Ads {

    private int Ads_id;
    private int AdsDetail_id;
    private String Content;
    private String Image;
    private int User_id;
    private String currentView;
    private String location;
    private String URI;

    public Ads() {
    }

    public Ads(int Ads_id, int AdsDetail_id, String Content, String Image, int User_id, String currentView, String location, String URI) {
        this.Ads_id = Ads_id;
        this.AdsDetail_id = AdsDetail_id;
        this.Content = Content;
        this.Image = Image;
        this.User_id = User_id;
        this.currentView = currentView;
        this.location = location;
        this.URI = URI;
    }

    public int getAds_id() {
        return Ads_id;
    }

    public void setAds_id(int Ads_id) {
        this.Ads_id = Ads_id;
    }

    public int getAdsDetail_id() {
        return AdsDetail_id;
    }

    public void setAdsDetail_id(int AdsDetail_id) {
        this.AdsDetail_id = AdsDetail_id;
    }

    public String getContent() {
        return Content;
    }

    public void setContent(String Content) {
        this.Content = Content;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public int getUser_id() {
        return User_id;
    }

    public void setUser_id(int User_id) {
        this.User_id = User_id;
    }

    public String getCurrentView() {
        return currentView;
    }

    public void setCurrentView(String currentView) {
        this.currentView = currentView;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getURI() {
        return URI;
    }

    public void setURI(String URI) {
        this.URI = URI;
    }

    @Override
    public String toString() {
        return "Ads{" + "Ads_id=" + Ads_id + ", AdsDetail_id=" + AdsDetail_id + ", Content=" + Content + ", Image=" + Image + ", User_id=" + User_id + ", currentView=" + currentView + ", location=" + location + ", URI=" + URI + '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        Ads ads = (Ads) o;

        if (Ads_id != ads.Ads_id) {
            return false;
        }
        if (AdsDetail_id != ads.AdsDetail_id) {
            return false;
        }
        if (User_id != ads.User_id) {
            return false;
        }
        if (!Content.equals(ads.Content)) {
            return false;
        }
        if (!Image.equals(ads.Image)) {
            return false;
        }
        if (!currentView.equals(ads.currentView)) {
            return false;
        }
        if (!location.equals(ads.location)) {
            return false;
        }
        return URI.equals(ads.URI);
    }

    @Override
    public int hashCode() {
        int result = Ads_id;
        result = 31 * result + AdsDetail_id;
        result = 31 * result + Content.hashCode();
        result = 31 * result + Image.hashCode();
        result = 31 * result + User_id;
        result = 31 * result + currentView.hashCode();
        result = 31 * result + location.hashCode();
        result = 31 * result + URI.hashCode();
        return result;
    }

}
