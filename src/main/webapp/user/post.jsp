<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" type="button" href="javascript:void(0)">Report</a>
                                </li>
                            </ul>
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
                    <a class="col nav-link nav-icon-hover" href="javascript:void(0)">
                        <span><i class="ti ti-share"></i></span>
                        <span class="hide-menu">Share</span>
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
                                    <div class="ms-2">
                                        <h6 class="card-title fw-semibold mb-0">${comment.user.username}: ${comment.content}</h6>
                                        <p class="s-4">${comment.date}</p>
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
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
</script>
