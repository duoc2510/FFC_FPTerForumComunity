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
import java.util.ArrayList;
import model.DAO.Shop_DB;
import model.DAO.User_DB;
import model.Discount;
import model.Product;
import model.Shop;
import model.User;
import notifications.NotificationWebSocket;

/**
 *
 * @author Admin
 */
public class Shop_myShop extends HttpServlet {

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
            out.println("<title>Servlet Shop_myShop</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Shop_myShop at " + request.getContextPath() + "</h1>");
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
        try {
            User user = (User) request.getSession().getAttribute("USER");
            if (user == null) {
                System.out.println("User is null");
                response.sendRedirect("login.jsp"); // Redirect to login if user is not found
                return;
            }

            System.out.println("User: " + user);
            Shop_DB sdb = new Shop_DB();
            Shop shop = sdb.getShopHaveStatusIs1ByUserID(user.getUserId());
            if (shop != null) {
                System.out.println("Shop found: " + shop);
                request.getSession().setAttribute("SHOP", shop);
                ArrayList<Product> productlist = sdb.getAllProductByShopID(shop.getShopID());

                ArrayList<Discount> discountlist = sdb.getAllDiscountByShopID(shop.getShopID());
                request.setAttribute("discounts", discountlist);

                System.out.println("Product list size: " + productlist.size());
                request.setAttribute("products", productlist);

                request.getRequestDispatcher("/marketplace/myShop.jsp").forward(request, response);
            } else {
                System.out.println("Shop not found for user: " + user.getUserId());
                request.getRequestDispatcher("/marketplace/createShop.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
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
        NotificationWebSocket nw = new NotificationWebSocket();
        User user = (User) request.getSession().getAttribute("USER");
        Shop_DB sdb = new Shop_DB();
        String name = request.getParameter("shopName");
        String campus = request.getParameter("campus");
        String phone = request.getParameter("shopPhone");
        String decription = request.getParameter("shopDescription");
        if (isValidPhoneNumber(phone.trim()) == true) {
            if (user.getUserWallet() >= 50000) {
                boolean updateSuccess = User_DB.updateWalletByEmail(user.getUserEmail(), user.getUserWallet() - 50000);
                nw.saveNotificationToDatabaseWithStatusIsBalance(user.getUserId(), "Trừ phí tạo shop : 50000đ!", "/walletbalance");
                Shop sh = new Shop(1, name, phone, campus, decription, user.getUserId(), null, 2);
                sdb.addShop(sh);
                Shop shop = sdb.getShopHaveStatusIs1ByUserID(user.getUserId());
                User updatedUser = User_DB.getUserByEmailorUsername(user.getUserEmail());
                request.getSession().setAttribute("USER", updatedUser);
                request.setAttribute("message", "Your shop has been successfully created and is waiting for admin approval.");
                request.getSession().setAttribute("SHOP", shop);
                request.getRequestDispatcher("/marketplace/createShop.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Your wallet doesn't have enough money.");
                request.getRequestDispatcher("/marketplace/createShop.jsp").forward(request, response);
            }

        } else {
            request.setAttribute("message", "The phone number must consist of 10 numbers and start with 09.");
            request.getRequestDispatcher("/marketplace/createShop.jsp").forward(request, response);
        }

    }

    public static boolean isValidPhoneNumber(String phoneNumber) {
        // Kiểm tra độ dài của chuỗi
        if (phoneNumber.length() != 10) {
            return false;
        }

        // Kiểm tra chuỗi có bắt đầu bằng "09" hay không
        if (!phoneNumber.startsWith("09")) {
            return false;
        }

        // Kiểm tra tất cả các ký tự còn lại có phải là số hay không
        for (int i = 0; i < phoneNumber.length(); i++) {
            if (!Character.isDigit(phoneNumber.charAt(i))) {
                return false;
            }
        }

        // Nếu tất cả các điều kiện đều đúng, trả về true
        return true;
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
