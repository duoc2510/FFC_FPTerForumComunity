<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>
    <c:choose>
        <c:when test="${empty sessionScope.USER}">
            <%@ include file="../index_guest.jsp" %>
        </c:when>
        <c:otherwise>
            <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
                 data-sidebar-position="fixed" data-header-position="fixed">
                <%@ include file="../include/slidebar.jsp" %>
                <div class="body-wrapper">
                    <%@ include file="../include/navbar.jsp" %>
                    <div class="container-fluid d-flex">
                        <div class="col-lg-12 w-100">
                            <%@ include file="../topic/tabTopic.jsp" %>
                            <c:set var="hasPendingPosts" value="false" />

                            <c:forEach var="topic" items="${topics}">
                                <c:forEach var="post" items="${postsTopic}">
                                    <c:if test="${post.status eq 'Pending' && not empty post.topicId && post.topicId == topic.topicId}">
                                        <c:set var="hasPendingPosts" value="true" />
                                        <%@ include file="topicPostdetail.jsp" %>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>

                            <c:if test="${not hasPendingPosts}">
                                <div class="row">
                                    <div class="card">
                                        <div class="card-body p-4 row">
                                            <div class="col-sm-12 text-center">
                                                <p>Không có bài viết nào đang chờ duyệt.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
        </body>
    </c:otherwise>
</c:choose>
<%@ include file="../include/footer.jsp" %>
