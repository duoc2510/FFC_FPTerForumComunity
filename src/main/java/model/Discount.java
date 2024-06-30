package model;

import java.util.Date;

public class Discount {

    private int discountId;
    private String code;
    private int ownerId;
    private int shopId;
    private double discountPercent;
    private Date validFrom;
    private Date validTo;
    private int usageLimit;
    private int usageCount;
    private double condition;

    // Constructor
    public Discount(String code, int ownerId, int shopId, double discountPercent, Date validFrom, Date validTo, int usageLimit, double condition) {
        this.code = code;
        this.ownerId = ownerId;
        this.shopId = shopId;
        this.discountPercent = discountPercent;
        this.validFrom = validFrom;
        this.validTo = validTo;
        this.usageLimit = usageLimit;
        this.usageCount = 0; // Default usage count
        this.condition = condition;
    }

    public Discount(int shopId, int discountId) {
        this.shopId = shopId;
        this.discountId = discountId;
    }

    public Discount() {
    }

    public Discount(int discountId, String code, int ownerId, int shopId, double discountPercent, Date validFrom, Date validTo, int usageLimit, int usageCount, double condition) {
        this.discountId = discountId;
        this.code = code;
        this.ownerId = ownerId;
        this.shopId = shopId;
        this.discountPercent = discountPercent;
        this.validFrom = validFrom;
        this.validTo = validTo;
        this.usageLimit = usageLimit;
        this.usageCount = usageCount;
        this.condition = condition;
    }

    // Getters and Setters
    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public int getShopId() {
        return shopId;
    }

    public void setShopId(int shopId) {
        this.shopId = shopId;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Date getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Date validFrom) {
        this.validFrom = validFrom;
    }

    public Date getValidTo() {
        return validTo;
    }

    public void setValidTo(Date validTo) {
        this.validTo = validTo;
    }

    public int getUsageLimit() {
        return usageLimit;
    }

    public void setUsageLimit(int usageLimit) {
        this.usageLimit = usageLimit;
    }

    public int getUsageCount() {
        return usageCount;
    }

    public void setUsageCount(int usageCount) {
        this.usageCount = usageCount;
    }

    public double getCondition() {
        return condition;
    }

    public void setCondition(double condition) {
        this.condition = condition;
    }

    @Override
    public String toString() {
        return "Discount{" + "discountId=" + discountId + ", code=" + code + ", ownerId=" + ownerId + ", shopId=" + shopId + ", discountPercent=" + discountPercent + ", validFrom=" + validFrom + ", validTo=" + validTo + ", usageLimit=" + usageLimit + ", usageCount=" + usageCount + ", condition=" + condition + '}';
    }

}
