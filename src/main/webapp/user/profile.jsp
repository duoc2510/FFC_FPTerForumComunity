<%@ include file="../include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid">
                <div class="row">
                    <div id="profile-wrapper">
                        <div class="bg-white shadow rounded overflow-hidden">
                            <div class="px-4 py-4 cover cover" style="background: url(${pageContext.request.contextPath}/upload/deli-2.png)">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <img src="${pageContext.request.contextPath}/${userInfo.userAvatar}" class="rounded-circle img-thumbnail">
                                        <a href="${pageContext.request.contextPath}/profile/setting" class="btn btn-outline-dark btn-sm btn-block edit-cover">Edit profile</a>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0">${userInfo.userFullName}</h4>
                                </div>
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">60</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Posts</small>
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
                            <style>
                                .post-container {
                                    background-color: #f8f9fa; /* Light grey background */
                                    border-radius: 10px; /* Rounded corners */
                                    border: 1px solid #e9ecef; /* Light border */
                                }

                                .post-box {
                                    background-color: #ffffff; /* White background */
                                    border-radius: 10px; /* Rounded corners */
                                    border: 1px solid #e9ecef; /* Light border */
                                }
                            </style>

                            <form id="postForm" action="AddPost" method="post" enctype="multipart/form-data" >
                                <div class="form-group">
                                    <label for="postStatus">Status</label>
                                    <select class="form-control" id="postStatus" name="postStatus">
                                        <option value="Public">Public</option>
                                        <option value="Friends">Friends</option>
                                        <option value="Only me">Only me</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="postTopic">Topic</label>
                                    <select class="form-control" id="postTopic" name="postTopic">
                                        <option value="Technology">Technology</option>
                                        <option value="Economics">Economics</option>
                                        <option value="Politics">Politics</option>
                                        <option value="Language">Language</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="postGroup">Group</label>
                                    <select class="form-control" id="postGroup" name="postGroup">
                                        <option value="IT">IT</option>
                                        <option value="Business">Business</option>
                                        <option value="Language">Language</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="postContent">What's on your mind?</label>
                                    <textarea class="form-control" id="postContent" name="postContent" rows="3"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="postImage">Upload Image</label>
                                    <input type="file" class="form-control-file" id="postImage" name="postImage">
                                </div>
                                <button type="submit" class="btn btn-primary">Add Post</button>
                            </form>

                            <div class="row">
                                <%@ include file="newsfeed.jsp" %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="../include/right-slidebar.jsp" %>
        </div>
    </div>
    <%@ include file="../include/footer.jsp" %>
</body>
</html>
