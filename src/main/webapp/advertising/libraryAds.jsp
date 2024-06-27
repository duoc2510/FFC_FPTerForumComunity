<%-- 
    Document   : index
    Created on : May 25, 2024, 9:43:06 PM
    Author     : mac
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../include/header.jsp" %>
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
                                    <span>To find an ad, search for keywords or an advertiser.</span>
                                    <h3>Advertising Library</h3>
                                    <h6>Search all the ads currently running across Meta technologies, as well as: <br/>
                                        Ads about social issues, event or activity that have run.<br/>
                                        Ads that have run anywhere in the Campus.<br/>
                                    </h6>
                                </div>
                                <div class="form-group pb-3">
                                    <div class="d-flex flex-row align-items-center mb-4 pb-1 row">


                                        <form class="form-inline my-3 mb-4">
                                            <div class=" d-flex mb-3"> 
                                                <select id="location" name="location" class="form-control form-select" style="margin-right:2%;">
                                                    <option value="all">All</option>
                                                </select>
                                                <select class="form-control  form-select ">
                                                    <option selected>Gender</option>
                                                    <option value="male">Male</option>
                                                    <option value="female">Female</option>
                                                </select>
                                            </div>

                                            <div class=" d-flex">
                                                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" style="margin-right:2%;">
                                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                                            </div>
                                        </form>
                                        <div class=" mb-3 col-12" style="width: 100%;">
                                            <div class="row no-gutters px-3">
                                                <!--${adUserMap}-->
                                                <c:forEach var="entry" items="${adsWithComboData}">
                                                    <c:set var="ads" value="${entry.key}" />
                                                    <c:set var="adsCombo" value="${entry.value}" />
                                                    <!-- Fetch user details from adUserMap using ads.adsDetailId -->
                                                    <c:set var="adUser" value="${adUserMap[ads.adsDetailId]}" />

                                                    <c:if test="${ads.isActive == 1}">
                                                        <div class="col-6 px-2">
                                                            <img src="${pageContext.request.contextPath}/${ads.image}" class="card-img w-100" alt="${ads.content}" style="height: 300px; object-fit: cover; border: 0px solid; border-radius: 10px 10px 0 0;">

                                                            <div class="card p-4">
                                                                <p>Advertising ID: ${ads.adsId}</p>
                                                                <h5 class="card-title mt-2">${ads.title}</h5>
                                                                <p class="ml-auto">User: ${adUser.userFullName}</p>
                                                                <img src="${pageContext.request.contextPath}/${adUser.userAvatar}" class="card-img" alt="avatarUser" style="height: 50px; width: 50px; object-fit: cover; border: 0px solid; border-radius: 50%;">

                                                                <p class="card-text mt-1">
                                                                    <small class="text-muted">Started running on ${ads.startDate}</small>
                                                                </p>
                                                                <p class="card-text mt-2">
                                                                    <small class="text-muted">${ads.title}</small>
                                                                </p>
                                                                <p class="card-text mt-2">
                                                                    <small class="text-muted">URL: <a href="${ads.uri}" target="_blank">${ads.uri}</a></small>
                                                                </p>
                                                                <p class="card-text mt-2">
                                                                    ${ads.isActive == 1 ? 'Active' : 'Not active'}
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
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
<script>
    $(document).ready(function () {
        // Fetch data from data.json using jQuery
        $.getJSON('${pageContext.request.contextPath}/static/json/data.json', function (data) {
            // Iterate over each campus in the JSON data
            $.each(data.Campus, function (index, campus) {
                // Append an option to the select element for each campus
                $('#location').append('<option value="' + campus.ID + '">' + campus.Name + '</option>');
            });
        });



    });
</script>
<%@ include file="../include/footer.jsp" %>
