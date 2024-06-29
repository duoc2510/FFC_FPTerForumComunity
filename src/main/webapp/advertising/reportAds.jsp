<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="../include/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid pb-2">
                <div class="row">
                    <div id="profile-wrapper">
                        <div class="bg-white shadow rounded overflow-hidden">
                            <div class="px-4 py-4 cover cover"
                                 style="background: url(${pageContext.request.contextPath}/upload/deli-2.png); height:250px;">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}"
                                             class="position-absolute rounded-circle img-thumbnail" style="object-fit: cover;">
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0 position-relative" style="left: 6.5em">${USER.userFullName}</h4>
                                </div>
                                <ul class="list-inline mb-0">
                                    <!-- Add any list items here if needed -->
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid pt-0">
                <div class="row form-settings d-flex justify-content-between">
                     <div class="col-12 col-sm-3 px-2">
                        <%@include file="menuAds.jsp" %>
                    </div>
                    <div class="col-12 col-sm-9 px-2">
                        <div class="bg-white shadow rounded p-4">
                            <div>
                                <div class="mb-4">
                                    <h3>Report </h3>
                                    <h6>Amplify your financial services advertising with FFC</h6>
                                </div>
                                <div class="form-group pb-3">
                                    <%--<c:forEach var="adsCombo" items="${allAdsCombo}">--%>
                                        <div data-ads="${adsCombo.adsDetailId}" class="d-flex flex-row align-items-center mb-4 pb-1">
                                            <img class="img-fluid" src="https://nhanhoa.com/templates/images/v2/kim_cuong.png"/>
                                            <div class="flex-fill mx-3 d-flex">
                                                <div data-mdb-input-init class="form-outline col-11">
                                                    <h6>${adsCombo.title}</h6>
                                                    <p>View post: ${adsCombo.maxReact}</p>
                                                    <p>${adsCombo.budget} VND</p>
                                                    <p>Rate: <c:choose>
                                                            <c:when test="${adsCombo.maxReact > 0}">
                                                                ${adsCombo.budget / adsCombo.maxReact} VND per view
                                                            </c:when>
                                                            <c:otherwise>
                                                                0 VND per view
                                                            </c:otherwise>
                                                        </c:choose></p>
                                                </div>
                                                <div class="col-1 d-flex justify-content-center align-items-center">
                                                    <a class="btn btn-primary" data-toggle="modal" data-target="#addProduct${adsCombo.adsDetailId}" href="javascript:void(0)">Boost</a>
                                                </div>
                                            </div>
                                        </div>
                                    <%--</c:forEach>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="../include/footer.jsp" %>
    </div>


</body>
</html>
