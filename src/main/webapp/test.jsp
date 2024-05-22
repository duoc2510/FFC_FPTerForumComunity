<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Detail</title>
    </head>
    <body>
        <h1>User Detail</h1>
        <div class="user-detail">
            <h2>User Info</h2>
            <div class="user-info">
                <p>User Name: ${userInfo.username}</p>
                <p>Email: ${userInfo.userEmail}</p>
            </div>
        </div>
    </body>
</html>
