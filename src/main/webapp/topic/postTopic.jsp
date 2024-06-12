<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<div class="tab-pane fade ${topic.topicId == topics[0].topicId ? 'show active' : ''}" id="${topic.topicId}-pane" role="tabpanel" aria-labelledby="${topic.topicId}-tab" tabindex="0">
    <table class="table table-hover">
        <thead>
            <tr>            
                <th scope="col">#</th>
                <th scope="col">Topic</th>
                <th scope="col">Title</th>
                <th scope="col">Author</th>
            </tr>
        </thead>
        <tbody>
        <c:set var="counter" value="1" />
        <c:set var="hasPosts" value="false" />
        <c:forEach var="post" items="${posts}">
            <c:if test="${post.topicId == topic.topicId && post.status eq 'Active'}">
                <tr>
                    <td>${counter}</td>
                    <td><a href="${pageContext.request.contextPath}/topic/${topic.topicId}">${topic.topicName}</a></td>
                    <td><a href="${pageContext.request.contextPath}/post/${post.postId}">${post.content}</a></td>
                    <td><a href="${pageContext.request.contextPath}/profile?username=${post.user.username}">${post.user.username}</a></td>
                </tr>
                <c:set var="counter" value="${counter + 1}" />
                <c:set var="hasPosts" value="true" />
            </c:if>
        </c:forEach>
        <c:if test="${not hasPosts}">
            <tr>
                <td colspan="4">Không có bài viết nào cho chủ đề này.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>