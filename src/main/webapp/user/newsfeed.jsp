<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid">
                <div class="row">
                    <div id="profile-wrapper">
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
                        <c:forEach var="post" items="${posts}">
                            <c:if test="${post.status eq 'Active' and post.postStatus eq 'Public'}">
                                <div class="col-lg-12">
                                    <div class="card w-100">
                                        <div class="card-body p-4">
                                            <div class="pb-3 d-flex row">
                                                <div class="col-1 text-center mt-2">
                                                    <c:choose>

                                                        <c:when test="${post.userId == USER.userId}">
                                                            <a href="${pageContext.request.contextPath}/profile">
                                                                <img src="${pageContext.request.contextPath}/${post.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                            </a>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/viewProfile?username=${post.user.username}">
                                                                <img src="${pageContext.request.contextPath}/${post.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="col-10">
                                                    <h6 class="card-title fw-semibold mb-4 d-inline">${post.user.username}</h6>
                                                    <p class="s-4">${post.createDate}</p>
                                                </div>
                                                <c:if test="${post.user.userId == user.userId}">
                                                    <div class="dropdown col-1 px-2" style="text-align: right">
                                                        <a class="dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                            <span> <i class="ti-more-alt"></i></span>   
                                                        </a>
                                                        <ul class="dropdown-menu">
                                                            <li>
                                                                <a class="dropdown-item" type="button" href="javascript:void(0)" onclick="editPost(${post.postId}, '${post.content}', '${post.status}', '${post.uploadPath}')">Edit</a>
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
                                                                    <c:choose>
                                                                        <c:when test="${comment.userId == USER.userId}">
                                                                            <a href="${pageContext.request.contextPath}/profile">
                                                                                <img src="${pageContext.request.contextPath}/${comment.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                                            </a>
                                                                        </c:when>

                                                                        <c:otherwise>
                                                                            <a href="${pageContext.request.contextPath}/viewProfile?username=${comment.user.username}">
                                                                                <img src="${pageContext.request.contextPath}/${comment.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    <div class="ms-2">
                                                                        <h6 class="card-title fw-semibold mb-0">${comment.user.username}: ${comment.content}</h6>
                                                                        <p class="s-4">${comment.date}</p>
                                                                    </div>
                                                                </div>
                                                                <c:if test="${comment.user.userId == user.userId}">
                                                                    <div class="dropdown">
                                                                        <button class="btn btn-link dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                                                            <i class="ti ti-more-alt"></i>
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
                        <!-- Modal for editing comment -->
                        <div class="modal fade" id="editCommentModal" tabindex="-1" aria-labelledby="editCommentModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editCommentModalLabel">Chá»nh sá»­a bÃ¬nh luáº­n</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="ÄÃ³ng"></button>
                                    </div>
                                    <form id="editCommentForm" action="${pageContext.request.contextPath}/comment" method="post">
                                        <div class="modal-body">
                                            <input type="hidden" name="action" value="editComment">
                                            <input type="hidden" id="editCommentId" name="commentId">
                                            <div class="form-group">
                                                <label for="editCommentContent">Ná»i dung:</label>
                                                <textarea class="form-control" id="editCommentContent" name="newContent" rows="3"></textarea>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">ÄÃ³ng</button>
                                            <button type="submit" class="btn btn-primary">LÆ°u thay Äá»i</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- Modal chá»nh sá»­a bÃ i ÄÄng -->
                        <div class="modal fade" id="editPostModal" tabindex="-1" aria-labelledby="editPostModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editPostModalLabel">Chá»nh sá»­a bÃ i ÄÄng</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="ÄÃ³ng"></button>
                                    </div>
                                    <form id="editPostForm" action="${pageContext.request.contextPath}/post" method="post" enctype="multipart/form-data">
                                        <div class="modal-body">
                                            <input type="hidden" name="action" value="editPost">
                                            <input type="hidden" id="editPostId" name="postId">
                                            <input type="hidden" id="existingUploadPath" name="existingUploadPath"> <!-- TrÆ°á»ng áº©n Äá» lÆ°u ÄÆ°á»ng dáº«n áº£nh cÅ© -->

                                            <div class="form-group">
                                                <label for="editPostContent">Ná»i dung:</label>
                                                <textarea class="form-control" id="editPostContent" name="newContent" rows="3"></textarea>
                                            </div>

                                            <div class="form-group">
                                                <label for="editPostStatus">Tráº¡ng thÃ¡i:</label>
                                                <select class="form-control" id="editPostStatus" name="newStatus">
                                                    <option value="Public" selected>Public</option>
                                                    <option value="Friends">Friends</option>
                                                    <option value="Only me">Only me</option>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label for="editPostUploadPath">Táº£i áº£nh lÃªn:</label>
                                                <input type="file" class="form-control" id="editPostUploadPath" name="newUploadPath">
                                            </div>

                                            <div class="form-group">
                                                <label>áº¢nh hiá»n táº¡i:</label>
                                                <img id="currentUploadPath" src="" alt="áº¢nh bÃ i ÄÄng hiá»n táº¡i" style="max-width: 100%; height: auto;">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">ÄÃ³ng</button>
                                            <button type="submit" class="btn btn-primary">LÆ°u thay Äá»i</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>


                        <script>
                            function editComment(commentId, content) {
                                document.getElementById('editCommentId').value = commentId;
                                document.getElementById('editContent').value = content;
                                var editCommentModal = new bootstrap.Modal(document.getElementById('editCommentModal'));
                                editCommentModal.show();
                            }
                            function editPost(postId, content, status, uploadPath) {
                                document.getElementById('editPostId').value = postId;
                                document.getElementById('editPostContent').value = content;

                                // Äáº·t giÃ¡ trá» tráº¡ng thÃ¡i cá»§a bÃ i ÄÄng
                                var editPostStatus = document.getElementById('editPostStatus');
                                editPostStatus.value = "Public";

                                // LÆ°u ÄÆ°á»ng dáº«n áº£nh hiá»n táº¡i vÃ o trÆ°á»ng áº©n
                                document.getElementById('existingUploadPath').value = uploadPath;

                                if (uploadPath && uploadPath !== 'null') {
                                    document.getElementById('currentUploadPath').src = uploadPath;
                                    document.getElementById('currentUploadPath').style.display = 'block';
                                } else {
                                    document.getElementById('currentUploadPath').style.display = 'none';
                                }

                                var editPostModal = new bootstrap.Modal(document.getElementById('editPostModal'));
                                editPostModal.show();
                            }

                        </script>
                    </div>
                </div>
            </div>
            <%@ include file="../include/right-slidebar.jsp" %>
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
