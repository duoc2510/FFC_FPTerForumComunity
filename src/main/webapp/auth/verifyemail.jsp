<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>FPTer</title>
        <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/static/images/logos/favicon.png" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/styles.min.css" />
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <!--  Body Wrapper -->
        <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
             data-sidebar-position="fixed" data-header-position="fixed">
            <div class="position-relative overflow-hidden radial-gradient min-vh-100 d-flex align-items-center justify-content-center">
                <div class="d-flex align-items-center justify-content-center w-100">
                    <div class="row justify-content-center w-100">
                        <div class="col-md-8 col-lg-4 col-xxl-3">
                            <div class="card mb-0">
                                <div class="card-body px-4">
                                    <a href="${pageContext.request.contextPath}/" class="text-nowrap logo-img text-center d-block py-3 w-100">
                                        <img src="${pageContext.request.contextPath}/static/images/logo.png" width="100" alt="">
                                    </a>
                                    <p class="text-center">FPTer</p>
                                    <p class="text-center">We have sent a 5-digit code to your email: ${email} </p>
                                    <h1 class="text-center">Enter Verify Number</h1>
                                    <form method="post" action="verifyemail">
                                        <div class="form-group">
                                            <label for="number">Enter a 5-digit Number:</label>
                                            <input type="number" class="form-control" id="number" name="number" min="10000" max="99999" required>
                                        </div>
                                        <%-- Ô input ẩn --%>
                                        <input type="hidden" id="status" name="status" value="${status}">
                                        <input type="hidden" id="x" name="x" value="${x}">
                                        <input type="hidden" id="mail" name="email" value="${email}">
                                        <input type="hidden" id="name" name="userName" value="${userName}">
                                        <input type="hidden" id="pass" name="password" value="${password}">
                                        <c:if test="${not empty message}">
                                            <div class="alert alert-info">${message}</div>
                                        </c:if>
                                        <div class="d-flex justify-content-between mt-3">
                                            <a href="register" class="btn btn-link">Cancel</a>
                                            <input type="submit" class="btn btn-primary" value="Submit">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/static/libs/jquery/dist/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>

</html>
