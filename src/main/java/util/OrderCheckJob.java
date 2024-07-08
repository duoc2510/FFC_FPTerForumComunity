package util;

import java.util.ArrayList;
import java.util.Date;
import model.DAO.Shop_DB;
import model.DAO.User_DB;
import model.Order;
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
                for (OrderItem ot : orderitemlistnewnew) {
                    Product p1 = sdb.getProductByID(ot.getProductID());
                    Shop shop1 = sdb.getShopHaveStatusIs1ByShopID(p1.getShopId());
                    User owner = User_DB.getUserById(shop1.getOwnerID());

                    boolean updateSuccess = User_DB.updateWalletByEmail(owner.getUserEmail(), owner.getUserWallet() + order.getTotal());
                    ///Trả về thông báo tại đây
                    nw.saveNotificationToDatabaseWithStatusIsBalance(owner.getUserId(), "Thanh toán tiền đơn hàng đã thành công :" + order.getTotal(), "/walletbalance");
                    nw.saveNotificationToDatabase(shop1.getOwnerID(), "Người đặt đã không đánh giá nên đơn hàng sẽ tự hoàn thành sau 3 ngày!", "/marketplace/allshop/shopdetail?shopid=" + shop1.getShopID());
                    nw.sendNotificationToClient(shop1.getOwnerID(), "Người đặt đã không đánh giá nên đơn hàng sẽ tự hoàn thành sau 3 ngày!", "/marketplace/allshop/shopdetail?shopid=" + shop1.getShopID());
                    sdb.updateOrderStatus(order.getOrder_ID(), "Success");
                    break;
                }
            }
        }
    }
}
