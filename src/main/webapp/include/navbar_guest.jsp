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
                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary mx-3 mt-2 d-block">Login</a>
                <a href="${pageContext.request.contextPath}/register"   style="color: red;border-color: red; "class="btn btn-outline-primary mx-3 mt-2 d-block">Register</a>
            </ul>
        </div>
    </nav>
</header>