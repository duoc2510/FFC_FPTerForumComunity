/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import java.util.stream.Collectors;
import model.DAO.Group_DB;
import model.Group;
import model.User;

/**
 *
 * @author PC
 */
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)

public class Group_edit extends HttpServlet {

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
            out.println("<title>Servlet User_groupEdit</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_groupEdit at " + request.getContextPath() + "</h1>");
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
        // Chuyển hướng request đến trang JSP để hiển thị thông tin nhóm
        request.getRequestDispatcher("/group/groupEdit.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        // Kiểm tra xem người dùng đã đăng nhập chưa
        Group group = (Group) request.getSession().getAttribute("group");
        User user = (User) request.getSession().getAttribute("USER");
        if (group != null) {
            // Lấy thông tin từ form
            int groupId = group.getGroupId();
            String nameGroup = request.getParameter("groupName");
            String description = request.getParameter("description");

            // Sử dụng lại avatar cũ mặc định
            String avatar = request.getParameter("oldAvatar");

            // Xử lý tải ảnh lên nếu có
            Part filePart = request.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0) {
                // Xử lý tải ảnh lên
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

                File uploadDir = new File(uploadFilePath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String fileName = getFileName(filePart);
                filePart.write(uploadFilePath + File.separator + fileName);

                // Cập nhật đường dẫn avatar
                avatar = UPLOAD_DIR + "/" + fileName;
            }

            // Cập nhật thông tin người dùng trong cơ sở dữ liệu
            boolean updateSuccess = Group_DB.updateGroup(groupId, nameGroup, description, avatar);
            if (updateSuccess) {
                request.setAttribute("message", "Thông tin nhóm đã được cập nhật.");
                updateSessionWithNewGroup(session, user.getUserId());
            } else {
                request.setAttribute("message", "Cập nhật thông tin nhóm thất bại.");
            }

            // Lấy lại thông tin người dùng sau khi cập nhật
            Group updateroup = Group_DB.viewGroup(groupId);

            session.setAttribute("group", updateroup);
            request.getRequestDispatcher("/group/groupEdit.jsp").forward(request, response);
        } else {
            // Nếu người dùng chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login");
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
            }
        }
        return "";
    }

    private void updateSessionWithNewGroup(HttpSession session, int creatorId) {
        // Retrieve all groups and filter out inactive ones
        List<Group> allGroups = Group_DB.getAllGroups();
        List<Group> groups = allGroups.stream()
                .filter(group -> !"inactive".equals(group.getStatus()))
                .collect(Collectors.toList());

        // Retrieve groups created by the user and filter out inactive ones
        List<Group> allGroupsCreated = Group_DB.getAllGroupsCreated(creatorId);
        List<Group> groupsCreated = allGroupsCreated.stream()
                .filter(group -> !"inactive".equals(group.getStatus()))
                .collect(Collectors.toList());

        // Retrieve groups joined by the user and filter out inactive ones
        List<Group> allGroupJoined = Group_DB.getAllGroupJoin(creatorId);
        List<Group> groupJoined = allGroupJoined.stream()
                .filter(group -> !"inactive".equals(group.getStatus()))
                .collect(Collectors.toList());

        // Filter out groups that the user has created or joined
        List<Integer> joinedGroupIds = groupJoined.stream()
                .map(Group::getGroupId)
                .collect(Collectors.toList());
        groups.removeIf(group -> group.getCreaterId() == creatorId || joinedGroupIds.contains(group.getGroupId()));

        // Check the status of each remaining group
        for (Group group : groups) {
            boolean isPending = Group_DB.isUserPendingApproval(creatorId, group.getGroupId());
            boolean isBanned = Group_DB.isUserBan(creatorId, group.getGroupId());
            group.setPending(isPending);
            group.setIsBanned(isBanned);
        }
        // Set attributes to be passed to JSP
        session.setAttribute("groupsJoined", groupJoined);
        session.setAttribute("groups", groups);
        session.setAttribute("groupsCreated", groupsCreated);
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
