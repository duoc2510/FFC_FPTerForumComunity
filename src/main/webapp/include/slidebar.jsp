<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside class="left-sidebar">
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
            <%@ include file="../ads/showAds.jsp" %>
        </nav>
    </div>
</aside>