package model;

/**
 *
 * @author Admin
 */
public class Shop {

    private int shopID;
    private String name;
    private String phone;
    private String campus;
    private String description;
    private int ownerID;
    private String image;
    private int status;
    

    public Shop() {
    }

    public Shop(int shopID, String name, String phone, String campus, String description, int ownerID, String image, int status) {
        this.shopID = shopID;
        this.name = name;
        this.phone = phone;
        this.campus = campus;
        this.description = description;
        this.ownerID = ownerID;
        this.image = image;
        this.status = status;
    }

    public int getShopID() {
        return shopID;
    }

    public void setShopID(int shopID) {
        this.shopID = shopID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCampus() {
        return campus;
    }

    public void setCampus(String campus) {
        this.campus = campus;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getOwnerID() {
        return ownerID;
    }

    public void setOwnerID(int ownerID) {
        this.ownerID = ownerID;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Shop{" + "shopID=" + shopID + ", name=" + name + ", phone=" + phone + ", campus=" + campus + ", description=" + description + ", ownerID=" + ownerID + ", image=" + image + ", status=" + status + '}';
    }

}
