<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="include/slidebar_guest.jsp" %>
        <div class="body-wrapper">
            <%@ include file="include/navbar_guest.jsp" %>
            <div class="container-fluid d-flex">
                <div class="col-lg-12 w-100">
                    <%@ include file="user/tabTopic.jsp" %>
                    <%@ include file="user/newPost.jsp" %>
                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="include/footer.jsp" %>
