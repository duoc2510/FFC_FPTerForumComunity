package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;
import java.util.List;
import model.DAO.User_DB;
import model.DAO.Payment_DB;
import model.Payment;
import notifications.NotificationWebSocket;

public class User_payment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Payment> payments = Payment_DB.getAllPayments();
        request.setAttribute("payments", payments);
        request.getRequestDispatcher("payments.jsp").forward(request, response);
    }

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
            double wallet = user.getUserWallet();

            // Gọi phương thức xử lý nạp tiền từ lớp DAO
            boolean success = Payment_DB.napTien(atmNumber, userId, bankName, amount, code);

            // Đặt message vào session
            String message = success ? "Nạp tiền thành công!" : "Nạp tiền thất bại!";
            session.setAttribute("message", message);

            // Cập nhật thông tin người dùng sau khi nạp tiền
            user = User_DB.getUserByEmailorUsername(user.getUsername());
            session.setAttribute("USER", user);

            // Chuẩn bị và gửi thông báo
            NotificationWebSocket nw = new NotificationWebSocket();
            double newWalletBalance = user.getUserWallet();
            String notificationMessage = "Nạp tiền thành công! Số dư: " + wallet + " + " + amount + " = " + newWalletBalance;

            nw.saveNotificationToDatabaseWithStatusIsBalance(userId, notificationMessage, "/walletbalance");
            nw.sendNotificationToClient(userId, notificationMessage, "/walletbalance");
        } catch (NumberFormatException | NullPointerException e) {
            // Xử lý ngoại lệ khi parsing dữ liệu không thành công hoặc dữ liệu không tồn tại
            HttpSession session = request.getSession();
            session.setAttribute("message", "Đã xảy ra lỗi trong quá trình xử lý. Vui lòng kiểm tra lại thông tin.");
            response.sendRedirect("errorPage.jsp"); // Chuyển hướng đến trang lỗi tùy chọn
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
            boolean success = Payment_DB.rutTien(userId, atmNumber, bankName, amount);

            // Đặt message vào session
            String message = success ? "Rút tiền thành công!" : "Rút tiền thất bại!";
            session.setAttribute("message", message);
            user = User_DB.getUserByEmailorUsername(user.getUsername());
            session.setAttribute("USER", user);

        } catch (NumberFormatException | NullPointerException e) {
        }
    }
}
