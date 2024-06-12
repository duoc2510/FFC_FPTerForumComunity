<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>


    <c:choose>
        <c:when test="${empty sessionScope.USER}">
            <%@ include file="index_guest.jsp" %>
        </c:when>
        <c:otherwise>
            <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
                 data-sidebar-position="fixed" data-header-position="fixed">
                <%@ include file="include/slidebar.jsp" %>
                <div class="body-wrapper">
                    <%@ include file="include/navbar.jsp" %>
                    <div class="container-fluid d-flex">
                        <div class="col-lg-12 w-100">
                            <%@ include file="topic/tabTopic.jsp" %>
                            <%-- Hiển thị tin nhắn thành công nếu có --%>
                            <c:if test="${sessionScope.USER ne null}">
                                <%@ include file="topic/newPost.jsp" %>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </body>
    </c:otherwise>
</c:choose>

<%@ include file="include/footer.jsp" %>
