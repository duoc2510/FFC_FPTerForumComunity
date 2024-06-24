package model;

public class Ads {

    private int adsId;
    private int adsDetailId;
    private String content;
    private String image;
    private int userId;
    private int currentView;
    private String location;
    private String title;
    private String uri;
    private String uploadPath;
    private int isActive;

    public Ads() {
    }

    public Ads(int adsId, int adsDetailId, String content, String image, int userId, int currentView, String location, String title, String uri, String uploadPath, int isActive) {
        this.adsId = adsId;
        this.adsDetailId = adsDetailId;
        this.content = content;
        this.image = image;
        this.userId = userId;
        this.currentView = currentView;
        this.location = location;
        this.title = title;
        this.uri = uri;
        this.uploadPath = uploadPath;
        this.isActive = isActive;
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

    public int getCurrentView() {
        return currentView;
    }

    public void setCurrentView(int currentView) {
        this.currentView = currentView;
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

    @Override
    public String toString() {
        return "Ads{" + "adsId=" + adsId + ", adsDetailId=" + adsDetailId + ", content=" + content + ", image=" + image + ", userId=" + userId + ", currentView=" + currentView + ", location=" + location + ", title=" + title + ", uri=" + uri + ", uploadPath=" + uploadPath + ", isActive=" + isActive + '}';
    }

}
