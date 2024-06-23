<%-- 
    Document   : comboAds
    Created on : Jun 23, 2024, 3:26:43 PM
    Author     : Admin
--%>


<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid pb-2">
                <div class="row ">
                    <div id ="profile-wrapper" >
                        <style>

                        </style>
                        <div class="bg-white shadow rounded overflow-hidden ">
                            <div class="px-4 py-4 cover cover " style="background: url(${pageContext.request.contextPath}/upload/deli-2.png); height:250px;" >
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}" class="position-absolute rounded-circle img-thumbnail" style="object-fit: cover;">

                                    </div>
                                </div>
                            </div>

                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center ">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0 position-relative" style="left: 6.5em">${USER.userFullName}</h4>     
                                </div>
                                <ul class="list-inline mb-0">

                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="container-fluid pt-0">
                <div class="row form-settings d-flex justify-content-between">
                    <div class="col-12 col-sm-5 px-2">
                        <%@include file="menuAds.jsp" %>
                    </div>
                    <div class="col-12 col-sm-7 px-2">
                        <div class=" bg-white shadow rounded p-4 ">
                            <div>
                                <div class="mb-4">
                                    <h3>Advertising Package</h3>
                                    <h6>We have 3 option to boost your branding</h6>
                                </div>
                                <div class="form-group pb-3">

                                    <c:forEach var="adsCombo" items="${allAdsCombo}">
                                        <div class="d-flex flex-row align-items-center mb-4 pb-1">

                                            <img class="img-fluid" src="https://nhanhoa.com/templates/images/v2/kim_cuong.png" />
                                            <div class="flex-fill mx-3 d-flex">
                                                <div data-mdb-input-init class="form-outline col-11">
                                                    <h4>${adsCombo.content}</h4>
                                                    <p>View post: ${adsCombo.maxView}</p>
                                                    <p>${adsCombo.budget} VND</p>
                                                </div>
                                                <div class="col-1 d-flex justify-content-center align-items-center">
                                                    <a class="btn btn-primary" href="javascript:void(0)">Boost</a>
                                                </div>
                                            </div>                                    
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </body>
            <%@ include file="../include/footer.jsp" %>