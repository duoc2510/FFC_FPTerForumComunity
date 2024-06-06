/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.util.List;
import java.util.stream.Collectors;
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
import model.DAO.Group_DB;
import model.Group;
import model.User;

/**
 *
 * @author ThanhDuoc
 */
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
public class Group_list extends HttpServlet {

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
            out.println("<title>Servlet Group_list</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Group_list at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");
        int userId = user.getUserId();

        // Khởi tạo danh sách groups và lưu vào session nếu chưa tồn tại
        if (session.getAttribute("groups") == null) {
            // Retrieve all groups and filter out inactive ones
            List<Group> allGroups = Group_DB.getAllGroups();
            List<Group> groups = allGroups.stream()
                    .filter(group -> !"inactive".equals(group.getStatus()))
                    .collect(Collectors.toList());

            session.setAttribute("groups", groups);
        }

        // Lấy danh sách groups từ session
        List<Group> groups = (List<Group>) session.getAttribute("groups");

        // Kiểm tra nếu thông tin về các nhóm đã tạo chưa được lưu trong session
        if (session.getAttribute("groupsCreated") == null) {
            // Retrieve groups created by the user and filter out inactive ones
            List<Group> allGroupsCreated = Group_DB.getAllGroupsCreated(userId);
            List<Group> groupsCreated = allGroupsCreated.stream()
                    .filter(group -> !"inactive".equals(group.getStatus()))
                    .collect(Collectors.toList());

            session.setAttribute("groupsCreated", groupsCreated);
        }

        // Kiểm tra nếu thông tin về các nhóm đã tham gia chưa được lưu trong session
        if (session.getAttribute("groupsJoined") == null) {
            // Retrieve groups joined by the user and filter out inactive ones
            List<Group> allGroupJoined = Group_DB.getAllGroupJoin(userId);
            List<Group> groupJoined = allGroupJoined.stream()
                    .filter(group -> !"inactive".equals(group.getStatus()))
                    .collect(Collectors.toList());

            session.setAttribute("groupsJoined", groupJoined);

            // Filter out groups that the user has created or joined
            List<Integer> joinedGroupIds = groupJoined.stream()
                    .map(Group::getGroupId)
                    .collect(Collectors.toList());
            groups.removeIf(group -> group.getCreaterId() == userId || joinedGroupIds.contains(group.getGroupId()));

            // Check the status of each remaining group
            for (Group group : groups) {
                boolean isPending = Group_DB.isUserPendingApproval(userId, group.getGroupId());
                boolean isBanned = Group_DB.isUserBan(userId, group.getGroupId());
                group.setPending(isPending);
                group.setIsBanned(isBanned);
            }
        }
        request.getRequestDispatcher("/group/index.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String UPLOAD_DIR = "Avatar_of_group";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");
        String groupIdParam = request.getParameter("groupId");
        String groupName = request.getParameter("groupName");
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "joinGroup":
                    if (groupIdParam != null) {
                        // Xử lý hành động tham gia nhóm
                        int groupId = Integer.parseInt(groupIdParam);
                        boolean success = Group_DB.joinGroup(user.getUserId(), groupId);
                        if (success) {
                            session.setAttribute("message", "You have successfully registered to join the group. Please wait for approval.");
                        } else {
                            session.setAttribute("error", "Failed to join the group. Please try again.");
                        }
                        response.sendRedirect("group?groupId=" + groupId);
                        updateSessionWithNewGroup(session, user.getUserId());
                    }
                    break;
                case "createGroup":
                    // Xử lý hành động tạo nhóm
                    String groupDescription = request.getParameter("groupDescription");
                    Part filePart = request.getPart("groupAvatar");

                    if (groupName.isEmpty() || groupDescription.isEmpty() || filePart == null || filePart.getSize() == 0) {
                        session.setAttribute("error", "Please fill in all required fields.");
                        response.sendRedirect("group");
                        return;
                    }

                    // Tạo thư mục lưu trữ nếu chưa tồn tại
                    String applicationPath = request.getServletContext().getRealPath("");
                    String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
                    File uploadFolder = new File(uploadFilePath);
                    if (!uploadFolder.exists()) {
                        uploadFolder.mkdirs();
                    }

                    String fileName = filePart.getSubmittedFileName();
                    String filePath = uploadFilePath + File.separator + fileName;
                    filePart.write(filePath);

                    String filePathForDatabase = UPLOAD_DIR + "/" + fileName;

                    Group group = new Group(user.getUserId(), groupName, groupDescription, filePathForDatabase);
                    int newGroupId = Group_DB.addGroup(group);

                    if (newGroupId != -1) {
                        session.setAttribute("message", "Group created successfully.");
                        response.sendRedirect("group/detail?groupId=" + newGroupId);
                        updateSessionWithNewGroup(session, user.getUserId());
                    } else {
                        session.setAttribute("error", "Failed to create the group. Please try again.");
                        response.sendRedirect("group");
                    }
                    break;
                case "deleteGroup":
                    if (groupIdParam != null) {
                        // Xử lý hành động xóa nhóm
                        int groupIdToDelete = Integer.parseInt(groupIdParam);
                        boolean deletionSuccess = Group_DB.deleteGroup(groupIdToDelete);
                        if (deletionSuccess) {
                            session.setAttribute("message", "Group deleted successfully.");
                        } else {
                            session.setAttribute("error", "Failed to delete the group. Please try again.");
                        }
                        updateSessionWithNewGroup(session, user.getUserId());
                        response.sendRedirect("group");
                    }
                    break;
                default:
                    response.sendRedirect("group");
                    break;
            }
        } else {
            response.sendRedirect("group");
        }
    }

// Phương thức cập nhật thông tin nhóm trong session sau khi thêm nhóm mới thành công
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
