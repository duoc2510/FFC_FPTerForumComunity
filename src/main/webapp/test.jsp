<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>News Feed</title>
    </head>
    <body>
        <h1>News Feed</h1>
        <p>Welcome, ${user.username}!</p>

        <%-- Lặp qua danh sách bài viết --%>
        <c:forEach var="post" items="${posts}">
            <div>
                <h3>Post ID: ${post.postId}</h3>
                <p>Content: ${post.content}</p>

                <%-- Kiểm tra xem bài viết có thông tin người đăng không --%>
                <c:if test="${not empty post.user}">
                    <p><strong>Author:</strong> ${post.user.username}</p>
                    <p><strong>User ID:</strong> ${post.user.userId}</p>
                </c:if>

                <hr>
            </div>
        </c:forEach>
    </body>
</html>
