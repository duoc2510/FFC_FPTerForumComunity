package model;

public class Upload {

    private int uploadId;
    private int postId;
    private int eventId;
    private int productId;
    private String uploadPath;

    public Upload() {
    }

    public Upload(int uploadId, int postId, int eventId, int productId, String uploadPath) {
        this.uploadId = uploadId;
        this.postId = postId;
        this.eventId = eventId;
        this.productId = productId;
        this.uploadPath = uploadPath;
    }

    public Upload(int uploadId, int postId, String uploadPath) {
        this.uploadId = uploadId;
        this.postId = postId;
        this.uploadPath = uploadPath;
    }
    

    public int getUploadId() {
        return uploadId;
    }

    public void setUploadId(int uploadId) {
        this.uploadId = uploadId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String uploadPath) {
        this.uploadPath = uploadPath;
    }

    @Override
    public String toString() {
        return "Upload{" + "uploadId=" + uploadId + ", postId=" + postId + ", eventId=" + eventId + ", productId=" + productId + ", uploadPath=" + uploadPath + '}';
    }

}
