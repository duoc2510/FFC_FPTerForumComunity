<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<table class="table table-hover">
    <!-- Table header -->
    <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">Topic</th>
            <th scope="col">Description</th>
            <th scope="col">Action</th>
        </tr>   
    </thead>
    <!-- Table body -->
    <tbody>
    <c:forEach var="topic" items="${topics}" varStatus="loop">
        <tr id="topic-row-${topic.topicId}">
            <th scope="row">${loop.index + 1}</th>
            <td>${topic.topicName}</td>
            <td>${topic.description}</td>
        <c:if test="${USER.userRole > 1}">
            <td>
                <form action="home" method="post">
                    <input type="hidden" name="topicId" value="${topic.topicId}">
                    <input type="hidden" name="action" value="deletetopic">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </td>
        </c:if>
        <c:if test="${USER.userRole == 1}">
            <td>
                <form action="${pageContext.request.contextPath}/follow" method="post">
                    <input type="hidden" name="topicId" value="${topic.topicId}">
                    <c:choose>
                        <c:when test="${topic.followed}">
                            <input type="hidden" name="action" value="unfollow">
                            <button type="submit" class="btn btn-secondary">Unfollow</button>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="action" value="follow">
                            <button type="submit" class="btn btn-primary">Follow</button>
                        </c:otherwise>
                    </c:choose>
                </form>
            </td>
        </c:if>
        </tr>
    </c:forEach>
</tbody>
</table>
