
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
                            .profile img{
                                top: 20em;
                            }
                        </style>
                        <div class="bg-white shadow rounded overflow-hidden ">
                            <div class="px-4 py-4 cover cover " style="background: url(${pageContext.request.contextPath}/upload/deli-2.png); height:250px;" >
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}" class="position-absolute rounded-circle img-thumbnail" style="object-fit: cover;">
                                        <div>
                                            <a href="${pageContext.request.contextPath}/profile/setting" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">Edit profile</a>
                                            <a href="${pageContext.request.contextPath}/profile?username=${USER.username}" class="btn btn-outline-dark btn-sm btn-block edit-cover">View profile</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                        
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center ">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0 position-relative" style="left: 6.5em">${USER.userFullName}</h4>     
                                </div>
                                <ul class="list-inline mb-0">
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
                                        <h5 class="font-weight-bold mb-0 d-block">${USER.userScore}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Score</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${USER.userRank}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Rank</small>
                                    </li>
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

                            <p class="font-italic mb-2"><i class="ti ti-calendar"></i>Ngày tham gia: ${USER.userCreateDate}</p>
                            <p class="font-italic mb-2">Giới tính: ${USER.userSex}</p>
                            <p class="font-italic mb-2"><i class="ti ti-feather"></i>${USER.userStory}</p>
                            <li class="list-inline-item w-100 mt-2">
                                <a href="friends" class="btn btn-outline-dark btn-sm w-100">List friends</a>
                            </li>
                        </div>

                    </div>
                    <div class="col-12 col-sm-7 px-2">
                        <div class=" bg-white shadow rounded p-4 ">
                            <div class="p0">
                                <h5 class="mb-2">Có gì mới không nà ${USER.userFullName} ơi</h5>
                            </div>
                            <div>
                                <form id="postForm" action="addpost" method="post" enctype="multipart/form-data">
                                    <div class="form-group pb-3">
                                        <label for="postStatus">Status</label>
                                        <select class="form-control" id="postStatus" name="postStatus">
                                            <option value="Public">Public</option>
                                            <option value="Friends">Friends</option>
                                            <option value="Only me">Only me</option>
                                        </select>
                                    </div>
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
                                    <button type="submit" class="btn btn-primary">Add Post</button>
                                </form>
                            </div>
                        </div>
                        <div class=" bg-white shadow rounded p-4 mt-4">

                            <div class="p0">
                                <h5 class="mb-2">Bài viết của bạn</h5>
                            </div>
                            <div>
                                <c:forEach var="post" items="${posts}">
                                    <c:if test="${post.user.userId == USER.userId && post.status eq null}">
                                        <%@include file="post.jsp" %>
                                    </c:if>
                                </c:forEach>

                                <%@include file="modalpost.jsp" %>
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

                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
