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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Admin
 */
public class User_rankView extends HttpServlet {

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
            out.println("<title>Servlet User_MyRank</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_MyRank at " + request.getContextPath() + "</h1>");
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
        // Gọi hàm và in ra kết quả ngày hiện tại
        String currentDate = getCurrentDate();

        // Gọi hàm và in ra kết quả ngày đầu tiên của tháng
        String firstDayOfMonth = getFirstDayOfMonth(currentDate);

        // Gọi hàm và in ra kết quả ngày cuối cùng của tháng
        String lastDayOfMonth = getLastDayOfMonth(currentDate);

        // Gọi hàm và in ra kết quả ngày đầu tiên của tháng sau
        String firstDayOfNextMonth = getFirstDayOfNextMonth(currentDate);

        // Gọi hàm và in ra kết quả ngày cuối cùng của tháng sau
        String lastDayOfNextMonth = getLastDayOfNextMonth(currentDate);

        request.setAttribute("currentDate", currentDate);
        request.setAttribute("firstDayOfMonth", firstDayOfMonth);
        request.setAttribute("lastDayOfMonth", lastDayOfMonth);
        request.setAttribute("firstDayOfNextMonth", firstDayOfNextMonth);
        request.setAttribute("lastDayOfNextMonth", lastDayOfNextMonth);
        request.getRequestDispatcher("/rank/myrank.jsp").forward(request, response);
    }

    // Hàm lấy ngày tháng năm hiện tại
    public static String getCurrentDate() {
        // Lấy ngày hiện tại
        LocalDate currentDate = LocalDate.now();

        // Định dạng ngày theo kiểu "dd-MM-yyyy"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

        // Trả về ngày dưới dạng chuỗi
        return currentDate.format(formatter);
    }

    // Hàm trả về ngày đầu tiên của tháng từ ngày tháng năm hiện tại
    public static String getFirstDayOfMonth(String currentDateString) {
        // Định dạng ngày theo kiểu "dd-MM-yyyy"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

        // Chuyển đổi chuỗi ngày tháng năm hiện tại sang đối tượng LocalDate
        LocalDate currentDate = LocalDate.parse(currentDateString, formatter);

        // Lấy ngày đầu tiên của tháng
        LocalDate firstDayOfMonth = currentDate.withDayOfMonth(1);

        // Trả về ngày đầu tiên của tháng dưới dạng chuỗi
        return firstDayOfMonth.format(formatter);
    }

    // Hàm trả về ngày cuối cùng của tháng từ ngày tháng năm hiện tại
    public static String getLastDayOfMonth(String currentDateString) {
        // Định dạng ngày theo kiểu "dd-MM-yyyy"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

        // Chuyển đổi chuỗi ngày tháng năm hiện tại sang đối tượng LocalDate
        LocalDate currentDate = LocalDate.parse(currentDateString, formatter);

        // Lấy ngày cuối cùng của tháng
        LocalDate lastDayOfMonth = currentDate.withDayOfMonth(currentDate.lengthOfMonth());

        // Trả về ngày cuối cùng của tháng dưới dạng chuỗi
        return lastDayOfMonth.format(formatter);
    }

    // Hàm trả về ngày đầu tiên của tháng sau từ ngày tháng năm hiện tại
    public static String getFirstDayOfNextMonth(String currentDateString) {
        // Định dạng ngày theo kiểu "dd-MM-yyyy"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

        // Chuyển đổi chuỗi ngày tháng năm hiện tại sang đối tượng LocalDate
        LocalDate currentDate = LocalDate.parse(currentDateString, formatter);

        // Tăng tháng lên 1 để lấy tháng sau
        LocalDate nextMonth = currentDate.plusMonths(1);

        // Lấy ngày đầu tiên của tháng sau
        LocalDate firstDayOfNextMonth = nextMonth.withDayOfMonth(1);

        // Trả về ngày đầu tiên của tháng sau dưới dạng chuỗi
        return firstDayOfNextMonth.format(formatter);
    }

    // Hàm trả về ngày cuối cùng của tháng sau từ ngày tháng năm hiện tại
    public static String getLastDayOfNextMonth(String currentDateString) {
        // Định dạng ngày theo kiểu "dd-MM-yyyy"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

        // Chuyển đổi chuỗi ngày tháng năm hiện tại sang đối tượng LocalDate
        LocalDate currentDate = LocalDate.parse(currentDateString, formatter);

        // Tăng tháng lên 1 để lấy tháng sau
        LocalDate nextMonth = currentDate.plusMonths(1);

        // Lấy ngày cuối cùng của tháng sau
        LocalDate lastDayOfNextMonth = nextMonth.withDayOfMonth(nextMonth.lengthOfMonth());

        // Trả về ngày cuối cùng của tháng sau dưới dạng chuỗi
        return lastDayOfNextMonth.format(formatter);
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
        processRequest(request, response);
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
