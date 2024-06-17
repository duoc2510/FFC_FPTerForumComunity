<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                                <button id="btn-show-reported-posts" type="button" class="btn btn-secondary">Bài viết bị báo cáo</button>
                                <button id="btn-show-reported-users" type="button" class="btn btn-secondary">Người dùng bị báo cáo</button>
                                <button id="btn-show-posts-gt-3" type="button" class="btn btn-secondary">Bài viết bị báo cáo >= 3 lần</button>
                                <button id="btn-show-users-gt-3" type="button" class="btn btn-secondary">Người dùng bị báo cáo >= 3 lần</button>
                            </div>
                            <div id="report-sections">
                                <!-- Danh sách các báo cáo bài viết -->
                                <div id="reported-posts-section">
                                    <h2>Danh sách các bài viết bị báo cáo</h2>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Avatar</th>
                                                <th>Chủ bài viết</th>
                                                <th>Bài viết</th>
                                                <th>Lý do</th>
                                                <th>Trạng thái</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:if test="${empty allPostReports}">
                                        <p>
                                            There aren't any reports.</p>
                                        </c:if>
                                            <c:forEach var="report" items="${allPostReports}">

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

                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Danh sách các báo cáo người dùng -->
                                <div id="reported-users-section" style="display: none;">
                                    <h2>Danh sách các người dùng bị báo cáo</h2>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Avatar</th>
                                                <th>Tên người dùng</th>
                                                <th>Lý do</th>
                                                <th>Trạng thái</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${empty allUserReports}">
                                        <p>
                                            There aren't any reports.</p>
                                        </c:if>
                                            <c:forEach var="report" items="${allUserReports}">
                                                <tr>
                                                    <td>       
                                                        <a href="${pageContext.request.contextPath}/profile?username=${report.user.username}" class="me-3">
                                                            <img src="${pageContext.request.contextPath}/${report.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                        </a>
                                                    </td>

                                                    <td>${report.user.username}</td>
                                                    <td>${report.reason}</td>
                                                    <td>${report.status}</td>

                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!-- Danh sách các bài viết bị báo cáo nhiều hơn hoặc bằng 3 lần -->
                            <div id="reported-posts-gt-3-section" style="display: none;">
                                <h2>Danh sách các bài viết bị báo cáo nhiều hơn hoặc bằng 3 lần</h2>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Avatar</th>
                                            <th>Chủ bài viết</th>
                                            <th>Nội dung bài viết</th>
                                            <th>Lý do</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty reportedPosts}">
                                        <p>
                                            There aren't any reports.</p>
                                        </c:if>
                                        <c:forEach var="reportedPosts" items="${reportedPosts}">
                                        <tr>
                                            <td>       
                                                <a href="${pageContext.request.contextPath}/profile?username=${reportedPosts.user.username}" class="me-3">
                                                    <img src="${pageContext.request.contextPath}/${reportedPosts.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                </a>
                                            </td>
                                            <td>${reportedPosts.user.username}</td>
                                            <td>${reportedPosts.post.content}</td>
                                            <td>${reportedPosts.reason}</td>
                                            <td>
                                                <form id="banPostForm_${reportedPosts.post.postId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                                    <input type="hidden" name="postId" value="${reportedPosts.post.postId}">
                                                    <input type="hidden" name="action" value="banPost">
                                                    <button type="button" class="btn btn-danger" onclick="confirmBan('banPostForm_${reportedPosts.post.postId}')">Ban bài viết</button>
                                                </form>
                                                <form id="banUserForm_${reportedPosts.user.userId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                                    <input type="hidden" name="userId" value="${reportedPosts.user.userId}">
                                                    <input type="hidden" name="action" value="banUser">
                                                    <button type="button" class="btn btn-danger" onclick="confirmBan('banUserForm_${reportedPosts.user.userId}')">Ban người dùng</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Danh sách các người dùng bị báo cáo nhiều hơn hoặc bằng 3 lần -->
                            <div id="reported-users-gt-3-section" style="display: none;">
                                <h2>Danh sách các người dùng bị báo cáo nhiều hơn hoặc bằng 3 lần</h2>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Avatar</th>
                                            <th>Tên người dùng</th>
                                            <th>Lý do</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty reportedUsers}">
                                       
                                        <p>There aren't any reports.</p>
                                        </c:if>
                                        <c:forEach var="reportedUsers" items="${reportedUsers}">
                                            <tr>
                                                <td>       
                                                    <a href="${pageContext.request.contextPath}/profile?username=${reportedUsers.user.username}" class="me-3">
                                                        <img src="${pageContext.request.contextPath}/${reportedUsers.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                    </a>
                                                </td>
                                                <td>${reportedUsers.user.username}</td>
                                                <td>${reportedUsers.reason}</td>
                                                <td>
                                                    <form id="banUserForm_${reportedUsers.user.userId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                                        <input type="hidden" name="userId" value="${reportedUsers.user.userId}">
                                                        <input type="hidden" name="action" value="banUser">
                                                        <button type="button" class="btn btn-danger" onclick="confirmBan('banUserForm_${reportedUsers.user.userId}')">Ban người dùng</button>
                                                    </form>
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
        </c:otherwise>
    </c:choose>
    <%@ include file="../include/footer.jsp" %>

    <script>
        // JavaScript để điều khiển hiển thị các danh sách báo cáo
        document.addEventListener("DOMContentLoaded", function () {
            // Hiển thị danh sách người dùng bị báo cáo khi trang được tải
            document.getElementById("reported-users-section").style.display = "block";

            // Xử lý khi bấm vào các mục 'Người dùng bị báo cáo', 'Bài viết bị báo cáo', 'Người dùng bị báo cáo >= 3 lần', hoặc 'Bài viết bị báo cáo >= 3 lần'
            document.getElementById("btn-show-reported-users").addEventListener("click", function () {
                document.getElementById("reported-users-section").style.display = "block";
                document.getElementById("reported-posts-section").style.display = "none";
                document.getElementById("reported-posts-gt-3-section").style.display = "none";
                document.getElementById("reported-users-gt-3-section").style.display = "none";
            });

            document.getElementById("btn-show-reported-posts").addEventListener("click", function () {
                document.getElementById("reported-users-section").style.display = "none";
                document.getElementById("reported-posts-section").style.display = "block";
                document.getElementById("reported-posts-gt-3-section").style.display = "none";
                document.getElementById("reported-users-gt-3-section").style.display = "none";
            });

            document.getElementById("btn-show-users-gt-3").addEventListener("click", function () {
                document.getElementById("reported-users-section").style.display = "none";
                document.getElementById("reported-posts-section").style.display = "none";
                document.getElementById("reported-posts-gt-3-section").style.display = "none";
                document.getElementById("reported-users-gt-3-section").style.display = "block";
            });

            document.getElementById("btn-show-posts-gt-3").addEventListener("click", function () {
                document.getElementById("reported-users-section").style.display = "none";
                document.getElementById("reported-posts-section").style.display = "none";
                document.getElementById("reported-posts-gt-3-section").style.display = "block";
                document.getElementById("reported-users-gt-3-section").style.display = "none";
            });

            // Xử lý khi bấm vào nút 'Hiển thị tất cả báo cáo'
            document.getElementById("btn-show-all-reports").addEventListener("click", function () {
                document.getElementById("reported-users-section").style.display = "block";
                document.getElementById("reported-posts-section").style.display = "block";
                document.getElementById("reported-posts-gt-3-section").style.display = "none";
                document.getElementById("reported-users-gt-3-section").style.display = "none";
            });
        });
        function confirmBan(formId) {
            if (confirm("Bạn có chắc chắn muốn thực hiện hành động này không?")) {
                document.getElementById(formId).submit();
            }
        }
    </script>
</body>
