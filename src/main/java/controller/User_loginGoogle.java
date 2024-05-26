/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAO.User_DB;
import model.User;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;
import util.Constants;
import util.UserGoogleDto;

/**
 *
 * @author Admin
 */
public class User_loginGoogle extends HttpServlet {

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
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        UserGoogleDto usergg = getUserInfo(accessToken);
//        System.out.println(user);
        User userInfo = User_DB.getUserByEmailorUsername(usergg.getEmail());
        if (userInfo != null) {
            User user = User.login(usergg.getEmail(), userInfo.getUserPassword());
            int userRole = userInfo.getUserRole();
            String role = null;
            String message = null;
            switch (userRole) {
                case 0:
                    message = "Your account has been banned.";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
                    return;
                case 1:
                    role = "USER";
                    message = "Welcome, User!";
                    break;
                case 2:
                    role = "MANAGER";
                    message = "Welcome, Manager!";
                    break;
                case 3:
                    role = "HOST GROUP";
                    message = "Welcome, User!";
                    break;
                case 4:
                    role = "ADMIN";
                    message = "Welcome, Admin!";
                    break;
            }
            request.getSession().setAttribute("USER", userInfo);
            request.getSession().setAttribute("ROLE", role);
            request.setAttribute("roleMessage", message);
            request.setAttribute("userInfo", userInfo);
            request.getRequestDispatcher("/auth/role.jsp").forward(request, response);
        } else {
            String msg = "Email account has not been created yet! ";
            request.setAttribute("message", msg);
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        }
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        // call api to get token
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        UserGoogleDto googlePojo = new Gson().fromJson(response, UserGoogleDto.class);

        return googlePojo;
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
        User user = (User) request.getSession().getAttribute("USER");
        if (user == null) {
            processRequest(request, response);

        } else {
            String role = null;
            String message = null;
            switch (user.getUserRole()) {
                case 0:
                    message = "Your account has been banned.";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
                    return;
                case 1:
                    role = "USER";
                    message = "Welcome, User!";
                    break;
                case 2:
                    role = "MANAGER";
                    message = "Welcome, Manager!";
                    break;
                case 3:
                    role = "HOST GROUP";
                    message = "Welcome, User!";
                    break;
                case 4:
                    role = "ADMIN";
                    message = "Welcome, Admin!";
                    break;
            }
            request.getSession().setAttribute("USER", user);
            request.getSession().setAttribute("ROLE", role);
            request.setAttribute("roleMessage", message);
            request.setAttribute("userInfo", user);
            request.getRequestDispatcher("/auth/role.jsp").forward(request, response);

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