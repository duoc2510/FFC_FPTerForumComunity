<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12">
    <div class="card w-100">
        <div class="card-body p-4">
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
                <div class="col-10">
                    <h6 class="card-title fw-semibold mb-4 d-inline">${post.user.username}</h6>
                    <p class="s-4">${post.createDate}</p>
                </div>
                <c:choose>
                    <c:when test="${post.user.userId == USER.userId}">
                        <!-- Dropdown menu for the post owner -->
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
                        <!-- Dropdown menu for the post owner -->
                        <div class="dropdown col-1 px-2" style="text-align: right">
                            <a class="dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <span><i class="ti-more-alt"></i></span>   
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="moreOptionsDropdownPost">
                                <c:choose>
                                    <c:when test="${post.hasReportPost}">
                                        <li>
                                            <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#revokePostReportModal">
                                                Revoke post report
                                            </button>
                                        </li>
                                        <li>
                                            <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#editPostReportModal">
                                                Edit post report
                                            </button>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#reportPostModal">
                                                Report post
                                            </button>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>


                            <div class="modal fade" id="reportPostModal" tabindex="-1" aria-labelledby="reportPostModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <form id="reportPostForm" action="${pageContext.request.contextPath}/report" method="post">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="reportPostModalLabel">Report post</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="mb-3">
                                                    <label for="reportPostReason" class="form-label">Reason</label>
                                                    <textarea class="form-control" id="reportPostReason" name="reportReason" rows="3" required></textarea>
                                                </div>

                                                <input type="hidden" name="postId" value="${post.postId}">
                                                <input type="hidden" name="userId" value="${post.user.userId}">
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
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Option to delete post for the post author -->
            <div class="mt-3">
                <p class="fs-6">${post.content}</p>
                <c:if test="${not empty post.uploadPath}">
                    <img src="${pageContext.request.contextPath}/${post.uploadPath}" alt="Post Image" class="post-image rounded mx-auto d-block">
                </c:if>
            </div>
            <div class="">
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
                <form action="${pageContext.request.contextPath}/comment" method="post" class="input-group">
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