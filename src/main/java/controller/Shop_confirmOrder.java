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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import model.DAO.Shop_DB;
import model.Discount;
import model.Order;
import model.OrderItem;
import model.Product;
import model.User;

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
        Shop_DB sdb = new Shop_DB();
        User user = (User) request.getSession().getAttribute("USER");
        String action = request.getParameter("action");
        int shopid = Integer.parseInt(request.getParameter("shopid"));
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String campus = request.getParameter("campus");
        String note = request.getParameter("note");
        double total = Double.parseDouble(request.getParameter("total"));
        String discountSelect = request.getParameter("discountSelect"); // Get discountSelect as String

        int discountId = 0; // Default value for discountId
        if (discountSelect != null && !discountSelect.isEmpty()) {
            discountId = Integer.parseInt(discountSelect);
        }

        switch (action) {
            case "confirm1":
                boolean check = false;
                Order order1 = sdb.getOrderHasStatusIsNullByUserID(user.getUserId());
                ArrayList<OrderItem> orderitemlist2 = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order1.getOrder_ID());
                for (OrderItem od : orderitemlist2) {
                    Product p = sdb.getProductByID(od.getProductID());
                    if (p.getQuantity() == 0) {
                        check = true;
                        break; // Stop the loop when a product is out of stock
                    }
                }
                if (!check) {
                    // If no products are out of stock, proceed to confirm the order
                    request.setAttribute("fullname", fullname);
                    request.setAttribute("phone", phone);
                    request.setAttribute("campus", campus);
                    request.setAttribute("note", note);
                    request.setAttribute("discountId", discountId);
                    request.setAttribute("total", total);
                    request.setAttribute("date", getCurrentDate());
                    request.setAttribute("shopid", shopid);

                    request.getRequestDispatcher("/marketplace/confirm.jsp").forward(request, response);
                } else {
                    // If any products are out of stock, redirect to the cart page with an error message
                    response.sendRedirect("cart?error=Your+Cart+Contains+Sold+Out+Product!");
                    return;
                }
                break;

            case "confirm2":
                boolean check2 = false;
                Order order = sdb.getOrderHasStatusIsNullByUserID(user.getUserId());
                ArrayList<OrderItem> orderitemlist1 = sdb.getAllOrderItemByOrderIdHasStatusIsNull(order.getOrder_ID());
                for (OrderItem ot : orderitemlist1) {
                    Product p = sdb.getProductByID(ot.getProductID());
                    if (p.getQuantity() == 0) {
                        check2 = true;
                        break; // Stop the loop when a product is out of stock
                    }
                }
                if (!check2) {
                    // If no products are out of stock, proceed to update the order
                    for (OrderItem ot : orderitemlist1) {
                        Product p = sdb.getProductByID(ot.getProductID());
                        p.setQuantity(p.getQuantity() - ot.getQuantity()); // Reduce the quantity by the amount ordered
                        sdb.updateProduct(p);
                    }
                    if (discountId != 0) {
                        Discount d = sdb.getDiscountByID(discountId);
                        sdb.updateUsageLimit(discountId, d.getUsageLimit() - 1);
                        sdb.updateUsageCount(discountId, d.getUsageCount() + 1);
                    }
                    order.setReceiverPhone(phone);
                    order.setDiscountid(discountId);
                    order.setNote(note);
                    order.setTotal(total);
                    order.setStatus("Pending");
                    sdb.updateOrderbyID(order);

                    // Create a new order for the user
                    Order newOrder = new Order(user.getUserId(), 1, null, "null", 0, 1, null, null, 5, null);
                    sdb.addOrder(newOrder);

                    // Retrieve the new order and set it in the session
                    Order ordernew = sdb.getOrderHasStatusIsNullByUserID(user.getUserId());
                    ArrayList<OrderItem> orderitemlist = sdb.getAllOrderItemByOrderIdHasStatusIsNull(ordernew.getOrder_ID());
                    request.getSession().setAttribute("ORDER", ordernew);
                    request.getSession().setAttribute("ORDERITEMLIST", orderitemlist);

                    // Redirect to the allshop page with a success message
                    response.sendRedirect("allshop?message=Thanks+for+your+order");
                } else {
                    // If any products are out of stock, redirect to the cart page with an error message
                    response.sendRedirect("cart?error=Your+Cart+Contains+Sold+Out+Product!");
                    return;
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
