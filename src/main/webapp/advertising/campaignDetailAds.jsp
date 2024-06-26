<%-- 
    Document   : campaignDetailAds.jsp
    Created on : Jun 26, 2024, 7:12:37 PM
    Author     : mac
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
                            <div class="mb-4">
                                <h3>Campaign advertising</h3>
                                <h6>you can keep an eye on your campaign while you’re on the go. Wherever you are, you’ll have the power to create and edit ads, track their performance, and manage ad budgets and schedules.</h6>
                            </div>
                            <div class="form-group pb-3">
                                <c:if test="${empty allAdsCombo}">
                                    <p class="mb-4">You have no campaigns.</p>
                                    <div class="d-flex">
                                        <div class="d-flex col-6" style="margin-right:2%;">
                                            <button class="btn btn-primary w-100" data-toggle="modal" data-target="#createCampaign" href="javascript:void(0)">Create new campaign</button>
                                        </div>
                                        <div class="d-flex col-6" style="width: 48%">
                                            <a class="w-100" href="${pageContext.request.contextPath}/advertising/combo">
                                                <button class="btn btn-light border w-100">Quick start with combo</button>
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
                                    ${AdsComboID}
                                <c:if test="${not empty allAdsCombo}">
                                    <c:forEach var="adsCombo" items="${allAdsCombo}">
                                        <div class="row mb-4 card py-3 px-2">
                                            <div class=col-12"> 
                                                <div data-ads="${adsCombo.adsDetailId}" class="d-flex flex-row align-items-center mb-4 pb-1">
                                                    <div class="border px-3 py-2 mx-2 rounded">
                                                        <i class="ti ti-eye d-inline"></i> <p class="d-inline">Awareness</p>
                                                    </div>

                                                    <h6 class="mt-1">${adsCombo.title}</h6>

                                                </div>
                                            </div>
                                            <div class="col-12 mx-3 mb-3 d-flex"> 
                                                <div class="col-6">
                                                    <p>Total views: ${adsCombo.maxView}</p>
                                                    <p>Budget: ${adsCombo.budget} VND</p>
                                                </div>
                                                <div class="col-6">
                                                    <p>Duration day: ${adsCombo.durationDay}</p>
                                                    <p>Rate: <span id="rate">${adsCombo.budget / adsCombo.maxView / adsCombo.durationDay}</span> VND/view</p>
                                                </div>
                                            </div>
                                            <div class="col-12 mt-2 mx-2 d-flex justify-content-end"> 
                                                <a class="btn btn-light" data-toggle="modal" data-target="#addProduct${adsCombo.adsDetailId}" href="javascript:void(0)">View</a>
                                                <a class="btn btn-primary mx-2" href="campaign/detail?id=${adsCombo.adsDetailId}">Continue</a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <div class="d-flex">
                                        <button class="btn btn-primary" data-toggle="modal" data-target="#addCampaign" href="javascript:void(0)">Create new campaign</button>
                                    </div>
                                </c:if>

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
                    <h5 class="modal-title">Create campagin</h5>
                    <button class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/advertising/campaign" method="post">
                    <div class="modal-body">
                        <div class="form-group mb-3">
                            <label for="productNameInput">Campaign name</label>
                            <input type="text" class="form-control" name="title" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="budgetInput">Budget:</label>
                            <input type="range" class="form-control" id="budgetInput" name="budget" min="10000" max="5000000" step="10000" required>
                            <span id="budgetValue">10,000 VND</span>
                        </div>

                        <div class="d-flex">
                            <div class="col-6 form-group mb-3" style="padding-right: 2%">
                                <label for="durationDayInput">Days:</label>
                                <input type="number" class="form-control" id="durationDayInput" name="durationDay" min="4" max="365" value="30" required>
                                <p id="dayErrorMessage" class="error-message">Duration between 4 and 365 days.</p>


                            </div>
                            <div class="col-6 form-group mb-3">
                                <label for="productQuantityInput">View:</label>
                                <input type="number" class="form-control" value="${adsCombo.maxView}" id="maxView" name="maxView" placeholder="Views want to auction">

                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <label for="productQuantityInput">Your wallet need:</label>
                            <input id="walletNeed" type="text" class="form-control" value="" readonly>
                            <p class="mt-2">Rate: <span id="caculateRate"></span></p>
                        </div>
                        <!-- Hidden input field -->
                        <input type="hidden" name="action" value="createCampaign">

                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Pay</button>
                    </div>
                </form>
            </div>
        </div>
    </div>



    <script>
        $(document).ready(function () {
            // UI 
            const $budgetInput = $('#budgetInput');
            const $budgetValue = $('#budgetValue');
            const $walletNeed = $('#walletNeed');

            // Function to format number as currency VND
            function formatCurrencyVND(value) {
                return Number(value).toLocaleString('vi-VN') + ' VND';
            }

            // Update the budget value display when the page loads
            $budgetValue.text(formatCurrencyVND($budgetInput.val()));

            // Add an event listener to update the value display when the input changes
            $budgetInput.on('input', function () {
                $budgetValue.text(formatCurrencyVND($budgetInput.val()));
                $walletNeed.val(formatCurrencyVND($budgetInput.val()));
            });


            //Validate
            const $durationDayInput = $('#durationDayInput');
            const $dayErrorMessage = $('#dayErrorMessage');
            $dayErrorMessage.hide();
            // Add an event listener to validate the value when the input changes
            $durationDayInput.on('input', function () {
                const value = $durationDayInput.val();
                if (value < 4 || value > 365) {
                    $dayErrorMessage.show();
                } else {
                    $dayErrorMessage.hide();
                }
            });

            // Caculate rate advertising



            const $maxViewInput = $('#maxView');
            const $caculateRate = $('#caculateRate');

            // Function to format number as currency VND
            function formatCurrencyVND(value) {
                return Number(value).toLocaleString('vi-VN') + ' VND';
            }

            // Function to calculate and update the rate
            function updateRate() {
                const budget = Number($budgetInput.val());
                const views = Number($maxViewInput.val());
                if (views > 0) {
                    const rate = budget / views;
                    $caculateRate.text(formatCurrencyVND(rate) + ' per view');
                } else {
                    $caculateRate.text('0 VND per view');
                }
            }

            // Update the budget value display when the page loads
            $budgetValue.text(formatCurrencyVND($budgetInput.val()));

            // Add event listeners to update the value display and calculate the rate when the input changes
            $budgetInput.on('input', function () {
                $budgetValue.text(formatCurrencyVND($budgetInput.val()));
                updateRate();
            });

            $maxViewInput.on('input', function () {
                updateRate();
            });


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
