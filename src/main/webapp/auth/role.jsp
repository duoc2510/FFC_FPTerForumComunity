<%@ include file="../include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>

        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid">
                <c:if test="${not empty roleMessage}">
                    <div class="alert alert-info">
                        ${roleMessage}
                    </div>
                </c:if>
                <!-- The rest of your content -->
            </div>
        </div>

        <%@ include file="../include/right-slidebar.jsp" %>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
