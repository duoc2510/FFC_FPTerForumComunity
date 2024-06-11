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
import model.DAO.Shop_DB;
import model.Order;
import model.OrderItem;
import model.Product;
import model.Shop;
import model.User;

/**
 *
 * @author Admin
 */
public class Shop_cart extends HttpServlet {

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
            out.println("<title>Servlet Shop_cart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Shop_cart at " + request.getContextPath() + "</h1>");
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
        int quantity = 1;
        Shop_DB sdb = new Shop_DB();
        User user = (User) request.getSession().getAttribute("USER");
        Shop shop = sdb.getShopHaveStatusIs1ByUserID(user.getUserId());
        int id;

        if (request.getParameter("productid") != null) {
            String id1 = request.getParameter("productid");
            id = Integer.parseInt(id1);
            String id2 = request.getParameter("shopid");
            int shopid = Integer.parseInt(id2);
            Product product = sdb.getProductByID(id);

            if (product != null) {
                // Check if the product belongs to the user's shop
                if (shop != null && product.getShopId() == shop.getShopID()) {
                    request.setAttribute("shopid", shopid);
                    request.setAttribute("productid", id);
                    request.setAttribute("message", "You cannot add your own product to the cart.");
                    request.getRequestDispatcher("/marketplace/productDetail.jsp").forward(request, response);
                    return;
                }

                if (request.getParameter("quantity") != null) {
                    quantity = Integer.parseInt(request.getParameter("quantity"));
                }
                HttpSession session = request.getSession();

                Order order = (Order) session.getAttribute("ORDER");
                ArrayList<OrderItem> orderitemlist = (ArrayList<OrderItem>) session.getAttribute("ORDERITEMLIST");

                if (orderitemlist != null && !orderitemlist.isEmpty()) {
                    boolean checkshop = false;
                    for (OrderItem item : orderitemlist) {
                        Product p = sdb.getProductByID(item.getProductID());
                        if (p.getShopId() == product.getShopId()) {
                            checkshop = true;
                        }
                    }
                    if (checkshop) {
                        boolean check = false;
                        for (OrderItem item : orderitemlist) {
                            if (item.getProductID() == product.getProductId()) {
                                item.setQuantity(item.getQuantity() + quantity);
                                sdb.updateOrderItem(item);
                                check = true;
                            }
                        }
                        if (!check) {
                            OrderItem item = new OrderItem(1, order.getOrder_ID(), product.getProductId(), quantity, product.getPrice());
                            sdb.addNewOrderItem(item);
                        }
                        ArrayList<OrderItem> orderitemlistnew = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order.getOrder_ID());
                        session.setAttribute("ORDERITEMLIST", orderitemlistnew);
                        session.setAttribute("ORDER", order);
                        response.sendRedirect(request.getContextPath() + "/marketplace/cart");
                        return;

                    } else {
                        request.setAttribute("shopid", shopid);
                        request.setAttribute("productid", id);
                        request.setAttribute("message", "The product is not from the same shop as the items already in the cart.");
                        request.getRequestDispatcher("/marketplace/productDetail.jsp").forward(request, response);
                        return;
                    }
                } else {
                    OrderItem item = new OrderItem(1, order.getOrder_ID(), product.getProductId(), quantity, product.getPrice());
                    sdb.addNewOrderItem(item);
                    ArrayList<OrderItem> orderitemlistnew = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order.getOrder_ID());
                    session.setAttribute("ORDERITEMLIST", orderitemlistnew);
                    session.setAttribute("ORDER", order);
                    response.sendRedirect(request.getContextPath() + "/marketplace/cart");
                    return;
                }
            }
        }
        request.getRequestDispatcher("/marketplace/cart.jsp").forward(request, response);
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
        // Lấy action từ request để phân biệt các hành động
        String action = request.getParameter("action");
        System.out.println("Received action: " + action); // Debugging log

        if (action != null && !action.isEmpty()) {
            if (action.equals("delete")) {
                String id1 = request.getParameter("id");
                int orderitemid = Integer.parseInt(id1);
                System.out.println("Deleting OrderItem ID: " + orderitemid); // Debugging log
                Shop_DB sdb = new Shop_DB();
                HttpSession session = request.getSession();
                sdb.deleteOrderItemByID(orderitemid);
                Order order = (Order) session.getAttribute("ORDER");
                ArrayList<OrderItem> orderitemlistnew = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order.getOrder_ID());
                session.setAttribute("ORDERITEMLIST", orderitemlistnew);
                session.setAttribute("ORDER", order);

                // Trả về phản hồi JSON
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"success\": true}");
                out.flush();
            } else if (action.equals("update")) {
                String id = request.getParameter("orderItemId");
                int orderItemId = Integer.parseInt(id);
                int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));
                System.out.println("Updating OrderItem ID: " + orderItemId + " to quantity: " + newQuantity); // Debugging log

                Shop_DB sdb = new Shop_DB();
                HttpSession session = request.getSession();
                sdb.updateOrderItemQuantity(orderItemId, newQuantity);
                Order order = (Order) session.getAttribute("ORDER");
                ArrayList<OrderItem> orderitemlistnew = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order.getOrder_ID());
                session.setAttribute("ORDERITEMLIST", orderitemlistnew);
                session.setAttribute("ORDER", order);

                // Trả về phản hồi JSON
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"success\": true}");
                out.flush();
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No action provided");
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
