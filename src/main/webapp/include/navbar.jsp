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
<script type="text/javascript">
     var USER = <%= userJson %>; // Chuyển đổi chuỗi JSON thành đối tượng JavaScript
</script>

<style>

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
   
</header>


