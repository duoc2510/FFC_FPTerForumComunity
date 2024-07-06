/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import model.DAO.Shop_DB;
import model.Discount;
import model.Order;
import model.OrderItem;
import model.Product;
import model.Shop;
import model.User;
import notifications.NotificationWebSocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.DAO.User_DB;

/**
 *
 * @author Admin
 */
public class Shop_confirmOrder extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Shop_confirmOrder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Shop_confirmOrder at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/marketplace/confirm.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        NotificationWebSocket nw = new NotificationWebSocket();
        Shop_DB sdb = new Shop_DB();
        User user = (User) request.getSession().getAttribute("USER");
        String action = request.getParameter("action");
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String note = request.getParameter("note");

        switch (action) {
            case "confirm1":

                // Get the selected discounts from the request
                String selectedDiscountsJson = request.getParameter("selectedDiscounts");
                ArrayList<Discount> discountList = new ArrayList<>();
                ArrayList<Order> orderList = new ArrayList<>();
                Map<Integer, Double> shopTotals = new HashMap<>(); // To store totals per shop

                if (selectedDiscountsJson != null && !selectedDiscountsJson.isEmpty()) {
                    // Use Jackson to parse the JSON string into a List of Maps
                    ObjectMapper mapper = new ObjectMapper();
                    try {
                        List<Map<String, Object>> selectedDiscounts = mapper.readValue(selectedDiscountsJson, List.class);

                        // Print out the selected discounts for demonstration purposes
                        for (Map<String, Object> discount : selectedDiscounts) {
                            int discountShopId = Integer.parseInt((String) discount.get("shopId"));
                            int discountId = Integer.parseInt((String) discount.get("discountId"));
                            double total = Double.parseDouble(discount.get("total").toString());
                            Discount dis = new Discount(discountShopId, discountId);
                            discountList.add(dis);
                            shopTotals.put(discountShopId, total);
                        }

                        // You can now use the selectedDiscounts list for further processing, such as applying discounts to the order, saving to the database, etc.
                    } catch (IOException e) {
                        e.printStackTrace();
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid discount data");
                        return;
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No discount data provided");
                    return;
                }

                boolean check = false;
                Order order1 = sdb.getOrderHasStatusIsNullByUserID(user.getUserId());
                ArrayList<OrderItem> orderitemlist2 = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order1.getOrder_ID());

                String[] selectedItems = request.getParameterValues("selectedItems");
                ArrayList<OrderItem> selectedOrderItems = new ArrayList<>();
                if (selectedItems != null) {
                    for (String itemId : selectedItems) {
                        for (OrderItem od : orderitemlist2) {
                            if (od.getOrderItem_id() == Integer.parseInt(itemId)) {
                                selectedOrderItems.add(od);
                                break;
                            }
                        }
                    }
                }

                for (OrderItem od : selectedOrderItems) {
                    Product p = sdb.getProductByID(od.getProductID());
                    if (p.getQuantity() == 0) {
                        check = true;
                        break;
                    }
                }

                if (!check) {
                    Collections.sort(selectedOrderItems, new Comparator<OrderItem>() {
                        @Override
                        public int compare(OrderItem o1, OrderItem o2) {
                            return Integer.compare(sdb.getProductByID(o1.getProductID()).getShopId(), sdb.getProductByID(o2.getProductID()).getShopId());
                        }
                    });

                    int currentShopId = -1;
                    Order newOrder = null;
                    for (OrderItem item : selectedOrderItems) {
                        int itemShopId = sdb.getProductByID(item.getProductID()).getShopId();

                        if (itemShopId != currentShopId) {
                            int discountId = 0;
                            double total = 0;
                            for (Discount discount : discountList) {
                                if (discount.getShopId() == itemShopId) {
                                    discountId = discount.getDiscountId();
                                    total = shopTotals.get(itemShopId);
                                    break;
                                }
                            }

                            newOrder = new Order(user.getUserId(), itemShopId, null, "NotConfirm", total, discountId, null, null, 5, null, null);
                            sdb.addOrder(newOrder);
                            currentShopId = itemShopId;
                        }

                        Order createdOrder = sdb.getLatestOrderByUserId(user.getUserId());
                        if (!orderList.contains(createdOrder)) {
                            orderList.add(createdOrder);
                        }
                        createdOrder.setReceiverPhone(phone);
                        createdOrder.setNote(note);
                        sdb.updateOrderbyID(createdOrder);

                        OrderItem newOrderItem = new OrderItem(1, createdOrder.getOrder_ID(), item.getProductID(), item.getQuantity(), item.getPrice());
                        sdb.addNewOrderItem(newOrderItem);
                    }

                    // Loại bỏ các phần tử trùng lặp
                    for (int i = 0; i < orderList.size(); i++) {
                        for (int j = i + 1; j < orderList.size(); j++) {
                            if (orderList.get(i).getOrder_ID() == orderList.get(j).getOrder_ID()) {
                                orderList.remove(j);
                                j--; // Giảm chỉ số j sau khi xóa phần tử để tránh bỏ qua phần tử tiếp theo
                            }
                        }
                    }

                    request.setAttribute("fullname", fullname);
                    request.setAttribute("phone", phone);
                    request.setAttribute("note", note);
                    request.setAttribute("date", getCurrentDate());
                    request.setAttribute("orderList", orderList);
                    request.setAttribute("selectedOrderItems", selectedOrderItems);

                    request.getRequestDispatcher("/marketplace/confirm.jsp").forward(request, response);
                } else {
                    String msg = "Your Cart Contains Sold Out Product!";
                    session.setAttribute("message", msg);
                    response.sendRedirect("cart");
                    return;
                }
                break;
            case "confirm2":
                String totalStr = request.getParameter("total");
                String paymentMethod = request.getParameter("paymentMethod");

                // Parse total amount to double
                double total = Double.parseDouble(totalStr);

                // Retrieve selected order items
                String[] orderlistidnew = request.getParameterValues("orderlist");

                boolean isOutOfStock = false;
                Order currentOrder = sdb.getOrderHasStatusIsNullByUserID(user.getUserId());
                ArrayList<OrderItem> currentOrderItems = sdb.getAllOrderItemByOrderIdHasStatusIsNull(currentOrder.getOrder_ID());

                // Retrieve the selected order item IDs from the request
                String[] selectedItemsConfirm2 = request.getParameterValues("selectedItems");

                // Create a list of selected OrderItems
                ArrayList<OrderItem> selectedOrderItemsConfirm2 = new ArrayList<>();
                if (selectedItemsConfirm2 != null) {
                    for (String itemId : selectedItemsConfirm2) {
                        for (OrderItem orderItem : currentOrderItems) {
                            if (orderItem.getOrderItem_id() == Integer.parseInt(itemId)) {
                                selectedOrderItemsConfirm2.add(orderItem);
                                break;
                            }
                        }
                    }
                }

                // Check if any selected products are out of stock
                for (OrderItem orderItem : selectedOrderItemsConfirm2) {
                    Product product = sdb.getProductByID(orderItem.getProductID());
                    if (product.getQuantity() == 0) {
                        isOutOfStock = true;
                        break;
                    }
                }

                if (!isOutOfStock) {

                    // If no products are out of stock, proceed to update the order
                    for (OrderItem orderItem : selectedOrderItemsConfirm2) {
                        Product product = sdb.getProductByID(orderItem.getProductID());
                        product.setQuantity(product.getQuantity() - orderItem.getQuantity()); // Reduce the quantity by the amount ordered
                        sdb.updateProduct(product);
                    }

                    if ("systemWallet".equals(paymentMethod)) {
                        ///trừ tiền người mua
                        boolean updateSuccess = User_DB.updateWalletByEmail(user.getUserEmail(), user.getUserWallet() - total);

                        //trả về thông báo trừ tiền tại đây:
                        nw.saveNotificationToDatabaseWithStatusIsBalance(user.getUserId(), "Trừ tiền đơn hàng :" + total, "/walletbalance");
                        for (String orderid : orderlistidnew) {
                            int id = Integer.parseInt(orderid);
                            Order order = sdb.getOrderbyID(id);
                            //kiểm tra có discount thì cập nhật lại số lượng
                            if (order.getDiscountid() != 0) {
                                Discount discount = sdb.getDiscountByID(order.getDiscountid());
                                sdb.updateUsageLimit(order.getDiscountid(), discount.getUsageLimit() - 1);
                                sdb.updateUsageCount(order.getDiscountid(), discount.getUsageCount() + 1);
                            }
                            order.setPayment_status("dathanhtoan");
                            order.setStatus("Pending");
                            sdb.updateOrderbyID(order);

                            ArrayList<OrderItem> oditl = sdb.getAllOrderItemByOrderID(id);
                            OrderItem oderitem = oditl.get(0);
                            Product p = sdb.getProductByID(oderitem.getProductID());
                            Shop shop = sdb.getShopHaveStatusIs1ByShopID(p.getShopId());

                            nw.saveNotificationToDatabase(shop.getOwnerID(), "Shop của bạn có đơn hàng mới!", "/marketplace/myshop");
                            nw.sendNotificationToClient(shop.getOwnerID(), "Shop của bạn có đơn hàng mới!", "/marketplace/myshop");

                        }

                    } else {
                        for (String orderid : orderlistidnew) {
                            int id = Integer.parseInt(orderid);
                            Order order = sdb.getOrderbyID(id);
                            //kiểm tra có discount thì cập nhật lại số lượng
                            if (order.getDiscountid() != 0) {
                                Discount discount = sdb.getDiscountByID(order.getDiscountid());
                                sdb.updateUsageLimit(order.getDiscountid(), discount.getUsageLimit() - 1);
                                sdb.updateUsageCount(order.getDiscountid(), discount.getUsageCount() + 1);
                            }
                            order.setPayment_status("thanhtoankhinhanhang");
                            order.setStatus("Pending");
                            sdb.updateOrderbyID(order);

                            ArrayList<OrderItem> oditl = sdb.getAllOrderItemByOrderID(id);
                            OrderItem oderitem = oditl.get(0);
                            Product p = sdb.getProductByID(oderitem.getProductID());
                            Shop shop = sdb.getShopHaveStatusIs1ByShopID(p.getShopId());

                            nw.saveNotificationToDatabase(shop.getOwnerID(), "Shop của bạn có đơn hàng mới!", "/marketplace/myshop");
                            nw.sendNotificationToClient(shop.getOwnerID(), "Shop của bạn có đơn hàng mới!", "/marketplace/myshop");

                        }
                    }

                    // Retrieve the new order and set it in the session
                    Order newOrderForUser = sdb.getOrderHasStatusIsNullByUserID(user.getUserId());

                    // Set orderid for currentOrderItems not in selectedOrderItemsConfirm2
                    for (OrderItem orderItem : currentOrderItems) {
                        if (selectedOrderItemsConfirm2.contains(orderItem)) {
                            sdb.deleteOrderItemByID(orderItem.getOrderItem_id());
                        }
                    }
                    ArrayList<OrderItem> newOrderItems = sdb.getAllOrderItemByOrderIdHasStatusIsNull(newOrderForUser.getOrder_ID());
                    request.getSession().setAttribute("ORDER", newOrderForUser);
                    request.getSession().setAttribute("ORDERITEMLIST", newOrderItems);

                    // Redirect to the allshop page with a success message
                    String msg = "Thanks for your order! ";
                    session.setAttribute("message", msg);
                    response.sendRedirect("allshop");

                } else {
                    // If any products are out of stock, redirect to the cart page with an error message
                    String msg = "Your Cart Contains Sold Out Product! ";
                    session.setAttribute("message", msg);
                    response.sendRedirect("cart");
                }
                break;
        }
    }

    public static String getCurrentDate() {
        // Create a SimpleDateFormat instance with the desired format
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

        // Get the current date
        Date now = new Date();

        // Format the current date
        return sdf.format(now);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
