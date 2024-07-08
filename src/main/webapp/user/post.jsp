<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<div class="col-lg-12">
    <div class="w-100">
        <div class="p-4 bg-white shadow rounded mb-3">
            <div class="pb-3 d-flex row">
                <div class="col-1 text-center mt-2">
                    <c:choose>
                        <c:when test="${post.userId == USER.userId}">
                            <a href="${pageContext.request.contextPath}/profile">
                                <img src="${pageContext.request.contextPath}/${post.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/profile?username=${post.user.username}">
                                <img src="${pageContext.request.contextPath}/${post.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-9 mx-3">
                    <h6 class="card-title fw-semibold mb-4 d-inline">${post.user.username}</h6>
                    <a href="${pageContext.request.contextPath}/post/detail?postId=${post.postId}" class="s-4">${post.createDate}</a>
                </div>
                <c:choose>
                    <c:when test="${post.user.userId == USER.userId}">
                        <div class="dropdown col-1 px-2" style="text-align: right">
                            <a class="dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <span><i class="ti-more-alt"></i></span>   
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
                    </c:when>
                    <c:otherwise>
                        <div class="dropdown col-1 px-2" style="text-align: right">
                            <a class="dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <span><i class="ti-more-alt"></i></span>   
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="moreOptionsDropdownPost">
                                <c:choose>

                                    <c:when test="${post.hasReportPost}">
                                        <li>

                                            <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#cancelReportModal_${post.postId}">
                                                Revoke report
                                            </button>

                                        </li>
                                        <li>
                                            <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#editPostReportModal">
                                                Edit post report
                                            </button>
                                        </li>
                                    </c:when>

                                    <c:otherwise>

                                        <c:choose>

                                            <c:when test="${USER.userRole == 1 || (post.user.userRole == 2 && USER.userRole==2)}">
                                                <li>
                                                    <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#reportPostModal_${post.postId}">
                                                        Report post
                                                    </button>
                                                </li>
                                            </c:when>

                                            <c:when test="${USER.userRole == 2 || USER.userRole == 3}">
                                                <li>
                                                    <c:choose>
                                                        <c:when test="${post.hasReportedPost}">
                                                            <form id="banPostForm_${post.postId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                                                <input type="hidden" name="postId" value="${post.postId}">
                                                                <input type="hidden" name="action" value="banPostMore3Time">
                                                                <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#banPostModal3Time_${post.postId}">
                                                                    Ban Post(has been reported) 
                                                                </button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <form id="banPostForm_${post.postId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                                                <input type="hidden" name="postId" value="${post.postId}">
                                                                <input type="hidden" name="action" value="banPostByAd">
                                                                <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#banPostModal_${post.postId}">
                                                                    Ban Post
                                                                </button>
                                                            </form>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </li>
                                            </c:when>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>


                        <div class="modal fade" id="reportPostModal_${post.postId}" tabindex="-1" aria-labelledby="reportPostModalLabel_${post.postId}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form id="reportPostForm_${post.postId}" action="${pageContext.request.contextPath}/report" method="post">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="reportPostModalLabel_${post.postId}">Report post</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <label for="reportPostReason_${post.postId}" class="form-label">Reason</label>
                                                <textarea class="form-control" id="reportPostReason_${post.postId}" name="reportReason" rows="3" required></textarea>
                                            </div>

                                            <input type="hidden" name="postId" value="${post.postId}">
                                            <input type="hidden" name="userId" value="${post.user.userId}">
                                            <input type="hidden" name="userRole" value="${post.user.userRole}">
                                            <input type="hidden" name="action" value="rpPost">
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-primary">Submit report</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="cancelReportModal_${post.postId}" tabindex="-1" aria-labelledby="cancelReportModalLabel_${post.postId}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="cancelReportModalLabel_${post.postId}">Cancel Report</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="${pageContext.request.contextPath}/report" method="post">
                                            <input type="hidden" name="postId" value="${post.postId}">

                                            <input type="hidden" name="action" value="cancelReportPost">
                                            <p>Are you sure you want to revoke this report?</p>
                                            <button type="submit" class="btn btn-danger">Cancel Report</button>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="editPostReportModal" tabindex="-1" aria-labelledby="editPostReportModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editPostReportModalLabel">Edit Post Report</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="${pageContext.request.contextPath}/report" method="post">
                                            <input type="hidden" name="postId" value="${post.postId}">

                                            <input type="hidden" name="action" value="editPostReport">
                                            <div class="mb-3">
                                                <label for="editReason" class="form-label">New Reason:</label>
                                                <textarea class="form-control" id="editReason" name="editReason" rows="3" required></textarea>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Save Changes</button>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="banPostModal_${post.postId}" tabindex="-1" aria-labelledby="banPostModalLabel_${post.postId}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="banPostModalLabel_${post.postId}">Enter the reason for banning the post</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form id="banPostFormReason_${post.postId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                            <input type="hidden" name="postId" value="${post.postId}">

                                            <input type="hidden" name="reportedId" value="${post.userId}">
                                            <input type="hidden" name="postContent" value="${post.content}">
                                            <input type="hidden" name="action" value="banPost">   
                                            <div class="mb-3">
                                                <label for="banReason_${post.postId}" class="form-label">Reason for banning posts:</label>
                                                <textarea class="form-control" id="banReason_${post.postId}" name="banReason" rows="3" required></textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" form="banPostFormReason_${post.postId}" class="btn btn-danger">Ban post</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="banPostModal3Time_${post.postId}" tabindex="-1" aria-labelledby="banPostModalLabel_${post.postId}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="banPostModalLabel_${post.postId}">Enter the reason for banning the post </h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form id="banPostFormReason3Time_${post.postId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                                            <input type="hidden" name="postId" value="${post.postId}">

                                            <input type="hidden" name="reportedId" value="${post.userId}">
                                            <input type="hidden" name="postContent" value="${post.content}">
                                            <input type="hidden" name="action" value="banPostMore3Time">   
                                            <div class="mb-3">
                                                <label for="banReason_${post.postId}" class="form-label">Reason for banning posts:</label>
                                                <textarea class="form-control" id="banReason_${post.postId}" name="banReason" rows="3" required></textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" form="banPostFormReason3Time_${post.postId}" class="btn btn-danger">Ban post</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="mt-1">
                <p class="fs-8">${post.content}</p>

                <c:if test="${not empty post.uploadPath}">
                    <img src="${pageContext.request.contextPath}/${post.uploadPath}" alt="Post Image" class="post-image rounded mx-auto d-block">
                </c:if>
            </div>
            <div class="">
                <div class="row p-3 d-flex justify-content-center text-center">
                    <!-- Like button (Th? <a>), hi?n th? khi ch?a like -->
                    <span id="like-count-${post.postId}">Post Likes: ${post.likeCount}</span>

                    <!-- Nút Like -->
                    <a href="#" id="like-btn-${post.postId}" class="col nav-link nav-icon-hover" style="${post.likedByCurrentUser ? 'display:none;' : ''}" onclick="handleLike(event, ${post.postId}, 'like')" data-postid="${post.postId}" data-action="like">
                        <span><i class="ti ti-message-plus" style="color: green;"></i></span>
                        <span class="hide-menu" style="color: green;">Like</span>
                    </a>

                    <!-- Nút Unlike -->
                    <a href="#" id="unlike-btn-${post.postId}" class="col nav-link nav-icon-hover" style="${post.likedByCurrentUser ? '' : 'display:none;'}" onclick="handleLike(event, ${post.postId}, 'unlike')" data-postid="${post.postId}" data-action="unlike">
                        <span><i class="ti ti-message-minus" style="color: red;"></i></span>
                        <span class="hide-menu" style="color: red;">Unlike</span>
                    </a>

                    <a class="col nav-link nav-icon-hover">
                        <span><i class="ti ti-message-plus"></i></span>
                        <span class="hide-menu">Comment</span>
                    </a>

                </div>
                <form action="${pageContext.request.contextPath}/comment" method="post" class="input-group">
                    <input type="hidden" name="action" value="addComment">
                    <input type="hidden" name="postId" value="${post.postId}">
                    <input type="hidden" name="userId" value="${user.userId}">
                    <input type="text" class="form-control" name="content" placeholder="Write a comment" required>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
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
                                            <a href="${pageContext.request.contextPath}/profile?username=${comment.user.username}">
                                                <img src="${pageContext.request.contextPath}/${comment.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="ms-2 ">
                                        <h6 class="card-title fw-semibold mb-0">${comment.user.username}</h6> <p>${comment.content}</p>
                                        <small>${comment.date}</small>
                                    </div>
                                </div>
                                <c:if test="${comment.user.userId == USER.userId}">
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

<div class="modal fade" id="reportPostModal_${post.postId}" tabindex="-1" aria-labelledby="reportPostModalLabel_${post.postId}" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reportPostModalLabel_${post.postId}">Ban Post</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="confirmBanPostForm_${post.postId}" action="${pageContext.request.contextPath}/manager/report" method="post">
                    <input type="hidden" name="postId" value="${post.postId}">
                    <input type="hidden" name="userId" value="${post.user.userId}">
                    <input type="hidden" name="postContent" value="${post.content}">
                    <input type="hidden" name="action" value="banPostByAd">
                    <div class="mb-3">
                        <label for="banReason_${post.postId}" class="form-label">Ban Reason</label>
                        <textarea class="form-control" id="banReason_${post.postId}" name="banReason" rows="3" required></textarea>
                    </div>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" onclick="confirmBan('confirmBanPostForm_${post.postId}')">Ban Post</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
                        document.addEventListener("DOMContentLoaded", function (event) {
                            // Ensure your DOM is fully loaded before executing any code
                            var msg = "${sessionScope.msg}";
                            console.log("Message from session:", msg);

                            if (msg !== null && msg !== "") {
                                swal({
                                    title: msg.includes("successfully") ? "Success" : "Error",
                                    text: msg,
                                    icon: msg.includes("successfully") ? "success" : "error",
                                    button: "OK!"
                                });

    <% session.removeAttribute("msg"); %>
                            }
                        });
                        function handleLike(event, postId, action) {
                            event.preventDefault();

                            $.ajax({
                                type: 'POST',
                                url: '${pageContext.request.contextPath}/rate',
                                data: {
                                    postId: postId,
                                    action: action
                                },
                                success: function (response) {
                                    $('#like-count-' + postId).text('Likes: ' + response.likeCount);

                                    // C?p nh?t tr?ng thái hi?n th? c?a các th? <a>
                                    if (action === 'like') {
                                        $('#like-btn-' + postId).hide();
                                        $('#unlike-btn-' + postId).show();
                                    } else if (action === 'unlike') {
                                        $('#like-btn-' + postId).show();
                                        $('#unlike-btn-' + postId).hide();
                                    }
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    console.error('Error:', errorThrown);
                                }
                            });
                        }
                        function confirmBan(formId) {
                            if (confirm("Are you sure you want to perform this action?")) {
                                document.getElementById(formId).submit();
                            }
                        }
</script>
