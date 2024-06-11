
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
                                        <img src="${pageContext.request.contextPath}/${user.userAvatar}" class="rounded-circle img-thumbnail" style="object-fit: cover;">
                                        <div>
                                            <a href="${pageContext.request.contextPath}/profile?username=${user.username}" class="btn btn-outline-dark btn-sm btn-block edit-cover">View personal profile</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center ">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0">${user.userFullName}</h4>
                                </div>
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${postCountGroup}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Post in group</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${cmtInGroup}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Comment in group</small>
                                    </li>    
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container-fluid pt-0">
                <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">
                    <div class="p0">
                        <h5 class="mb-2">Bài viết trong nhóm </h5>
                    </div>
                    <c:if test="${empty posts}">
                        <p>Người này không có bài post nào trong group.</p>
                    </c:if>
                    <div>
                        <c:forEach var="post" items="${posts}">
                            <c:if test="${post.groupId == group.groupId && post.status eq 'Active'}">
                                <div class="col-lg-12">
                                    <div class="card w-100">
                                        <div class="card-body p-4">
                                            <div class="pb-3 d-flex row">
                                                <div class="col-1 text-center mt-2">
                                                    <a class="nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <img src="${pageContext.request.contextPath}/${user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                    </a>
                                                </div>
                                                <div class="col-10">
                                                    <h6 class="card-title fw-semibold mb-4 d-inline">${user.username}</h6>
                                                    <p class="s-4">${post.createDate}</p>
                                                </div>
                                                <c:if test="${post.userId == user.userId}">
                                                    <div class="dropdown col-1 px-2" style="text-align: right">
                                                        <a class="dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                            <span> <i class="ti-more-alt"></i></span>   
                                                        </a>
                                                        <ul class="dropdown-menu">
                                                            <li>
                                                                <a class="dropdown-item" type="button" href="#">Edit</a>
                                                            </li>
                                                            <li>
                                                                <form class="dropdown-item p-0 m-0" onsubmit="return confirm('Are you sure you want to delete this post?');" action="${pageContext.request.contextPath}/post" method="post">
                                                                    <input type="hidden" name="action" value="deletePost">
                                                                    <input type="hidden" name="postId" value="${post.postId}">
                                                                    <button type="submit" class="dropdown-item">Delete Post</button>
                                                                </form>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </c:if>
                                            </div>

                                            <!-- Option to delete post for the post author -->
                                            <div class="mt-0 fs-6">
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
                                                    <a class="col nav-link nav-icon-hover">
                                                        <span><i class="ti ti-message-plus"></i></span>
                                                        <span class="hide-menu">Comment</span>
                                                    </a>
                                                    <a class="col nav-link nav-icon-hover" href="javascript:void(0)">
                                                        <span><i class="ti ti-share"></i></span>
                                                        <span class="hide-menu">Share</span>
                                                    </a>
                                                </div>
                                                <!-- Add comment form -->
                                                <form action="${pageContext.request.contextPath}/comment" method="post" class="input-group">
                                                    <input type="hidden" name="action" value="addComment">
                                                    <input type="hidden" name="postId" value="${post.postId}">
                                                    <input type="hidden" name="userId" value="${user.userId}">
                                                    <input type="text" class="form-control" name="content" placeholder="Write a comment" required>
                                                    <button type="submit" class="btn btn-primary">Submit</button>
                                                </form>
                                                <!-- Display comments -->
                                                <div class="comments mt-3">
                                                    <c:forEach var="comment" items="${post.comments}">
                                                        <div class="comment">
                                                            <div class="d-flex justify-content-between align-items-center pb-3">
                                                                <div class="d-flex align-items-center">
                                                                    <div class="text-center mt-2">
                                                                        <img src="${pageContext.request.contextPath}/${comment.user.userAvatar}" alt="" width="30" class="rounded-circle avatar-cover">
                                                                    </div>
                                                                    <div class="ms-2">
                                                                        <h6 class="card-title fw-semibold mb-0">${comment.user.username}:${comment.content}</h6>
                                                                        <p class="s-4">${comment.date}</p>
                                                                    </div>
                                                                </div>
                                                                <c:if test="${comment.user.userId == USER.userId}">
                                                                    <div class="dropdown">
                                                                        <button class="btn btn-link dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                                                            <i class="ti ti-more"></i>
                                                                        </button>
                                                                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                                                                            <li>
                                                                                <button class="dropdown-item" type="button" onclick="editComment(${comment.commentId}, '${comment.content}')">Edit</button>
                                                                            </li>
                                                                            <li>
                                                                                <form class="dropdown-item p-0 m-0" onsubmit="return confirm('Are you sure you want to delete this comment?');" action="${pageContext.request.contextPath}/comment" method="post">
                                                                                    <input type="hidden" name="action" value="deleteComment">
                                                                                    <input type="hidden" name="commentId" value="${comment.commentId}">
                                                                                    <button type="submit" class="dropdown-item">Delete</button>
                                                                                </form>
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        <%@include file="modal.jsp" %>
                        <script>
                            function editComment(commentId, content) {
                                document.getElementById('editCommentId').value = commentId;
                                document.getElementById('editContent').value = content;
                                var editCommentModal = new bootstrap.Modal(document.getElementById('editCommentModal'));
                                editCommentModal.show();
                            }
                            document.getElementById('postImage').addEventListener('change', function (event) {
                                const file = event.target.files[0];
                                const previewContainer = document.getElementById('imgPreview');
                                const previewImage = document.createElement('img');
                                const previewDefaultText = previewContainer.querySelector('p');

                                if (file) {
                                    const reader = new FileReader();

                                    previewDefaultText.style.display = 'none';
                                    previewImage.style.display = 'block';

                                    reader.addEventListener('load', function () {
                                        previewImage.setAttribute('src', this.result);
                                    });

                                    reader.readAsDataURL(file);
                                    previewContainer.appendChild(previewImage);
                                } else {
                                    previewDefaultText.style.display = null;
                                    previewImage.style.display = null;
                                }
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
</body>
<%@ include file="../include/footer.jsp" %>
