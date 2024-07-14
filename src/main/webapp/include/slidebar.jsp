<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<aside class="left-sidebar">
    <style>
        .sub-item{
            font-size: 13px;
            padding-left: 20px;
        }
    </style>

    <!-- Sidebar scroll-->  
    <div class="brand-logo d-flex align-items-center justify-content-between">
        <a href="${pageContext.request.contextPath}/home" class="text-nowrap logo-img">
            <img src="${pageContext.request.contextPath}/static/images/logo.png" width="100" alt="" />
        </a>
        <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
            <i class="ti ti-x fs-8"></i>
        </div>
    </div>
    <!-- Sidebar navigation-->
    <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
        <ul id="sidebarnav">
            <c:if test="${USER.userRole == 3}">
                <li class="sidebar-item">
                    <a class="rounded sidebar-link rounded has-arrow" href="javascript:void(0)" aria-expanded="false">
                        <span>
                            <i class="ti ti-users"></i>
                        </span>
                        <span class="hide-menu">Admin <i style="font-size: 13px" class="ti ti-arrow-down"></i></span>
                    </a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/ManageUsers?action=allUser" class="sidebar-link rounded" role="button">
                                <span class="hide-menu">- Manage users</span>
                            </a>
                        </li>
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/handelRpManager" class="sidebar-link rounded">
                                <span class="hide-menu">- Handle report manager</span>
                            </a>
                        </li>

                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/approveshop" class="sidebar-link rounded">
                                <span class="hide-menu">- Approve shop</span>
                            </a>
                        </li>

                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/createvoucher" class="sidebar-link rounded">
                                <span class="hide-menu">- Create voucher</span>
                            </a>
                        </li>
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/viewFeedBack" class="sidebar-link rounded">
                                <span class="hide-menu">- View feedback</span>
                            </a>
                        </li>
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/transaction" class="sidebar-link rounded">
                                <span class="hide-menu">- Transaction Manage</span>
                            </a>
                        </li>
                    </ul>
                </li>
            </c:if>
            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/post" aria-expanded="false">
                    <span>
                        <i class="ti ti-article"></i>
                    </span>
                    <span class="hide-menu">News Feed</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/group" aria-expanded="false">
                    <span>
                        <i class="ti ti-users"></i>
                    </span>
                    <span class="hide-menu">Group</span>
                </a>
            </li>

            <c:if test="${USER.userRole > 1}">
                <li class="sidebar-item">
                    <a class="sidebar-link rounded has-arrow" href="javascript:void(0)" aria-expanded="false">
                        <span>
                            <i class="ti ti-users"></i>
                        </span>
                        <span class="hide-menu">Manager <i style="font-size: 13px" class="ti ti-arrow-down"></i></span>
                    </a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/manager/post" class="sidebar-link rounded">
                                <span class="hide-menu">- Approve Post</span>
                            </a>
                        </li>
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/manager/report" class="sidebar-link rounded">
                                <span class="hide-menu">- Handle report</span>
                            </a>
                        </li>
                    </ul>
                </li>
            </c:if>

            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/listEvent" aria-expanded="false">
                    <span>
                        <i class="ti ti-calendar-event"></i>
                    </span>
                    <span class="hide-menu">Event</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/advertising" aria-expanded="false">
                    <span>
                        <i class="ti ti-speakerphone"></i>
                    </span>
                    <span class="hide-menu">Advertising</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/rank" aria-expanded="false">
                    <span>
                        <i class="ti ti-trophy"></i>
                    </span>
                    <span class="hide-menu">Rank</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/marketplace" aria-expanded="false">
                    <span>
                        <i class="ti ti-basket"></i>
                    </span>
                    <span class="hide-menu">Marketplace</span>
                </a>
            </li>
        </ul>
        <c:choose>
            <c:when test="${USER.userRank == 3 && USER.userRole == 1}">
                <%@ include file="../user/managerRegistr.jsp" %>
            </c:when>
            <c:otherwise>
                <%@ include file="../ads/showAds.jsp" %>
            </c:otherwise>
        </c:choose>
        <c:if test="${USER.userRole != 3}">
            <%@ include file="../user/feedBackModal.jsp" %>
        </c:if>

        <div class="d-flex w-100">
            <div class="swipe-mode" style="width: 65px">
                <input type="checkbox" class="checkbox" id="checkbox">
                <label for="checkbox" class="checkbox-label">
                    <i class="fas fa-moon"></i>
                    <i class="fas fa-sun"></i>
                    <span class="ball"></span>
                </label>
            </div>
            <div style="width: 50px">
                <a id="webcamButton" class="nav-link" data-bs-toggle="modal" data-bs-target="#webcamModal">
                    <svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="currentColor" class="bi bi-lightning-charge-fill" viewBox="0 0 16 16">
                    <path d="M11.251.068a.5.5 0 0 1 .227.58L9.677 6.5H13a.5.5 0 0 1 .364.843l-8 8.5a.5.5 0 0 1-.842-.49L6.323 9.5H3a.5.5 0 0 1-.364-.843l8-8.5a.5.5 0 0 1 .615-.09z"/>
                    </svg>
                </a>
            </div>
        </div>


        <!-- Webcam Modal -->
        <div class="webcam-popup modal fade" id="webcamModal" tabindex="-1" aria-labelledby="webcamModalLabel" aria-hidden="true"  data-bs-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content rounded1dot2">
                    <div class="modal-header">
                        <h3 class="modal-title" id="webcamModalLabel">Hand Tracking</h3>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <section id="demos">
                            <div class="video-container" class="mb-3" id="liveView">
                                <video id="webcam" autoplay playsinline></video>
                                <canvas class="output_canvas" id="output_canvas"></canvas>
                            </div>
                            <h3>Distance between Index and Middle Fingers: <span id="fingerDistance">0</span></h3>

                        </section>
                        <p> 1 finger to turn Dark Mode On </p>
                        <p> 3 fingers to turn Dark Mode Off </p>
                        <p> 2 fingers to scroll </p>
                        <p> 5 fingers to turn off Camera</p>

                    </div>
                </div>
            </div>
        </div>
        <!-- Webcam Modal -->


    </nav>
</aside>



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
