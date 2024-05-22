<%-- 
    Document   : lost-account
    Created on : May 13, 2024, 7:42:43 AM
    Author     : mac
--%>
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
    </head>

    <body>
        <!--  Body Wrapper -->
        <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
             data-sidebar-position="fixed" data-header-position="fixed">
            <div
                class="position-relative overflow-hidden radial-gradient min-vh-100 d-flex align-items-center justify-content-center">
                <div class="d-flex align-items-center justify-content-center w-100">
                    <div class="row justify-content-center w-100">
                        <div class="col-md-8 col-lg-4 col-xxl-3">
                            <div class="card mb-0">
                                <div class="card-body px-4">
                                    <a href="${pageContext.request.contextPath}/" class="text-nowrap logo-img text-center d-block py-3 w-100">
                                        <img src="${pageContext.request.contextPath}/static/images/logo.png" width="100" alt="">
                                    </a>
                                    <p class="text-center">FPTer</p>
                                    <form action="lostaccount" method="post">
                                        <div class="mb-3">
                                            <label for="identify" class="form-label">Email</label>
                                            <input type="text" class="form-control" placeholder="Enter email" id="identify" name="identify" autofocus>
                                        </div>

                                        <c:if test="${not empty message}">
                                            <div class="alert alert-info">${message}</div>
                                        </c:if>
                                        <button type="submit" value="Submit" class="btn btn-primary w-100 py-8 fs-4 mb-4 rounded-2">Sent mail reset password</button>

                                        <div class="d-flex align-items-center justify-content-center">
                                            <a class="text-primary fw-bold ms-2" href="${pageContext.request.contextPath}/register">Create an account</a>
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
    </body>

</html>