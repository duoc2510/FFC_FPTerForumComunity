<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                                    <form name="input" action="logingooglehandler" method="post">
                                        <div class="mb-3">
                                            <label for="identify" class="form-label">Email</label>
                                            <input type="text" class="form-control" placeholder="Enter email or Username" id="identify" name="identify" value="${cookie.identify.value}" autofocus>
                                        </div>
                                        <div class="mb-4">
                                            <label for="password" class="form-label">Password</label>
                                            <input type="password" id="password" name="password" class="form-control" placeholder="Enter password" value="${cookie.password.value}">
                                        </div>


                                        <c:if test="${not empty message}">
                                            <div class="alert alert-danger">${message}</div>
                                        </c:if>

                                        <div class="d-flex align-items-center justify-content-between mb-4">
                                            <div class="form-check">
                                                <input class="form-check-input primary" type="checkbox" value="true" id="flexCheckChecked" name="rememberMe" <c:if test="${cookie.rememberMe.value eq 'true'}">checked</c:if>>
                                                    <label class="form-check-label text-dark" for="flexCheckChecked">
                                                        Remember me
                                                    </label>
                                                </div>
                                                <a class="text-primary fw-bold" href="${pageContext.request.contextPath}/lostaccount">Forgot Password ?</a>
                                        </div>
                                        <input class="btn btn-primary w-100 py-8 fs-4 mb-4 rounded-2" type="submit" value="Sign in">
                                        <%@ include file="googlelogin.jsp" %>
                                        <div class="mt-3 d-flex align-items-center justify-content-center">
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
