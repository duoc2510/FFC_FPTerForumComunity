<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>

<body>
    <style>
        .btn-small {
            display: inline-block;
            width: auto;
        }
    </style>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid">
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
                <div class="row">
                    <div id="profile-wrapper">
                        <div class="bg-white shadow rounded overflow-hidden">
                            <div class="px-4 py-4 cover" style="height: 300px !important; object-fit: cover; background: url(${pageContext.request.contextPath}/${group.image}">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <div>
                                            <c:if test="${group.createrId == USER.userId}">
                                                <a href="${pageContext.request.contextPath}/inGroup/groupEdit?groupId=${group.groupId}" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">Edit Group</a>
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

                                    <c:choose>
                                        <c:when test="${group.pending}">
                                            <button class="btn btn-secondary btn-sm btn-block edit-cover mx-2" disabled>Pending Approval</button>
                                        </c:when>
                                        <c:when test="${isUserApproved and group.createrId != USER.userId}">
                                            <button class="btn btn-primary btn-sm btn-block edit-cover mx-2" disabled>Joined Group</button>
                                            <form action="${pageContext.request.contextPath}/groupOut?groupId=${group.groupId}&action=leave" method="post" style="display:inline;" onsubmit="return confirmLeaveGroup(this);">
                                                <input type="hidden" name="groupId" value="${group.groupId}">
                                                <button type="submit" class="btn btn-secondary btn-sm btn-block edit-cover mx-2">Out Group</button>
                                            </form>
                                        </c:when>
                                        <c:when test="${isUserBanned}">
                                            <button class="btn btn-info btn-danger btn-block edit-cover mx-2" disabled>You have been banned</button>
                                        </c:when>
                                        <c:when test="${group.createrId == USER.userId}">
                                            <button class="btn btn-info btn-sm btn-block edit-cover mx-2" disabled>Welcome Host Group</button>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/joinGroup?groupId=${group.groupId}" class="btn btn-primary btn-sm btn-block edit-cover mx-2">Join Group</a>
                                        </c:otherwise>
                                    </c:choose>

                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${postCount}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Posts</small>
                                    </li>       
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${group.memberCount}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Members</small>
                                    </li>
                                </ul>
                            </div>
                            <div class="px-4 py-3">
                                <h5 class="mb-2">Description</h5>
                                <div class="p-4 rounded shadow-sm">
                                    <p class="font-italic mb-0">${group.groupDescription}</p>
                                </div>
                            </div>
                            <div class="container-fluid pt-0">
                                <c:if test="${isUserApproved or group.createrId == USER.userId}">
                                    <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">

                                        <a href="${pageContext.request.contextPath}/groupViewMember?groupId=${group.groupId}" id="memberGroupBtn" class="btn btn-primary btn-small" >Group Members</a>


                                        <c:if test="${group.createrId == USER.userId}">
                                            <a href="${pageContext.request.contextPath}/groupPendingRequest?groupId=${group.groupId}" id="pendingRequestBtn" class="btn btn-primary btn-small" >Pending Requests</a>
                                            <div class="pending-request" id="pendingRequest">
                                                <h2>Pending Members</h2>
                                                <c:if test="${empty pendingMembers}">
                                                    <p>No pending members.</p>
                                                </c:if>
                                                <c:if test="${not empty pendingMembers}">
                                                    <table class="table table-striped">
                                                        <thead>
                                                            <tr>

                                                                <th>User Name</th>
                                                                <th>Status</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:if test="${not empty messageOfApprove}">
                                                            <div class="alert alert-info" role="alert">
                                                                ${messageOfApprove}
                                                            </div>
                                                        </c:if>
                                                        <c:forEach var="member" items="${pendingMembers}">
                                                            <tr>

                                                                <td> 
                                                                    <img src="${pageContext.request.contextPath}/${member.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                                    <a href="${pageContext.request.contextPath}/profileAnotherUser?userId=${member.user.userId}">
                                                                        ${member.user.username}
                                                                    </a>
                                                                </td>
                                                                <td>${member.status}</td>
                                                                <td>

                                                                    <form action="${pageContext.request.contextPath}/groupPendingRequest" method="post" style="display: inline;">
                                                                        <input type="hidden" name="memberId" value="${member.memberGroupId}">
                                                                        <input type="hidden" name="groupId" value="${group.groupId}">
                                                                        <input type="hidden" name="action" value="accept">
                                                                        <button type="submit" class="btn btn-success">Approve</button>
                                                                    </form>
                                                                    <form action="${pageContext.request.contextPath}/groupPendingRequest" method="post" style="display: inline;">
                                                                        <input type="hidden" name="memberId" value="${member.memberGroupId}">
                                                                        <input type="hidden" name="groupId" value="${group.groupId}">
                                                                        <input type="hidden" name="action" value="deny">
                                                                        <button type="submit" class="btn btn-danger">Reject</button>
                                                                    </form>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </c:if>
                                            </div>   
                                        </c:if>
                                    </c:if>   
                                </div>
                                <c:if test="${isUserApproved or group.createrId == USER.userId}">
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
                                                    <h6 class="card-title fw-semibold mb-4 d-inline">
                                                        <a href="${pageContext.request.contextPath}/groupViewPostMember?userId=${post.user.userId}&groupId=${groupId}">
                                                            ${post.user.username}
                                                        </a>
                                                    </h6>
                                                    <p class="s-4">${post.createDate}</p>
                                                </div>
                                                <c:if test="${post.user.userId == USER.userId}">
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
                        </c:if>    
                        <c:if test="${not isUserApproved and group.createrId != USER.userId and !isUserBanned}">
                            <div class="container mt-3">
                                <h3>You must join the group to view posts and comments.</h3>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>


        </div>

    </div>
    <%@ include file="../include/footer.jsp" %>
    <script>
        function editComment(commentId, content) {
            document.getElementById('editCommentId').value = commentId;
            document.getElementById('editContent').value = content;
            var editCommentModal = new bootstrap.Modal(document.getElementById('editCommentModal'));
            editCommentModal.show();
        }
        function showMemberGroup() {
            document.getElementById('pendingRequest').style.display = 'none';
            document.getElementById('memberGroup').style.display = 'block';
        }

        // Function cho sự kiện khi click vào nút hiển thị yêu cầu chờ
        function showPendingRequest() {
            document.getElementById('memberGroup').style.display = 'none';
            document.getElementById('pendingRequest').style.display = 'block';
        }

        // Gắn sự kiện cho nút hiển thị danh sách thành viên nhóm
        document.getElementById('memberGroupBtn').addEventListener('click', showMemberGroup);

        // Gắn sự kiện cho nút hiển thị yêu cầu chờ
        document.getElementById('pendingRequestBtn').addEventListener('click', showPendingRequest);

        function confirmLeaveGroup(form) {
            return confirm('Are you sure you want to leave this group?');
        }

    </script>
</body>

</html>
