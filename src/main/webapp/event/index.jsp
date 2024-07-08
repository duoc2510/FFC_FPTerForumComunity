<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.min.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.min.js"></script>

<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>

        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid" >
                <!-- Message Display -->
                <c:if test="${not empty sessionScope.message}">
                    <div id="message" class="alert alert-info">
                        ${sessionScope.message}
                    </div>
                    <c:remove var="message" scope="session"/>
                </c:if>
                <%@ include file="allEvent.jsp" %>
            </div>
        </div>
        <%@ include file="../include/right-slidebar.jsp" %>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
