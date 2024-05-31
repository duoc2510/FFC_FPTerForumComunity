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
                            <div class="px-4 py-4 cover" style="height: 300px !important; object-fit: cover; background: url(${pageContext.request.contextPath}/${group.image}">

                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center ">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0">${group.groupName}</h4>
                                </div>

                                <ul class="list-inline mb-0">
                                    <c:choose>
                                        <c:when test="${group.pending}">
                                            <button class="btn btn-secondary btn-sm btn-block edit-cover mx-2" disabled>Pending Approval</button>
                                        </c:when>
                                        <c:when test="${isUserApproved and group.createrId != USER.userId}">
                                            <button class="btn btn-primary btn-sm btn-block edit-cover mx-2" disabled>Joined Group</button>
                                        </c:when>
                                        <c:when test="${group.createrId == USER.userId}">
                                            <button class="btn btn-info btn-sm btn-block edit-cover mx-2" disabled>Welcome Host Group</button>
                                            <form action="${pageContext.request.contextPath}/removeMember" method="post"  style="display:inline;">
                                                <input type="hidden" name="groupId" value="${groupId}">
                                                <input type="hidden" name="memberId" value="${member.id}">
                                                <button type="submit" class="btn btn-secondary btn-sm btn-block edit-cover mx-2">Remove</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/joinGroup?groupId=${group.groupId}" class="btn btn-primary btn-sm btn-block edit-cover mx-2">Join Group</a>
                                        </c:otherwise>
                                    </c:choose>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${postCount}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Posts</small>
                                    </li>
                                    <li class="list-inline-item">
                                        <h5 class="font-weight-bold mb-0 d-block">${group.memberCount}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Member</small>
                                    </li>
                                </ul>
                            </div>
                            <div class="px-4 py-3">
                                <h5 class="mb-2">Description</h5>
                                <div class="p-4 rounded shadow-sm">
                                    <p class="font-italic mb-0">${group.groupDescription}</p>
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
                    <form action="groupEdit" method="post" enctype="multipart/form-data">
                        <div class="form-group pb-3">
                            <label>Name of group:</label>
                            <input type="text" class="form-control" name="groupName" value="${group.groupName}">
                        </div>    
                        <div class="form-group pb-3">
                            <label>Description</label>
                            <textarea class="form-control" name="description">${group.groupDescription}</textarea>
                        </div>
                        <div class="form-group pb-3">
                            <label for="avatar">Avatar Group:</label>
                            <input type="file" class="form-control" id="avatar" name="avatar">
                        </div>
                        <input type="hidden" name="oldAvatar" value="${group.image}">

                        <button type="submit" class="btn btn-primary">Save changes</button>

                    </form>
                    <c:if test="${not empty message}">
                        <div class="alert alert-info" role="alert">
                            ${message}
                        </div>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
