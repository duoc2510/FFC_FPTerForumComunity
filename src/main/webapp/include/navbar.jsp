<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%
// Lấy đối tượng USER từ session
User user = (User) session.getAttribute("USER");
// Chuyển đối tượng USER thành chuỗi JSON
String userJson = new Gson().toJson(user);
%>

     <style>
        #searchDropdown {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            z-index: 1000;
            display: none;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
            max-height: 200px;
            overflow-y: auto;
            width: 190px; /* Adjust this value as needed */
        }

        #searchDropdown .list-group-item {
            padding: 10px;
            cursor: pointer;
        }

        #searchDropdown .list-group-item:hover {
            background-color: #f1f1f1;
        }
        
        .non-clickable {
            background-color: #f8f9fa;
            pointer-events: none;
            color: #6c757d;
            cursor: default;
        }

        .non-clickable:hover {
            background-color: #f8f9fa; /* Không đổi màu khi hover */
        }

        .history-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .history-item .close-btn {
            color: red;
            cursor: pointer;
            margin-left: 10px;
        }
    </style>

<header class="app-header border-bottom">
    <nav class="navbar navbar-expand-lg navbar-light">

        <ul class="navbar-nav w-100" style="max-width: 400px; position: relative;">
            <form class="d-flex" action="${pageContext.request.contextPath}/search" method="post">
                <input id="searchInput" type="text" class="form-control me-2 rounded" name="query" placeholder="Search for user name or group name" aria-label="Search" data-bs-toggle="tooltip" data-bs-placement="bottom">
                <button class="btn btn-outline-success rounded" type="submit">Search</button>
            </form>
            <div id="searchDropdown" class="list-group position-absolute" style="max-height: 200px; overflow-y: auto; display: none;"></div>
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
                        <ul class="dropdown-menu notification-list rounded mt-2" aria-labelledby="dropdownMenuLink" id="notificationList">
                            <!-- Notifications will be dynamically loaded here -->
                        </ul>
                    </li>
                </div>
                <a href="${pageContext.request.contextPath}/messenger">
                    <i class="ti ti-message-forward fs-8"></i>
                </a>

                <li class="nav-item dropdown ">
                    <a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2"
                       data-bs-toggle="dropdown"
                       aria-expanded="false">
                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}" alt="" width="35"
                             class="rounded-circle avatar-cover">
                    </a>
                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up rounded mt-2" aria-labelledby="drop2" style="min-width: 200px">
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
                                <a href="${pageContext.request.contextPath}/wallet" class="dropdown-item d-flex" id="walletLink">
                                      <i class="ti ti-database fs-6 "></i><p class="mb-0 ms-2 fs-3" id="walletAmount"> ${USER.userWallet}</p>
                                </a>
                                <i class="ti ti-repeat" class="position-absolute p-1" id="reloadWalletIcon" style="cursor: pointer;"></i>
                            </div>
                            <a href="${pageContext.request.contextPath}/walletbalance"
                               class="d-flex align-items-center gap-2 dropdown-item">
                                <i class="ti ti-database fs-6 "></i>
                                <p class="mb-0 fs-3">Balance Wallet</p>
                            </a>

                            <a href="${pageContext.request.contextPath}/logout"
                               class="btn btn-outline-danger mx-3 mt-2 d-block rounded">Logout</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>


    </nav>
    <script type="text/javascript">
        var USER = <%= userJson %>; // Chuyển đổi chuỗi JSON thành đối tượng JavaScript
    </script>
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
                            $('#notificationList').prepend('<li class="notification-item px-4 pb-3 border-bottom"><p class="text-danger mb-0">Bạn có ' + newNotificationCount + ' thông báo chưa đọc</p> <a href="' + contextPath + '/allnotifications"><p class="text-primary ">Show all</p></a></li>');
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
                                  } else {
                            $('#notificationList').empty();
                            $('#notificationCount').text(oldNotificationCount).show();
                            $('#notificationList').append('<li class="notification-item"><a class="dropdown-item" >No new notifications</a></li>');
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
        $(document).ready(function () {
            var userId = USER.userId; // Sử dụng USER.userId trực tiếp
            var searchInput = $('#searchInput');
            var searchDropdown = $('#searchDropdown');
            var searchHistoryKey = 'searchHistory_' + userId;

            // Load search history from localStorage
            var searchHistory = JSON.parse(localStorage.getItem(searchHistoryKey)) || [];
            console.log("Loaded search history for user " + userId + ":", searchHistory);

            // Function to save search query to search history
            function saveToSearchHistory(query) {
                // Remove query if already exists to maintain uniqueness
                var index = searchHistory.indexOf(query);
                if (index !== -1) {
                    searchHistory.splice(index, 1);
                }
                // Add query to beginning of search history
                searchHistory.unshift(query);
                // Limit search history to 7 items
                if (searchHistory.length > 7) {
                    searchHistory.pop();
                }
                // Save updated search history to localStorage
                localStorage.setItem(searchHistoryKey, JSON.stringify(searchHistory));
                console.log("Updated search history for user " + userId + ":", searchHistory);
            }

            // Function to render search history dropdown
            function renderSearchHistory() {
                console.log("Rendering search history for user " + userId + ":", searchHistory);
                searchDropdown.empty();

                // Add "History" title
             

                searchHistory.forEach(function (query) {
                    searchDropdown.append('<div class="list-group-item history-item">' +
                            '<span class="query-text">' + query + '</span>' +
                            '<span class="close-btn">&times;</span>' +
                            '</div>');
                });
                searchDropdown.show();
            }

            // Function to perform search suggestions
            function performSearch(query) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/searchSuggestions',
                    type: 'GET',
                    data: {query: query},
                    success: function (data) {
                        try {
                            var suggestions = JSON.parse(data);
                            searchDropdown.empty();
                            suggestions.forEach(function (user) {
                                searchDropdown.append('<a href="${pageContext.request.contextPath}/profile?username=' + user.username + '" class="list-group-item list-group-item-action">' + user.userFullName + '</a>');
                            });
                            searchDropdown.show();
                        } catch (e) {
                            console.error('JSON parse error: ', e);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('AJAX request error: ', status, error);
                    }
                });
            }

            // Event handler for search input focus
            searchInput.on('focus', function () {
                console.log("Search input focused");
                if (searchHistory.length > 0) {
                    renderSearchHistory();
                } else {
                    console.log("No search history to show");
                }
            });

            // Event handler for typing in search input
            searchInput.on('input', function () {
                var query = $(this).val();
                console.log("Search input value:", query);
                if (query.length > 1) {
                    performSearch(query);
                } else {
                    searchDropdown.hide();
                }
            });

            // Event delegation for clicking on history items and close buttons
            $(document).on('click', '.history-item', function (event) {
                var target = $(event.target);
                if (target.hasClass('close-btn')) {
                    // Handle delete history item
                    var query = target.siblings('.query-text').text().trim();
                    searchHistory = searchHistory.filter(function (item) {
                        return item !== query;
                    });
                    localStorage.setItem(searchHistoryKey, JSON.stringify(searchHistory));
                    renderSearchHistory();
                } else {
                    event.preventDefault();
                    var query = $(this).find('.query-text').text().trim();
                    searchInput.val(query);
                    saveToSearchHistory(query); // Save selected history item to history
                    performSearch(query); // Perform search based on selected history item
                    searchDropdown.hide();
                }
            });

            // Click handler to hide dropdown when clicking outside searchInput and searchDropdown
            $(document).click(function (event) {
                if (!$(event.target).closest('#searchInput, #searchDropdown').length) {
                    searchDropdown.hide();
                }
            });

            // Event handler for search form submission to save the query
            $('.d-flex').on('submit', function (event) {
                var query = searchInput.val().trim();
                if (query.length > 0) {
                    saveToSearchHistory(query);
                }
            });
        });






    </script>

</header>
