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
import java.util.Date;
import java.util.List;
import model.DAO.Event_DB;
import model.DAO.User_DB;
import model.Event;
import model.User;

/**
 *
 * @author Admin
 */
public class Event_viewEvent extends HttpServlet {

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
            out.println("<title>Servlet Event_viewEvent</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Event_viewEvent at " + request.getContextPath() + "</h1>");
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
        String eventIdStr = request.getParameter("eventId");
        HttpSession session = request.getSession();
        if (eventIdStr != null) {
            int eventId = Integer.parseInt(eventIdStr);
            User user = (User) session.getAttribute("USER");
            List<Event> eventList = (List<Event>) session.getAttribute("eventList");
            if (eventList == null) {
                eventList = Event_DB.getAllEvents();
                for (Event event : eventList) {
                    boolean interested = Event_DB.checkUserInterest(user.getUserId(), event.getEventId());
                    event.setIsInterest(interested);
                }
                session.setAttribute("eventList", eventList);
            }

            Event event = Event_DB.getEventById(eventId);
            boolean interested = Event_DB.checkUserInterest(user.getUserId(), eventId);
            event.setIsInterest(interested);
            request.setAttribute("event", event);

            List<String> interestedUsers = User_DB.getUsersInterestedInEvent(eventId);
            int numInterestedUsers = User_DB.countInterestedUsers(eventId);
            request.setAttribute("numInterestedUsers", numInterestedUsers);
            request.setAttribute("interestedUsers", interestedUsers);
            // Set the current time
            request.setAttribute("now", new Date());
            request.getRequestDispatcher("/event/viewEvent.jsp").forward(request, response);
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
