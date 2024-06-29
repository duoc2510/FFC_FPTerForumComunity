<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
    /*    .user-settings  .dropdown-menu{
            min-width: 200px !important;
        }*/
    .avatar-cover {
        width: 35px;
        height: 35px;
        object-fit: cover;
    }

    .notification-count {
        position: absolute;
        top: 10px;
        right: 10px;
        background-color: red;
        color: white;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
    }

    .notification-list {
        max-height: 300px;
        overflow-y: auto;
    }

    .notification-item {
        display: flex;
        flex-direction: column;
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }

    .notification-item .date {
        font-size: 0.8em;
        color: #888;
    }
</style>

<header class="app-header">
    <nav class="navbar navbar-expand-lg navbar-light">




        <ul class="navbar-nav w-100" style="max-width: 400px">
            <form class="d-flex" action="${pageContext.request.contextPath}/search" method="post">
                <input id="searchInput" type="text" class="form-control me-2" name="query" placeholder="Search for user name or group name" aria-label="Search" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Search for user name or group name">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
        </ul>

        <div class="navbar-collapse justify-content-end px-0" id="navbarNav">
            <ul class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
                <li class="nav-item d-block d-xl-none">
                    <a class="nav-link sidebartoggler nav-icon-hover" id="headerCollapse"
                       href="javascript:void(0)">
                        <i class="ti ti-menu-2"></i>
                    </a>
                </li>
                <c:set var="notifications" value="${Shop_DB.getAllNotificationsbyUSERID(USER.userId)}" />
                <div class="dropdown show user-settings">
                    <li class="nav-item position-relative">
                        <a class="nav-link dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="ti ti-bell-ringing"></i>
                            <div class="notification bg-primary rounded-circle"></div>
                            <span id="notificationCount" class="notification-count" style="display: none;">0</span>
                        </a>
                        <ul class="dropdown-menu notification-list" aria-labelledby="dropdownMenuLink" id="notificationList">
                            <!-- Notifications will be dynamically loaded here -->
                        </ul>
                    </li>
                </div>
                <a href="${pageContext.request.contextPath}/messenger">
                    <i class="ti ti-message-forward fs-8"></i>
                </a>

                <li class="nav-item dropdown">
                    <a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2"
                       data-bs-toggle="dropdown"
                       aria-expanded="false">
                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}" alt="" width="35"
                             class="rounded-circle avatar-cover">
                    </a>
                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2" style="min-width: 200px">
                        <div class="message-body">
                            <a href="${pageContext.request.contextPath}/profile?username=${USER.username}"
                               class="d-flex align-items-center gap-2 dropdown-item">
                                <img src="${pageContext.request.contextPath}/${USER.userAvatar}" alt=""
                                     width="40" class="rounded-circle avatar-cover">
                                <p class="mb-0 fs-6">
                                    <c:choose>
                                        <c:when test="${USER.userRole == 1}">
                                            ${USER.username}
                                        </c:when>
                                        <c:when test="${USER.userRole == 2}">
                                            Manager
                                        </c:when>
                                        <c:when test="${USER.userRole == 3}">
                                            Admin
                                        </c:when>
                                    </c:choose>
                                </p>
                            </a>
                            <a href="${pageContext.request.contextPath}/profile/setting"
                               class="d-flex align-items-center gap-2 dropdown-item">
                                <i class="ti ti-user-circle fs-6"></i>
                                <p class="mb-0 fs-3">My Account</p>
                            </a>
                            <div class="d-flex align-items-center gap-2">
                                <a href="${pageContext.request.contextPath}/payment" class="dropdown-item" id="walletLink">
                                    <p class="mb-0 fs-3" id="walletAmount">Wallet: ${USER.userWallet}</p>
                                </a>
                                <i class="ti ti-repeat" id="reloadWalletIcon" style="cursor: pointer;"></i>
                            </div>
                            <a href="${pageContext.request.contextPath}/profile/setting"
                               class="d-flex align-items-center gap-2 dropdown-item">
                                <i class="ti ti-database fs-6 "></i>
                                <p class="mb-0 fs-3">Balance Wallet</p>
                            </a>

                            <a href="${pageContext.request.contextPath}/logout"
                               class="btn btn-outline-danger mx-3 mt-2 d-block">Logout</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </nav>

    <script>
        var contextPath = '<%= request.getContextPath() %>';
        var oldNotificationCount = 0;

        $(document).ready(function () {
            var socket = new WebSocket("ws://" + window.location.host + contextPath + "/notifications");

            socket.onmessage = function (event) {
                var data = JSON.parse(event.data);
                if (data.type === "notification") {
                    loadNotifications();
                }
            };

            function loadNotifications() {
                $.ajax({
                    url: contextPath + '/notifications',
                    method: 'GET',
                    success: function (data) {
                        $('#notificationList').empty();
                        if (data.length > 0) {
                            var newNotificationCount = data.length;
                            var newNotifications = newNotificationCount - oldNotificationCount;

                            if (newNotifications != oldNotificationCount) {
                                $('#notificationCount').text(newNotifications).show();
                            } else {
                                $('#notificationCount').text(oldNotificationCount).show();
                            }
                            $('#notificationList').prepend('<li class="notification-item text-center"><p class="text-danger mb-0">Bạn có ' + newNotificationCount + ' thông báo chưa đọc</p></li>');

                            var notificationsToShow = data.slice(0, 10);
                            $.each(notificationsToShow, function (index, notification) {
                                var listItem = $('<li class="notification-item"></li>');
                                var link = $('<a class="dropdown-item" href="' + contextPath + notification.notification_link + '"></a>');
                                link.click(function () {
                                    updateNotificationStatus(notification.notificationId);
                                });
                                link.append(notification.message + '<br><span class="date">' + notification.date + '</span>');
                                listItem.append(link);
                                $('#notificationList').append(listItem);
                            });

                            $('#notificationList').append('<li class="text-center mt-2"><a href="' + contextPath + '/allnotifications" id="showMoreButton" class="btn btn-link text-decoration-none">Show All</a></li>');

                        } else {
                            $('#notificationList').empty();
                            $('#notificationCount').text(oldNotificationCount).show();
                            $('#notificationList').append('<li class="notification-item"><a class="dropdown-item" >No new notifications</a></li>');
                            $('#notificationList').append('<li class="text-center mt-2"><a href="' + contextPath + '/allnotifications" id="showMoreButton" class="btn btn-link text-decoration-none">Show All</a></li>');
                        }
                    }
                });
            }

            function updateNotificationStatus(notificationId) {
                $.ajax({
                    url: contextPath + '/notifications',
                    method: 'POST',
                    data: {notificationId: notificationId},
                    success: function (response) {
                        console.log('Notification status updated successfully.');
                    },
                    error: function (xhr, status, error) {
                        console.error('Failed to update notification status:', error);
                    }
                });
            }

            // Handle click event for reloading wallet
            $('#reloadWalletIcon').on('click', function (event) {
                event.preventDefault(); // Prevent the default action

                $.ajax({
                    url: contextPath + '/reloadwallet', // Change this to your actual endpoint
                    method: 'POST',
                    success: function (data) {
                        // Assuming the response contains the updated wallet amount
                        $('#walletAmount').text('Wallet: ' + data.newWalletAmount);
                    },
                    error: function (xhr, status, error) {
                        console.error('Failed to reload wallet:', error);
                    }
                });
            });

            $.ajax({
                url: contextPath + '/notifications',
                method: 'GET',
                success: function (data) {
                    oldNotificationCount = data.length;
                    $('#notificationCount').text(oldNotificationCount).show();
                }
            });

            loadNotifications();
//            setInterval(loadNotifications, 2000);

            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });

            $('#dropdownMenuLink').on('click', function () {
                $('#notificationCount').hide();
                oldNotificationCount = 0;
                loadNotifications();
                $.ajax({
                    url: contextPath + '/notifications',
                    method: 'GET',
                    success: function (data) {
                        oldNotificationCount = data.length;
                        $('#notificationCount').text(oldNotificationCount).show();
                    }
                });
                loadNotifications();
            });
        });

    </script>


</header>
