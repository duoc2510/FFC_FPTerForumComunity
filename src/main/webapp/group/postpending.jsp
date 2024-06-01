<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="postsContainer">
    <div class="post-card post-pending col-lg-12">
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
                    <c:if test="${post.user.userId == user.userId}">
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
                <div class="mt-3 text-center">
                    <!-- Accept and Deny buttons -->
                    <form action="${pageContext.request.contextPath}/inGroup?groupId=${group.groupId}" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="acceptPost">
                        <input type="hidden" name="postId" value="${post.postId}">
                        <button type="submit" class="btn btn-success">Accept</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/inGroup?groupId=${group.groupId}" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="denyPost">
                        <input type="hidden" name="postId" value="${post.postId}">
                        <button type="submit" class="btn btn-danger">Deny</button>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
