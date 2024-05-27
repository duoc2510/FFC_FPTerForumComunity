<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Group Details</title>
    <!-- Add your CSS and JS links here -->
</head>
<body>
    <c:set var="message" value="${sessionScope.message}" scope="page"/>
    <c:set var="error" value="${sessionScope.error}" scope="page"/>
    <c:remove var="message" scope="session"/>
    <c:remove var="error" scope="session"/>

    <c:if test="${not empty message}">
        <div class="alert alert-success">
            ${message}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            ${error}
        </div>
    </c:if>

    <!-- Your existing group details content here -->
</body>
</html>
