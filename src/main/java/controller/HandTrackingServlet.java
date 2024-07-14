package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HandTrackingServlet", urlPatterns = {"/HandTrackingServlet"})
public class HandTrackingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StringBuilder jsonBuilder = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }
        } catch (IOException ex) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String json = jsonBuilder.toString();

        // Xử lý dữ liệu JSON tại đây (ví dụ: lưu vào cơ sở dữ liệu, gửi đến client khác...)
        System.out.println("Received hand tracking data: " + json);

        response.setStatus(HttpServletResponse.SC_OK);
    }
}
