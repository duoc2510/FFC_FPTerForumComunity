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
            <div class="container-fluid pb-1">
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
                                                <a href="${pageContext.request.contextPath}/group/edit?groupId=${group.groupId}" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">Edit Group</a>
                                                <a href="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">View Group</a>
                                            </c:if></div>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center">
                                <div class="media-body mb-2 text-white">
                                    <h4 class="mt-0 mb-0" style="text-align:left;">${group.groupName}</h4>
                                    <c:choose>
                                        <c:when test="${group.pending}">
                                            <button class="btn btn-secondary btn-sm btn-block edit-cover my-2" disabled>Pending Approval</button>
                                        </c:when>
                                        <c:when test="${isUserApproved and group.createrId != USER.userId}">
                                            <button class="btn btn-primary btn-sm btn-block edit-cover my-2" disabled>Joined Group</button>
                                            <form action="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}&action=leave" method="post" style="display:inline;" onsubmit="return confirmLeaveGroup(this);">
                                                <input type="hidden" name="groupId" value="${group.groupId}">
                                                <button type="submit" class="btn btn-secondary btn-sm btn-block edit-cover my-2">Out Group</button>
                                            </form>
                                        </c:when>
                                        <c:when test="${isUserBanned}">
                                            <button class="btn btn-info btn-danger btn-block edit-cover my-2" disabled>You have been banned</button>
                                        </c:when>
                                        <c:when test="${group.createrId == USER.userId}">
                                            <button class="btn btn-info btn-sm btn-block edit-cover my-2" disabled>Welcome Host Group</button>
                                            <form action="${pageContext.request.contextPath}/group" method="post" style="display:inline;" onsubmit="return confirmDeleteGroup()">
                                                <input type="hidden" name="action" value="deleteGroup">
                                                <input type="hidden" name="groupId" value="${group.groupId}">
                                                <button type="submit" class="btn btn-secondary btn-sm btn-block edit-cover mx-2">Delete Group</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/group" method="post">
                                                <input type="hidden" name="groupId" value="${group.groupId}">
                                                <input type="hidden" name="action" value="joinGroup"> <!-- Thêm tham số ẩn để xác định hành động -->
                                                <button type="submit" class="btn btn-primary w-100 mt-3">Join Group</button>
                                            </form>                                       
                                        </c:otherwise>
                                    </c:choose>
                                </div>                    
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${postCount}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Posts</small>
                                    </li>       
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${group.memberCount}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Members</small>
                                    </li>
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${isUserApproved or group.createrId == USER.userId}">
                <div class="container-fluid pt-0">
                    <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">
                        <c:if test="${isUserApproved or group.createrId == USER.userId}">
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <c:if test="${group.createrId == USER.userId}">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">Pending member</button>
                                    </li>
                                </c:if>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">Group Members</button>
                                </li>
                            </ul>
                            <div class="tab-content my-3" id="myTabContent">
                                <div class="tab-pane fad show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
                                    <c:if test="${group.createrId == USER.userId}">
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
                                                                <a href="${pageContext.request.contextPath}/group/profile?userId=${member.user.userId}">
                                                                    ${member.user.username}
                                                                </a>
                                                            </td>
                                                            <td>${member.status}</td>
                                                            <td>
                                                                <form action="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}" method="post" style="display: inline;">
                                                                    <input type="hidden" name="memberId" value="${member.memberGroupId}">
                                                                    <input type="hidden" name="groupId" value="${group.groupId}">
                                                                    <input type="hidden" name="action" value="accept">
                                                                    <button type="submit" class="btn btn-success">Approve</button>
                                                                </form>
                                                                <form action="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}" method="post" style="display: inline;">
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
                                <div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
                                    <h2>List Members</h2>
                                    <c:if test="${empty allMembers}">
                                        <p>No members.</p>
                                    </c:if>

                                    <c:if test="${not empty allMembers}">
                                        <table class="table">
                                            <thead>
                                                <tr>            
                                                    <th scope="col">#</th>
                                                    <th scope="col">User</th>
                                                    <th scope="col">Action</th>
                                                </tr>
                                            </thead>
                                            <c:set var="counter" value="1" />
                                            <tbody>

                                                <c:forEach var="member" items="${allMembers}">
                                                    <tr>
                                                        <td>${counter}</td>
                                                        <td><img src="${pageContext.request.contextPath}/${member.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                            <a href="${pageContext.request.contextPath}/group/profile?userId=${member.user.userId}&groupId=${group.groupId}">
                                                                ${member.user.username}
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <c:if test="${USER.userId == group.createrId && USER.userId != member.user.userId}">
                                                                <form id="kickForm${member.user.userId}" action="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}" method="post" style="display:inline;">
                                                                    <input type="hidden" name="groupId" value="${group.groupId}">
                                                                    <input type="hidden" name="userId" value="${member.user.userId}">
                                                                    <input type="hidden" name="action" value="kick"> 
                                                                    <button id="kickButton${member.user.userId}" type="submit" class="btn btn-secondary btn-sm btn-block edit-cover mx-2" onclick="return confirmKick(this);">Kick</button>
                                                                </form>
                                                                <form id="banForm${member.user.userId}" action="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}" method="post" style="display:inline;">
                                                                    <input type="hidden" name="groupId" value="${group.groupId}">
                                                                    <input type="hidden" name="userId" value="${member.user.userId}">
                                                                    <input type="hidden" name="action" value="ban"> 
                                                                    <button id="banButton${member.user.userId}" type="submit" class="btn btn-danger btn-sm btn-block edit-cover" onclick="return confirmBan(this);">Ban</button>
                                                                </form>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                    <c:set var="counter" value="${counter + 1}" />
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>
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
                            <form id="postForm" action="${pageContext.request.contextPath}/addpost" method="post" enctype="multipart/form-data">
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
                                <a type="button" class="btn btn-primary" id="btnActive">Active Posts</a>
                                <a type="button" class="btn btn-secondary" id="btnPending">Pending Posts</a>
                            </div>
                        </c:if>

                        <div id="postsContainer">
                            <c:forEach var="post" items="${posts}">
                                <c:if test="${post.groupId == group.groupId && post.status eq 'Active'}">
                                    <%@ include file="postactive.jsp" %>
                                </c:if>
                                <c:if test="${post.groupId == group.groupId && group.createrId == USER.userId && post.status eq 'Pending'}">
                                    <%@ include file="postpending.jsp" %>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${not isUserApproved and group.createrId != USER.userId and !isUserBanned}">
                <div class="container-fluid pt-0">

                    <div class="row form-settings bg-white  d-flex justify-content-between ">
                        <div class="col-12 col-sm-5 px-2">
                            <div class="px-4 py-3 shadow rounded p-4">
                                <h5 class="mb-2">Description</h5>
                                <div class="p-4 ">
                                    <p class="font-italic mb-0">${group.groupDescription}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-7 px-2">
                            <div class="p0 shadow rounded p-4">
                                <h5 class="mb-2">Bạn chưa tham gia group ${USER.userFullName} ơi</h5>
                            </div>
                        </div>


                    </div>
                </div>
            </c:if>

            <%@include file="modal.jsp" %>
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
<script>
    function editComment(commentId, content) {
        document.getElementById('editCommentId').value = commentId; // Thiết lập giá trị ID của bình luận vào input ẩn
        document.getElementById('editCommentContent').value = content; // Thiết lập nội dung bình luận vào textarea

        var editCommentModal = new bootstrap.Modal(document.getElementById('editCommentModal')); // Tạo modal sử dụng Bootstrap
        editCommentModal.show(); // Hiển thị modal chỉnh sửa bình luận
    }

    document.getElementById('postImage').addEventListener('change', handlePostImageChange);

    function handlePostImageChange(event) {
        const file = event.target.files[0];
        const previewContainer = document.getElementById('imgPreview');
        const previewDefaultText = previewContainer.querySelector('p');

        // Xóa ảnh hiện tại nếu có
        const existingPreviewImage = previewContainer.querySelector('img');
        if (existingPreviewImage) {
            previewContainer.removeChild(existingPreviewImage);
        }

        if (file) {
            const reader = new FileReader();
            const previewImage = document.createElement('img');

            previewDefaultText.style.display = 'none';
            previewImage.style.display = 'block';

            reader.addEventListener('load', function () {
                previewImage.setAttribute('src', this.result);
            });

            reader.readAsDataURL(file);
            previewContainer.appendChild(previewImage);
        } else {
            previewDefaultText.style.display = null;
        }
    }

    function editPost(postId, content, status, uploadPath) {
        document.getElementById('editPostId').value = postId;
        document.getElementById('editPostContent').value = content;
        document.getElementById('editPostStatus').value = "Public";
        document.getElementById('existingUploadPath').value = uploadPath ? uploadPath : 'null';

        var currentUploadPathImg = document.getElementById('currentUploadPath');
        if (uploadPath && uploadPath !== 'null') {
            currentUploadPathImg.src = uploadPath;
            currentUploadPathImg.style.display = 'block';
        } else {
            currentUploadPathImg.style.display = 'none';
        }

        var editPostModal = new bootstrap.Modal(document.getElementById('editPostModal'));
        editPostModal.show();

        const editPostImageInput = document.getElementById('editPostImage');
        editPostImageInput.removeEventListener('change', handleEditPostImageChange);
        editPostImageInput.addEventListener('change', handleEditPostImageChange);
    }

    function handleEditPostImageChange(event) {
        const file = event.target.files[0];
        const currentUploadPathImg = document.getElementById('currentUploadPath');

        if (file) {
            const reader = new FileReader();
            reader.addEventListener('load', function () {
                currentUploadPathImg.src = this.result;
                currentUploadPathImg.style.display = 'block';
            });
            reader.readAsDataURL(file);
        } else {
            currentUploadPathImg.style.display = 'none';
        }
    }

    function showMemberGroup() {
        document.getElementById('pendingRequest').style.display = 'none';
        document.getElementById('memberGroup').style.display = 'block';
    }

    function showPendingRequest() {
        document.getElementById('memberGroup').style.display = 'none';
        document.getElementById('pendingRequest').style.display = 'block';
    }



    function confirmLeaveGroup(form) {
        return confirm('Are you sure you want to leave this group?');
    }


    document.addEventListener("DOMContentLoaded", function () {
        var btnActive = document.getElementById("btnActive");
        var btnPending = document.getElementById("btnPending");

        btnActive.addEventListener("click", function () {
            togglePosts("post-active", "post-pending", "block", "none");
        });

        btnPending.addEventListener("click", function () {
            togglePosts("post-active", "post-pending", "none", "block");
        });

        function togglePosts(activeClass, pendingClass, activeDisplay, pendingDisplay) {
            var activePosts = document.getElementsByClassName(activeClass);
            var pendingPosts = document.getElementsByClassName(pendingClass);

            for (var i = 0; i < activePosts.length; i++) {
                activePosts[i].style.display = activeDisplay;
            }
            for (var i = 0; i < pendingPosts.length; i++) {
                pendingPosts[i].style.display = pendingDisplay;
            }
        }
    });
    function confirmDeleteGroup() {
        // Get the number of members from the JSP
        var memberCount = <c:out value="${group.memberCount}" />;

        // Check the number of members
        if (memberCount > 1) {
            // Show alert if there are more than 1 member
            alert("Your group has more than 1 member. To delete the group, you need to remove all members.");
            return false; // Prevent form submission
        } else {
            // Show confirmation alert if there is only 1 member
            var confirmDelete = confirm("You are the last member of the group. Are you sure you want to delete it?");
            return confirmDelete; // Allow or prevent form submission based on user's choice
        }
    }
    function confirmKick(button) {
        return confirm("Are you sure you want to kick this member?");
    }

    function confirmBan(button) {
        return confirm("Are you sure you want to ban this member?");
    }
</script>