/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Comment;
import model.DAO.Comment_DB;
import model.DAO.Group_DB;
import model.DAO.Post_DB;
import model.DAO.User_DB;
import model.Group;
import model.Group_member;
import model.Post;
import model.User;

/**
 *
 * @author PC
 */
public class Group_detail extends HttpServlet {

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
            out.println("<title>Servlet User_inGroup</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User_inGroup at " + request.getContextPath() + "</h1>");
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
        // Lấy userId và groupId từ request, bạn cần thay đổi phần này tùy vào cách bạn truyền dữ liệu từ client
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");
        int userId = user.getUserId();
        int groupId = Integer.parseInt(request.getParameter("groupId"));
        int postCount = Group_DB.countPostsInGroup(groupId);
        // Gọi phương thức viewGroup để lấy thông tin nhóm từ cơ sở dữ liệu
        Group group = Group_DB.viewGroup(groupId);

        // Lấy danh sách tất cả các thành viên của nhóm
        List<Group_member> allMembers = Group_DB.getAllMembersByGroupId(groupId);
        List<Group_member> approvedMembers = new ArrayList<>();

        // Duyệt qua tất cả các thành viên và thêm những thành viên có trạng thái "approved" vào danh sách mới
        for (Group_member member : allMembers) {
            if ("approved".equalsIgnoreCase(member.getStatus()) || "host".equalsIgnoreCase(member.getStatus())) {
                approvedMembers.add(member);
            }
        }
        session.setAttribute("approvedMembers", approvedMembers);
        // Lọc ra các thành viên có trạng thái là 'pending'
        List<Group_member> pendingMembers = new ArrayList<>();

        for (Group_member member : allMembers) {
            if ("pending".equals(member.getStatus())) {
                pendingMembers.add(member);
            }
        }
        // Kiểm tra nếu posts đã có trong session
        List<Post> posts = (List<Post>) session.getAttribute("postsGroup");
        if (posts == null) {
            posts = Post_DB.getPostsWithGroupId();
            for (Post post : posts) {
                User author = Post_DB.getUserByPostId(post.getPostId());
                post.setUser(author);

                List<Comment> comments = Comment_DB.getCommentsByPostId(post.getPostId());
                for (Comment comment : comments) {
                    User commentUser = User_DB.getUserById(comment.getUserId());
                    if (commentUser != null) {
                        comment.setUser(commentUser);
                    }
                }
                post.setComments(comments);
            }
            session.setAttribute("postsGroup", posts);
        }

        // Đặt danh sách các thành viên đang chờ duyệt vào thuộc tính request
        request.setAttribute("pendingMembers", pendingMembers);
        boolean isPending = Group_DB.isUserPendingApproval(userId, groupId);
        group.setPending(isPending);
        boolean isUserApproved = Group_DB.isUserApproved(userId, groupId);
        boolean isUserBanned = Group_DB.isUserBan(userId, groupId);
        session.setAttribute("isUserApproved", isUserApproved);
        session.setAttribute("isUserBanned", isUserBanned);
        session.setAttribute("group", group);
        session.setAttribute("postCount", postCount);
        session.setAttribute("allMembers", approvedMembers);
        request.getRequestDispatcher("/group/groupDetails.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");
        String action = request.getParameter("action");

        boolean redirectToReferer = false; // Biến trạng thái để kiểm soát việc gọi sendRedirect()
        boolean result = false;
        String messageOfApprove = "";
        if (action != null && !action.isEmpty()) {
            if ("accept".equals(action) || "deny".equals(action)) {
                int memberGroupId = 0;
                try {
                    memberGroupId = Integer.parseInt(request.getParameter("memberId"));
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid memberId parameter");
                    return;
                }
                if ("accept".equals(action)) {
                    result = Group_DB.accept(memberGroupId);
                    messageOfApprove = result ? "Member approved successfully!" : "Failed to approve member.";
                } else if ("deny".equals(action)) {
                    result = Group_DB.deny(memberGroupId);
                    messageOfApprove = result ? "Member denied successfully!" : "Failed to deny member.";
                }
                session.setAttribute("messageOfApprove", messageOfApprove);
            } else if ("acceptPost".equals(action) || "denyPost".equals(action)) {
                String reason = request.getParameter("reason");
                int postId = 0;
                try {
                    postId = Integer.parseInt(request.getParameter("postId"));
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid postId parameter");
                    return;
                }
                result = ("acceptPost".equals(action)) ? Post_DB.updatePostStatus(postId, "Active", "Oke") : Post_DB.updatePostStatus(postId, "Denied", reason);
            } else if ("leave".equals(action)) {
                int groupId = Integer.parseInt(request.getParameter("groupId"));
                boolean success = Group_DB.leaveGroup(groupId, user.getUserId());
                if (success) {
                    List<Group_member> allMembers = Group_DB.getAllMembersByGroupId(groupId);
                    session.setAttribute("allMembers", allMembers);
                    session.setAttribute("message", "You have successfully left the group.");
                    redirectToReferer = true;
                } else {
                    session.setAttribute("error", "Failed to leave the group. Please try again.");
                }
            } else if ("kick".equals(action)) {
                int groupId = Integer.parseInt(request.getParameter("groupId"));
                int userIdOut = Integer.parseInt(request.getParameter("userId"));
                boolean success = Group_DB.kickMember(groupId, userIdOut);
                if (success) {
                    List<Group_member> allMembers = Group_DB.getAllMembersByGroupId(groupId);
                    session.setAttribute("allMembers", allMembers);
                    session.setAttribute("message", "Member has been kicked out successfully.");
                    redirectToReferer = true;
                } else {
                    session.setAttribute("error", "Failed to kick member. Please try again.");
                }
            } else if ("ban".equals(action)) {
                int groupId = Integer.parseInt(request.getParameter("groupId"));
                int userIdOut = Integer.parseInt(request.getParameter("userId"));
                boolean success = Group_DB.banMember(groupId, userIdOut);
                if (success) {
                    List<Group_member> allMembers = Group_DB.getAllMembersByGroupId(groupId);
                    session.setAttribute("allMembers", allMembers);
                    session.setAttribute("message", "Member has been banned successfully.");
                    redirectToReferer = true;
                } else {
                    session.setAttribute("error", "Failed to ban member. Please try again.");
                }
            }
        }

        if (redirectToReferer) {
            String referer = request.getHeader("referer");
            response.sendRedirect(referer);
        } else {
            if (result) {
                int groupId = Integer.parseInt(request.getParameter("groupId"));
                List<Group_member> allMembers = Group_DB.getAllMembersByGroupId(groupId);
                session.setAttribute("allMembers", allMembers);
                response.sendRedirect("detail?groupId=" + groupId);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update member status");
            }

            boolean success = false;
            if ("acceptPost".equals(action) || "denyPost".equals(action)) {
                success = result;
            }

            if (success) {
                List<Post> posts = Post_DB.getPostsWithGroupId();
                for (Post p : posts) {
                    User author = Post_DB.getUserByPostId(p.getPostId());
                    p.setUser(author);
                    List<Comment> comments = Comment_DB.getCommentsByPostId(p.getPostId());
                    for (Comment comment : comments) {
                        User commentUser = User_DB.getUserById(comment.getUserId());
                        if (commentUser != null) {
                            comment.setUser(commentUser);
                        }
                    }
                    p.setComments(comments);
                }
                session.setAttribute("postsGroup", posts);
                System.out.println("Post status updated successfully.");
            } else {
                System.out.println("Failed to update post status.");
            }
        }
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
