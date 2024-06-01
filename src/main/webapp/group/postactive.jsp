<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="postsContainer">
    <div class="post-card post-active col-lg-12">
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
                                <a href="${pageContext.request.contextPath}/viewProfile?username=${post.user.username}">
                                    <img src="${pageContext.request.contextPath}/${post.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="col-10">
                        <h6 class="card-title fw-semibold mb-4 d-inline">${post.user.username}</h6>
                        <p class="s-4">${post.createDate}</p>
                    </div>
                    <c:if test="${post.user.userId == USER.userId}">
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
                    </c:if>
                </div>
                <div class="mt-3">
                    <p>${post.content}</p>
                    <c:if test="${not empty post.uploadPath}">
                        <img src="${pageContext.request.contextPath}/${post.uploadPath}" alt="Post Image" class="post-image">
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
                                                <a href="${pageContext.request.contextPath}/viewProfile?username=${comment.user.username}">
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
</div>
<script src="group.js"></script>