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
                        <h2 class="card-title mb-0">Thông báo Biến Động Số Dư</h2>
                    </div>
                    <div class="card-body">
                        <div id="all" class="tab-content active">
                            <ul class="notification-list list-group">
                                <c:choose>
                                    <c:when test="${empty Shop_DB.getBalanceNotificationsByUserId(USER.userId)}">
                                        <p class="no-notifications">There are no notifications.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="notification" items="${Shop_DB.getBalanceNotificationsByUserId(USER.userId)}">
                                            <li class="notification-item list-group-item">
                                                <div class="content">
                                                    <a style="color: black;" class="message" >${notification.message}</a>
                                                    <p class="date">${notification.date}</p>
                                                </div>
                                            </li>
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

        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>