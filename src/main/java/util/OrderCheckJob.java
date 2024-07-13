package util;

import java.util.ArrayList;
import java.util.Date;
import model.DAO.Shop_DB;
import model.DAO.User_DB;
import model.Discount;
import model.Order;
import model.OrderDiscount;
import model.OrderItem;
import model.Product;
import model.Shop;
import model.User;
import notifications.NotificationWebSocket;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class OrderCheckJob implements Job {

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        Shop_DB sdb = new Shop_DB();
        NotificationWebSocket nw = new NotificationWebSocket();
        Date currentDate = new Date();
        ArrayList<Order> orders = sdb.getAllOrderWithStatusIsCompleted();

        // Tính toán ngày 3 ngày trước
        long threeDaysInMillis = 3 * 24 * 60 * 60 * 1000; // 3 ngày tính bằng milliseconds
        Date threeDaysAgo = new Date(currentDate.getTime() - threeDaysInMillis);

        for (Order order : orders) {
            Date orderDate = order.getOrderDate();
            String paymentStatus = order.getPayment_status();

            // Kiểm tra orderDate có từ 3 ngày trước và có payment_status là "thanhtoankhinhanhang"
            if (orderDate.before(threeDaysAgo) && "dathanhtoan".equals(paymentStatus)) {
                ArrayList<OrderItem> orderitemlistnewnew = sdb.getAllOrderItemByOrderID(order.getOrder_ID());
                double total1 = 0;
                for (OrderItem o : orderitemlistnewnew) {
                    total1 = total1 + (o.getPrice() * o.getQuantity());
                }
                for (OrderItem ot : orderitemlistnewnew) {
                    Product p1 = sdb.getProductByID(ot.getProductID());
                    Shop shop1 = sdb.getShopHaveStatusIs1ByShopID(p1.getShopId());
                    User owner = User_DB.getUserById(shop1.getOwnerID());
                    ArrayList<OrderDiscount> orderdislist = sdb.getAllOrderDiscountByOrderID(order.getOrder_ID());
                    for (OrderDiscount ord : orderdislist) {
                        Discount dis = sdb.getDiscountByID(ord.getDiscountID());
                        if (dis.getShopId() == 0) {
                            boolean check = User_DB.updateWalletByEmail(owner.getUserEmail(), owner.getUserWallet() + (total1 - order.getTotal()) - (total1 * 5 / 100));
                            nw.saveNotificationToDatabaseWithStatusIsBalance(owner.getUserId(), "Return system voucher money :" + (total1 - order.getTotal()) + " and deduct order commissions :" + (total1 * 5 / 100), "/walletbalance");

                        } else {
                            boolean check = User_DB.updateWalletByEmail(owner.getUserEmail(), owner.getUserWallet() - (total1 * 5 / 100));
                            nw.saveNotificationToDatabaseWithStatusIsBalance(owner.getUserId(), "Minus order commissions :" + (total1 * 5 / 100), "/walletbalance");

                        }
                    }

                    boolean updateSuccess = User_DB.updateWalletByEmail(owner.getUserEmail(), owner.getUserWallet() + order.getTotal());
                    ///Trả về thông báo tại đây
                    nw.saveNotificationToDatabaseWithStatusIsBalance(owner.getUserId(), "Order payment has been successful :" + order.getTotal(), "/walletbalance");
                    nw.saveNotificationToDatabase(shop1.getOwnerID(), "The person who placed the order did not rate it, so the order will be completed automatically after 3 days!", "/marketplace/allshop/shopdetail?shopid=" + shop1.getShopID());
                    nw.sendNotificationToClient(shop1.getOwnerID(), "The person who placed the order did not rate it, so the order will be completed automatically after 3 days!", "/marketplace/allshop/shopdetail?shopid=" + shop1.getShopID());
                    sdb.updateOrderStatus(order.getOrder_ID(), "Success");
                    break;
                }
            }
        }
    }
}
