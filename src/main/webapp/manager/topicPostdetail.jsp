<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<div class="col-lg-12 w-100">
    <style>
        .card .avatar img {
            width: 100%;
            object-fit: cover;
            aspect-ratio: 1 / 1;
        }
        .card-content img {
            height: 300px;
            object-fit: cover;
        }
    </style>
    <div class="row">
        <div class="card">
            <div class="card-body p-4 row">
                <div class="col-sm-2 px-2 text-center" style="padding-right: 1rem">
                    <div class="avatar">
                        <img class="rounded-circle" src="${pageContext.request.contextPath}/${post.user.userAvatar}">
                    </div>
                    <h4><a href="${pageContext.request.contextPath}/profile?username=${post.user.username}">${post.user.username}</a></h4>
                    <h5>Topic: ${topic.topicName}</h4>
                </div>
                <div class="col-sm-10">
                    <div class="content p-sm-2">
                        <p class="date-time">${post.createDate}</p>
                        <h2 class="main-content">${post.content}</h2>
                        <c:if test="${not empty post.uploadPath}">
                            <h5 class="my-4">Đính kèm </h5>
                            <div class="row mx-0">
                                <div class="col-sm-4 px-sm-2">
                                    <div class="card card-content">
                                        <img src="${pageContext.request.contextPath}/${post.uploadPath}" class="card-img-top" alt="...">
                                    </div>
                                </div>
                            </div>
                        </c:if>

                    </div>
                </div>
                <div class="mt-3 text-center">
                    <!-- Nút Accept -->
                    <form action="${pageContext.request.contextPath}/manager/post" method="post" style="display:inline;" onsubmit="showPopup('Bài đăng đã được chấp nhận.');">
                        <input type="hidden" name="action" value="acceptPost">
                        <input type="hidden" name="postId" value="${post.postId}">
                        <input type="hidden" name="reason" value="1">
                        <button type="submit" class="btn btn-success">Accept</button>
                    </form>
                    <!-- Nút Deny -->
                    <form style="display:inline;">
                        <button type="button" class="btn btn-danger" onclick="showDenyModal('${post.postId}')">Deny</button>
                    </form>
                </div>
                <div class="modal fade" id="denyModal" tabindex="-1" aria-labelledby="denyModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="denyModalLabel">Nhập lý do từ chối</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body" onsubmit="showPopup('Bài đăng đã bị từ chối.');">
                                <form id="denyForm" action="${pageContext.request.contextPath}/manager/post" method="post">
                                    <input type="hidden" name="action" value="denyPost">
                                    <input type="hidden" id="modalPostId" name="postId" value="">
                                    <div class="mb-3">
                                        <label for="reason" class="form-label">Lý do từ chối</label>
                                        <textarea class="form-control" id="reason" name="reason" required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-danger">Gửi</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal thông báo -->
                <div class="modal fade" id="popupModal" tabindex="-1" aria-labelledby="popupModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="popupModalLabel">Thông báo</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p id="popupMessage"></p>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>   
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            function showDetail(src) {
                Swal.fire({
                    html: `
                        <div class="card text-bg-dark">
                            <img src="${src}" class="card-img" alt="...">
                        </div>
                    `,
                    showCloseButton: true,
                });
            }

            // Attach click event to all images with the class 'card-img-top'
            document.querySelectorAll('.card-img-top').forEach(img => {
                img.addEventListener('click', function () {
                    showDetail(this.src);
                });
            });
        });
        function showDenyModal(postId) {
            document.getElementById('modalPostId').value = postId;
            var myModal = new bootstrap.Modal(document.getElementById('denyModal'));
            myModal.show();
        }
        // Hàm hiển thị thông báo
        function showPopup(message) {
            // Hiển thị modal chứa thông báo
            var popupModal = document.getElementById("popupModal");
            var messageElement = document.getElementById("popupMessage");
            messageElement.innerText = message;
            var popup = new bootstrap.Modal(popupModal);
            popup.show();
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</div>