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
                    <div class="col-12 col-sm-5 px-2">
                        <%@include file="menuAds.jsp" %>
                    </div>
                    <div class="col-12 col-sm-7 px-2">
                        <div class="bg-white shadow rounded p-4">
                            <div>
                                <div class="mb-4">
                                    <h3>Advertising Package</h3>
                                    <h6>We have 3 options to boost your branding</h6>
                                </div>
                                <div class="form-group pb-3">
                                    <c:forEach var="adsCombo" items="${allAdsCombo}">
                                        <div data-ads="${adsCombo.adsDetailId}" class="d-flex flex-row align-items-center mb-4 pb-1">
                                            <img class="img-fluid" src="https://nhanhoa.com/templates/images/v2/kim_cuong.png" />
                                            <div class="flex-fill mx-3 d-flex">
                                                <div data-mdb-input-init class="form-outline col-11">
                                                    <h6>${adsCombo.content}</h6>
                                                    <p>View post: ${adsCombo.maxView}</p>
                                                    <p>${adsCombo.budget} VND</p>
                                                </div>
                                                <div class="col-1 d-flex justify-content-center align-items-center">
                                                    <a class="btn btn-primary" data-toggle="modal" data-target="#addProduct${adsCombo.adsDetailId}" href="javascript:void(0)">Boost</a>
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
        <%@ include file="../include/footer.jsp" %>
    </div>
    <!-- Modals to add new Advertising by Package -->
    <c:forEach var="adsCombo" items="${allAdsCombo}">
        <div class="modal fade" id="addProduct${adsCombo.adsDetailId}" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Boost your brand ${adsCombo.content}</h5>
                        <button class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <form action="boost" method="post" enctype="multipart/form-data">
                        <div class="modal-body">
                            <div class="form-group mb-3">
                                <label for="productNameInput">Title:</label>
                                <input type="text" class="form-control" name="Title" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="productPriceInput">Campus:</label>
                                <div class="form-group" id="checkboxLocation">
                                    <div class="checkbox my-2">
                                        <label>
                                            <input type="checkbox" name="campus" class="check" id="checkAll" value="All"> All campus
                                        </label>
                                    </div>
                                    <!-- Add other campus checkboxes as json -->
                                </div>
                            </div>
                            <div class="form-group mb-3">
                                <label for="fileInput">Choose Image File:</label>
                                <input type="file" class="form-control-file" id="fileInput" name="file" accept="image/*" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="productDescriptionInput">Content:</label>
                                <textarea class="form-control" name="Content" required></textarea>
                            </div>
                            <div class="form-group mb-3">
                                <label for="productURIInput">URI:</label>
                                <input type="text" class="form-control" name="URI" required>
                            </div>
                            <div class="d-flex">
                                <div class="col-6 form-group mb-3" style="padding-right: 2%">
                                    <label for="productQuantityInput">View can get:</label>
                                    <input type="text" class="form-control" value="${adsCombo.maxView}" readonly>
                                </div>
                                <div class="col-6 form-group mb-3">
                                    <label for="productQuantityInput">Your wallet need:</label>
                                    <input type="text" class="form-control" value="${adsCombo.budget} VND" readonly>
                                </div>
                            </div>
                            <!-- Hidden input field -->
                            <input type="hidden" name="adsDetailId" value="${adsCombo.adsDetailId}"/>
                            <input type="hidden" id="location" name="location">
                            <input type="hidden" name="action" value="boost">

                            <!--<input type="hidden" name="action" value="add">-->
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Pay</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>

    <script>
        $(document).ready(function () {
            $.getJSON('${pageContext.request.contextPath}/static/json/data.json', function (data) {
                // Iterate over each campus in the JSON data
                $.each(data.Campus, function (index, campus) {
                    // Append a checkbox for each campus
                    $('#checkboxLocation').append('<div class="checkbox my-2"><label><input type="checkbox" class="check" name="campus" value="' + campus.ID + '">' + campus.Name + '</label></div>');
                });

                // Selectors for dynamically added checkboxes
                const checkboxes = $('#checkboxLocation input[name="campus"]');
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
       
    </script>
</body>
</html>
