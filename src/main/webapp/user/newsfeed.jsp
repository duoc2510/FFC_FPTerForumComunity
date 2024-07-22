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
                    <div id="profile-wrapper" style="max-width: 650px ; margin:auto;">
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
                         <%@include file="post_ads.jsp" %>
                        <c:forEach var="post" items="${postsUser}">
                            <c:if test="${ post.postStatus eq 'Public' && post.status ne 'banned'}">
                                <%@include file="post.jsp" %>
                               
                            </c:if>
                        </c:forEach>


                        <!--QUANG CAO--> 
                        <!--2 BAI XUAT HIEN QUANG CAO 1 LAN--> 
                      


                        <!--QUANG CAO--> 





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
                            $(document).ready(function () {
                                // Bắt sự kiện gửi bình luận khi nhấn nút Submit
                                $('form[action="${pageContext.request.contextPath}/comment"]').submit(function (event) {
                                    // Ngăn chặn hành động mặc định của form
                                    event.preventDefault();
                                    // Lấy dữ liệu từ form
                                    var formData = $(this).serialize();
                                    // Gửi yêu cầu AJAX để thêm bình luận
                                    $.ajax({
                                        type: "POST",
                                        url: $(this).attr('action'),
                                        data: formData,
                                        success: function (response) {
                                            // Xử lý phản hồi từ máy chủ nếu cần
                                            console.log(response);
                                            // Ví dụ: làm mới trang để hiển thị bình luận mới
                                            window.location.reload();
                                        },
                                        error: function (xhr, status, error) {
                                            // Xử lý lỗi nếu có
                                            console.error('Error:', error);
                                            // Ví dụ: hiển thị thông báo lỗi cho người dùng
                                            alert('Failed to add comment. Please try again later.');
                                        }
                                    });
                                });
                            });
                        </script>

                    </div>
                </div>
            </div>
            <%@ include file="../include/right-slidebar.jsp" %>
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>