package model;

/**
 *
 * @author Admin
 */
public class OrderDiscount {

    private int order_ID;
    private int discountID;

    public OrderDiscount() {
    }

    public OrderDiscount(int order_ID, int discountID) {
        this.order_ID = order_ID;
        this.discountID = discountID;
    }

    public int getOrder_ID() {
        return order_ID;
    }

    public void setOrder_ID(int order_ID) {
        this.order_ID = order_ID;
    }

    public int getDiscountID() {
        return discountID;
    }

    public void setDiscountID(int discountID) {
        this.discountID = discountID;
    }

    @Override
    public String toString() {
        return "OrderDiscount{" + "order_ID=" + order_ID + ", discountID=" + discountID + '}';
    }
}
