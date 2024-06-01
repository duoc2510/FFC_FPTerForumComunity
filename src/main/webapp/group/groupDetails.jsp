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
                        <div class="bg-white shadow rounded overflow-hidden ">
                            <div class="px-4 py-4 cover" style="height: 300px !important; background-image: url('${pageContext.request.contextPath}/${group.image}'); background-size: cover; background-position: top; background-repeat: no-repeat;">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <div>
                                            <c:if test="${group.createrId == USER.userId}">
                                                <a href="${pageContext.request.contextPath}/inGroup/groupEdit?groupId=${group.groupId}" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">Edit Group</a>
                                                <a href="${pageContext.request.contextPath}/inGroup?groupId=${group.groupId}" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">View Group</a>
                                            </c:if></div>
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
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${isUserApproved or group.createrId == USER.userId}">
                <div class="container-fluid pt-0">
                    <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">
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
                            </div>
                        </c:if>  
                    </div>
                </div>
            </c:if>



            <c:if test="${isUserApproved or group.createrId == USER.userId}">
                <div class="container-fluid pt-0">
                    <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">
                        <div class="p0">
                            <h5 class="mb-2">Có gì mới không nà ${USER.userFullName} ơi</h5>
                        </div>
                        <div>
                            <form id="postForm" action="addpost" method="post" enctype="multipart/form-data">
                                <div class="form-group pb-3">
                                    <textarea class="form-control" id="postContent" name="postContent" rows="3" placeholder="Có chuyện gì vui vậy :>"></textarea>
                                </div>
                                <div class="form-group pb-3">
                                    <label for="postImage">Upload Image</label>
                                    <input type="file" class="form-control" id="postImage" name="postImage" accept="image/*">
                                    <div class="img-preview" id="imgPreview">
                                        <p>No image selected</p>
                                    </div>
                                </div>
                                <c:if test="${not empty group.groupId}">
                                    <input type="hidden" name="groupId" value="${group.groupId}" />
                                </c:if>
                                <button type="submit" class="btn btn-primary">Add Post</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${isUserApproved or group.createrId == USER.userId}">
                <div class="container-fluid pt-0">
                    <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">
                        <div class="p0">
                            <h5 class="mb-2">Bài viết của Group ${group.groupName}</h5>
                        </div>
                        <!-- Add buttons to filter posts by status -->
                        <c:if test="${group.createrId == USER.userId}">
                            <div class="btn-group" role="group" aria-label="Filter posts">
                                <button type="button" class="btn btn-primary" id="btnActive">Active Posts</button>
                                <button type="button" class="btn btn-secondary" id="btnPending">Pending Posts</button>
                            </div>
                        </c:if>

                        <div id="postsContainer">
                            <c:forEach var="post" items="${posts}">
                                <c:if test="${post.groupId == group.groupId}">
                                    <c:if test="${post.status eq 'Active'}">
                                        <%@ include file="postactive.jsp" %>
                                    </c:if>
                                    <c:if test="${post.status eq 'Pending'}">
                                        <%@ include file="postpending.jsp" %>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </div>

                    </div>
                </div>
            </c:if>

            <c:if test="${not isUserApproved and group.createrId != USER.userId and !isUserBanned}">
                <div class="container-fluid pt-0">
                    <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">
                        <div class="p0">
                            <h5 class="mb-2">Bạn chưa tham gia group ${USER.userFullName} ơi</h5>
                        </div>
                    </div>
                </div>
            </c:if>
            <!-- Modal for editing comment -->
            <div class="modal fade" id="editCommentModal" tabindex="-1" aria-labelledby="editCommentModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editCommentModalLabel">Edit Comment</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form id="editCommentForm" action="${pageContext.request.contextPath}/comment" method="post">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="editComment">
                                <input type="hidden" id="editCommentId" name="commentId">
                                <div class="form-group">
                                    <label for="editCommentContent">Content:</label>
                                    <textarea class="form-control" id="editCommentContent" name="newContent" rows="3"></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Modal for editing post -->
            <div class="modal fade" id="editPostModal" tabindex="-1" aria-labelledby="editPostModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editPostModalLabel">Edit Post</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form id="editPostForm" action="${pageContext.request.contextPath}/post" method="post" enctype="multipart/form-data">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="editPost">
                                <input type="hidden" id="editPostId" name="postId">
                                <input type="hidden" id="existingUploadPath" name="existingUploadPath"> <!-- Hidden field to store the existing image path -->

                                <div class="form-group">
                                    <label for="editPostContent">Content:</label>
                                    <textarea class="form-control" id="editPostContent" name="newContent" rows="3"></textarea>
                                </div>

                                <div class="form-group">
                                    <label for="editPostUploadPath">Upload Image:</label>
                                    <input type="file" class="form-control" id="editPostUploadPath" name="newUploadPath">
                                </div>

                                <div class="form-group">
                                    <label>Current Image:</label>
                                    <img id="currentUploadPath" src="" alt="Current post image" style="max-width: 100%; height: auto;">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
<script>
    function editComment(commentId, content) {
        document.getElementById('editCommentId').value = commentId;
        document.getElementById('editCommentContent').value = content;
        var editCommentModal = new bootstrap.Modal(document.getElementById('editCommentModal'));
        editCommentModal.show();
    }

    function editPost(postId, content, status, uploadPath) {
        document.getElementById('editPostId').value = postId;
        document.getElementById('editPostContent').value = content;
        document.getElementById('existingUploadPath').value = uploadPath;
        document.getElementById('currentUploadPath').src = uploadPath ? `${pageContext.request.contextPath}/${uploadPath}` : '';
                var editPostModal = new bootstrap.Modal(document.getElementById('editPostModal'));
                editPostModal.show();
            }

            function showMemberGroup() {
                document.getElementById('pendingRequest').style.display = 'none';
                document.getElementById('memberGroup').style.display = 'block';
            }

            function showPendingRequest() {
                document.getElementById('memberGroup').style.display = 'none';
                document.getElementById('pendingRequest').style.display = 'block';
            }

            document.getElementById('memberGroupBtn').addEventListener('click', showMemberGroup);
            document.getElementById('pendingRequestBtn').addEventListener('click', showPendingRequest);

            function confirmLeaveGroup(form) {
                return confirm('Are you sure you want to leave this group?');
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

            document.getElementById("btnActive").addEventListener("click", function () {
                var activePosts = document.getElementsByClassName("post-active");
                var pendingPosts = document.getElementsByClassName("post-pending");

                for (var i = 0; i < activePosts.length; i++) {
                    activePosts[i].style.display = "block";
                }
                for (var i = 0; i < pendingPosts.length; i++) {
                    pendingPosts[i].style.display = "none";
                }
            });

            document.getElementById("btnPending").addEventListener("click", function () {
                var activePosts = document.getElementsByClassName("post-active");
                var pendingPosts = document.getElementsByClassName("post-pending");

                for (var i = 0; i < activePosts.length; i++) {
                    activePosts[i].style.display = "none";
                }
                for (var i = 0; i < pendingPosts.length; i++) {
                    pendingPosts[i].style.display = "block";
                }
            });
</script>
