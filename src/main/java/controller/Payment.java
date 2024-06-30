package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;
import model.DAO.User_DB;
import model.DAO.User_payment;

public class Payment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && !action.isEmpty()) {
            if (action.equals("napTien")) {
                handleNapTien(request, response);
                response.sendRedirect(request.getContextPath() + "/wallet/deposit");
            } else if (action.equals("rutTien")) {
                handleRutTien(request, response);
                response.sendRedirect(request.getContextPath() + "/wallet/withdraw");
            }
        } else {
        }
    }

    private void handleNapTien(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("USER");
            if (user == null) {
                throw new ServletException("Không tìm thấy người dùng trong session.");
            }

            int userId = user.getUserId();
            double amount = Double.parseDouble(request.getParameter("amount"));
            String atmNumber = request.getParameter("atmNumber");
            String bankName = request.getParameter("bankName");
            int code = Integer.parseInt(request.getParameter("code")); // Lấy mã code từ request

            // Gọi phương thức xử lý nạp tiền từ lớp DAO
            boolean success = User_payment.napTien(atmNumber, userId, bankName, amount, code);

            // Đặt message vào session
            String message = success ? "Nạp tiền thành công!" : "Nạp tiền thất bại!";
            session.setAttribute("message", message);
            user = User_DB.getUserByEmailorUsername(user.getUsername());
            session.setAttribute("USER", user);

        } catch (NumberFormatException | NullPointerException e) {
        }
    }

    private void handleRutTien(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("USER");
            if (user == null) {
                throw new ServletException("Không tìm thấy người dùng trong session.");
            }

            int userId = user.getUserId();
            double amount = Double.parseDouble(request.getParameter("amount"));
            String atmNumber = request.getParameter("atmNumber");
            String bankName = request.getParameter("bankName");

            // Gọi phương thức xử lý rút tiền từ lớp DAO
            boolean success = User_payment.rutTien(userId, atmNumber, bankName, amount);

            // Đặt message vào session
            String message = success ? "Rút tiền thành công!" : "Rút tiền thất bại!";
            session.setAttribute("message", message);
            user = User_DB.getUserByEmailorUsername(user.getUsername());
            session.setAttribute("USER", user);

        } catch (NumberFormatException | NullPointerException e) {
        }
    }
}
