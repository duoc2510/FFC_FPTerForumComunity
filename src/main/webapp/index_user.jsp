<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="include/navbar.jsp" %>
            <div class="container-fluid d-flex">
                <div >
                    <%@ include file="user/newsfeed.jsp" %>
                </div>
            </div>
            <%@ include file="include/right-slidebar.jsp" %>
        </div>
    </div>
</body>
<%@ include file="include/footer.jsp" %>
