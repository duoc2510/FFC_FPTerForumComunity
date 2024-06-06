<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<table class="table table-hover">
    <!-- Table header -->
    <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">Topic</th>
            <th scope="col">Description</th>
    <c:if test="${USER.userRole > 1}">
        <th scope="col">Action</th>
    </c:if>
</tr>
</thead>
<!-- Table body -->
<tbody>
    <!-- Iterate over topics and display each topic as a row -->
<c:forEach var="topic" items="${topics}" varStatus="loop">
    <tr id="topic-row-${topic.topicId}">
        <th scope="row">${loop.index + 1}</th>
        <td>${topic.topicName}</td>
        <td>${topic.description}</td>
    <c:if test="${USER.userRole > 1}">
        <td>
            <!-- Delete form for each topic -->
            <form action="deleteTopic" method="get">
                <input type="hidden" name="topicId" value="${topic.topicId}">
                <button type="submit" class="btn btn-danger">Delete</button>
            </form>
        </td>
    </c:if>
    </tr>
</c:forEach>
</tbody>
</table>
