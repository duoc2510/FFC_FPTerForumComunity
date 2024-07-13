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

/**
 *
 * @author Admin
 */
public class Shop_confirmContinue extends HttpServlet {

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
            out.println("<title>Servlet Shop_confirmContinue</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Shop_confirmContinue at " + request.getContextPath() + "</h1>");
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
        Shop_DB sdb = new Shop_DB();
        User user = (User) request.getSession().getAttribute("USER");
        String shopid = request.getParameter("shopid");
        int id = Integer.parseInt(shopid);
        Order o = sdb.getOrderByShopIdWithStatusNotConfirm(id, user.getUserId());
        request.setAttribute("shopid", shopid);
        request.setAttribute("ordernotconfirm", o);
        request.getRequestDispatcher("/marketplace/confirmcontinue.jsp").forward(request, response);
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
        Shop_DB sdb = new Shop_DB();
        NotificationWebSocket nw = new NotificationWebSocket();
        User user = (User) request.getSession().getAttribute("USER");
        String paymentMethod = request.getParameter("paymentMethod");
        String campus = request.getParameter("campus");
        String shopid = request.getParameter("shopid");
        int shopidnew = Integer.parseInt(shopid);
        String ordernotconfirm = request.getParameter("ordernotconfirm");
        int ordernotconfirmid = Integer.parseInt(ordernotconfirm);
        Order o = sdb.getOrderbyID(ordernotconfirmid);
        ArrayList<OrderItem> selectedOrderItems = sdb.getAllOrderItemByOrderID(ordernotconfirmid);

        Order currentOrder = sdb.getOrderHasStatusIsNullByUserID(user.getUserId());
        ArrayList<OrderItem> currentOrderItems = sdb.getAllOrderItemByOrderIdHasStatusIsNull(currentOrder.getOrder_ID());

        // Nested loops to check product IDs and delete matching items
        for (OrderItem currentOrderItem : currentOrderItems) {
            for (OrderItem selectedOrderItem : selectedOrderItems) {
                if (currentOrderItem.getProductID() == selectedOrderItem.getProductID()) {
                    sdb.deleteOrderItemByID(currentOrderItem.getOrderItem_id());
                    System.out.println("Deleted OrderItem with ID: " + currentOrderItem.getOrderItem_id()); // Logging for debugging
                    break; // Exit inner loop once a match is found and deletion is performed
                }
            }
        }

        boolean isOutOfStock = false;
        boolean isDiscountExpired = false;
        boolean isDiscountLimitReached = false;
        String discountMessage = "";

        // Check if any selected products are out of stock
        for (OrderItem orderItem : selectedOrderItems) {
            Product product = sdb.getProductByID(orderItem.getProductID());
            if (product.getQuantity() == 0) {
                isOutOfStock = true;
                break;
            }
        }

        // Check if the discount is expired or has reached its usage limit
        ArrayList<OrderDiscount> orderdislist = sdb.getAllOrderDiscountByOrderID(o.getOrder_ID());
        for (OrderDiscount ord : orderdislist) {
            if (ord.getDiscountID() != 0) {
                Discount discount = sdb.getDiscountByID(ord.getDiscountID());
                if (discount.getValidTo().before(new Date())) {
                    isDiscountExpired = true;
                    discountMessage = "Your discount code has expired.";
                } else if (discount.getUsageLimit() <= 0) {
                    isDiscountLimitReached = true;
                    discountMessage = "The discount limit has been reached.";
                }
            }
        }

        if (!isOutOfStock && !isDiscountExpired && !isDiscountLimitReached) {
            // If no products are out of stock and the discount is not expired or limited, proceed to update the order
            for (OrderItem orderItem : selectedOrderItems) {
                Product product = sdb.getProductByID(orderItem.getProductID());
                product.setQuantity(product.getQuantity() - orderItem.getQuantity()); // Reduce the quantity by the amount ordered
                sdb.updateProduct(product);
            }

            if ("systemWallet".equals(paymentMethod)) {
                // Deduct money from the buyer
                boolean updateSuccess = User_DB.updateWalletByEmail(user.getUserEmail(), user.getUserWallet() - o.getTotal());

                // Return notification of money deduction here:
                nw.saveNotificationToDatabaseWithStatusIsBalance(user.getUserId(), "Deduct the order amount :" + o.getTotal(), "/walletbalance");
                // Check if there is a discount and update its usage
                for (OrderDiscount ord : orderdislist) {

                    if (ord.getDiscountID() != 0) {
                        Discount discount = sdb.getDiscountByID(ord.getDiscountID());
                        sdb.updateUsageLimit(ord.getDiscountID(), discount.getUsageLimit() - 1);
                        sdb.updateUsageCount(ord.getDiscountID(), discount.getUsageCount() + 1);
                    }
                }
                o.setPayment_status("dathanhtoan");
                o.setStatus("Pending");
                sdb.updateOrderByID(o);

                Shop shop = sdb.getShopHaveStatusIs1ByShopID(shopidnew);

                nw.saveNotificationToDatabase(shop.getOwnerID(), "Your shop has a new order!", "/marketplace/myshop");
                nw.sendNotificationToClient(shop.getOwnerID(), "Your shop has a new order!", "/marketplace/myshop");

            } else {
                // Check if there is a discount and update its usage
                for (OrderDiscount ord : orderdislist) {
                    if (ord.getDiscountID() != 0) {
                        Discount discount = sdb.getDiscountByID(ord.getDiscountID());
                        sdb.updateUsageLimit(ord.getDiscountID(), discount.getUsageLimit() - 1);
                        sdb.updateUsageCount(ord.getDiscountID(), discount.getUsageCount() + 1);
                    }
                }
                o.setPayment_status("thanhtoankhinhanhang");
                o.setStatus("Pending");
                sdb.updateOrderByID(o);

                Shop shop = sdb.getShopHaveStatusIs1ByShopID(shopidnew);

                nw.saveNotificationToDatabase(shop.getOwnerID(), "Your shop has a new order!", "/marketplace/myshop");
                nw.sendNotificationToClient(shop.getOwnerID(), "Your shop has a new order!", "/marketplace/myshop");
            }

            // Retrieve the new order and set it in the session
            ArrayList<OrderItem> newOrderItems = sdb.getAllOrderItemByOrderIdHasStatusIsNull(currentOrder.getOrder_ID());

            request.getSession().setAttribute("ORDER", currentOrder);
            request.getSession().setAttribute("ORDERITEMLIST", newOrderItems);

            // Redirect to the allshop page with a success message
            String msg = "Thanks for your order!";
            session.setAttribute("message", msg);
            response.sendRedirect("/FPTer/martketplace/allshop");

        } else if (isOutOfStock) {
            // If any products are out of stock, redirect to the cart page with an error message
            String msg = "Your Cart Contains Sold Out Product!";
            session.setAttribute("message", msg);
            response.sendRedirect("cart");
        } else {
            // If the discount is expired or the limit is reached, redirect to the cart page with an error message
            session.setAttribute("message", discountMessage);
            response.sendRedirect("cart");
        }
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
