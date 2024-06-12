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
            <form class="d-flex" action="${pageContext.request.contextPath}/search" method="post">
                <input type="text" class="form-control me-2" name="query" placeholder="Search for user name or group name" aria-label="Search" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Search for user name or group name">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
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
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink" >
                            <li><a class="dropdown-item" href="#">Notification 1</a></li>
                            <li><a class="dropdown-item" href="#">Notification 2</a></li>
                            <li><a class="dropdown-item" href="#">Notification 3</a></li>
                        </ul>
                    </li>
                </div>

                <li class="nav-item dropdown">
                    <a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}" alt="" width="35" class="rounded-circle avatar-cover">
                    </a>
                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2">
                        <div class="message-body">
                            <a href="${pageContext.request.contextPath}/profile?username=${USER.username}" class="d-flex align-items-center gap-2 dropdown-item">
                                <img src="${pageContext.request.contextPath}/${USER.userAvatar}" alt="" width="40" class="rounded-circle avatar-cover">
                                <p class="mb-0 fs-6">
                                <c:choose>
                                    <c:when test="${USER.userRole == 1}">
                                        ${USER.username}
                                    </c:when>
                                    <c:when test="${USER.userRole == 2}">
                                        Manager
                                    </c:when>
                                    <c:when test="${USER.userRole == 3}">
                                        Admin
                                    </c:when>
                                </c:choose>
                                </p>
                            </a>
                            <a href="${pageContext.request.contextPath}/profile/setting" class="d-flex align-items-center gap-2 dropdown-item">
                                <i class="ti ti-user-circle fs-6"></i>
                                <p class="mb-0 fs-3">My Account</p>
                            </a>
                            <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                <i class="ti ti-wallet fs-6"></i>
                                <p class="mb-0 fs-3">Wallet: ${USER.userWallet}</p>
                            </a>
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger mx-3 mt-2 d-block">Logout</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </nav>
    <script>
        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        })
    </script>
</header>