<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table class="table table-hover">
    <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">Topic</th>
            <th scope="col">Description</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="topic" items="${topics}">
            <tr>
                <th scope="row">${topic.topicId}</th>
                <td>${topic.topicName}</td>
                <td>${topic.description}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

