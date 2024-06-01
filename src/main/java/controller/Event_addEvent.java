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
import model.DAO.Event_DB;
import model.Upload;
import model.User;
import model.User_event;

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
        request.getRequestDispatcher("/event/allEvent.jsp").forward(request, response);
    }

    private static final String UPLOAD_DIR = "Avatar_of_events";
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        Timestamp startDate = Timestamp.valueOf(request.getParameter("start_date"));
        Timestamp endDate = Timestamp.valueOf(request.getParameter("end_date"));

        int userId = ((User) request.getSession().getAttribute("USER")).getUserId(); // Thay đổi từ "userID" sang "USER" và sử dụng phương thức getUserId()

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

        User_event event = new User_event(0, title, description, startDate, endDate, userId);
        Upload upload = new Upload(0, 0, 0, 0, 0, 0, filePathForDatabase); // Thay đổi savePath thành filePathForDatabase

        Event_DB eventDB = new Event_DB();
        if (eventDB.addEvent(event, upload)) {
            request.setAttribute("message", "Event added successfully!");
        } else {
            request.setAttribute("message", "Error adding event.");
        }
        request.getRequestDispatcher("/event/allEvent.jsp").forward(request, response);
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
