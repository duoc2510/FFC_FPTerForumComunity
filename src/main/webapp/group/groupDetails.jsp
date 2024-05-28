<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                                        <img src="${pageContext.request.contextPath}/${group.image}" class="rounded-circle img-thumbnail" style="object-fit: cover;">
                                        <div>
                                            <c:if test="${group.createrId == user.userId}">
                                                <a href="${pageContext.request.contextPath}/group/edit?groupId=${group.groupId}" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">Edit Group</a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0">${group.groupName}</h4>
                                    <p class="font-italic mb-0">${group.groupDescription}</p>
                                </div>
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${group.memberCount}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Members</small>
                                    </li>
                                </ul>
                            </div>
                            <div class="px-4 py-3">
                                <h5 class="mb-2">About</h5>
                                <div class="p-4 rounded shadow-sm">
                                    <p class="font-italic mb-0">${group.groupDescription}</p>
                                </div>
                            </div>
                            <div class="container-fluid pt-0">
                                <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">
                                 
                                    <a href="${pageContext.request.contextPath}/group/members?groupId=${group.groupId}" class="btn btn-primary">Group Members</a>
                                    <c:if test="${group.createrId == USER.userId}">
                                        <a href="${pageContext.request.contextPath}/group/pendingRequests?groupId=${group.groupId}" class="btn btn-primary">Pending Requests</a>
                                    </c:if>
                                    <form id="postForm" action="${pageContext.request.contextPath}/group/addPost" method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="groupId" value="${group.groupId}">
                                        <div class="form-group pb-3">
                                            <label for="postContent">What's on your mind?</label>
                                            <textarea class="form-control" id="postContent" name="postContent" rows="3"></textarea>
                                        </div>
                                        <div class="form-group pb-3">
                                            <label for="postImage">Upload Image</label>
                                            <input type="file" class="form-control" id="postImage" name="postImage">
                                        </div>
                                        <button type="submit" class="btn btn-primary">Add Post</button>
                                    </form>
                                </div>
                            </div>
                                     
                            <c:forEach var="post" items="${group.post}">
                                <div class="col-lg-12">
                                    <div class="card w-100">
                                        <div class="card-body p-4">
                                            <div class="pb-3 d-flex row">
                                                <div class="col-1 text-center mt-2">
                                                    <a class="nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <img src="${pageContext.request.contextPath}/${post.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                    </a>
                                                </div>
                                                <div class="col-10">
                                                    <h6 class="card-title fw-semibold mb-4 d-inline">${post.user.username}</h6>
                                                    <p class="s-4">${post.createDate}</p>
                                                </div>
                                                <c:if test="${post.user.userId == user.userId}">
                                                    <div class="dropdown col-1 px-2" style="text-align: right">
                                                        <a class="dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                            <span><i class="ti-more-alt"></i></span>
                                                        </a>
                                                        <ul class="dropdown-menu">
                                                            <li>
                                                                <a class="dropdown-item" href="#">Edit</a>
                                                            </li>
                                                            <li>
                                                                <form class="dropdown-item mt-3" onsubmit="return confirm('Are you sure you want to delete this post?');" action="${pageContext.request.contextPath}/group/post" method="post">
                                                                    <input type="hidden" name="action" value="deletePost">
                                                                    <input type="hidden" name="postId" value="${post.postId}">
                                                                    <button type="submit" class="dropdown-item">Delete Post</button>
                                                                </form>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="mt-3">
                                                <p class="fs-6">${post.content}</p>
                                                <c:if test="${not empty post.uploadPath}">
                                                    <img src="${pageContext.request.contextPath}/${post.uploadPath}" alt="Post Image" class="post-image">
                                                </c:if>
                                            </div>
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
                                            <form action="${pageContext.request.contextPath}/group/comment" method="post" class="input-group">
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
                                                                    <h6 class="card-title fw-semibold mb-0">${comment.user.username}: ${comment.content}</h6>
                                                                    <p class="s-4">${comment.date}</p>
                                                                </div>
                                                            </div>
                                                            <c:if test="${comment.user.userId == user.userId}">
                                                                <div class="dropdown">
                                                                    <button class="btn btn-link dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                                                        <i class="ti ti-more"></i>
                                                                    </button>
                                                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                                                                        <li>
                                                                            <button class="dropdown-item" type="button" onclick="editComment(${comment.commentId}, '${comment.content}')">Edit</button>
                                                                        </li>
                                                                        <li>
                                                                            <form class="dropdown-item p-0 m-0" onsubmit="return confirm('Are you sure you want to delete this comment?');" action="${pageContext.request.contextPath}/group/comment" method="post">
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
                            </c:forEach>
                            <!-- Modal for editing comment -->
                            <div class="modal fade" id="editCommentModal" tabindex="-1" aria-labelledby="editCommentModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="editCommentModalLabel">Edit Comment</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <form id="editCommentForm" action="${pageContext.request.contextPath}/group/comment" method="post">
                                            <div class="modal-body">
                                                <input type="hidden" name="action" value="editComment">
                                                <input type="hidden" id="editCommentId" name="commentId">
                                                <div class="form-group">
                                                    <label for="editContent">Content:</label>
                                                    <textarea class="form-control" id="editContent" name="newContent" rows="3"></textarea>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Save changes</button>
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
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp" %>
</body>
</html>
