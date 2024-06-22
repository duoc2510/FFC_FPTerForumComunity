package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.DAO.Event_DB;
import model.Upload;
import model.User;
import model.Event;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
public class Event_addEvent extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Event_addEvent</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Event_addEvent at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/event/index.jsp").forward(request, response);
    }

    private static final String UPLOAD_DIR = "Avatar_of_events";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startDateString = request.getParameter("start_date");
        String endDateString = request.getParameter("end_date");
        String location = request.getParameter("location");
        String place = request.getParameter("place");

        Timestamp startDate = null;
        Timestamp endDate = null;

        // Sử dụng DateTimeFormatter để định dạng lại chuỗi datetime-local thành định dạng Timestamp yêu cầu
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        if (startDateString != null && !startDateString.isEmpty()) {
            LocalDateTime localDateTime = LocalDateTime.parse(startDateString, formatter);
            startDate = Timestamp.valueOf(localDateTime);
        }

        if (endDateString != null && !endDateString.isEmpty()) {
            LocalDateTime localDateTime = LocalDateTime.parse(endDateString, formatter);
            endDate = Timestamp.valueOf(localDateTime);
        }

        // Check if the dates are valid
        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
        if (startDate.before(currentTimestamp) || endDate.before(currentTimestamp) || endDate.before(startDate)) {
            // Set the message in the session
            request.getSession().setAttribute("message", "Invalid date selection. Please ensure the dates are correct and in the future.");
            // Redirect to the events page
            response.sendRedirect(request.getContextPath() + "/listEvent");
            return;
        }

        if (endDate.before(startDate)) {
            request.getSession().setAttribute("message", "End date cannot be before start date.");
            response.sendRedirect(request.getContextPath() + "/listEvent");
            return;
        }

        User user = (User) request.getSession().getAttribute("USER");
        if (user == null) {
            // Xử lý khi người dùng không được xác định
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int userId = user.getUserId();

        Part filePart = request.getPart("upload_path");
        String fileName = extractFileName(filePart);

        // Tạo thư mục lưu trữ nếu chưa tồn tại
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        File uploadFolder = new File(uploadFilePath);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        String savePath = uploadFilePath + File.separator + fileName;
        filePart.write(savePath);

        // Đường dẫn lưu trong cơ sở dữ liệu
        String filePathForDatabase = UPLOAD_DIR + File.separator + fileName;

        Timestamp createdAt = new Timestamp(System.currentTimeMillis());

        Event event = new Event(0, title, description, startDate, endDate, userId, location, place, createdAt);

        Upload upload = new Upload(0, 0, 0, 0, filePathForDatabase);
        Event_DB eventDB = new Event_DB();
        String message;
        if (eventDB.addEvent(event, upload)) {
            message = "Event added successfully!";
        } else {
            message = "Error adding event.";
        }
        // Set the message in the session
        request.getSession().setAttribute("message", message);

        // Redirect to the events page
        response.sendRedirect(request.getContextPath() + "/listEvent");
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}