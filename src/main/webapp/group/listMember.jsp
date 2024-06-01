<%@ include file="../include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid pb-2">
                <div class="row">
                    <div id="profile-wrapper">
                        <div class="bg-white shadow rounded overflow-hidden">
                            <div class="px-4 py-4 cover" style="height: 300px !important; object-fit: cover; background: url(${pageContext.request.contextPath}/${group.image})">
                                <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                    <div>
                                        <c:if test="${group.createrId == USER.userId}">
                                            <a href="${pageContext.request.contextPath}/inGroup/groupEdit?groupId=${group.groupId}" class="btn btn-outline-dark btn-sm btn-block edit-cover mx-2">Edit Group</a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0">${group.groupName}</h4>
                                </div>

                                <ul class="list-inline mb-0">
                                    <c:choose>
                                        <c:when test="${group.pending}">
                                            <button class="btn btn-secondary btn-sm btn-block edit-cover mx-2" disabled>Pending Approval</button>
                                        </c:when>
                                        <c:when test="${isUserApproved && group.createrId != USER.userId}">
                                            <button class="btn btn-primary btn-sm btn-block edit-cover mx-2" disabled>Joined Group</button>
                                            <form action="${pageContext.request.contextPath}/groupOut?groupId=${group.groupId}&action=leave" method="post" style="display:inline;" onsubmit="return confirmLeaveGroup(this);">
                                                <input type="hidden" name="groupId" value="${group.groupId}">
                                                <button type="submit" class="btn btn-secondary btn-sm btn-block edit-cover mx-2">Out Group</button>
                                            </form>
                                        </c:when>
                                        <c:when test="${group.createrId == USER.userId}">
                                            <button class="btn btn-info btn-sm btn-block edit-cover mx-2" disabled>Welcome Host Group</button>
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
                        <div class="member-group" id="memberGroup">
                            <h2>List Members</h2>
                            <c:if test="${empty approvedMembers}">
                                <p>No members.</p>
                            </c:if>
                            <c:if test="${not empty approvedMembers}">
                                <table class="table table-striped">
                                    <tbody>
                                        <c:forEach var="member" items="${approvedMembers}">
                                            <tr>
                                                <td>
                                                    <img src="${pageContext.request.contextPath}/${member.user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                                    <a href="${pageContext.request.contextPath}/groupViewPostMember?userId=${member.user.userId}&groupId=${group.groupId}">
                                                        ${member.user.username}
                                                    </a>
                                                    <c:if test="${member.user.userId != USER.userId && member.user.userId != group.createrId}">
                                                        <form id="kickForm${member.user.userId}" action="${pageContext.request.contextPath}/groupOut" method="post" style="display:inline;">
                                                            <input type="hidden" name="groupId" value="${group.groupId}">
                                                            <input type="hidden" name="userId" value="${member.user.userId}">
                                                            <input type="hidden" name="action" value="kick"> 
                                                            <button id="kickButton${member.user.userId}" type="submit" class="btn btn-secondary btn-sm btn-block edit-cover mx-2" onclick="return confirmKick(this);">Kick</button>
                                                        </form>

                                                        <form id="banForm${member.user.userId}" action="${pageContext.request.contextPath}/groupOut" method="post" style="display:inline;">
                                                            <input type="hidden" name="groupId" value="${group.groupId}">
                                                            <input type="hidden" name="userId" value="${member.user.userId}">
                                                            <input type="hidden" name="action" value="ban"> 
                                                            <button id="banButton${member.user.userId}" type="submit" class="btn btn-danger btn-sm btn-block edit-cover mx-2" onclick="return confirmBan(this);">Ban</button>
                                                        </form>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function confirmKick(button) {
            return confirm("Are you sure you want to kick this member?");
        }

        function confirmBan(button) {
            return confirm("Are you sure you want to ban this member?");
        }
    </script>
</body>
<%@ include file="../include/footer.jsp" %>
