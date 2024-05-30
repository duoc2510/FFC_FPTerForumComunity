<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
        <!-- Iterate over topics and display each topic as a row -->
        <c:forEach var="topic" items="${topics}">
            <tr id="topic-row-${topic.topicId}">
                <th scope="row">${topic.topicId}</th>
                <td>${topic.topicName}</td>
                <td>${topic.description}</td>
                <td>
                    <!-- Delete form for each topic -->
                    <form action="deleteTopic" method="get">
                        <input type="hidden" name="topicId" value="${topic.topicId}">
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<c:if test="${not empty successMessage}">
        <div class="success-message">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="error-message">${errorMessage}</div>
    </c:if>