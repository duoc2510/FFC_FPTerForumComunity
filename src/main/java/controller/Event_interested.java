package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAO.Event_DB;
import model.User;

public class Event_interested extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (var out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Event_interested</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Event_interested at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("USER");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = user.getUserId();
        String eventIdStr = request.getParameter("eventId");

        if (eventIdStr != null) {
            try {
                int eventId = Integer.parseInt(eventIdStr);

                // Kiểm tra xem người dùng đã quan tâm đến sự kiện chưa
                boolean isAlreadyInterested = Event_DB.checkUserInterest(userId, eventId);

                if ("add".equals(request.getParameter("action"))) {
                    // Nếu action là add, thực hiện thêm quan tâm vào sự kiện
                    if (!isAlreadyInterested) {
                        boolean success = Event_DB.addUserInterest(userId, eventId);
                         
                        if (success) {
                            // Nếu thêm quan tâm thành công
                            request.setAttribute("interestAdded", true);
                        } else {
                            // Nếu thêm quan tâm không thành công
                            request.setAttribute("interestAdded", false);
                            response.getWriter().println("Failed to add user interest.");
                        }
                    } else {
                        // Người dùng đã quan tâm rồi
                        request.setAttribute("interestAdded", true);
                    }
                } else if ("cancel".equals(request.getParameter("action"))) {
                    // Nếu action là cancel, thực hiện huỷ quan tâm sự kiện
                    if (isAlreadyInterested) {
                        boolean success = Event_DB.deleteUserInterest(userId, eventId);

                        if (success) {
                            // Nếu huỷ quan tâm thành công
                            request.setAttribute("interestAdded", false);
                        } else {
                            // Nếu huỷ quan tâm không thành công
                            request.setAttribute("interestAdded", true);
                            response.getWriter().println("Failed to cancel user interest.");
                        }
                    } else {
                        // Người dùng chưa quan tâm trước đó
                        request.setAttribute("interestAdded", false);
                    }
                }

                // Sau khi xử lý xong, chuyển hướng hoặc refresh trang
                response.sendRedirect(request.getHeader("Referer"));
            } catch (NumberFormatException e) {
                response.getWriter().println("Invalid event ID.");
                e.printStackTrace();
            }
        } else {
            response.getWriter().println("Missing event ID.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
