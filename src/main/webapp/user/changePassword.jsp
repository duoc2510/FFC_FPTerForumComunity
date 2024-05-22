<%-- 
    Document   : settings
    Created on : May 17, 2024, 9:55:18?AM
    Author     : mac
--%>

<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>

        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid pb-2">
                <div class="row ">
                    <div id ="profile-wrapper" >
                        <div class="bg-white shadow rounded overflow-hidden ">
                            <div class="px-4 py-4 cover cover " style="background: url(${pageContext.request.contextPath}/upload/deli-2.png)">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <img src="${pageContext.request.contextPath}/${userInfo.userAvatar}" class="rounded-circle img-thumbnail">
                                        <a href="${pageContext.request.contextPath}/profile/setting" class="btn btn-outline-dark btn-sm btn-block edit-cover">Edit profile</a>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center ">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0">${userInfo.userFullName}</h4>
                                </div>
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${postCount}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Posts</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">745</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Followers</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">340</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Following</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${userInfo.userScore}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Score</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${userInfo.userRank}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Rank</small>
                                    </li>
                                </ul>
                            </div>
                            <div class="px-4 py-3">
                                <h5 class="mb-2">About</h5>
                                <div class="p-4 rounded shadow-sm">
                                    <p class="font-italic mb-0">${userInfo.userStory}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid pt-0">
                <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">
                    <div class="p0">
                        <h5 class="mb-2">Settings</h5>
                    </div>
                    <form action="changepass" method="post" onsubmit="return validatePassword()">
                        <div class="form-group pb-3">
                            <label>Email:</label>
                            <input type="email" class="form-control" name="email" value="${USER.userEmail}" disabled>
                        </div>
                        <div class="form-group pb-3">
                            <label>Old Password:</label>
                            <input type="password" class="form-control" name="oldPassword"/>
                        </div>
                        <div class="form-group pb-3">
                            <label>New Password:</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" onkeyup="showPasswordHint()"/>
                            <div id="passwordHint" style="color: #666; font-size: 14px; margin-top: 5px;"></div>
                        </div>
                        <div class="form-group pb-3">
                            <label>Confirm Password:</label>
                            <input type="password" class="form-control" name="confirmPassword"/>

                        </div>
                        <c:if test="${not empty message}">
                            <div class="alert alert-info">${message}</div>
                        </c:if>
                        <button type="submit" class="btn btn-primary">Change Password</button>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="../include/right-slidebar.jsp" %>


    </div>
</body>
<%@ include file="../include/footer.jsp" %>
<script>
    function validatePassword() {
        var password = document.getElementById("newPassword").value;
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
        var password = document.getElementById("newPassword").value;
        var passwordHint = document.getElementById("passwordHint");
        var lowercaseRegex = /[a-z]/;
        var uppercaseRegex = /[A-Z]/;
        var digitRegex = /\d/;
        var specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
        var hintMessage = "";

        if (!lowercaseRegex.test(password)) {
            hintMessage += "Password should contain at least one lowercase letter. <br>";
        }

        if (!uppercaseRegex.test(password)) {
            hintMessage += "Password should contain at least one uppercase letter. <br>";
        }

        if (!digitRegex.test(password)) {
            hintMessage += "Password should contain at least one digit. <br>";
        }

        if (!specialCharRegex.test(password)) {
            hintMessage += "Password should contain at least one special character. <br>";
        }

        passwordHint.innerHTML = hintMessage;
    }
</script>