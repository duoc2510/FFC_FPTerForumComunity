<%-- 
    Document   : index
    Created on : May 25, 2024, 9:43:06 PM
    Author     : mac
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../include/header.jsp" %>
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
                            <div class="px-4 py-4 cover" style="background: url(${pageContext.request.contextPath}/upload/deli-2.png); height:250px;">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}" class="position-absolute rounded-circle img-thumbnail" style="object-fit: cover;">
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0 position-relative" style="left: 6.5em">${USER.userFullName}</h4>
                                </div>
                                <ul class="list-inline mb-0"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid pt-0">
                <div class="row form-settings d-flex justify-content-between">
                    <div class="col-12 col-sm-5 px-2">
                        <%@ include file="menuAds.jsp" %>
                    </div>
                    <div class="col-12 col-sm-7 px-2">
                        <div class="bg-white shadow rounded p-4">
                            <div>
                                <div class="mb-4">
                                    <h3>My Advertising</h3>
                                    <h6>Payment Method</h6>
                                </div>
                                <div class="form-group pb-3">
                                    <div class="d-flex flex-row align-items-center mb-4 pb-1">
                                        <%--<c:forEach var="ads" items="${allAds}">--%>
                                            <div class="card mb-3" style="width: 100%;">
                                                <div class="row no-gutters">
                                                    <div class="col-md-4">
                                                        <img src="${pageContext.request.contextPath}/${ads.image}" class="card-img" alt="${ads.content}">
                                                    </div>
                                                    <div class="col-md-8">
                                                        <div class="card-body">
                                                            <h5 class="card-title">${ads.content}</h5>
                                                            <p class="card-text"><small class="text-muted">Views: ${ads.currentView}</small></p>
                                                            <p class="card-text"><small class="text-muted">Location: ${ads.location}</small></p>
                                                            <p class="card-text"><small class="text-muted">URI: <a href="${ads.uri}" target="_blank">${ads.uri}</a></small></p>
                                                        </div>
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
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
