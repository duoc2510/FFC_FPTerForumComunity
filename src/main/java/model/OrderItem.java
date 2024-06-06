package model;

/**
 *
 * @author Admin
 */
public class OrderItem {

    private int OrderItem_id;
    private int Order_id;
    private int productID;
    private int quantity;
    private double price;

    public OrderItem() {
    }

    public OrderItem(int OrderItem_id, int Order_id, int productID, int quantity, double price) {
        this.OrderItem_id = OrderItem_id;
        this.Order_id = Order_id;
        this.productID = productID;
        this.quantity = quantity;
        this.price = price;
    }

    public int getOrderItem_id() {
        return OrderItem_id;
    }

    public void setOrderItem_id(int OrderItem_id) {
        this.OrderItem_id = OrderItem_id;
    }

    public int getOrder_id() {
        return Order_id;
    }

    public void setOrder_id(int Order_id) {
        this.Order_id = Order_id;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "OrderItem{" + "OrderItem_id=" + OrderItem_id + ", Order_id=" + Order_id + ", productID=" + productID + ", quantity=" + quantity + ", price=" + price + '}';
    }

}
