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
import java.util.Collections;
import java.util.Comparator;
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
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int quantity = 1;
//        Shop_DB sdb = new Shop_DB();
//        User user = (User) request.getSession().getAttribute("USER");
//        Shop shop = sdb.getShopHaveStatusIs1ByUserID(user.getUserId());
//        int id;
//
//        if (request.getParameter("productid") != null) {
//            String id1 = request.getParameter("productid");
//            id = Integer.parseInt(id1);
//            String id2 = request.getParameter("shopid");
//            int shopid = Integer.parseInt(id2);
//            Product product = sdb.getProductByID(id);
//
//            if (product != null) {
//                // Check if the product belongs to the user's shop
//                if (shop != null && product.getShopId() == shop.getShopID()) {
//                    request.setAttribute("shopid", shopid);
//                    request.setAttribute("productid", id);
//                    request.setAttribute("message", "You cannot add your own product to the cart.");
//                    request.getRequestDispatcher("/marketplace/productDetail.jsp").forward(request, response);
//                    return;
//                }
//
//                if (request.getParameter("quantity") != null) {
//                    quantity = Integer.parseInt(request.getParameter("quantity"));
//                }
//                HttpSession session = request.getSession();
//
//                Order order = (Order) session.getAttribute("ORDER");
//                ArrayList<OrderItem> orderitemlist = (ArrayList<OrderItem>) session.getAttribute("ORDERITEMLIST");
//
//                if (orderitemlist != null && !orderitemlist.isEmpty()) {
//                    boolean check = false;
//                    for (OrderItem item : orderitemlist) {
//                        if (item.getProductID() == product.getProductId()) {
//                            // Check if the quantity does not exceed the available quantity of the product
//                            if (item.getQuantity() + quantity <= product.getQuantity()) {
//                                item.setQuantity(item.getQuantity() + quantity);
//                                sdb.updateOrderItem(item);
//                                check = true;
//                            } else {
//                                // If quantity exceeds available quantity, set an error message
//                                request.setAttribute("shopid", shopid);
//                                request.setAttribute("productid", id);
//                                request.setAttribute("message", "The quantity of this product is now maximum.");
//                                request.getRequestDispatcher("/marketplace/productDetail.jsp").forward(request, response);
//                                return;
//                            }
//                        }
//                    }
//                    if (!check) {
//                        OrderItem item = new OrderItem(1, order.getOrder_ID(), product.getProductId(), quantity, product.getPrice());
//                        sdb.addNewOrderItem(item);
//                    }
//                    ArrayList<OrderItem> orderitemlistnew = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order.getOrder_ID());
//                    Collections.sort(orderitemlistnew, new Comparator<OrderItem>() {
//                        @Override
//                        public int compare(OrderItem o1, OrderItem o2) {
//                            return Integer.compare(sdb.getProductByID(o1.getProductID()).getShopId(), sdb.getProductByID(o2.getProductID()).getShopId());
//                        }
//                    });
//                    session.setAttribute("ORDERITEMLIST", orderitemlistnew);
//                    session.setAttribute("ORDER", order);
//                    response.sendRedirect(request.getContextPath() + "/marketplace/cart");
//                    return;
//                } else {
//                    OrderItem item = new OrderItem(1, order.getOrder_ID(), product.getProductId(), quantity, product.getPrice());
//                    sdb.addNewOrderItem(item);
//                    ArrayList<OrderItem> orderitemlistnew = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order.getOrder_ID());
//                    Collections.sort(orderitemlistnew, new Comparator<OrderItem>() {
//                        @Override
//                        public int compare(OrderItem o1, OrderItem o2) {
//                            return Integer.compare(sdb.getProductByID(o1.getProductID()).getShopId(), sdb.getProductByID(o2.getProductID()).getShopId());
//                        }
//                    });
//                    session.setAttribute("ORDERITEMLIST", orderitemlistnew);
//                    session.setAttribute("ORDER", order);
//                    response.sendRedirect(request.getContextPath() + "/marketplace/cart");
//                    return;
//                }
//            }
//        }
//        request.getRequestDispatcher("/marketplace/cart.jsp").forward(request, response);
//    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
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
            Shop snew = sdb.getShopHaveStatusIs1ByShopID(shopid);
            Product product = sdb.getProductByID(id);

            if (product != null) {
                // Check if the product belongs to the user's shop
                if (shop != null && product.getShopId() == shop.getShopID()) {
//                    request.setAttribute("shopid", shopid);
//                    request.setAttribute("productid", id);
//                    request.setAttribute("message", "You cannot add your own product to the cart.");
//                    request.getRequestDispatcher("/marketplace/productDetail.jsp").forward(request, response);
                    String msg = "You cannot add your own product to the cart! ";
                    session.setAttribute("message", msg);
                    response.sendRedirect("allshop/shopdetail/productdetail?productid=" + id + "&shopid=" + shopid);
                    return;
                }

                if (request.getParameter("quantity") != null) {
                    quantity = Integer.parseInt(request.getParameter("quantity"));
                }
//                HttpSession session = request.getSession();

                Order order = (Order) session.getAttribute("ORDER");
                ArrayList<OrderItem> orderitemlist = (ArrayList<OrderItem>) session.getAttribute("ORDERITEMLIST");

                if (orderitemlist != null && !orderitemlist.isEmpty()) {
                    boolean checkshop = false;
                    for (OrderItem item : orderitemlist) {
                        Product p = sdb.getProductByID(item.getProductID());
                        Shop s = sdb.getShopHaveStatusIs1ByShopID(p.getShopId());
                        if (s.getCampus().equals(snew.getCampus())) {
                            checkshop = true;
                        }
                    }
                    if (checkshop) {
                        boolean check = false;
                        for (OrderItem item : orderitemlist) {
                            if (item.getProductID() == product.getProductId()) {
                                // Check if the quantity does not exceed the available quantity of the product
                                if (item.getQuantity() + quantity <= product.getQuantity()) {
                                    item.setQuantity(item.getQuantity() + quantity);
                                    sdb.updateOrderItem(item);
                                    check = true;
                                } else {
                                    // If quantity exceeds available quantity, set an error message
//                                    request.setAttribute("shopid", shopid);
//                                    request.setAttribute("productid", id);
//                                    request.setAttribute("message", "The quantity of this product is now maximum.");
//                                    request.getRequestDispatcher("/marketplace/productDetail.jsp").forward(request, response);

                                    String msg = "The quantity of this product is now maximum! ";
                                    session.setAttribute("message", msg);
                                    response.sendRedirect("allshop/shopdetail/productdetail?productid=" + id + "&shopid=" + shopid);
                                    return;
                                }
                            }

                        }
                        if (!check) {
                            OrderItem item = new OrderItem(1, order.getOrder_ID(), product.getProductId(), quantity, product.getPrice());
                            sdb.addNewOrderItem(item);
                        }
                        ArrayList<OrderItem> orderitemlistnew = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order.getOrder_ID());
                        Collections.sort(orderitemlistnew, new Comparator<OrderItem>() {
                            @Override
                            public int compare(OrderItem o1, OrderItem o2) {
                                return Integer.compare(sdb.getProductByID(o1.getProductID()).getShopId(), sdb.getProductByID(o2.getProductID()).getShopId());
                            }
                        });
                        session.setAttribute("ORDERITEMLIST", orderitemlistnew);
                        session.setAttribute("ORDER", order);
                        response.sendRedirect(request.getContextPath() + "/marketplace/cart");
                        return;

                    } else {
//                        request.setAttribute("shopid", shopid);
//                        request.setAttribute("productid", id);
//                        request.setAttribute("message", "The added product must belong to a shop on the same campus as the existing shop in the cart.");
//                        request.getRequestDispatcher("/marketplace/productDetail.jsp").forward(request, response);

                        String msg = "The added product must belong to a shop on the same campus as the existing shop in the cart! ";
                        session.setAttribute("message", msg);
                        response.sendRedirect("allshop/shopdetail/productdetail?productid=" + id + "&shopid=" + shopid);
                        return;
                    }
                } else {
                    OrderItem item = new OrderItem(1, order.getOrder_ID(), product.getProductId(), quantity, product.getPrice());
                    sdb.addNewOrderItem(item);
                    ArrayList<OrderItem> orderitemlistnew = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order.getOrder_ID());
                    Collections.sort(orderitemlistnew, new Comparator<OrderItem>() {
                        @Override
                        public int compare(OrderItem o1, OrderItem o2) {
                            return Integer.compare(sdb.getProductByID(o1.getProductID()).getShopId(), sdb.getProductByID(o2.getProductID()).getShopId());
                        }
                    });
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
                Collections.sort(orderitemlistnew, new Comparator<OrderItem>() {
                    @Override
                    public int compare(OrderItem o1, OrderItem o2) {
                        return Integer.compare(sdb.getProductByID(o1.getProductID()).getShopId(), sdb.getProductByID(o2.getProductID()).getShopId());
                    }
                });
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
                OrderItem odi = sdb.getOrderItemById(orderItemId);
                Product p = sdb.getProductByID(odi.getProductID());
                if (newQuantity > p.getQuantity()) {
                    newQuantity = p.getQuantity();
                }
                if (newQuantity == 0) {
                    newQuantity = 1;
                }
                sdb.updateOrderItemQuantity(orderItemId, newQuantity);
                Order order = (Order) session.getAttribute("ORDER");
                ArrayList<OrderItem> orderitemlistnew = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order.getOrder_ID());
                Collections.sort(orderitemlistnew, new Comparator<OrderItem>() {
                    @Override
                    public int compare(OrderItem o1, OrderItem o2) {
                        return Integer.compare(sdb.getProductByID(o1.getProductID()).getShopId(), sdb.getProductByID(o2.getProductID()).getShopId());
                    }
                });
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
