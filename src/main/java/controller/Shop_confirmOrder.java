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
import java.util.Date;
import model.DAO.Shop_DB;
import model.Discount;
import model.Order;
import model.OrderItem;
import model.Product;
import model.Shop;
import model.User;
import notifications.NotificationWebSocket;

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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        NotificationWebSocket nw = new NotificationWebSocket();
        Shop_DB sdb = new Shop_DB();
        User user = (User) request.getSession().getAttribute("USER");
        String action = request.getParameter("action");
        int shopid = Integer.parseInt(request.getParameter("shopid"));
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String campus = request.getParameter("campus");
        String note = request.getParameter("note");
        double total = Double.parseDouble(request.getParameter("total"));
        String discountSelect = request.getParameter("discountSelect");

        int discountId = 0;
        if (discountSelect != null && !discountSelect.isEmpty()) {
            discountId = Integer.parseInt(discountSelect);
        }

        switch (action) {
            case "confirm1":
                boolean check = false;
                Order order1 = sdb.getOrderHasStatusIsNullByUserID(user.getUserId());
                ArrayList<OrderItem> orderitemlist2 = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order1.getOrder_ID());

                // Retrieve the selected order item IDs from the request
                String[] selectedItems = request.getParameterValues("selectedItems");

                // Create a list of selected OrderItems
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
                    // If no selected products are out of stock, proceed to confirm the order
                    request.setAttribute("fullname", fullname);
                    request.setAttribute("phone", phone);
                    request.setAttribute("campus", campus);
                    request.setAttribute("note", note);
                    request.setAttribute("discountId", discountId);
                    request.setAttribute("total", total);
                    request.setAttribute("date", getCurrentDate());
                    request.setAttribute("shopid", shopid);
                    request.setAttribute("selectedOrderItems", selectedOrderItems);

                    request.getRequestDispatcher("/marketplace/confirm.jsp").forward(request, response);
                } else {
                    // If any selected products are out of stock, redirect to the cart page with an error message
                    String msg = "Your Cart Contains Sold Out Product! ";
                    session.setAttribute("message", msg);
                    response.sendRedirect("cart");
                    return;
                }
                break;

            case "confirm2":
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

                    if (discountId != 0) {
                        Discount discount = sdb.getDiscountByID(discountId);
                        sdb.updateUsageLimit(discountId, discount.getUsageLimit() - 1);
                        sdb.updateUsageCount(discountId, discount.getUsageCount() + 1);
                    }

                    currentOrder.setReceiverPhone(phone);
                    currentOrder.setDiscountid(discountId);
                    currentOrder.setNote(note);
                    currentOrder.setTotal(total);
                    currentOrder.setStatus("Pending");
                    sdb.updateOrderbyID(currentOrder);

                    // Create a new order for the user
                    Order newOrder = new Order(user.getUserId(), 1, null, "null", 0, 1, null, null, 5, null);
                    sdb.addOrder(newOrder);

                    // Retrieve the new order and set it in the session
                    Order newOrderForUser = sdb.getOrderHasStatusIsNullByUserID(user.getUserId());

                    // Set orderid for currentOrderItems not in selectedOrderItemsConfirm2
                    for (OrderItem orderItem : currentOrderItems) {
                        if (!selectedOrderItemsConfirm2.contains(orderItem)) {
                            orderItem.setOrder_id(newOrderForUser.getOrder_ID());
                            sdb.updateOrderItemID(orderItem); // Update orderid in database
                        }
                    }
                    ArrayList<OrderItem> newOrderItems = sdb.getAllOrderItemByOrderIdHasStatusIsNull(newOrderForUser.getOrder_ID());
                    request.getSession().setAttribute("ORDER", newOrderForUser);
                    request.getSession().setAttribute("ORDERITEMLIST", newOrderItems);

                    Shop shop = sdb.getShopHaveStatusIs1ByUserID(shopid);
//                    sdb.addNewNotification(shop.getOwnerID(), "Shop của bạn có đơn hàng mới!", "/marketplace/myshop");
                    nw.saveNotificationToDatabase(shop.getOwnerID(), "Shop của bạn có đơn hàng mới!", "/marketplace/myshop");
                    nw.sendNotificationToClient(shop.getOwnerID(), "Shop của bạn có đơn hàng mới!", "/marketplace/myshop");

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
