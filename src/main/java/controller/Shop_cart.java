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
        int id;
        if (request.getParameter("productid") != null) {
            String id1 = request.getParameter("productid");
            id = Integer.parseInt(id1);
            String id2 = request.getParameter("shopid");
            int shopid = Integer.parseInt(id2);
            Product product = sdb.getProductByID(id);
            if (product != null) {
                if (request.getParameter("quantity") != null) {
                    quantity = Integer.parseInt(request.getParameter("quantity"));
                }
                HttpSession session = request.getSession();

                Order order = (Order) session.getAttribute("ORDER");
                ArrayList<OrderItem> orderitemlist = (ArrayList<OrderItem>) session.getAttribute("ORDERITEMLIST");

                if (!orderitemlist.isEmpty()) {

                    boolean checkshop = false;
                    for (OrderItem item : orderitemlist) {
                        if (sdb.getProductByID(item.getProductID()).getShopId() == product.getShopId()) {
                            checkshop = true;
                        }
                    }
                    if (checkshop == true) {
                        boolean check = false;
                        for (OrderItem item : orderitemlist) {
                            if (item.getProductID() == product.getProductId()) {
                                item.setQuantity(item.getQuantity() + quantity);
                                sdb.updateOrderItem(item);
                                check = true;
                            }
                        }
                        if (check == false) {
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
                        request.setAttribute("message", "sản phẩm này không cùng 1 shop với sản phẩm đang có trong giỏ hàng.");
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
        // Sử dụng response.sendRedirect để điều hướng tới trang giỏ hàng
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
        //delete product move cart
        String id1 = request.getParameter("id");
        int orderitemid = Integer.parseInt(id1);
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
