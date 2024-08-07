<%-- 
    Document   : campaignDetailAds.jsp
    Created on : Jun 26, 2024, 7:12:37 PM
    Author     : mac
--%>

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
                            <div class="px-4 py-4 cover cover" style="background: url(${pageContext.request.contextPath}/upload/deli-2.png); height:250px;">
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
                            <div class="mb-4">
                                <h3>Advertising for ${comboInformation[0].title} campaign</h3>
                                <h6>you can keep an eye on your campaign while you’re on the go. Wherever you are, you’ll have the power to create and edit ads, track their performance, and manage ad budgets and schedules.</h6>
                            </div>
                            <div class="form-group pb-3 d-flex flex-wrap">

                                <c:if test="${empty allAdsUserInCombo}">
                                    <p class="mb-4">You have no advertising for ${comboInformation[0].title} campaign.</p>
                                </c:if>

                                <c:forEach var="ads" items="${allAdsUserInCombo}">
                                    <div class="col-6 px-2">
                                        <img src="${pageContext.request.contextPath}/${ads.image}" class="card-img w-100 rounded-top" alt="${ads.content}" style="height: 300px; object-fit: cover; border: 0px solid; border-radius: 10px 10px 0 0;">

                                        <div class="card p-4 rounded">
                                            <p>Advertising ID: ${ads.adsId}</p>
                                            <h5 class="card-title mt-2">${ads.title}</h5>

                                            <div class="row mb-1 align-items-center">
                                                <div class="col-3  px-3 ">
                                                    <img src="${pageContext.request.contextPath}/${USER.userAvatar}" class="card-img" alt="avatarUser" style="object-fit: cover; border: 0px solid; border-radius: 50%;">
                                                </div>
                                                <div class="col-9">
                                                    <p class="ml-auto"><b> ${USER.userFullName}</b></p>
                                                    <span>Sponsored</span>
                                                </div>
                                            </div>

                                            <p class="mt-1">
                                                Started running on ${ads.startDate}
                                            </p>
                                            <p class="card-text mt-2">
                                                ${ads.title}
                                            </p>
                                            <p class="card-text mt-2">
                                                URL: <a href="${pageContext.request.contextPath}/redirect?to=${ads.uri}&a=${ads.adsId}" target="_blank">${ads.uri}</a>
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
                                </c:forEach>

                            </div>
                            <div class="d-flex">
                                <button class="btn btn-primary" data-toggle="modal" data-target="#createCampaign">Create advertising</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp" %>    
    <!-- Modal to add new campaign -->
    <div class="modal fade" id="createCampaign" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Create advertising for ${comboInformation[0].title} campaign</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/advertising/boost" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="form-group mb-3">
                            <label for="productNameInput">Title:</label>
                            <input type="text" class="form-control" name="Title" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="fileInput">Choose Image File:</label>
                            <input type="file" class="form-control-file" id="fileInput" name="file" accept="image/*" required>
                        </div>
                        <div class="form-group mb-3">
                            <label for="productDescriptionInput">Content:</label>
                            <textarea class="form-control" name="Content" required></textarea>
                        </div>
                        <%--<c:choose>--%>
                            <%--<c:when test="${adsCombo.comboType == 'traffic'}">--%>
                                <div class="form-group mb-3">
                                    <label for="productURIInput">URL:</label>
                                    <input type="text" class="form-control" name="URI" required>
                                </div>
                            <%--</c:when>--%>
                        <%--</c:choose>--%>
                        
                        <div class="form-group checkboxLocation">
                            <div class="checkbox my-2">
                                <label>
                                    <input type="checkbox" name="campus" class="check" id="checkAll" value="All"> All campus
                                </label>
                            </div>
                            <!-- Other checkboxes will be dynamically added here -->
                        </div>
                        <div class="form-group mb-3">
                            <label for="budgetInput">Gender</label>
                            <select class="form-select" name="targetSex">
                                <option value="all">All</option>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                            </select>
                        </div>



                        <!-- Hidden input fields -->
                        <input type="hidden" name="adsDetailId" value="${AdsComboID}"/>
                        <input type="hidden" id="location${adsCombo.adsDetailId}" name="location">
                        <input type="hidden" name="action" value="boostInCampaign">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Create</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $.getJSON('${pageContext.request.contextPath}/static/json/data.json', function (data) {
                // Iterate over each campus in the JSON data
                $.each(data.Campus, function (index, campus) {
                    // Append a checkbox for each campus
                    $('.checkboxLocation').append('<div class="checkbox my-2"><label><input type="checkbox" class="check" name="campus" value="' + campus.ID + '">' + campus.Name + '</label></div>');
                });

                // Selectors for dynamically added checkboxes
                const checkboxes = $('.checkboxLocation input[name="campus"]');
                const hiddenInput = $('#location');
                const checkAllBox = $('#checkAll');

                function updateCampusArray() {
                    let selected = [];
                    checkboxes.each(function () {
                        if ($(this).is(':checked') && this !== checkAllBox[0]) {
                            selected.push($(this).val());
                        }
                    });

                    if (checkAllBox.is(':checked')) {
                        selected = ["All"];
                    }

                    hiddenInput.val(JSON.stringify(selected));
                }

                checkboxes.change(function () {
                    if (this === checkAllBox[0] && $(this).is(':checked')) {
                        checkboxes.not(checkAllBox).prop('checked', false);
                    } else if (!$(this).is(':checked') && this === checkAllBox[0]) {
                        checkAllBox.prop('checked', false);
                    }
                    updateCampusArray();
                });

                $("#checkAll").click(function () {
                    checkboxes.not(checkAllBox).prop('checked', $(this).prop('checked'));
                    updateCampusArray();
                });

                updateCampusArray(); // Initial update  
            });
        });

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
</body>
</html>
