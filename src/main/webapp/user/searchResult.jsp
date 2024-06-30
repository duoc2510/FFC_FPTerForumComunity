<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*" %>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>
    <title>Search Results</title>
    <style>
        .avatar-cover {
            object-fit: cover;
            height: 35px;
            width: 35px;
        }
        .event-img {
            height: 150px;
            object-fit: cover;
        }
        .group-link {
            text-decoration: none;
            color: inherit;
        }
        .group-link:hover {
            text-decoration: underline;
        }
    </style>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">

        <c:choose>
            <c:when test="${empty sessionScope.USER}">
                <%@ include file="../include/slidebar_guest.jsp" %>
            </c:when>
            <c:otherwise>
                <%@ include file="../include/slidebar.jsp" %>
            </c:otherwise>
        </c:choose>

        <div class="body-wrapper">
            <c:choose>
                <c:when test="${empty sessionScope.USER}">
                    <%@ include file="../include/navbar_guest.jsp" %>
                </c:when>
                <c:otherwise>
                    <%@ include file="../include/navbar.jsp" %>
                </c:otherwise>
            </c:choose>

            <div class="container-fluid d-flex">
                <div class="container mt-4">
                    <h2>Search Results</h2>

                    <div class="btn-group mb-4">
                        <button id="allButton" class="btn btn-primary">All</button>
                        <button id="usersButton" class="btn btn-secondary">Users</button>
                        <button id="groupsButton" class="btn btn-secondary">Groups</button>
                        <button id="usernameButton" class="btn btn-secondary">Usernames</button>
                        <button id="shopsButton" class="btn btn-secondary">Shops</button>
                        <button id="productsButton" class="btn btn-secondary">Products</button>
                    </div>
                    <div id="results">
                        <c:if test="${empty filteredUsers && empty filteredGroups && empty filteredShops && empty filteredProducts }">
                            <p>Don't have any result.</p>
                        </c:if>



                        <div id="allResults">
                            <!-- User List -->
                            <c:forEach var="user" items="${filteredUsers}">
                                <div class="card mb-3">
                                    <div class="card-body d-flex align-items-center">
                                        <a href="${pageContext.request.contextPath}/profile?username=${user.username}" class="me-3">
                                            <img src="${pageContext.request.contextPath}/${user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                        </a>
                                        <div class="me-3">
                                            <h5 class="card-title mb-0">${user.userFullName}</h5>
                                        </div>
                                        <div class="flex-grow-1">
                                            <ul class="list-inline mb-0">
                                                <c:choose>
                                                    <c:when test="${user.userId == USER.userId}"></c:when>
                                                    <c:when test="${user.isPending}">
                                                        <div class="dropdown d-inline">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Request Sent
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmCancel()">
                                                                        <input type="hidden" name="friendId" value="${user.userId}">
                                                                        <input type="hidden" name="friendName" value="${user.username}">
                                                                        <input type="hidden" name="action" value="cancelFrSearch">
                                                                        <button type="submit" class="dropdown-item">Cancel Request</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${user.isPendingRq}">
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="acceptFrSearch">
                                                            <button type="submit" class="btn btn-success btn-sm btn-block edit-cover mx-2">Accept Friend</button>
                                                        </form>
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="denyFrSearch">
                                                            <button type="submit" class="btn btn-danger btn-sm btn-block edit-cover mx-2">Deny Friend</button>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${user.isApproved}">
                                                        <div class="dropdown d-inline dropup">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Friends
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmUnfriend()">
                                                                        <input type="hidden" name="friendId" value="${user.userId}">
                                                                        <input type="hidden" name="friendName" value="${user.username}">
                                                                        <input type="hidden" name="action" value="unfriendSearch">
                                                                        <button type="submit" class="dropdown-item">Unfriend</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form id="addFriendForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="addFrSearch">
                                                            <button type="submit" class="btn btn-primary btn-sm btn-block edit-cover mx-2">Add Friend</button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- Group List -->
                            <div class="row">
                                <c:forEach var="group" items="${filteredGroups}">
                                    <div class="card col-md-3 m-2">
                                        <img src="${pageContext.request.contextPath}/${group.image}" class="card-img-top event-img" alt="...">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <a href="group/detail?groupId=${group.groupId}" class="group-link">${group.groupName}</a>
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
                                                <c:when test="${group.isApproved or group.createrId == USER.userId}">
                                                    <a href="group/detail?groupId=${group.groupId}" class="btn btn-info w-100 mt-3">Access Group</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="group/detail?groupId=${group.groupId}" class="btn btn-primary w-100 mt-3">Join Group</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="col-lg-12">
                                <div class="w-100 row">
                                    <c:forEach var="shop" items="${filteredShops}" >
                                        <div class="col-md-4">
                                            <div class="card mx-2">
                                                <a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}" data-toggle="modal" data-target="#productID1">
                                                    <img class="card-img-top" src="${pageContext.request.contextPath}/static/${shop.getImage()}">
                                                </a>
                                                <div class="card-body">
                                                    <h5 class="card-title"><a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}">${shop.getName()}</a></h5>
                                                    <p class="card-text"><a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}">Campus : ${shop.getCampus()}</a></p>
                                                    <p class="card-text"><a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}">Giới Thiệu : ${shop.getDescription()}</a></p>
                                                    <a href="#" class="btn btn-primary mt-3 w-100">Liên hệ: ${shop.getPhone()}</a>
                                                </div>

                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div id="allProduct" class="w-100 row container">
                                <!--loop this-->
                                <c:forEach var="product" items="${filteredProducts}">
                                    <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(product.productId)}" />
                                    <c:set var="shop" value="${Shop_DB.getShopByShopID(product.shopId)}" />
                                    <c:if test="${product.quantity != 0}">
                                        <div class="col-md-4">
                                            <div class="card mx-2">

                                                <a href="/FPTer/marketplace/allshop/shopdetail/productdetail?productid=${product.productId}&shopid=${product.shopId}">
                                                    <img class="card-img-top" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}">
                                                </a>
                                                <div class="card-body">
                                                    <h5 class="card-title">${product.name}</h5>
                                                    <p class="card-text">Shop name: ${shop.name}</p>
                                                    <p class="card-text">Price: ${product.price} VNĐ</p>  
                                                    <p class="card-text">${product.productDescription}</p>
                                                    <a href="/FPTer/marketplace/allshop/shopdetail/productdetail?productid=${product.productId}&shopid=${product.shopId}" class="btn btn-primary mt-3 w-100">Buy now</a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if> 
                                    <c:if test="${product.quantity == 0}">
                                        <div class="col-md-4">
                                            <div class="card mx-1">
                                                <div class="position-relative image-container">
                                                    <img class="card-img-top" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}">
                                                    <img class="sold-out-overlay" src="${pageContext.request.contextPath}/static/images/soldout.jpg">
                                                </div>
                                                <div class="card-body">
                                                    <h5 class="card-title"><a> ${product.name}</a></h5>
                                                    <p class="card-text"><a>${product.price} VNĐ</a></p>
                                                    <p class="card-text"><a>${product.productDescription}</a></p>
                                                    <button class="btn btn-danger mt-3 w-100" disabled>Sold out</button>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>



                                </c:forEach>





                            </div>
                        </div>

                        <div id="userResults" class="d-none">
                            <c:if test="${empty filteredUsers}">
                                <p>Don't have any users you are looking for.</p>
                            </c:if>
                            <c:forEach var="user" items="${filteredUsers}">
                                <div class="card mb-3">
                                    <div class="card-body d-flex align-items-center">
                                        <a href="${pageContext.request.contextPath}/profile?username=${user.username}" class="me-3">
                                            <img src="${pageContext.request.contextPath}/${user.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                        </a>
                                        <div class="me-3">
                                            <h5 class="card-title mb-0">${user.userFullName}</h5>
                                        </div>
                                        <div class="flex-grow-1">
                                            <ul class="list-inline mb-0">
                                                <c:choose>
                                                    <c:when test="${user.userId == USER.userId}"></c:when>
                                                    <c:when test="${user.isPending}">
                                                        <div class="dropdown d-inline">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Request Sent
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmCancel()">
                                                                        <input type="hidden" name="friendId" value="${user.userId}">
                                                                        <input type="hidden" name="friendName" value="${user.username}">
                                                                        <input type="hidden" name="action" value="cancelFrSearch">
                                                                        <button type="submit" class="dropdown-item">Cancel Request</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${user.isPendingRq}">
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="acceptFrSearch">
                                                            <button type="submit" class="btn btn-success btn-sm btn-block edit-cover mx-2">Accept Friend</button>
                                                        </form>
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="denyFrSearch">
                                                            <button type="submit" class="btn btn-danger btn-sm btn-block edit-cover mx-2">Deny Friend</button>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${user.isApproved}">
                                                        <div class="dropdown d-inline dropup">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Friends
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmUnfriend()">
                                                                        <input type="hidden" name="friendId" value="${user.userId}">
                                                                        <input type="hidden" name="friendName" value="${user.username}">
                                                                        <input type="hidden" name="action" value="unfriendSearch">
                                                                        <button type="submit" class="dropdown-item">Unfriend</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form id="addFriendForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${user.userId}">
                                                            <input type="hidden" name="friendName" value="${user.username}">
                                                            <input type="hidden" name="action" value="addFrSearch">
                                                            <button type="submit" class="btn btn-primary btn-sm btn-block edit-cover mx-2">Add Friend</button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div id="groupResults" class="d-none">
                            <c:if test="${empty filteredGroups}">
                                <p>Don't have any groups you are looking for.</p>
                            </c:if>
                            <div class="row">
                                <c:forEach var="group" items="${filteredGroups}">
                                    <div class="card col-md-3 m-2">
                                        <img src="${pageContext.request.contextPath}/${group.image}" class="card-img-top event-img" alt="...">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <a href="group/detail?groupId=${group.groupId}" class="group-link">${group.groupName}</a>
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
                                                <c:when test="${group.isApproved or group.createrId == USER.userId}">
                                                    <a href="group/detail?groupId=${group.groupId}" class="btn btn-info w-100 mt-3">Access Group</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="group/detail?groupId=${group.groupId}" class="btn btn-primary w-100 mt-3">Join Group</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <div id="usernameResults" class="d-none">
                            <c:if test="${empty filteredUsers}">
                                <p>Don't have any usernames you are looking for.</p>
                            </c:if>
                            <c:forEach var="username" items="${filteredUsers}">
                                <div class="card mb-3">
                                    <div class="card-body d-flex align-items-center">
                                        <a href="${pageContext.request.contextPath}/profile?username=${username.username}" class="me-3">
                                            <img src="${pageContext.request.contextPath}/${username.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                        </a>
                                        <div class="me-3">
                                            <h5 class="card-title mb-0">${username.userFullName}</h5>
                                        </div>
                                        <div class="flex-grow-1">
                                            <ul class="list-inline mb-0">
                                                <c:choose>
                                                    <c:when test="${username.userId == USER.userId}"></c:when>
                                                    <c:when test="${username.isPending}">
                                                        <div class="dropdown d-inline">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Request Sent
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmCancel()">
                                                                        <input type="hidden" name="friendId" value="${username.userId}">
                                                                        <input type="hidden" name="friendName" value="${username.username}">
                                                                        <input type="hidden" name="action" value="cancelFrSearch">
                                                                        <button type="submit" class="dropdown-item">Cancel Request</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${username.isPendingRq}">
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${username.userId}">
                                                            <input type="hidden" name="friendName" value="${username.username}">
                                                            <input type="hidden" name="action" value="acceptFrSearch">
                                                            <button type="submit" class="btn btn-success btn-sm btn-block edit-cover mx-2">Accept Friend</button>
                                                        </form>
                                                        <form action="${pageContext.request.contextPath}/friends" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${username.userId}">
                                                            <input type="hidden" name="friendName" value="${username.username}">
                                                            <input type="hidden" name="action" value="denyFrSearch">
                                                            <button type="submit" class="btn btn-danger btn-sm btn-block edit-cover mx-2">Deny Friend</button>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${username.isApproved}">
                                                        <div class="dropdown d-inline dropup">
                                                            <button class="btn btn-warning btn-sm btn-block edit-cover mx-2 dropdown-toggle" type="button" id="friendDropdown" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                                                                Friends
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="friendDropdown">
                                                                <li>
                                                                    <form id="unfriendRequestForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline" onsubmit="return confirmUnfriend()">
                                                                        <input type="hidden" name="friendId" value="${username.userId}">
                                                                        <input type="hidden" name="friendName" value="${username.username}">
                                                                        <input type="hidden" name="action" value="unfriendSearch">
                                                                        <button type="submit" class="dropdown-item">Unfriend</button>
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form id="addFriendForm" action="${pageContext.request.contextPath}/friendHandel" method="post" class="d-inline">
                                                            <input type="hidden" name="friendId" value="${username.userId}">
                                                            <input type="hidden" name="friendName" value="${username.username}">
                                                            <input type="hidden" name="action" value="addFrSearch">
                                                            <button type="submit" class="btn btn-primary btn-sm btn-block edit-cover mx-2">Add Friend</button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div id="shopResults" class="d-none">
                            <div class="col-lg-12">
                                 <c:if test="${empty filteredShops}">
                                <p>Don't have any shops you are looking for.</p>
                            </c:if>
                                <div class="w-100 row">
                                    <c:forEach var="shop" items="${filteredShops}" >
                                        <div class="col-md-4">
                                            <div class="card mx-2">
                                                <a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}" data-toggle="modal" data-target="#productID1">
                                                    <img class="card-img-top" src="${pageContext.request.contextPath}/static/${shop.getImage()}">
                                                </a>
                                                <div class="card-body">
                                                    <h5 class="card-title"><a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}">${shop.getName()}</a></h5>
                                                    <p class="card-text"><a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}">Campus : ${shop.getCampus()}</a></p>
                                                    <p class="card-text"><a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}">Giới Thiệu : ${shop.getDescription()}</a></p>
                                                    <a href="#" class="btn btn-primary mt-3 w-100">Liên hệ: ${shop.getPhone()}</a>
                                                </div>

                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div id="productResults" class="d-none">
                            <div id="allProduct" class="w-100 row container">
                                 <c:if test="${empty filteredProducts}">
                                <p>Don't have any products you are looking for.</p>
                            </c:if>
                                <!--loop this-->
                                <c:forEach var="product" items="${filteredProducts}">
                                    <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(product.productId)}" />
                                     <c:set var="shop" value="${Shop_DB.getShopByShopID(product.shopId)}" />
                                    <c:if test="${product.quantity != 0}">
                                        <div class="col-md-4">
                                            <div class="card mx-2">

                                                <a href="/FPTer/marketplace/allshop/shopdetail/productdetail?productid=${product.productId}&shopid=${product.shopId}">
                                                    <img class="card-img-top" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}">
                                                </a>
                                                <div class="card-body">
                                                    <h5 class="card-title">${product.name}</h5>
                                                    <p class="card-text">Shop name: ${shop.name}</p>
                                                    <p class="card-text">Price: ${product.price} VNĐ</p>
                                                    <p class="card-text">${product.productDescription}</p>
                                                    <a href="/FPTer/marketplace/allshop/shopdetail/productdetail?productid=${product.productId}&shopid=${product.shopId}" class="btn btn-primary mt-3 w-100">Buy now</a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if> 
                                    <c:if test="${product.quantity == 0}">
                                        <div class="col-md-4">
                                            <div class="card mx-1">
                                                <div class="position-relative image-container">
                                                    <img class="card-img-top" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}">
                                                    <img class="sold-out-overlay" src="${pageContext.request.contextPath}/static/images/soldout.jpg">
                                                </div>
                                                <div class="card-body">
                                                    <h5 class="card-title"><a> ${product.name}</a></h5>
                                                    <p class="card-text"><a>${product.price} VNĐ</a></p>
                                                    <p class="card-text"><a>${product.productDescription}</a></p>
                                                    <button class="btn btn-danger mt-3 w-100" disabled>Sold out</button>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>



                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>


        <script>
            $(document).ready(function () {
                $('#allButton').click(function () {
                    $('#allResults').removeClass('d-none');
                    $('#userResults, #groupResults, #usernameResults, #shopResults, #productResults').addClass('d-none');
                    $(this).addClass('btn-primary').removeClass('btn-secondary');
                    $('#usersButton, #groupsButton, #usernameButton, #shopsButton, #productsButton').addClass('btn-secondary').removeClass('btn-primary');
                });

                $('#usersButton').click(function () {
                    $('#allResults').addClass('d-none');
                    $('#userResults').removeClass('d-none');
                    $('#groupResults, #usernameResults, #shopResults, #productResults').addClass('d-none');
                    $(this).addClass('btn-primary').removeClass('btn-secondary');
                    $('#allButton, #groupsButton, #usernameButton, #shopsButton, #productsButton').addClass('btn-secondary').removeClass('btn-primary');
                });

                $('#groupsButton').click(function () {
                    $('#allResults, #userResults, #usernameResults, #shopResults, #productResults').addClass('d-none');
                    $('#groupResults').removeClass('d-none');
                    $(this).addClass('btn-primary').removeClass('btn-secondary');
                    $('#allButton, #usersButton, #usernameButton, #shopsButton, #productsButton').addClass('btn-secondary').removeClass('btn-primary');
                });

                $('#usernameButton').click(function () {
                    $('#allResults, #userResults, #groupResults, #shopResults, #productResults').addClass('d-none');
                    $('#usernameResults').removeClass('d-none');
                    $(this).addClass('btn-primary').removeClass('btn-secondary');
                    $('#allButton, #usersButton, #groupsButton, #shopsButton, #productsButton').addClass('btn-secondary').removeClass('btn-primary');
                });

                $('#shopsButton').click(function () {
                    $('#allResults, #userResults, #groupResults, #usernameResults, #productResults').addClass('d-none');
                    $('#shopResults').removeClass('d-none');
                    $(this).addClass('btn-primary').removeClass('btn-secondary');
                    $('#allButton, #usersButton, #groupsButton, #usernameButton, #productsButton').addClass('btn-secondary').removeClass('btn-primary');
                });

                $('#productsButton').click(function () {
                    $('#allResults, #userResults, #groupResults, #usernameResults, #shopResults').addClass('d-none');
                    $('#productResults').removeClass('d-none');
                    $(this).addClass('btn-primary').removeClass('btn-secondary');
                    $('#allButton, #usersButton, #groupsButton, #usernameButton, #shopsButton').addClass('btn-secondary').removeClass('btn-primary');
                });
            });
            function confirmCancel() {
                return confirm("Bạn có muốn hủy lời mời này không?");
            }
            function confirmUnfriend() {
                return confirm("Bạn có chắc chắn muốn hủy kết bạn không?");
            }
        </script>
</body>


</body>
<%@ include file="../include/footer.jsp" %>