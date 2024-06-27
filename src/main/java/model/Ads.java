package model;

import java.util.Date;

public class Ads {

    private int adsId;
    private int adsDetailId;
    private String content;
    private String image;
    private int userId;
    private int currentReact;
    private String location;
    private String title;
    private String uri;
    private String uploadPath;
    private int isActive;
    private Date startDate;

    public Ads() {
    }

    public Ads(int adsId, int adsDetailId, String content, String image, int userId, int currentReact, String location, String title, String uri, String uploadPath, int isActive, Date startDate) {
        this.adsId = adsId;
        this.adsDetailId = adsDetailId;
        this.content = content;
        this.image = image;
        this.userId = userId;
        this.currentReact = currentReact;
        this.location = location;
        this.title = title;
        this.uri = uri;
        this.uploadPath = uploadPath;
        this.isActive = isActive;
        this.startDate = startDate;
    }

    public int getAdsId() {
        return adsId;
    }

    public void setAdsId(int adsId) {
        this.adsId = adsId;
    }

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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCurrentReact() {
        return currentReact;
    }

    public void setCurrentReact(int currentReact) {
        this.currentReact = currentReact;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String uploadPath) {
        this.uploadPath = uploadPath;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    @Override
    public String toString() {
        return "Ads{" + "adsId=" + adsId + ", adsDetailId=" + adsDetailId + ", content=" + content + ", image=" + image + ", userId=" + userId + ", currentReact=" + currentReact + ", location=" + location + ", title=" + title + ", uri=" + uri + ", uploadPath=" + uploadPath + ", isActive=" + isActive + ", startDate=" + startDate + '}';
    }

}
