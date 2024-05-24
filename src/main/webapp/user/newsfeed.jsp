
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
                            <c:forEach var="post" items="${posts}">
                                <div class="col-lg-12 ">
                                    <div class="card w-100">
                                        <div class="card-body p-4">
                                            <div class="pb-3 d-inline">
                                                <a class="row nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <div class="col-1 text-center mt-2">
                                                        <img class="rounded-circle d-inline mr-3"  alt="" width="32" src="${pageContext.request.contextPath}/${userInfo.userAvatar}" class="avatar">>
                                                    </div>
                                                    <div class="col">
                                                        <h6 class="card-title fw-semibold mb-4 d-inline">${userInfo.userFullName}</h6>
                                                        <p class="s-4"> ${post.createDate}</p>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="mt-3">
                                                <p>${post.content}</p>
                                                <c:if test="${not empty post.uploadPath}">
                                                    <img src="${pageContext.request.contextPath}/${post.uploadPath}" alt="Post Image" class="post-image">
                                                </c:if>
                                            </div>

                                            <div class="">
                                                <div class="row p-3 d-flex justify-content-center text-center">

                                                    <a class="col nav-link nav-icon-hover" href="javascript:void(0)">
                                                        <span><i class="ti ti-heart"></i></span>
                                                        <span class="hide-menu">Like</span>
                                                    </a>

                                                    <a class="col nav-link nav-icon-hover" >
                                                        <span><i class="ti ti-message-plus"></i></span>
                                                        <span class="hide-menu">Comment</span>
                                                    </a>

                                                    <a class="col nav-link nav-icon-hover" href="javascript:void(0)">
                                                        <span><i class="ti ti-share"></i></span>
                                                        <span class="hide-menu">Share</span>
                                                    </a>
                                                </div>
                                                <div class="input-group">
                                                    <input type="text" class="form-control" placeholder="Write a comment" >
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="../include/right-slidebar.jsp" %>
        </div>
    </div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>