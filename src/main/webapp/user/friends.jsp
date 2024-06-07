
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid pb-2">
                <div class="row ">
                    <div id ="profile-wrapper" >
                        <style>
                            .post {
                                border: 1px solid #ccc;
                                border-radius: 8px;
                                padding: 10px;
                                margin-bottom: 20px;
                            }

                            .post-header {
                                display: flex;
                                align-items: center;
                            }

                            .avatar {
                                width: 40px;
                                height: 40px;
                                border-radius: 50%;
                                margin-right: 10px;
                            }

                            .user-info {
                                display: flex;
                                flex-direction: column;
                            }

                            .user-name {
                                margin: 0;
                            }

                            .post-status {
                                margin: 5px 0 0;
                                color: #888;
                                font-size: 14px;
                            }

                            .post-content {
                                margin-top: 10px;
                            }

                            .post-content p {
                                margin: 0;
                            }

                            .post-image {
                                max-width: 100%;
                                height: auto;
                                margin-top: 10px;
                            }
                            .img-preview {
                                margin-top: 20px;
                            }
                            .img-preview img {
                                max-width: 100%;
                                max-height: 300px;
                            }
                        </style>
                        <div class="bg-white shadow rounded overflow-hidden ">
                            <div class="px-4 py-4 cover cover " style="background: url(${pageContext.request.contextPath}/upload/deli-2.png)">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}" class="rounded-circle img-thumbnail" style="object-fit: cover;">
                                        <div>
                                            <a href="${pageContext.request.contextPath}/profile/setting" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">Edit profile</a>
                                            <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-dark btn-sm btn-block edit-cover">View profile</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center ">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0">${USER.userFullName}</h4>
                                </div>
                                <ul class="list-inline mb-0">

                                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending-tab-pane" type="button" role="tab" aria-controls="pending-tab-pane" aria-selected="false">Pending Friend Requests</button>
                                        </li>
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link active" id="accepted-tab" data-bs-toggle="tab" data-bs-target="#accepted-tab-pane" type="button" role="tab" aria-controls="accepted-tab-pane" aria-selected="true">Friends</button>
                                        </li>
                                    </ul>




                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${postCount}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Posts</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">745</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Followers</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">340</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Following</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${USER.userScore}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Score</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${USER.userRank}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Rank</small>
                                    </li>
                                </ul>
                            </div>
                            <div class="px-4 py-3">
                                <div class="p-4 rounded shadow-sm">
                                    <p class="font-italic mb-0">${USER.userStory}</p>
                                </div>
                            </div>

                            <div class="container">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="mt-3">


                                            <div class="tab-content" id="myTabContent">
                                                <div class="tab-pane fade" id="pending-tab-pane" role="tabpanel" aria-labelledby="pending-tab">
                                                    <div id="pending-friends-list">
                                                        <h4>Pending Friend Requests</h4>
                                                        <div class="table-responsive">
                                                            <table class="table table-striped">
                                                                <c:choose>
                                                                    <c:when test="${empty pendingFriends}">
                                                                        <tr>
                                                                            <td colspan="4">Don't have any pending friends.</td>
                                                                        </tr>
                                                                    </c:when>
                                                                    <c:otherwise>              
                                                                        <thead>
                                                                            <tr>
                                                                                <th>Avatar</th>
                                                                                <th>User Name</th>
                                                                                <th>Status</th>
                                                                                <th>Actions</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>


                                                                            <c:forEach var="pendingFriend" items="${pendingFriends}">
                                                                                <tr>
                                                                                    <td>
                                                                                        <a href="${pageContext.request.contextPath}/profile?username=${pendingFriend.username}">
                                                                                            <img src="${pageContext.request.contextPath}/${pendingFriend.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                                                        </a>
                                                                                    </td>
                                                                                    <td>${pendingFriend.username}</td>
                                                                                    <td>Pending</td>
                                                                                    <td>
                                                                                        <form action="${pageContext.request.contextPath}/friends" method="post">
                                                                                            <input type="hidden" name="friendId" value="${pendingFriend.userId}">
                                                                                            <input type="hidden" name="action" value="accept">
                                                                                            <button type="submit" class="btn btn-success btn-sm">Accept</button>
                                                                                        </form>
                                                                                        <form action="${pageContext.request.contextPath}/friends" method="post">
                                                                                            <input type="hidden" name="friendId" value="${pendingFriend.userId}">
                                                                                            <input type="hidden" name="action" value="deny">
                                                                                            <button type="submit" class="btn btn-danger btn-sm">Deny</button>
                                                                                        </form>
                                                                                    </td>
                                                                                </tr>
                                                                            </c:forEach>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="tab-pane fade show active" id="accepted-tab-pane" role="tabpanel" aria-labelledby="accepted-tab">
                                                    <div id="accepted-friends-list">
                                                        <h4 class="mb-4">Friends</h4>
                                                        <div class="row row-cols-1 row-cols-md-3 g-4">
                                                            <c:forEach var="acceptedFriend" items="${acceptedFriends}">
                                                                <div class="col">
                                                                    <div class="card h-100">
                                                                        <img src="${pageContext.request.contextPath}/${acceptedFriend.userAvatar}" class="card-img-top rounded-circle avatar-cover mx-auto" alt="${acceptedFriend.username}" width="100">
                                                                        <div class="card-body text-center">
                                                                            <h5 class="card-title">${acceptedFriend.username}</h5>
                                                                            <a href="${pageContext.request.contextPath}/profile?username=${acceptedFriend.username}" class="btn btn-outline-dark btn-sm">View Profile</a>
                                                                            <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmUnfriend()">
                                                                                <input type="hidden" name="friendId" value="${acceptedFriend.userId}">
                                                                                <input type="hidden" name="friendName" value="${acceptedFriend.username}">
                                                                                <input type="hidden" name="action" value="unfriend">
                                                                                <button type="submit" class="btn btn-warning btn-sm btn-block edit-cover mx-2">Unfriend</button>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                        <c:if test="${empty acceptedFriends}">
                                                            <tr>
                                                                <td colspan="4">Don't have any friends.</td>
                                                            </tr>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
        <script>

            function confirmUnfriend() {
                return confirm("Bạn có chắc chắn muốn hủy kết bạn không?");
            }
        </script>
</body>
<%@ include file="../include/footer.jsp" %>
