<%-- 
    Document   : register
    Created on : May 13, 2024, 7:19:33 AM
    Author     : mac
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

                                    <form name="input" action="register" method="post" onsubmit="return validateForm()">
                                        <div class="mb-3">
                                            <label for="userName" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="userName" name="userName" placeholder="Enter name">
                                        </div>
                                        <div class="mb-3">
                                            <label for="userEmail" class="form-label">Email Address</label>
                                            <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="Enter email"  onkeyup="showEmailHint()">
                                            <div id="emailHint" style="color: #666; font-size: 14px; margin-top: 5px;"></div>
                                        </div>
                                        <div class="mb-4">
                                            <label for="password" class="form-label">Password</label>
                                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter new password"  onkeyup="showPasswordHint()">
                                            <div id="passwordHint" style="color: #666; font-size: 14px; margin-top: 5px;"></div>
                                        </div>
                                        <div class="mb-4">
                                            <label for="rePassword" class="form-label">Re-Password</label>
                                            <input type="password" class="form-control" id="rePassword" name="rePassword" placeholder="Re-enter new password">

                                        </div>
                                        <c:if test="${not empty message}">
                                            <div class="alert alert-info">${message}</div>
                                        </c:if>

                                        <button type="submit" class="btn btn-primary w-100 py-8 fs-4 mb-4 rounded-2">Sign Up</button>
                                        <%@ include file="googlelogin.jsp" %>
                                        <div class="mt-3 d-flex align-items-center justify-content-center">
                                            <p class="fs-4 mb-0 fw-bold">Already have an account?</p>
                                            <a class="text-primary fw-bold ms-2" href="${pageContext.request.contextPath}/logingooglehandler?value=login">Sign In</a>
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
    <script>
                                                function validateForm() {
                                                    return validateEmail() && validatePassword();
                                                }

                                                function validateEmail() {
                                                    var email = document.getElementById("userEmail").value;
                                                    var emailHint = document.getElementById("emailHint");
                                                    var emailRegex = /^[a-zA-Z0-9._%+-]+@(fpt\.edu\.vn|fe\.edu\.vn)$/;

                                                    var isValid = true;
                                                    var errorMessage = "";

                                                    if (!emailRegex.test(email)) {
                                                        isValid = false;
                                                        errorMessage = "Email must end with @fpt.edu.vn or @fe.edu.vn.";
                                                    }

                                                    if (!isValid) {
                                                        alert(errorMessage);
                                                        emailHint.textContent = errorMessage;
                                                    } else {
                                                        emailHint.textContent = "";
                                                    }

                                                    return isValid;
                                                }

                                                function showEmailHint() {
                                                    var email = document.getElementById("userEmail").value;
                                                    var emailHint = document.getElementById("emailHint");
                                                    var emailRegex = /^[a-zA-Z0-9._%+-]+@(fpt\.edu\.vn|fe\.edu\.vn)$/;

                                                    if (!emailRegex.test(email)) {
                                                        emailHint.textContent = "Email must end with @fpt.edu.vn or @fe.edu.vn.";
                                                    } else {
                                                        emailHint.textContent = "";
                                                    }
                                                }

                                                function validatePassword() {
                                                    var password = document.getElementById("password").value;
                                                    var lowercaseRegex = /[a-z]/;
                                                    var uppercaseRegex = /[A-Z]/;
                                                    var digitRegex = /\d/;
                                                    var specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;

                                                    var isValid = true;
                                                    var errorMessage = "";

                                                    if (!lowercaseRegex.test(password)) {
                                                        isValid = false;
                                                        errorMessage += "Password must contain at least one lowercase letter.\n";
                                                    }

                                                    if (!uppercaseRegex.test(password)) {
                                                        isValid = false;
                                                        errorMessage += "Password must contain at least one uppercase letter.\n";
                                                    }

                                                    if (!digitRegex.test(password)) {
                                                        isValid = false;
                                                        errorMessage += "Password must contain at least one digit.\n";
                                                    }

                                                    if (!specialCharRegex.test(password)) {
                                                        isValid = false;
                                                        errorMessage += "Password must contain at least one special character.\n";
                                                    }

                                                    if (!isValid) {
                                                        alert(errorMessage);
                                                    }

                                                    return isValid;
                                                }

                                                function showPasswordHint() {
                                                    var password = document.getElementById("password").value;
                                                    var passwordHint = document.getElementById("passwordHint");
                                                    var lowercaseRegex = /[a-z]/;
                                                    var uppercaseRegex = /[A-Z]/;
                                                    var digitRegex = /\d/;
                                                    var specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;

                                                    var hintMessage = "";

                                                    if (!lowercaseRegex.test(password)) {
                                                        hintMessage += "Password should contain at least one lowercase letter. ";
                                                    }

                                                    if (!uppercaseRegex.test(password)) {
                                                        hintMessage += "Password should contain at least one uppercase letter. ";
                                                    }

                                                    if (!digitRegex.test(password)) {
                                                        hintMessage += "Password should contain at least one digit. ";
                                                    }

                                                    if (!specialCharRegex.test(password)) {
                                                        hintMessage += "Password should contain at least one special character. ";
                                                    }

                                                    passwordHint.textContent = hintMessage;
                                                }
    </script>
</html>