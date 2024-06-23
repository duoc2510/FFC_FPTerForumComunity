<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.logging.*" %>
<%
    Logger logger = Logger.getLogger("errorLogger");
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage == null) {
        errorMessage = "An unexpected error occurred.";
    }
    logger.log(Level.SEVERE, errorMessage);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #d9534f;
        }
        p {
            font-size: 16px;
            color: #333;
        }
        a {
            color: #0275d8;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Error</h1>
        <p><%= errorMessage %></p>
        <p>Something went wrong while processing your request. Please try again later.</p>
        <p>If the problem persists, please contact our support team.</p>
        <p><a href="<%= request.getContextPath() %>/index.jsp">Go back to homepage</a></p>
    </div>
</body>
</html>
