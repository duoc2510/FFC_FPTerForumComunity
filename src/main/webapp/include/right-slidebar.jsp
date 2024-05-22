<%-- 
    Document   : right-slidebar
    Created on : May 16, 2024, 10:35:34 AM
    Author     : mac
--%>

<style>
    .right-sidebar {
        right: 0;
        top: 69px;
        width: 200px;
        background-color: #fff;
        position: absolute;
        -webkit-transition: 0.2s ease-in;
        transition: 0.2s ease-in;
        height: calc(100vh - 69px);
        z-index: 1;
        border-right: 1px solid rgb(229, 234, 239);
    }

    @media (max-width: 1000px) {
        .right-sidebar{
            display: none;
        }
        #boxchat{
            display: none !important;
        }
    }

</style>
<aside class="right-sidebar border" >
    <!-- Sidebar scroll-->
    <div>

        <!-- Sidebar navigation-->
        <nav class="sidebar-nav scroll-sidebar">
            <ul>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}" aria-expanded="false">
                        <span>
                            <img src="https://upload.wikimedia.org/wikipedia/commons/9/9e/Kh%C3%A1_B%E1%BA%A3nh_khai_tr%C6%B0%C6%A1ng_shop_b%C3%A1n_qu%E1%BA%A7n_%C3%A1o_%E1%BB%9F_Qu%E1%BB%91c_Oai_2019-03-16.png" alt="" width="35" class="rounded-circle">
                        </span>
                        <span class="hide-menu"><strong>Kha B</strong></span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="${pageContext.request.contextPath}/group" aria-expanded="false">
                        <span>
                            <img src="http://localhost:8080/FPTer/static/images/user.png" alt="" width="35" class="rounded-circle">
                        </span>
                        <span class="hide-menu"><strong>Nguyen Truong</strong></span>
                    </a>
                </li>
            </ul>

        </nav>
    </div>
</aside>