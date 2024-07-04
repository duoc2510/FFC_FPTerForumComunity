<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <style>
                .notification-item {
                    display: flex;
                    align-items: center;
                    padding: 10px;
                    border-bottom: 1px solid #ddd;
                    background-color: #fff;
                    margin-bottom: 10px;
                    border-radius: 4px;
                    flex-direction: row;
                    border: none;
                }

                .notification-item .content {
                    flex-grow: 1;
                }

                .notification-item .content .message {
                    margin: 0;
                    font-weight: bold;
                }

                .notification-item .content .date {
                    font-size: 0.8em;
                    color: #888;
                }

                .notification-item .status {
                    margin-left: 10px;
                }

                .notification-item .status .status-icon {
                    width: 10px;
                    height: 10px;
                    border-radius: 50%;
                    background-color: blue;
                }

                .tab-content {
                    display: none;
                }

                .tab-content.active {
                    display: block;
                }

                .nav-tabs .nav-link.active {
                    background-color: #007bff !important;
                    color: #fff !important;
                    border-radius: 4px;
                }

                .nav-tabs .nav-link {
                    color: #007bff !important;
                }
            </style>
            </head>
            <div class="container-fluid">
                <div class="notification-container card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h2 class="card-title mb-0">Thông báo</h2>
                    </div>
                    <ul class="nav nav-tabs card-header-tabs my-3  justify-content-center" style="width: 100%; margin-left: 0.09px;">
                        <li class="nav-item">
                            <button class="nav-link active tab-link" onclick="openTab(event, 'all')">Tất cả</button>
                        </li>
                        <li class="nav-item">
                            <button class="nav-link tab-link" onclick="openTab(event, 'unread')">Chưa đọc</button>
                        </li>
                    </ul>
                    <div class="card-body">
                        <div id="all" class="tab-content active">
                            <ul class="notification-list list-group">
                                <c:choose>
                                    <c:when test="${empty Shop_DB.getAllNotificationsbyUSERID(USER.userId)}">
                                        <p class="no-notifications">There are no notifications.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="notification" items="${Shop_DB.getAllNotificationsbyUSERID(USER.userId)}">
                                            <li class="notification-item list-group-item">
                                                <div class="content">
                                                    <a style="color: black;" href="#" class="message" onclick="updateNotificationStatus(event, ${notification.notificationId}, '/FPTer${notification.notification_link}')">${notification.message}</a>
                                                    <p class="date">${notification.date}</p>
                                                </div>
                                                <div class="status">
                                                    <c:if test="${notification.status eq 'Unread'}">
                                                        <div class="status-icon"></div>
                                                    </c:if>
                                                    <c:if test="${notification.status eq 'Read'}">
                                                        <button class="btn btn-sm btn-danger delete-notification" onclick="deleteNotification(event, ${notification.notificationId})">
                                                            X
                                                        </button>
                                                    </c:if>

                                                </div>
                                            </li>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                        <div id="unread" class="tab-content">
                            <ul class="notification-list list-group">
                                <c:choose>
                                    <c:when test="${empty Shop_DB.getUnreadNotificationsByUserId(USER.userId)}">
                                        <p class="no-notifications">You have read all the notifications.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="notification" items="${Shop_DB.getUnreadNotificationsByUserId(USER.userId)}">
                                            <c:if test="${notification.status eq 'Unread'}">
                                                <li class="notification-item list-group-item">
                                                    <div class="content">
                                                        <a style="color: black;" href="#" class="message" onclick="updateNotificationStatus(event, ${notification.notificationId}, '/FPTer${notification.notification_link}')">${notification.message}</a>
                                                        <p class="date">${notification.date}</p>
                                                    </div>
                                                    <div class="status">
                                                        <div class="status-icon"></div>
                                                    </div>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <script>
                                                            function openTab(event, tabName) {
                                                                var i, tabcontent, tablinks;
                                                                tabcontent = document.getElementsByClassName("tab-content");
                                                                for (i = 0; i < tabcontent.length; i++) {
                                                                    tabcontent[i].classList.remove("active");
                                                                }
                                                                tablinks = document.getElementsByClassName("tab-link");
                                                                for (i = 0; i < tablinks.length; i++) {
                                                                    tablinks[i].classList.remove("active");
                                                                }
                                                                document.getElementById(tabName).classList.add("active");
                                                                event.currentTarget.classList.add("active");
                                                            }

                                                            // Function to update notification status
                                                            function updateNotificationStatus(event, notificationId, link) {
                                                                event.preventDefault();  // Prevent the default link navigation
                                                                $.ajax({
                                                                    url: '<%= request.getContextPath() %>/notifications',
                                                                    method: 'POST',
                                                                    data: {notificationId: notificationId},
                                                                    success: function (response) {
                                                                        console.log('Notification status updated successfully.');
                                                                        // Manually navigate to the link after the AJAX call is successful
                                                                        window.location.href = link;
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        console.error('Failed to update notification status:', error);
                                                                        // Optionally navigate to the link even if the AJAX call fails
                                                                        window.location.href = link;
                                                                    }
                                                                });
                                                            }

                                                            // Function to delete notification
                                                            function deleteNotification(event, notificationId) {
                                                                event.stopPropagation();  // Stop event bubbling
                                                                event.preventDefault();   // Prevent the default link navigation

                                                                if (confirm("Bạn có chắc chắn muốn xóa thông báo này không?")) {
                                                                    $.ajax({
                                                                        url: '<%= request.getContextPath() %>/allnotifications',
                                                                        method: 'POST',
                                                                        data: {notificationId: notificationId},
                                                                        success: function (response) {
                                                                            console.log('Notification deleted successfully.');
                                                                            // Optionally, update the UI to reflect the deletion
                                                                            $(event.target).closest('.notification-item').remove();
                                                                        },
                                                                        error: function (xhr, status, error) {
                                                                            console.error('Failed to delete notification:', error);
                                                                            // Handle error scenario if needed
                                                                        }
                                                                    });
                                                                }
                                                            }

            </script>
            <%--<%@ include file="../include/right-slidebar.jsp" %>--%>
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>