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
                                    <h3>My Advertising</h3>
                                    <h6>Payment Method</h6>
                                </div>
                                <div class="form-group pb-3">
                                    <div class="d-flex flex-row align-items-center mb-4 pb-1 row">
                                        <c:forEach var="entry" items="${adsWithComboData}">
                                            <c:set var="ads" value="${entry.key}" />
                                            <c:set var="adsCombo" value="${entry.value}" />

                                            <div class="card mb-3 col-12" style="width: 100%;">
                                                <div class="row no-gutters px-3">
                                                    <div class="col-md-4">
                                                        <img src="${pageContext.request.contextPath}/${ads.image}" class="card-img h-100" alt="${ads.content}">
                                                    </div>
                                                    <div class="col-md-8">
                                                        <div class="card-body">
                                                            <h5 class="card-title">${ads.content}</h5>
                                                            <p class="card-text mt-2">
                                                                <small class="text-muted">Views: ${ads.currentReact} / ${adsCombo.maxReact}</small>
                                                            </p>
                                                            <p class="card-text mt-2">
                                                                <small class="text-muted">Location: ${ads.location}</small>
                                                            </p>
                                                            <p class="card-text mt-2">
                                                                <small class="text-muted">URL: <a href="${ads.uri}" target="_blank">${ads.uri}</a></small>
                                                            </p>
                                                            <p class="card-text mt-2">
                                                            <div class="form-check form-switch">
                                                                <input 
                                                                    class="form-check-input" 
                                                                    type="checkbox" 
                                                                    ${ads.isActive == 1 ? 'checked' : ''}
                                                                    onchange="handleActiveChange(${ads.adsId}, this.checked)"
                                                                    >
                                                                <label class="form-check-label" for="flexSwitchCheckChecked_${ads.adsId}">
                                                                    ${ads.isActive == 1 ? 'Active' : 'Not active'}
                                                                </label>
                                                            </div>
                                                            </p>
                                                        </div>
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
            </div>
        </div>
    </div>
</body>
<script>
    function handleActiveChange(adsId, isActive) {
        if (isActive == false) {
            isActive = 0;
        } else {
            isActive = 1;
        }
        var data = {
            action: "changeActive",
            adsId: adsId,
            isActive: isActive  // Convert boolean to integer (1 or 0)
        };

        $.ajax({
            url: '${pageContext.request.contextPath}/advertising/boost', // Update URL according to your servlet mapping
            type: 'POST',
            data: data,
            dataType: 'json',
            success: function (response) {
                if (response.success) {
                    swal("Success! Your advertising status has been changed!", {
                        icon: "success",
                    }).then(() => {
                        location.reload();
                    });
                } else {
                    swal("Error!", response.message, "error");
                }
            },
            error: function (xhr, status, error) {
                swal("Error!", "Unable to update advertising status.", "error");
            }
        });
    }
</script>
<%@ include file="../include/footer.jsp" %>
