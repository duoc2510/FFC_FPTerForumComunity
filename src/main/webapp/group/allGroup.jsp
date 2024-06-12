<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<!-- Thêm quy t?c CSS tr?c ti?p vào JSP -->
<style>
    .group-link {
        text-decoration: none;
        color: inherit; /* Gi? nguyên màu s?c hi?n t?i */
    }
    .group-link:hover {
        color: #007bff; /* ??i màu thành xanh d??ng khi hover */
        text-decoration: underline; /* Thêm g?ch d??i khi hover */
    }
    .hidden {
        display: none;
    }
</style>
<div class="row">
    <div class="col-12 mb-3">
        <button class="btn btn-success" type="button" data-bs-toggle="modal" data-bs-target="#createGroupModal">Create Group</button>
        <a href="javascript:void(0);" class="btn btn-primary" onclick="toggleGroupList()">Groups You Can Join</a>
        <a href="javascript:void(0);" class="btn btn-secondary" onclick="toggleJoinedGroups()">Groups You Joined</a>
        <a href="javascript:void(0);" class="btn btn-info" onclick="toggleCreatedGroups()">Groups You Created</a>
    </div>
</div>

<!-- Hi?n th? các nhóm mà ng??i dùng có th? tham gia -->
<div class="row" id="groupListSection">
    <h2>Groups You Can Join</h2>
    <c:forEach var="group" items="${groups}">
        <div class="card col-md-3 m-2">
            <img src="${pageContext.request.contextPath}/${group.image}" class="card-img-top event-img" alt="...">
            <div class="card-body">
                <h5 class="card-title">
                    <a href="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}" class="group-link">
                        ${group.groupName}
                    </a>
                </h5>
                <p class="card-text">${group.groupDescription}</p>
                <p class="card-text">Members: ${group.memberCount}</p>
                <c:choose>
                    <c:when test="${group.pending}">
                        <button class="btn btn-secondary w-100 mt-3" disabled>Pending approval</button>
                    </c:when>
                    <c:when test="${group.isBanned}">
                        <button class="btn btn-danger w-100 mt-3" disabled>You have been banned</button>
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/group" method="post">
                            <input type="hidden" name="groupId" value="${group.groupId}">
                            <input type="hidden" name="action" value="joinGroup"> <!-- Thêm tham số ẩn để xác định hành động -->
                            <button type="submit" class="btn btn-primary w-100 mt-3">Join Group</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:forEach>
</div>

<!-- Hi?n th? các nhóm mà ng??i dùng ?ã tham gia -->
<div id="joinedGroupsSection" class="row hidden">
    <h2>Groups You Joined</h2>
    <c:choose>
        <c:when test="${empty groupsJoined}">
            <p>You haven't joined any groups yet.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="group" items="${groupsJoined}">
                <div class="card col-md-3 m-2">
                    <img src="${pageContext.request.contextPath}/${group.image}" class="card-img-top event-img" alt="Group Avatar">
                    <div class="card-body">
                        <h5 class="card-title">
                            <a href="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}" class="group-link">
                                ${group.groupName}
                            </a>
                        </h5>
                        <p class="card-text">${group.groupDescription}</p>
                        <p class="card-text">Members: ${group.memberCount}</p>
                        <a href="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}" class="btn btn-info w-100 mt-3">Access Group</a>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<div id="createdGroupsSection" class="row hidden">
    <h2>Groups You Created</h2>
    <c:choose>
        <c:when test="${empty groupsCreated}">
            <p>You haven't created any groups yet.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="group" items="${groupsCreated}">
                <div class="card col-md-3 m-2">
                    <img src="${pageContext.request.contextPath}/${group.image}" class="card-img-top event-img" alt="Group Avatar">
                    <div class="card-body">
                        <h5 class="card-title">
                            <a href="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}" class="group-link">
                                ${group.groupName}
                            </a>
                        </h5>
                        <p class="card-text">${group.groupDescription}</p>
                        <p class="card-text">Members: ${group.memberCount}</p>
                        <a href="${pageContext.request.contextPath}/group/detail?groupId=${group.groupId}" class="btn btn-info w-100 mt-3">Access Group</a>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
<%@include file="modal.jsp" %>
<script>
    function  {
    var createdGroupsSection = document.getElementById("createdGroupsSection");
    var joinedGroupsSection = document.getElementById("joinedGroupsSection");
    var groupListSection = document.getElementById("groupListSection");

    createdGroupsSection.classList.remove("hidden");
    joinedGroupsSection.classList.add("hidden");
    groupListSection.classList.add("hidden");
}

function toggleJoinedGroups() {
    var createdGroupsSection = document.getElementById("createdGroupsSection");
    var joinedGroupsSection = document.getElementById("joinedGroupsSection");
    var groupListSection = document.getElementById("groupListSection");

    joinedGroupsSection.classList.remove("hidden");
    createdGroupsSection.classList.add("hidden");
    groupListSection.classList.add("hidden");
}

function toggleGroupList() {
    var createdGroupsSection = document.getElementById("createdGroupsSection");
    var joinedGroupsSection = document.getElementById("joinedGroupsSection");
    var groupListSection = document.getElementById("groupListSection");

    groupListSection.classList.remove("hidden");
    createdGroupsSection.classList.add("hidden");
    joinedGroupsSection.classList.add("hidden");
}

</script>