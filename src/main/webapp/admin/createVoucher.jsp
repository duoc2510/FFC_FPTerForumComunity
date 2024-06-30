<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*" %>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                            <div id="report-sections">
                                <div id="reported-posts-section">
                                    <h2>Create coupons for the entire system</h2>
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <form id="createVoucherForm">
                                                <div class="modal-body">
                                                    <div class="form-group">
                                                        <label for="discountCodeInput">Discount Code:</label>
                                                        <input type="text" class="form-control" id="discountCodeInput" name="discountCode" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="discountPercentInput">Discount Percent:</label>
                                                        <input type="number" class="form-control" id="discountPercentInput" name="discountPercent" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="discountConditionInput">Discount Condition (Giá trị đơn hàng tối thiểu):</label>
                                                        <input type="number" class="form-control" id="discountConditionInput" name="discountConditionInput" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="validFromInput">Valid From:</label>
                                                        <input type="date" class="form-control" id="validFromInput" name="validFrom" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="validToInput">Valid To:</label>
                                                        <input type="date" class="form-control" id="validToInput" name="validTo" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="usageLimitInput">Usage Limit:</label>
                                                        <input type="number" class="form-control" id="usageLimitInput" name="usageLimit" required>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="submit" class="btn btn-primary">Add New</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    <%@ include file="../include/footer.jsp" %>

    <script>
        $(document).ready(function () {
            $('#createVoucherForm').on('submit', function (event) {
                event.preventDefault();

                var formData = {
                    discountCode: $('#discountCodeInput').val(),
                    discountPercent: $('#discountPercentInput').val(),
                    discountConditionInput: $('#discountConditionInput').val(),
                    validFrom: $('#validFromInput').val(),
                    validTo: $('#validToInput').val(),
                    usageLimit: $('#usageLimitInput').val()
                };

                $.ajax({
                    type: 'POST',
                    url: 'createvoucher',
                    data: formData,
                    success: function (response) {
                        swal('Success', 'Discount created successfully!', 'success');
                        // Optionally, clear the form fields or perform other actions
                        $('#createVoucherForm')[0].reset();
                    },
                    error: function (xhr, status, error) {
                        swal('Error', 'There was an error creating the discount.', 'error');
                    }
                });
            });
        });
    </script>
</body>
</html>
