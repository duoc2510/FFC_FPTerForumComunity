<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<body>
    <c:choose>
        <c:when test="${empty sessionScope.USER}">
            <%@ include file="../index_guest.jsp" %>
        </c:when>
        <c:otherwise>
            <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
                 data-sidebar-position="fixed" data-header-position="fixed">
                <%@ include file="../include/slidebar.jsp" %>
                <div class="body-wrapper">
                    <%@ include file="../include/navbar.jsp" %>
                    <div class="container-fluid d-flex">
                        <div class="col-lg-12 w-100">
                          
                            
                            <div class="btn-group mb-3">
                                <a href="${pageContext.request.contextPath}/admin/ManageUsers?action=allUser" class="btn btn-secondary" role="button">List all users</a>
                                <a href="${pageContext.request.contextPath}/admin/ManageUsers?action=unBanUser" class="btn btn-secondary" role="button">List users banned</a>
                                <a href="${pageContext.request.contextPath}/admin/ManageUsers?action=listManager" class="btn btn-secondary" role="button">List manager</a>
                                <a href="${pageContext.request.contextPath}/admin/ManageUsers?action=approveManager" class="btn btn-secondary" role="button">Approve manager</a>
                            </div>
                            <div id="report-sections">
                                <div id="reported-posts-section">
                                    <h2>List all manager</h2>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Avatar</th>
                                                <th>User Name</th>
                                                <th>User Role</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${empty managers}">
                                                <tr>
                                                    <td colspan="4">
                                                        <p>There aren't any manager.</p>
                                                    </td>
                                                </tr>
                                            </c:if>
                                            <c:forEach var="user" items="${managers}">
                                                <tr>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/profile?username=${user.username}" class="me-3">
                                                            <img src="${pageContext.request.contextPath}/${user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                        </a>
                                                    </td>
                                                    <td>${user.username}</td>
                                                    <td>${user.userRole}</td>
                                                    <td>
                                                        <div class="dropdown">
                                                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton_${user.userId}" data-bs-toggle="dropdown" aria-expanded="false">
                                                                Actions
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                                
                                                              
                                                                    <li>
                                                                        <form id="revokeManagerForm_${user.userId}" action="${pageContext.request.contextPath}/admin/ManageUsers" method="post">
                                                                            <input type="hidden" name="userId" value="${user.userId}">
                                                                            <input type="hidden" name="action" value="revokeM">
                                                                            <button type="button" class="dropdown-item" onclick="confirmRevoke('revokeManagerForm_${user.userId}')">Revoke manager</button>
                                                                        </form>
                                                                    </li>
                                                             
                                                                <li>
                                                                    <form id="banUserForm_${user.userId}" action="${pageContext.request.contextPath}/admin/ManageUsers" method="post">
                                                                        <input type="hidden" name="userId" value="${user.userId}">
                                                                        <input type="hidden" name="action" value="banUser">
                                                                        <button type="button" class="dropdown-item" onclick="confirmBan('banUserForm_${user.userId}')">Ban</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    <%@ include file="../include/footer.jsp" %>

    <script>
        document.addEventListener("DOMContentLoaded", function (event) {
            var msg = "${sessionScope.msg}";
            console.log("Message from session:", msg);
            if (msg !== null && msg !== "") {
                swal({
                    title: msg.includes("successfully") ? "Success" : "Error",
                    text: msg,
                    icon: msg.includes("successfully") ? "success" : "error",
                    button: "OK!"
                });
                <% session.removeAttribute("msg"); %>
            }
        });

        

        function confirmBan(formId) {
            if (confirm("Bạn có chắc chắn muốn thực hiện hành động này?")) {
                document.getElementById(formId).submit();
            }
        }

        function confirmUnban(formId) {
            if (confirm("Bạn có chắc chắn muốn unban user này?")) {
                document.getElementById(formId).submit();
            }
        }

        function confirmRevoke(formId) {
            if (confirm("Bạn có chắc chắn muốn thu hồi quyền manager của người dùng này?")) {
                document.getElementById(formId).submit();
            }
        }
    </script>
</body>
