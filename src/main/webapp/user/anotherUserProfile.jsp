
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
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

                            .modal-dialog-centered {
                                display: flex !important;
                                align-items: center;
                                min-height: calc(100% - 4.5rem);
                            }
                            .modal-content {
                                padding: 20px;
                            }
                            .dropdown-menu {
                                position: absolute; /* Đảm bảo dropdown hiển thị dựa trên vị trí tuyệt đối */
                                z-index: 1000; /* Thiết lập z-index cao hơn để dropdown hiển thị phía trên */
                                margin-top: 5px; /* Điều chỉnh margin để tạo khoảng cách phù hợp với button */
                                margin-left: 0; /* Điều chỉnh margin nếu cần thiết */
                                padding: 8px 0; /* Điều chỉnh padding nếu cần thiết */
                            }

                        </style>



                        <div class="bg-white shadow rounded  ">
                            <div class="px-4 py-4 cover cover " style="border-radius: 1.5em 1.5em 0 0;background: url(${pageContext.request.contextPath}/upload/deli-2.png)">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <img src="${pageContext.request.contextPath}/${user.userAvatar}" class="rounded-circle img-thumbnail" style="object-fit: cover;">
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center ">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0">${user.userFullName}</h4>     
                                </div>
                                <ul class="list-inline mb-0">
                                    <c:choose>
                                        <c:when test="${friendStatus == 'sent'}">
                                            <div class="dropdown d-inline">
                                                <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                    Request Sent
                                                </button>
                                                <ul class="dropdown-menu" aria-labelledby="friendDropdown" style="    top: -1em;    margin-left: 9em;">
                                                    <li>
                                                        <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmUnfriend()">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="cancel">
                                                            <button type="submit" class="dropdown-item">Hủy lời mời</button>
                                                        </form>
                                                    </li>
                                                </ul>
                                            </div>
                                        </c:when>
                                        <c:when test="${friendStatus == 'received'}">
                                            <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                <input type="hidden" name="friendId" value="${user.userId}">
                                                <input type="hidden" name="friendName" value="${user.username}">
                                                <input type="hidden" name="action" value="acceptFr"> 
                                                <button type="submit" class="btn btn-success btn-sm btn-block edit-cover mx-2">Accept friend</button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                <input type="hidden" name="friendId" value="${user.userId}">
                                                <input type="hidden" name="friendName" value="${user.username}">
                                                <input type="hidden" name="action" value="denyFr"> 
                                                <button type="submit" class="btn btn-danger btn-sm btn-block edit-cover mx-2">Deny friend</button>
                                            </form>
                                        </c:when>
                                        <c:when test="${areFriend}">
                                            <div class="dropdown d-inline">
                                                <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown"  data-bs-display="static"  aria-expanded="false">
                                                    Bạn bè
                                                </button>
                                                <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                    <li>
                                                        <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmUnfriend()">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="unfriendProfile">
                                                            <button type="submit" class="dropdown-item">Hủy kết bạn</button>
                                                        </form>
                                                    </li>
                                                </ul>
                                            </div>
                                        </c:when>
                                        <c:otherwise> 
                                            <form id="addFriendForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline">
                                                <input type="hidden" name="friendId" value="${user.userId}">
                                                <input type="hidden" name="friendName" value="${user.username}">
                                                <input type="hidden" name="action" value="add">
                                                <button type="submit" class="btn btn-primary btn-sm btn-block edit-cover mx-2">Add Friend</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>

                                    <c:choose>
                                        <c:when test="${USER.userRole == 3}">
                                            <li class="list-inline-item">
                                                <div class="dropdown d-inline">
                                                    <button class="btn btn-secondary btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="moreOptionsDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                        <i class="fas fa-ellipsis-h"></i>
                                                    </button>
                                                    <ul class="dropdown-menu" aria-labelledby="moreOptionsDropdown">
                                                        <c:choose>
                                                            <c:when test="${user.userRole == 0}">
                                                                <li>
                                                                    <button type="button" class="dropdown-item" disabled>
                                                                        User banned
                                                                    </button>
                                                                </li>
                                                            </c:when>
                                                            <c:when test="${user.userRole == 2}">
                                                                <li class="w-100">
                                                                    <form id="revokeManagerForm_${user.userId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                                                        <input type="hidden" name="userId" value="${user.userId}">
                                                                        <input type="hidden" name="username" value="${user.username}">
                                                                        <input type="hidden" name="action" value="revokeM">
                                                                        <button type="button" class="dropdown-item" onclick="confirmRevoke('revokeManagerForm_${user.userId}')">Revoke manager</button>
                                                                    </form>
                                                                    <form id="banUserForm_${user.userId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                                                        <input type="hidden" name="userId" value="${user.userId}">
                                                                        <input type="hidden" name="username" value="${user.username}">
                                                                        <input type="hidden" name="action" value="banUserByAd">
                                                                        <button type="button" class="btn btn-danger" onclick="confirmBan('banUserForm_${user.userId}')">Ban user</button>
                                                                    </form>
                                                                </li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li>       
                                                                <li class="w-100">
                                                                    <form id="setManagerForm_${user.userId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                                                        <input type="hidden" name="userId" value="${user.userId}">
                                                                        <input type="hidden" name="username" value="${user.username}">
                                                                        <input type="hidden" name="action" value="setM">
                                                                        <button type="button" class="btn btn-primary" onclick="confirmSetM('setManagerForm_${user.userId}')">Set manager</button>
                                                                    </form>
                                                                </li>
                                                                <form id="banUserForm_${user.userId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                                                    <input type="hidden" name="userId" value="${user.userId}">
                                                                    <input type="hidden" name="username" value="${user.username}">
                                                                    <input type="hidden" name="action" value="banUserByAd">
                                                                    <button type="button" class="btn btn-danger" onclick="confirmBan('banUserForm_${user.userId}')">Ban user</button>
                                                                </form>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </ul>
                                                </div>  
                                            </li>
                                        </c:when>


                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${USER.userRole == 2}">
                                                    <li class="list-inline-item">
                                                        <div class="dropdown d-inline">
                                                            <button class="btn btn-secondary btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="moreOptionsDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                <i class="fas fa-ellipsis-h"></i>
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="moreOptionsDropdown">
                                                                <c:choose>

                                                                    <c:when test="${user.userRole == 0}">
                                                                        <li>
                                                                            <button type="button" class="dropdown-item" disabled>
                                                                                User banned
                                                                            </button>
                                                                        </li>
                                                                    </c:when>

                                                                    <c:when test="${hasReportedMore3}">
                                                                        <li>
                                                                            <form id="banUserForm_${user.userId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                                                                <input type="hidden" name="userId" value="${user.userId}">
                                                                                <input type="hidden" name="username" value="${user.username}">
                                                                                <input type="hidden" name="action" value="banUserByM">
                                                                                <button type="button" class="btn btn-danger" onclick="confirmBan('banUserForm_${user.userId}')">Ban user</button>
                                                                            </form>
                                                                        </li>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <li>
                                                                            <button type="button" class="dropdown-item" disabled>
                                                                                Valid user
                                                                            </button>
                                                                        </li>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </ul>
                                                        </div>  
                                                    </li>
                                                </c:when>


                                                <c:when test="${user.userRole != 3 && (USER.userRole == 1)}">
                                                    <li class="list-inline-item">
                                                        <div class="dropdown d-inline">
                                                            <button class="btn btn-secondary btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="moreOptionsDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                <i class="fas fa-ellipsis-h"></i>
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="moreOptionsDropdown">
                                                                <c:choose>

                                                                    <c:when test="${hasReport}">
                                                                        <li>
                                                                            <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#revokeReportModal_${user.userId}">
                                                                                Revoke report
                                                                            </button>
                                                                        </li>
                                                                        <li>
                                                                            <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#editReportModal_${user.userId}">
                                                                                Edit report
                                                                            </button>
                                                                        </li>
                                                                    </c:when>

                                                                    <c:otherwise>
                                                                        <li>
                                                                            <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#reportModal">
                                                                                Report profile
                                                                            </button>
                                                                        </li>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </ul>
                                                        </div>  
                                                    </li>
                                                </c:when>

                                                <c:otherwise>

                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <form id="reportForm" action="${pageContext.request.contextPath}/report" method="post">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="reportModalLabel">Report personal profile</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="mb-3">
                                                            <label for="reportReason" class="form-label text-center w-100">Reason</label>
                                                            <textarea class="form-control" id="reportReason" name="reportReason" rows="3" required></textarea>
                                                        </div>
                                                        <input type="hidden" name="userId" value="${user.userId}">
                                                        <input type="hidden" name="username" value="${user.username}">
                                                        <input type="hidden" name="userRole" value="${user.userRole}">
                                                        <input type="hidden" name="action" value="rpUser">
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <button type="submit" class="btn btn-primary">Submit report</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal fade" id="revokeReportModal_${user.userId}" tabindex="-1" aria-labelledby="revokeReportModalLabel_${user.userId}" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="revokeReportModalLabel_${user.userId}">Revoke Report</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="${pageContext.request.contextPath}/report" method="post">
                                                        <input type="hidden" name="reportId" value="${user.userId}">
                                                        <input type="hidden" name="username" value="${user.username}">
                                                        <input type="hidden" name="action" value="revokeReportU">
                                                        <p>Are you sure you want to revoke this report?</p>
                                                        <button type="submit" class="btn btn-danger">Revoke Report</button>
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal fade" id="editReportModal_${user.userId}" tabindex="-1" aria-labelledby="editReportModalLabel_${user.userId}" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="editReportModalLabel_${report.reportId}">Edit Report</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="${pageContext.request.contextPath}/report" method="post">
                                                        <input type="hidden" name="reportId" value="${user.userId}">
                                                        <input type="hidden" name="username" value="${user.username}">
                                                        <input type="hidden" name="action" value="editReportU">
                                                        <div class="mb-3">
                                                            <label for="editReason_${user.userId}" class="form-label">New Reason:</label>
                                                            <textarea class="form-control" id="editReason_${user.userId}" name="editReason" rows="3" required></textarea>
                                                        </div>
                                                        <button type="submit" class="btn btn-primary">Save Changes</button>
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <li class="list-inline-item">
                                        <button id="openMessageModal" class="btn btn-primary btn-sm ml-2">
                                            <i class="fas fa-envelope mr-1"></i> Nhắn tin
                                        </button>
                                    </li>

                                    <!-- Modal -->
                                    <div class="modal" id="messageModal">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <!-- Modal Header -->
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Nhập tin nhắn mới</h5>
                                                </div>
                                                <!-- Modal Body -->
                                                <div class="modal-body">
                                                    <form id="sendMessageForm" action="${pageContext.request.contextPath}/messenger" method="post">
                                                        <div class="form-group">
                                                            <label for="messageText">Tin nhắn:</label>
                                                            <textarea class="form-control" id="messageText" name="messageText" rows="3"></textarea>
                                                        </div>
                                                        <input type="hidden" name="toId" value="${user.userId}"> <!-- Thay bằng userId của người dùng cần nhắn tin -->
                                                        <button type="submit" class="btn btn-primary">Gửi</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <script>
                                        document.getElementById('openMessageModal').addEventListener('click', function () {
                                            $('#messageModal').modal('show'); // Sử dụng jQuery để hiển thị modal
                                        });
                                    </script>
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
                                        <h5 class="font-weight-bold mb-0 d-block">${user.userScore}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Score</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${user.userRank}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Rank</small>
                                    </li>
                                    <c:if test="${not empty reportMessage}">
                                        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-delay="3000">
                                            <div class="toast-header">
                                                <strong class="mr-auto">Thông báo</strong>
                                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="toast-body">
                                                ${reportMessage}
                                            </div>
                                        </div>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid pt-0">
                <div class="row form-settings d-flex justify-content-between">
                    <div class="col-12 col-sm-5 px-2">
                        <div class=" bg-white shadow rounded p-4 ">
                            <p class="font-italic mb-2"><i class="ti ti-calendar"></i>Ngày tham gia: ${user.userCreateDate}</p>
                            <p class="font-italic mb-2">Giới tính: ${user.userSex}</p>
                            <p class="font-italic mb-2"><i class="ti ti-feather"></i>${user.userStory}</p>
                        </div>
                    </div>
                    <div class="col-12 col-sm-7 px-2">
                        <!--<div class=" bg-white shadow rounded p-4 ">-->
                        <div class="p0">
                            <h5 class="mb-2">Bài viết của bạn</h5>
                        </div>
                        <div>
                            <c:forEach var="post" items="${posts}">
                                <c:if test="${post.user.userId == user.userId}">
                                    <c:if test="${post.postStatus eq'Public'}">
                                        <%@include file="post.jsp" %>
                                    </c:if>                                
                                </c:if>
                            </c:forEach>
                        </div>
                        <!--</div>-->
                        <%@include file="modalpost.jsp" %>


                    </div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function (event) {
                // Ensure your DOM is fully loaded before executing any code
                var msg = "${sessionScope.msg}";
                console.log("Message from session:", msg);
                // Kiểm tra nếu msg không rỗng, hiển thị thông báo
                if (msg !== null && msg !== "") {
                    swal({
                        title: msg.includes("successfully") ? "Success" : "Error",
                        text: msg,
                        icon: msg.includes("successfully") ? "success" : "error",
                        button: "OK!"
                    });
                    // Xóa msg sau khi hiển thị để tránh hiển thị lại khi tải lại trang
            <% session.removeAttribute("msg"); %>
                }
            });
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

            function confirmCancel() {
                return confirm("Bạn có muốn hủy lời mời này không?");
            }
            function confirmUnfriend() {
                return confirm("Bạn có chắc chắn muốn hủy kết bạn không?");
            }
            function confirmBan(formId) {
                if (confirm("Bạn có chắc chắn muốn thực hiện hành động này không?")) {
                    document.getElementById(formId).submit();
                }
            }
            function confirmRevoke(formId) {
                if (confirm("Bạn có chắc chắn muốn thu hồi quyền manager của người dùng này?")) {
                    document.getElementById(formId).submit();
                }
            }
            function confirmSetM(formId) {
                if (confirm("Bạn có chắc chắn muốn set quyền manager của người dùng này?")) {
                    document.getElementById(formId).submit();
                }
            }
        </script>
</body>
<%@ include file="../include/footer.jsp" %>


