
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
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
                            .dropdown-menu {
                                transform: translateY(0) !important;
                            }
                            .modal-dialog-centered {
                                display: flex !important;
                                align-items: center;
                                min-height: calc(100% - 4.5rem);
                            }
                            .modal-content {
                                padding: 20px;
                            }
                        </style>



                        <div class="bg-white shadow rounded overflow-hidden ">
                            <div class="px-4 py-4 cover cover " style="background: url(${pageContext.request.contextPath}/upload/deli-2.png)">
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
                                                <ul class="dropdown-menu" aria-labelledby="friendDropdown">
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
                                    <li class="list-inline-item">
                                        <div class="dropdown d-inline">
                                            <button class="btn btn-secondary btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="moreOptionsDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                <i class="fas fa-ellipsis-h"></i>
                                            </button>
                                            <ul class="dropdown-menu" aria-labelledby="moreOptionsDropdown">
                                                <c:choose>
                                                    <c:when test="${hasReport}">
                                                        
                                                        <li>
                                                            <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#revokeReportModal">
                                                                Revoke report
                                                            </button>
                                                        </li>
                                                        <li>
                                                            <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#editReportModal">
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
                            <div class="px-4 py-3">
                                <p class="font-italic mb-0"><i class="ti ti-calendar"></i>Ngày tham gia: ${user.userCreateDate}</p>
                                <p class="font-italic mb-0">Giới tính: ${user.userSex}</p>
                                <div class="p-4 rounded shadow-sm">
                                    <p class="font-italic mb-0">${user.userStory}<i class="ti ti-feather"></i></p>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container-fluid pt-0">
                <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">
                    <div class="p0">
                        <h5 class="mb-2">Bài viết của ${user.userFullName}</h5>
                    </div>
                    <div>
                        <c:forEach var="post" items="${posts}">
                            <c:if test="${post.user.userId == user.userId}">
                                <c:if test="${post.postStatus eq'Public'}">
                                    <%@include file="post.jsp" %>
                                </c:if>                                
                            </c:if>
                        </c:forEach>
                        <%@include file="modalpost.jsp" %>


                    </div>
                </div>
            </div>
        </div>
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

            function confirmCancel() {
                return confirm("Bạn có muốn hủy lời mời này không?");
            }
            function confirmUnfriend() {
                return confirm("Bạn có chắc chắn muốn hủy kết bạn không?");
            }
            document.addEventListener('DOMContentLoaded', function () {
                var reportForm = document.getElementById('reportForm');

                reportForm.addEventListener('submit', function (event) {
                    // Bạn có thể thêm các kiểm tra hoặc xử lý khác tại đây
                    // Nếu cần thiết, ngăn chặn gửi form bằng cách sử dụng event.preventDefault();
                });
            });

            $('.toast').toast('show');
            // Xóa reportMessage khỏi session
            <c:remove var="reportMessage" scope="session"/>;
        </script>
</body>
<%@ include file="../include/footer.jsp" %>
