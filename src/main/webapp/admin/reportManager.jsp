<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
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
                            <h2>Danh sách các báo cáo</h2>
                            <!-- Nút chuyển đổi giữa các danh sách báo cáo -->
                            <div class="btn-group mb-3">
                                <button id="btn-show-all-reports" type="button" class="btn btn-secondary">Hiển thị tất cả báo cáo</button>
                                <button id="btn-show-reported-posts" type="button" class="btn btn-secondary">Bài viết bị báo cáo của manager</button>
                                <button id="btn-show-reported-users" type="button" class="btn btn-secondary">Manager bị báo cáo</button>
                            </div>
                            <div id="report-sections">
                                <!-- Danh sách các báo cáo bài viết -->
                                <div id="reported-posts-section">
                                    <h2>Danh sách các bài viết của manager bị báo cáo</h2>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Avatar</th>
                                                <th>Chủ bài viết</th>
                                                <th>Bài viết</th>
                                                <th>Lý do</th>
                                                <th>Trạng thái</th>
                                                <th> Action </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${empty allPostReportsM}">
                                            <p>
                                                There aren't any reports.</p>
                                            </c:if>
                                            <c:forEach var="report" items="${allPostReportsM}">
                                            <tr>
                                                <td>       
                                                    <a href="${pageContext.request.contextPath}/profile?username=${report.user.username}" class="me-3">
                                                        <img src="${pageContext.request.contextPath}/${report.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                    </a>
                                                </td>
                                                <td>${report.user.username}</td>
                                                <td>${report.post.content}</td>
                                                <td>${report.reason}</td>
                                                <td>${report.status}</td>
                                                <td>
                                                    <div class="dropdown">
                                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton_${report.post.postId}" data-bs-toggle="dropdown" aria-expanded="false">
                                                            Actions
                                                        </button>
                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton_${report.post.postId}">
                                                            <li>
                                                                <form id="banPostForm_${report.post.postId}" action="${pageContext.request.contextPath}/admin/handelRpManager" method="post">
                                                                    <input type="hidden" name="postId" value="${report.post.postId}">
                                                                    <input type="hidden" name="action" value="banPost">
                                                                    <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#banPostModal_${report.post.postId}">Ban bài viết</button>
                                                                </form>
                                                            </li>
                                                            <li>
                                                                <form id="banUserForm_${report.user.userId}" action="${pageContext.request.contextPath}/admin/handelRpManager" method="post">
                                                                    <input type="hidden" name="userId" value="${report.user.userId}">
                                                                    <input type="hidden" name="action" value="banUser">
                                                                    <button type="button" class="dropdown-item" onclick="confirmBan('banUserForm_${report.user.userId}')">Ban manager</button>
                                                                </form>
                                                            </li>
                                                            <li>
                                                                <form id="revokeManagerForm_${report.user.userId}" action="${pageContext.request.contextPath}/admin/handelRpManager" method="post">
                                                                    <input type="hidden" name="userId" value="${report.user.userId}">
                                                                    <input type="hidden" name="action" value="revokeM">
                                                                    <button type="button" class="dropdown-item" onclick="confirmRevoke('revokeManagerForm_${report.user.userId}')">Revoke manager</button>
                                                                </form>
                                                            </li>
                                                            <li>
                                                                <form id="cancelReportPostForm_${report.post.postId}" action="${pageContext.request.contextPath}/admin/handelRpManager" method="post">
                                                                    <input type="hidden" name="postId" value="${report.post.postId}">
                                                                    <input type="hidden" name="action" value="cancelReportMgP">
                                                                    <button type="button" class="dropdown-item" onclick="confirmCancel('cancelReportPostForm_${report.post.postId}')">Cancel Report</button>
                                                                </form>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <div class="modal fade" id="banPostModal_${report.post.postId}" tabindex="-1" aria-labelledby="banPostModalLabel_${report.post.postId}" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="banPostModalLabel_${report.post.postId}">Nhập lý do cấm bài viết</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form id="banPostFormReason_${report.post.postId}" action="${pageContext.request.contextPath}/admin/handelRpManager" method="post">
                                                                <input type="hidden" name="postId" value="${report.post.postId}">
                                                                <input type="hidden" name="action" value="banPost">
                                                                <div class="mb-3">
                                                                    <label for="banReason_${report.post.postId}" class="form-label">Lý do cấm bài viết:</label>
                                                                    <textarea class="form-control" id="banReason_${report.post.postId}" name="banReason" rows="3" required></textarea>
                                                                </div>
                                                            </form>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                            <button type="submit" form="banPostFormReason_${report.post.postId}" class="btn btn-danger">Cấm bài viết</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Danh sách các báo cáo người dùng -->
                                <div id="reported-users-section" style="display: none;">
                                    <h2>Danh sách các manager bị báo cáo</h2>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Avatar</th>
                                                <th>Tên người dùng</th>
                                                <th>Lý do</th>
                                                <th>Trạng thái</th>
                                                <th> Action </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${empty allUserReportsM}">
                                            <p>
                                                There aren't any reports.</p>
                                            </c:if>
                                            <c:forEach var="report" items="${allUserReportsM}">
                                            <tr>
                                                <td>       
                                                    <a href="${pageContext.request.contextPath}/profile?username=${report.user.username}" class="me-3">
                                                        <img src="${pageContext.request.contextPath}/${report.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                    </a>
                                                </td>

                                                <td>${report.user.username}</td>
                                                <td>${report.reason}</td>
                                                <td>${report.status}</td>
                                                <td>
                                                    <div class="dropdown">
                                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton_${report.user.userId}" data-bs-toggle="dropdown" aria-expanded="false">
                                                            Actions
                                                        </button>
                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton_${report.user.userId}">
                                                            <li>
                                                                <form id="banUserForm_${report.user.userId}" action="${pageContext.request.contextPath}/admin/handelRpManager" method="post">
                                                                    <input type="hidden" name="userId" value="${report.user.userId}">
                                                                    <input type="hidden" name="action" value="banUser">
                                                                    <button type="button" class="dropdown-item" onclick="confirmBan('banUserForm_${report.user.userId}')">Ban manager</button>
                                                                </form>
                                                            </li>
                                                            <li>
                                                                <form id="revokeManagerForm_${report.user.userId}" action="${pageContext.request.contextPath}/admin/handelRpManager" method="post">
                                                                    <input type="hidden" name="userId" value="${report.user.userId}">
                                                                    <input type="hidden" name="action" value="revokeM">
                                                                    <button type="button" class="dropdown-item" onclick="confirmRevoke('revokeManagerForm_${report.user.userId}')">Revoke manager</button>
                                                                </form>
                                                            </li>
                                                            <li>
                                                                <form id="cancelReportUserForm_${report.user.userId}" action="${pageContext.request.contextPath}/admin/handelRpManager" method="post">
                                                                    <input type="hidden" name="userId" value="${report.user.userId}">
                                                                    <input type="hidden" name="action" value="cancelReportMgU">
                                                                    <button type="button" class="dropdown-item" onclick="confirmCancel('cancelReportUserForm_${report.user.userId}')">Cancel Report</button>
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
            // Ensure your DOM is fully loaded before executing any code
            var msg = "${sessionScope.msg}";
            console.log("Message from session:", msg);
            // Kiểm tra nếu msg không rỗng, hiển thị thông báo
            if (msg !== null && msg !== "") {
                swal({
                    title: msg.includes("successfully") ? "Success" : "Error",
                    text: msg,
                    icon: msg.includes("successfully") ? "success" : "error",
                    button: "OK!"
                });
                // Xóa msg sau khi hiển thị để tránh hiển thị lại khi tải lại trang
        <% session.removeAttribute("msg"); %>
            }
        });
        // JavaScript để điều khiển hiển thị các danh sách báo cáo
        document.addEventListener("DOMContentLoaded", function () {
            // Hiển thị danh sách người dùng bị báo cáo khi trang được tải
            document.getElementById("reported-users-section").style.display = "block";

            // Xử lý khi bấm vào các mục 'Người dùng bị báo cáo', 'Bài viết bị báo cáo'
            document.getElementById("btn-show-reported-users").addEventListener("click", function () {
                document.getElementById("reported-users-section").style.display = "block";
                document.getElementById("reported-posts-section").style.display = "none";
            });

            document.getElementById("btn-show-reported-posts").addEventListener("click", function () {
                document.getElementById("reported-users-section").style.display = "none";
                document.getElementById("reported-posts-section").style.display = "block";
            });

            // Xử lý khi bấm vào nút 'Hiển thị tất cả báo cáo'
            document.getElementById("btn-show-all-reports").addEventListener("click", function () {
                document.getElementById("reported-users-section").style.display = "block";
                document.getElementById("reported-posts-section").style.display = "block";
            });
        });

        function confirmBan(formId) {
            if (confirm("Bạn có chắc chắn muốn thực hiện hành động này?")) {
                document.getElementById(formId).submit();
            }
        }

        function confirmCancel(formId) {
            if (confirm("Are you sure you want to cancel this report?")) {
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
