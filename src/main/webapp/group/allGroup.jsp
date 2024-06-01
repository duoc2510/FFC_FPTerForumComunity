<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Th�m quy t?c CSS tr?c ti?p v�o JSP -->
<style>
    .group-link {
        text-decoration: none;
        color: inherit; /* Gi? nguy�n m�u s?c hi?n t?i */
    }
    .group-link:hover {
        color: #007bff; /* ??i m�u th�nh xanh d??ng khi hover */
        text-decoration: underline; /* Th�m g?ch d??i khi hover */
    }
    .hidden {
        display: none;
    }
</style>

<script>
 function toggleCreatedGroups() {
    var createdGroupsSection = document.getElementById("createdGroupsSection");
    var joinedGroupsSection = document.getElementById("joinedGroupsSection");
    var groupListSection = document.getElementById("groupListSection");

    if (createdGroupsSection.classList.contains("hidden")) {
        createdGroupsSection.classList.remove("hidden");
        joinedGroupsSection.classList.add("hidden");
        groupListSection.classList.add("hidden");
    } else {
        createdGroupsSection.classList.add("hidden");
    }
}

function toggleJoinedGroups() {
    var createdGroupsSection = document.getElementById("createdGroupsSection");
    var joinedGroupsSection = document.getElementById("joinedGroupsSection");
    var groupListSection = document.getElementById("groupListSection");

    if (joinedGroupsSection.classList.contains("hidden")) {
        joinedGroupsSection.classList.remove("hidden");
        createdGroupsSection.classList.add("hidden");
        groupListSection.classList.add("hidden");
    } else {
        joinedGroupsSection.classList.add("hidden");
    }
}

function toggleGroupList() {
    var createdGroupsSection = document.getElementById("createdGroupsSection");
    var joinedGroupsSection = document.getElementById("joinedGroupsSection");
    var groupListSection = document.getElementById("groupListSection");

    if (groupListSection.classList.contains("hidden")) {
        groupListSection.classList.remove("hidden");
        createdGroupsSection.classList.add("hidden");
        joinedGroupsSection.classList.add("hidden");
    } else {
        groupListSection.classList.add("hidden");
    }
}


</script>


<c:set var="error" value="${sessionScope.error}" scope="page"/>
<c:remove var="error" scope="session"/>

<c:if test="${not empty error}">
    <div class="alert alert-danger">
        ${error}
    </div>
</c:if>

<div class="row">
    <div class="col-12 mb-3">
        <a href="addGroup" class="btn btn-success">Create Group</a>
          <a href="javascript:void(0);" class="btn btn-primary" onclick="toggleGroupList()">Groups You Can Join</a> <!-- Th�m n�t m?i -->
        <a href="javascript:void(0);" class="btn btn-secondary" onclick="toggleJoinedGroups()">Groups You Joined</a>
        <a href="javascript:void(0);" class="btn btn-info" onclick="toggleCreatedGroups()">Groups You Created</a>
    </div>
</div>

<!-- Hi?n th? c�c nh�m m� ng??i d�ng c� th? tham gia -->
<div class="row" id="groupListSection">
    <h2>Groups You Can Join</h2>
    <c:forEach var="group" items="${groups}">
        <div class="card col-md-3 m-2">
            <img src="${pageContext.request.contextPath}/${group.image}" class="card-img-top event-img" alt="...">
            <div class="card-body">
                <h5 class="card-title">
                    <a href="inGroup?groupId=${group.groupId}" class="group-link">
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
                        <a href="joinGroup?groupId=${group.groupId}" class="btn btn-primary w-100 mt-3">Join Group</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:forEach>
</div>

<!-- Hi?n th? c�c nh�m m� ng??i d�ng ?� tham gia -->
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
                            <a href="inGroup?groupId=${group.groupId}" class="group-link">
                                ${group.groupName}
                            </a>
                        </h5>
                        <p class="card-text">${group.groupDescription}</p>
                        <p class="card-text">Members: ${group.memberCount}</p>
                        <a href="inGroup?groupId=${group.groupId}" class="btn btn-info w-100 mt-3">Access Group</a>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<!-- Hi?n th? c�c nh�m m� ng??i d�ng ?� t?o -->
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
                            <a href="inGroup?groupId=${group.groupId}" class="group-link">
                                ${group.groupName}
                            </a>
                        </h5>
                        <p class="card-text">${group.groupDescription}</p>
                        <p class="card-text">Members: ${group.memberCount}</p>
                        <a href="inGroup?groupId=${group.groupId}" class="btn btn-info w-100 mt-3">Access Group</a>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
