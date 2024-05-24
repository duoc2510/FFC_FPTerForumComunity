<%@ include file="../include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid">
                <div class="row">
                    <div id="profile-wrapper">
                        <div class="bg-white shadow rounded overflow-hidden">
                            <div class="px-4 py-4 cover" style="background: url(${pageContext.request.contextPath}/upload/deli-2.png)">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <img src="${pageContext.request.contextPath}/${userInfo.userAvatar}" class="rounded-circle img-thumbnail">
                                        <a href="${pageContext.request.contextPath}/profile/setting" class="btn btn-outline-dark btn-sm btn-block edit-cover">Edit profile</a>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0">${userInfo.userFullName}</h4>
                                </div>
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">60</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Posts</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">745</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Followers</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">340</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Following</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${userInfo.userScore}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Score</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${userInfo.userRank}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Rank</small>
                                    </li>
                                </ul>
                            </div>
                            <div class="px-4 py-3">
                                <h5 class="mb-2">About</h5>
                                <div class="p-4 rounded shadow-sm">
                                    <p class="font-italic mb-0">${userInfo.userStory}</p>
                                </div>
                            </div>

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
                            </style>
                            <h1>Posts</h1>
                            <div class="post-container">
                                <c:forEach var="post" items="${posts}">
                                    <div class="post">
                                        <div class="post-header">
                                            <img src="${pageContext.request.contextPath}/${userInfo.userAvatar}" class="avatar">                              
                                            <div class="user-info">
                                                <h5 class="user-name">${userInfo.userFullName}</h5>
                                                <p class="post-status">${post.status}</p>
                                                <p class="post-date">${post.createDate}</p>
                                            </div>
                                        </div>
                                        <div class="post-content">
                                            <p>${post.content}</p>
                                            <img src="${pageContext.request.contextPath}/${post.image}" alt="Post Image" class="post-image">
                                        </div>
                                   
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <%@ include file="newsfeed.jsp" %>
                </div>
            </div>
            <%@ include file="../include/right-slidebar.jsp" %>
        </div>
    </div>
    <%@ include file="../include/footer.jsp" %>
</body>
</html>
