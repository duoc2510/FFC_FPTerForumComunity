<%@ include file="../include/header.jsp" %>
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
                                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}" class="rounded-circle img-thumbnail" style="object-fit: cover;">
                                        <div>
                                            <a href="${pageContext.request.contextPath}/profile/setting" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">Edit profile</a>
                                            <a href="${pageContext.request.contextPath}/profile?username=${USER.username}" class="btn btn-outline-dark btn-sm btn-block edit-cover">View profile</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center ">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0">${USER.userFullName}</h4>     
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
                                        <h5 class="font-weight-bold mb-0 d-block">${USER.userScore}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Score</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${USER.userRank}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Rank</small>
                                    </li>
                                </ul>
                            </div>
                            <div class="px-4 py-3">
                                <p class="font-italic mb-0"><i class="ti ti-calendar"></i>Ngày tham gia: ${USER.userCreateDate}</p>
                                <div class="p-4 rounded shadow-sm">
                                    <p class="font-italic mb-0">${USER.userStory}<i class="ti ti-feather"></i></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid pt-0">




                <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#main-setting" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">Setting</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#changepass-setting" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">Change Password</button>
                        </li>
                    </ul>

                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane px-1 fade show active" id="main-setting" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
                            <div class="py-3">
                                <h5 class="mb-2">Information</h5>
                            </div>
                            <form action="setting" method="post" enctype="multipart/form-data">
                                <div class="form-group pb-3">
                                    <label>Full Name:</label>
                                    <input type="text" class="form-control" name="fullName" value="${USER.userFullName}">
                                </div>
                                <div class="form-group pb-3">
                                    <label>Email:</label>
                                    <input type="email" class="form-control" name="email" value="${USER.userEmail}" disabled>
                                </div>
                                <div class="form-group pb-3">
                                    <label>About:</label>
                                    <textarea class="form-control" name="story">${USER.userStory}</textarea>
                                </div>
                                <div class="form-group pb-3">
                                    <label for="avatar">Avatar:</label>
                                    <input type="file" class="form-control" id="avatar" name="avatar">
                                </div>
                                <input type="hidden" name="oldAvatar" value="${USER.userAvatar}">
                                <div class="form-group pb-3">
                                    <label>Gender:</label>
                                    <select class="form-control" name="gender">
                                        <option value="Male" ${USER.userSex == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${USER.userSex == 'Female' ? 'selected' : ''}>Female</option>
                                        <option value="Other" ${USER.userSex == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary">Save changes</button>
                                <a href="changepass" class="btn btn-primary">Change Password</a>
                            </form>
                        </div>

                        <div class="tab-pane px-1 fade" id="changepass-setting" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
                            <div class="py-3">
                                <h5 class="mb-2">Change Password</h5>
                            </div>
                            <form action="changepass" method="post" onsubmit="return validatePassword()">
                                <div class="form-group pb-3">
                                    <label>Email:</label>
                                    <input type="email" class="form-control" name="email" value="${USER.userEmail}" readonly="">
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
            </div>
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
