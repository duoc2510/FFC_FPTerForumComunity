<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>
    <title>Search Results</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .avatar-cover {
            object-fit: cover;
            height: 35px;
            width: 35px;
        }
        .event-img {
            height: 150px;
            object-fit: cover;
        }
        .group-link {
            text-decoration: none;
            color: inherit;
        }
        .group-link:hover {
            text-decoration: underline;
        }
    </style>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">

        <c:choose>
            <c:when test="${empty sessionScope.USER}">
                <%@ include file="../include/slidebar_guest.jsp" %>
            </c:when>
            <c:otherwise>
                <%@ include file="../include/slidebar.jsp" %>
            </c:otherwise>
        </c:choose>

        <div class="body-wrapper">
            <c:choose>
                <c:when test="${empty sessionScope.USER}">
                    <%@ include file="../include/navbar_guest.jsp" %>
                </c:when>
                <c:otherwise>
                    <%@ include file="../include/navbar.jsp" %>
                </c:otherwise>
            </c:choose>

            <div class="container-fluid d-flex">
                <div class="container mt-4">
                    <h2>Search Results</h2>

                    <div class="btn-group mb-4">
                        <button id="allButton" class="btn btn-primary">All</button>
                        <button id="usersButton" class="btn btn-secondary">Users</button>
                        <button id="groupsButton" class="btn btn-secondary">Groups</button>
                        <button id="usernameButton" class="btn btn-secondary">Usernames</button>
                    </div>
                    <div id="results">
                        <c:if test="${empty filteredUsername && empty filteredUsers && empty filteredGroups}">
                             <p>Don't have any result.</p>
                            </c:if>
                        <div id="allResults">
                            <!-- User List -->
                            <c:forEach var="user" items="${filteredUsers}">
                                <div class="card mb-3">
                                    <div class="card-body d-flex align-items-center">
                                        <a href="${pageContext.request.contextPath}/profile?username=${user.username}" class="me-3">
                                            <img src="${pageContext.request.contextPath}/${user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                        </a>
                                        <div class="me-3">
                                            <h5 class="card-title mb-0">${user.userFullName}</h5>
                                        </div>
                                        <div class="flex-grow-1">
                                            <ul class="list-inline mb-0">
                                                <c:choose>
                                                    <c:when test="${user.userId == USER.userId}"></c:when>
                                                    <c:when test="${user.isPending}">
                                                        <div class="dropdown d-inline">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Request Sent
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmCancel()">
                                                                        <input type="hidden" name="friendId" value="${user.userId}">
                                                                        <input type="hidden" name="friendName" value="${user.username}">
                                                                        <input type="hidden" name="action" value="cancelFrSearch">
                                                                        <button type="submit" class="dropdown-item">Cancel Request</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${user.isPendingRq}">
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="acceptFrSearch">
                                                            <button type="submit" class="btn btn-success btn-sm btn-block edit-cover mx-2">Accept Friend</button>
                                                        </form>
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="denyFrSearch">
                                                            <button type="submit" class="btn btn-danger btn-sm btn-block edit-cover mx-2">Deny Friend</button>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${user.isApproved}">
                                                        <div class="dropdown d-inline dropup">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Friends
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmUnfriend()">
                                                                        <input type="hidden" name="friendId" value="${user.userId}">
                                                                        <input type="hidden" name="friendName" value="${user.username}">
                                                                        <input type="hidden" name="action" value="unfriendSearch">
                                                                        <button type="submit" class="dropdown-item">Unfriend</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form id="addFriendForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="addFrSearch">
                                                            <button type="submit" class="btn btn-primary btn-sm btn-block edit-cover mx-2">Add Friend</button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- Group List -->
                            <div class="row">
                                <c:forEach var="group" items="${filteredGroups}">
                                    <div class="card col-md-3 m-2">
                                        <img src="${pageContext.request.contextPath}/${group.image}" class="card-img-top event-img" alt="...">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <a href="group/detail?groupId=${group.groupId}" class="group-link">${group.groupName}</a>
                                            </h5>
                                            <p class="card-text">${group.groupDescription}</p>
                                            <p class="card-text">Members: ${group.memberCount}</p>
                                            <c:choose>
                                                <c:when test="${group.pending}">
                                                    <button class="btn btn-secondary w-100 mt-3" disabled>Pending approval</button>
                                                </c:when>
                                                <c:when test="${group.isBanned}">
                                                    <button class="btn btn-danger w-100 mt-3" disabled>You have been banned</button>
                                                </c:when>
                                                <c:when test="${group.isApproved or group.createrId == USER.userId}">
                                                    <a href="group/detail?groupId=${group.groupId}" class="btn btn-info w-100 mt-3">Access Group</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="group/detail?groupId=${group.groupId}" class="btn btn-primary w-100 mt-3">Join Group</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="row">
                           
                            <c:forEach var="username" items="${filteredUsername}">
                                <div class="card mb-3">
                                    <div class="card-body d-flex align-items-center">
                                        <a href="${pageContext.request.contextPath}/profile?username=${username.username}" class="me-3">
                                            <img src="${pageContext.request.contextPath}/${username.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                        </a>
                                        <div class="me-3">
                                            <h5 class="card-title mb-0">${username.userFullName}</h5>
                                        </div>
                                        <div class="flex-grow-1">
                                            <ul class="list-inline mb-0">
                                                <c:choose>
                                                    <c:when test="${username.userId == USER.userId}"></c:when>
                                                    <c:when test="${username.isPending}">
                                                        <div class="dropdown d-inline">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Request Sent
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmCancel()">
                                                                        <input type="hidden" name="friendId" value="${username.userId}">
                                                                        <input type="hidden" name="friendName" value="${username.username}">
                                                                        <input type="hidden" name="action" value="cancelFrSearch">
                                                                        <button type="submit" class="dropdown-item">Cancel Request</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${username.isPendingRq}">
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${username.userId}">
                                                            <input type="hidden" name="friendName" value="${username.username}">
                                                            <input type="hidden" name="action" value="acceptFrSearch">
                                                            <button type="submit" class="btn btn-success btn-sm btn-block edit-cover mx-2">Accept Friend</button>
                                                        </form>
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${username.userId}">
                                                            <input type="hidden" name="friendName" value="${username.username}">
                                                            <input type="hidden" name="action" value="denyFrSearch">
                                                            <button type="submit" class="btn btn-danger btn-sm btn-block edit-cover mx-2">Deny Friend</button>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${username.isApproved}">
                                                        <div class="dropdown d-inline dropup">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Friends
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmUnfriend()">
                                                                        <input type="hidden" name="friendId" value="${username.userId}">
                                                                        <input type="hidden" name="friendName" value="${username.username}">
                                                                        <input type="hidden" name="action" value="unfriendSearch">
                                                                        <button type="submit" class="dropdown-item">Unfriend</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form id="addFriendForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${username.userId}">
                                                            <input type="hidden" name="friendName" value="${username.username}">
                                                            <input type="hidden" name="action" value="addFrSearch">
                                                            <button type="submit" class="btn btn-primary btn-sm btn-block edit-cover mx-2">Add Friend</button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                            
                            
                        </div>
                      
                        <div id="userResults" class="d-none">
                            <c:if test="${empty filteredUsers}">
                                <p>Don't have any users you are looking for.</p>
                            </c:if>
                            <c:forEach var="user" items="${filteredUsers}">
                                <div class="card mb-3">
                                    <div class="card-body d-flex align-items-center">
                                        <a href="${pageContext.request.contextPath}/profile?username=${user.username}" class="me-3">
                                            <img src="${pageContext.request.contextPath}/${user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                        </a>
                                        <div class="me-3">
                                            <h5 class="card-title mb-0">${user.userFullName}</h5>
                                        </div>
                                        <div class="flex-grow-1">
                                            <ul class="list-inline mb-0">
                                                <c:choose>
                                                    <c:when test="${user.userId == USER.userId}"></c:when>
                                                    <c:when test="${user.isPending}">
                                                        <div class="dropdown d-inline">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Request Sent
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmCancel()">
                                                                        <input type="hidden" name="friendId" value="${user.userId}">
                                                                        <input type="hidden" name="friendName" value="${user.username}">
                                                                        <input type="hidden" name="action" value="cancelFrSearch">
                                                                        <button type="submit" class="dropdown-item">Cancel Request</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${user.isPendingRq}">
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="acceptFrSearch">
                                                            <button type="submit" class="btn btn-success btn-sm btn-block edit-cover mx-2">Accept Friend</button>
                                                        </form>
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="denyFrSearch">
                                                            <button type="submit" class="btn btn-danger btn-sm btn-block edit-cover mx-2">Deny Friend</button>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${user.isApproved}">
                                                        <div class="dropdown d-inline dropup">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Friends
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmUnfriend()">
                                                                        <input type="hidden" name="friendId" value="${user.userId}">
                                                                        <input type="hidden" name="friendName" value="${user.username}">
                                                                        <input type="hidden" name="action" value="unfriendSearch">
                                                                        <button type="submit" class="dropdown-item">Unfriend</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form id="addFriendForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="addFrSearch">
                                                            <button type="submit" class="btn btn-primary btn-sm btn-block edit-cover mx-2">Add Friend</button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div id="groupResults" class="d-none">
                            <c:if test="${empty filteredGroups}">
                                <p>Don't have any groups you are looking for.</p>
                            </c:if>
                            <div class="row">
                                <c:forEach var="group" items="${filteredGroups}">
                                    <div class="card col-md-3 m-2">
                                        <img src="${pageContext.request.contextPath}/${group.image}" class="card-img-top event-img" alt="...">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <a href="group/detail?groupId=${group.groupId}" class="group-link">${group.groupName}</a>
                                            </h5>
                                            <p class="card-text">${group.groupDescription}</p>
                                            <p class="card-text">Members: ${group.memberCount}</p>
                                            <c:choose>
                                                <c:when test="${group.pending}">
                                                    <button class="btn btn-secondary w-100 mt-3" disabled>Pending approval</button>
                                                </c:when>
                                                <c:when test="${group.isBanned}">
                                                    <button class="btn btn-danger w-100 mt-3" disabled>You have been banned</button>
                                                </c:when>
                                                <c:when test="${group.isApproved or group.createrId == USER.userId}">
                                                    <a href="group/detail?groupId=${group.groupId}" class="btn btn-info w-100 mt-3">Access Group</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="group/detail?groupId=${group.groupId}" class="btn btn-primary w-100 mt-3">Join Group</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <div id="usernameResults" class="d-none">
                            <c:if test="${empty filteredUsername}">
                                <p>Don't have any usernames you are looking for.</p>
                            </c:if>
                            <c:forEach var="username" items="${filteredUsername}">
                                <div class="card mb-3">
                                    <div class="card-body d-flex align-items-center">
                                        <a href="${pageContext.request.contextPath}/profile?username=${username.username}" class="me-3">
                                            <img src="${pageContext.request.contextPath}/${username.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                        </a>
                                        <div class="me-3">
                                            <h5 class="card-title mb-0">${username.userFullName}</h5>
                                        </div>
                                        <div class="flex-grow-1">
                                            <ul class="list-inline mb-0">
                                                <c:choose>
                                                    <c:when test="${username.userId == USER.userId}"></c:when>
                                                    <c:when test="${username.isPending}">
                                                        <div class="dropdown d-inline">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Request Sent
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmCancel()">
                                                                        <input type="hidden" name="friendId" value="${username.userId}">
                                                                        <input type="hidden" name="friendName" value="${username.username}">
                                                                        <input type="hidden" name="action" value="cancelFrSearch">
                                                                        <button type="submit" class="dropdown-item">Cancel Request</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${username.isPendingRq}">
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${username.userId}">
                                                            <input type="hidden" name="friendName" value="${username.username}">
                                                            <input type="hidden" name="action" value="acceptFrSearch">
                                                            <button type="submit" class="btn btn-success btn-sm btn-block edit-cover mx-2">Accept Friend</button>
                                                        </form>
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${username.userId}">
                                                            <input type="hidden" name="friendName" value="${username.username}">
                                                            <input type="hidden" name="action" value="denyFrSearch">
                                                            <button type="submit" class="btn btn-danger btn-sm btn-block edit-cover mx-2">Deny Friend</button>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${username.isApproved}">
                                                        <div class="dropdown d-inline dropup">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Friends
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmUnfriend()">
                                                                        <input type="hidden" name="friendId" value="${username.userId}">
                                                                        <input type="hidden" name="friendName" value="${username.username}">
                                                                        <input type="hidden" name="action" value="unfriendSearch">
                                                                        <button type="submit" class="dropdown-item">Unfriend</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form id="addFriendForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${username.userId}">
                                                            <input type="hidden" name="friendName" value="${username.username}">
                                                            <input type="hidden" name="action" value="addFrSearch">
                                                            <button type="submit" class="btn btn-primary btn-sm btn-block edit-cover mx-2">Add Friend</button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="../include/footer.jsp" %>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#allButton').click(function() {
                $('#allResults').removeClass('d-none');
                $('#userResults').addClass('d-none');
                $('#groupResults').addClass('d-none');
                $('#usernameResults').addClass('d-none');
                $(this).addClass('btn-primary').removeClass('btn-secondary');
                $('#usersButton, #groupsButton, #usernameButton').addClass('btn-secondary').removeClass('btn-primary');
            });

            $('#usersButton').click(function() {
                $('#allResults').addClass('d-none');
                $('#userResults').removeClass('d-none');
                $('#groupResults').addClass('d-none');
                $('#usernameResults').addClass('d-none');
                $(this).addClass('btn-primary').removeClass('btn-secondary');
                $('#allButton, #groupsButton, #usernameButton').addClass('btn-secondary').removeClass('btn-primary');
            });

            $('#groupsButton').click(function() {
                $('#allResults').addClass('d-none');
                $('#userResults').addClass('d-none');
                $('#groupResults').removeClass('d-none');
                $('#usernameResults').addClass('d-none');
                $(this).addClass('btn-primary').removeClass('btn-secondary');
                $('#allButton, #usersButton, #usernameButton').addClass('btn-secondary').removeClass('btn-primary');
            });

            $('#usernameButton').click(function() {
                $('#allResults').addClass('d-none');
                $('#userResults').addClass('d-none');
                $('#groupResults').addClass('d-none');
                $('#usernameResults').removeClass('d-none');
                $(this).addClass('btn-primary').removeClass('btn-secondary');
                $('#allButton, #usersButton, #groupsButton').addClass('btn-secondary').removeClass('btn-primary');
            });
        });
         function confirmCancel() {
            return confirm("Bạn có muốn hủy lời mời này không?");
        }
        function confirmUnfriend() {
            return confirm("Bạn có chắc chắn muốn hủy kết bạn không?");
        }
    </script>
</body>

    
</body>
<%@ include file="../include/footer.jsp" %>