<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<head>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
<aside class="left-sidebar">
    <!-- Bootstrap CSS -->


    <style>
        .sub-item{
            font-size: 13px;
            padding-left: 20px;
        }
    </style>

    <!-- Sidebar scroll-->  
    <div>
        <div class="brand-logo d-flex align-items-center justify-content-between">
            <a href="${pageContext.request.contextPath}/home" class="text-nowrap logo-img">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" width="100" alt="" />
            </a>
            <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
                <i class="ti ti-x fs-8"></i>
            </div>
        </div>
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
            <ul id="sidebarnav">
                <c:if test="${USER.userRole == 3}">
                    <li class="sidebar-item">
                        <a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                            <span>
                                <i class="ti ti-users"></i>
                            </span>
                            <span class="hide-menu">Admin <i style="font-size: 13px" class="ti ti-arrow-down"></i></span>
                        </a>
                        <ul aria-expanded="false" class="collapse  first-level">
                            <li class="sidebar-item sub-item">
                                <a href="${pageContext.request.contextPath}/admin/ManageUsers?action=allUser" class="sidebar-link" role="button">
                                    <span class="hide-menu">- Manage users</span>
                                </a>
                            </li>
                            <li class="sidebar-item sub-item">
                                <a href="${pageContext.request.contextPath}/admin/handelRpManager" class="sidebar-link">
                                    <span class="hide-menu">- Handle report manager</span>
                                </a>
                            </li>

                            <li class="sidebar-item sub-item">
                                <a href="${pageContext.request.contextPath}/#" class="sidebar-link">
                                    <span class="hide-menu">- Reset rankings</span>
                                </a>
                            </li>
                            <li class="sidebar-item sub-item">
                                <a href="${pageContext.request.contextPath}/admin/approveshop" class="sidebar-link">
                                    <span class="hide-menu">- Approve shop</span>
                                </a>
                            </li>
                            <li class="sidebar-item sub-item">
                                <a href="${pageContext.request.contextPath}/#" class="sidebar-link">
                                    <span class="hide-menu">- Add ads</span>
                                </a>
                            </li>
                            <li class="sidebar-item sub-item">
                                <a href="${pageContext.request.contextPath}/admin/createvoucher" class="sidebar-link">
                                    <span class="hide-menu">- Create voucher</span>
                                </a>
                            </li>
                            <li class="sidebar-item sub-item">
                                <a href="${pageContext.request.contextPath}/admin/viewFeedBack" class="sidebar-link">
                                    <span class="hide-menu">- View feedback</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                </c:if>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}/post" aria-expanded="false">
                        <span>
                            <i class="ti ti-article"></i>
                        </span>
                        <span class="hide-menu">News Feed</span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}/group" aria-expanded="false">
                        <span>
                            <i class="ti ti-users"></i>
                        </span>
                        <span class="hide-menu">Group</span>
                    </a>
                </li>

                <c:if test="${USER.userRole > 1}">
                    <li class="sidebar-item">
                        <a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                            <span>
                                <i class="ti ti-users"></i>
                            </span>
                            <span class="hide-menu">Manager <i style="font-size: 13px" class="ti ti-arrow-down"></i></span>
                        </a>
                        <ul aria-expanded="false" class="collapse  first-level">
                            <li class="sidebar-item sub-item">
                                <a href="${pageContext.request.contextPath}/manager/post" class="sidebar-link">
                                    <span class="hide-menu">- Approve Post</span>
                                </a>
                            </li>
                            <li class="sidebar-item sub-item">
                                <a href="${pageContext.request.contextPath}/manager/report" class="sidebar-link">
                                    <span class="hide-menu">- Handle report</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                </c:if>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}/listEvent" aria-expanded="false">
                        <span>
                            <i class="ti ti-calendar-event"></i>
                        </span>
                        <span class="hide-menu">Event</span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}/advertising" aria-expanded="false">
                        <span>
                            <i class="ti ti-speakerphone"></i>
                        </span>
                        <span class="hide-menu">Advertising</span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}/rank" aria-expanded="false">
                        <span>
                            <i class="ti ti-trophy"></i>
                        </span>
                        <span class="hide-menu">Rank</span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}/marketplace" aria-expanded="false">
                        <span>
                            <i class="ti ti-basket"></i>
                        </span>
                        <span class="hide-menu">Marketplace</span>
                    </a>
                </li>
            </ul>
            <c:choose>
                <c:when test="${USER.userRank == 3 && USER.userRole == 1}">
                    <%@ include file="../user/managerRegistr.jsp" %>
                </c:when>
                <c:otherwise>
                    <%@ include file="../ads/showAds.jsp" %>
                </c:otherwise>
            </c:choose>
           <c:if test="${USER.userRole != 3}">
                <%@ include file="../user/feedBackModal.jsp" %>
            </c:if>
        </nav>
    </div>
</aside>
