<%@ include file="../include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid pb-2">
                <div class="row ">
                    <div class="bg-white shadow rounded overflow-hidden ">
                        <div class="px-4 py-4 cover" style="height: 300px !important; background-image: url('${pageContext.request.contextPath}/${group.image}'); background-size: cover; background-position: top; background-repeat: no-repeat;">
                            <div class="media align-items-end profile-head">
                                <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                    <div>
                                        <c:if test="${group.createrId == USER.userId}">
                                            <a href="${pageContext.request.contextPath}/group/edit?groupId=${group.groupId}" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">Edit Group</a>
                                            <a href="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">View Group</a>
                                        </c:if></div>
                                </div>
                            </div>
                        </div>
                        <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center">
                            <div class="media-body mb-2 text-white">
                                <h4 class="mt-0 mb-0" style="text-align:left;">${group.groupName}</h4>
                                <c:choose>
                                    <c:when test="${group.pending}">
                                        <button class="btn btn-secondary btn-sm btn-block edit-cover my-2" disabled>Pending Approval</button>
                                    </c:when>
                                    <c:when test="${isUserApproved and group.createrId != USER.userId}">
                                        <button class="btn btn-primary btn-sm btn-block edit-cover my-2" disabled>Joined Group</button>
                                        <form action="${pageContext.request.contextPath}/groupOut?groupId=${group.groupId}&action=leave" method="post" style="display:inline;" onsubmit="return confirmLeaveGroup(this);">
                                            <input type="hidden" name="groupId" value="${group.groupId}">
                                            <button type="submit" class="btn btn-secondary btn-sm btn-block edit-cover my-2">Out Group</button>
                                        </form>
                                    </c:when>
                                    <c:when test="${isUserBanned}">
                                        <button class="btn btn-info btn-danger btn-block edit-cover my-2" disabled>You have been banned</button>
                                    </c:when>
                                    <c:when test="${group.createrId == USER.userId}">
                                        <button class="btn btn-info btn-sm btn-block edit-cover my-2" disabled>Welcome Host Group</button>
                                        <form action="${pageContext.request.contextPath}/group?groupId=${group.groupId}" method="post" style="display:inline;" onsubmit="return confirmDeleteGroup()">
                                            <input type="hidden" name="groupId" value="${group.groupId}">
                                            <input type="hidden" name="memberId" value="${member.id}">
                                            <button type="submit" class="btn btn-secondary btn-sm btn-block edit-cover mx-2">Delete Group</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="${pageContext.request.contextPath}/group" method="post">
                                            <input type="hidden" name="groupId" value="${group.groupId}">
                                            <button type="submit" class="btn btn-primary w-100 mt-3">Join Group</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>                    
                            <ul class="list-inline mb-0">
                                <li class="list-inline-item">
                                    <h5 class="font-weight-bold mb-0 d-block">${postCount}</h5><small class="text-muted"><i class="fas fa-image mr-1"></i>Posts</small>
                                </li>       
                                <li class="list-inline-item">
                                    <h5 class="font-weight-bold mb-0 d-block">${group.memberCount}</h5><small class="text-muted"><i class="fas fa-user mr-1"></i>Members</small>
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
            <div class="container-fluid pt-0">
                <div class="row form-settings bg-white shadow rounded py-4 px-4 d-flex justify-content-between ">
                    <div class="p0">
                        <h5 class="mb-2">Settings</h5>
                    </div>
                    <form action="${pageContext.request.contextPath}/group/edit" method="post" enctype="multipart/form-data">
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
                </div>
            </div>
        </div>
    </div>
    <script>
        function confirmDeleteGroup() {
            // Get the number of members from the JSP
            var memberCount = <c:out value="${group.memberCount}" />;

            // Check the number of members
            if (memberCount > 1) {
                // Show alert if there are more than 1 member
                alert("Your group has more than 1 member. To delete the group, you need to remove all members.");
                return false; // Prevent form submission
            } else {
                // Show confirmation alert if there is only 1 member
                var confirmDelete = confirm("You are the last member of the group. Are you sure you want to delete it?");
                return confirmDelete; // Allow or prevent form submission based on user's choice
            }
        }
    </script>
</body>
<%@ include file="../include/footer.jsp" %>
