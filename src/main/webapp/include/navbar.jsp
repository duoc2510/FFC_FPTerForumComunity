<style>
     .avatar-cover{
        width: 35px;
        height: 35px;
        object-fit: cover;
    }
    </style>

<header class="app-header">
    <nav class="navbar navbar-expand-lg navbar-light">



        <ul class="navbar-nav w-100" style="max-width: 400px">
            <input type="text" class="form-control " placeholder="Search" >
        </ul>

        <div class="navbar-collapse justify-content-end px-0" id="navbarNav">
            <ul class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
                <!--tim kiem--> 

                <li class="nav-item d-block d-xl-none">
                    <a class="nav-link sidebartoggler nav-icon-hover" id="headerCollapse" href="javascript:void(0)">
                        <i class="ti ti-menu-2"></i>
                    </a>
                </li>
                <!--thong bao-->
                <div class="dropdown show" >
                    <li class="nav-item">
                        <a class="nav-link dropdown-toggle"  href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="ti ti-bell-ringing"></i>
                            <div class="notification bg-primary rounded-circle"></div>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink" style="left: -10vw !important">
                            <li><a class="dropdown-item" href="#">Notification 1</a></li>
                            <li><a class="dropdown-item" href="#">Notification 2</a></li>
                            <li><a class="dropdown-item" href="#">Notification 3</a></li>
                        </ul>
                    </li>
                </div>
                <!--loop to print all thong bao--> 
                <%--<%@ include file="../user/notification.jsp" %>--%>

                <li class="nav-item dropdown">
                    <a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                     
                    </a>
                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2">
                        <div class="message-body">
                            <a href="${pageContext.request.contextPath}/profile" class="d-flex align-items-center gap-2 dropdown-item">
                                 <img src="${pageContext.request.contextPath}/${USER.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                                <p class="mb-0 fs-3">${USER.username}</p>
                            </a>
                            <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                <i class="ti ti-mail fs-6"></i>
                                <p class="mb-0 fs-3">My Account</p>
                            </a>
                            <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                <i class="ti ti-list-check fs-6"></i>
                                <p class="mb-0 fs-3">My Task</p>
                            </a>
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-primary mx-3 mt-2 d-block">Logout</a>
                        </div>
                    </div>
                </li>

            </ul>

        </div>
    </nav>
</header>