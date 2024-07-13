<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ include file="../include/header.jsp" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- SweetAlert JS -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <c:if test="${not empty sessionScope.USER}">
            <%@ include file="../include/slidebar.jsp" %>
        </c:if>
        <c:if test="${empty sessionScope.USER}">
            <%@ include file="../include/slidebar_guest.jsp" %>
        </c:if>
        <div class="body-wrapper">
            <c:if test="${not empty sessionScope.USER}">
                <%@ include file="../include/navbar.jsp" %>
            </c:if>
            <c:if test="${empty sessionScope.USER}">
                <%@ include file="../include/navbar_guest.jsp" %>
            </c:if>
            <div class="container-fluid">
                <!-- Fetching order details -->
                <c:set var="orderID" value="${orderid}" />
                <c:set var="order" value="${Shop_DB.getOrderbyID(orderID)}" />
                <c:set var="orderItems" value="${Shop_DB.getAllOrderItemByOrderID(orderID)}" />

                <div class="row">
                    <div class="col-md-12">
                        <div class="card mb-3">
                            <div class="card-header text-center">
                                <h3>Chi Tiết Đơn Hàng</h3>
                            </div>
                            <div class="card-body">
                                <!-- Order Information -->
                                <div class="invoice p-5">
                                    <h5><i class="bi bi-info-circle-fill"></i> Thông Tin Đơn Hàng</h5>
                                    <div class="border-top mt-3 mb-3 border-bottom">
                                        <table class="table">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <div class="py-2">
                                                            <i class="bi bi-person-fill"></i>
                                                            <span class="d-block text-muted">Người Nhận:</span>
                                                            <span>${USER.userFullName}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="py-2">
                                                            <i class="bi bi-telephone-fill"></i>
                                                            <span class="d-block text-muted">Số Điện Thoại:</span>
                                                            <span>${order.receiverPhone}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="py-2">
                                                            <i class="bi bi-calendar-fill"></i>
                                                            <span class="d-block text-muted">Ngày Đặt Hàng:</span>
                                                            <span>${order.orderDate}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="py-2">
                                                            <i class="bi bi-pencil-fill"></i>
                                                            <span class="d-block text-muted">Ghi Chú:</span>
                                                            <span>${order.note}</span>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- Order Items -->
                                    <h5><i class="bi bi-bag-fill"></i> Sản Phẩm Trong Đơn Hàng</h5>
                                    <div class="my-2">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>Tên Sản Phẩm</th>
                                                    <th>Image</th>
                                                    <th>Số Lượng</th>
                                                    <th>Giá</th>
                                                    <th>Tổng</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:set var="totalPrice" value="0" />
                                                <c:forEach var="item" items="${orderItems}">
                                                    <c:set var="product" value="${Shop_DB.getProductByID(item.productID)}" />
                                                    <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(item.productID)}" />
                                                    <tr>
                                                        <td>${product.name}</td>
                                                        <td><img id="main-image-${product.productId}" class="rounded card-img-top product-img" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}" alt="Card image cap"></td>
                                                        <td>${item.quantity}</td>
                                                        <td>${item.price} VND</td>
                                                        <td>${item.quantity * item.price} VND</td>
                                                        <c:set var="totalPrice" value="${item.quantity * item.price + totalPrice}" />
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- Order Total -->
                                    <div class="row d-flex justify-content-end mt-5">
                                        <div class="col-md-6">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <div class="text-left">
                                                                <i class="bi bi-cash-stack"></i>
                                                                <span class="text-muted">Tổng:</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="text-right">
                                                                <span>${totalPrice} VND</span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <c:set var="discount" value="${Shop_DB.getDiscountByID(order.discountid)}" />
                                                    <tr>
                                                        <td>
                                                            <div class="text-left">
                                                                <i class="bi bi-tag-fill"></i>
                                                                <span class="text-muted">Giảm Giá:</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="text-right">
                                                                <span>- ${totalPrice * discount.discountPercent / 100} VND</span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr class="border-top border-bottom">
                                                        <td>
                                                            <div class="text-left">
                                                                <i class="bi bi-wallet-fill"></i>
                                                                <span class="font-weight-bold">Tổng Cộng:</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="text-right">
                                                                <span class="font-weight-bold text-success">${totalPrice - (totalPrice * discount.discountPercent / 100)} VND</span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- Order Status -->
                                    <h5><i class="bi bi-flag-fill"></i> Trạng Thái Đơn Hàng</h5>
                                    <div class="progress mb-3">
                                        <c:choose>
                                            <c:when test="${order.status == 'Pending'}">
                                                <div class="progress-bar bg-warning" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">Đang chờ xác nhận</div>
                                            </c:when>
                                            <c:when test="${order.status == 'Accept'}">
                                                <div class="progress-bar bg-info" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">Đã xác nhận</div>
                                            </c:when>
                                            <c:when test="${order.status == 'Completed'}">
                                                <div class="progress-bar bg-primary" role="progressbar" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">Đã hoàn tất</div>
                                            </c:when>
                                            <c:when test="${order.status == 'Cancelled'}">
                                                <div class="progress-bar bg-danger" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">Đã hủy</div>
                                            </c:when>
                                            <c:when test="${order.status == 'Fail'}">
                                                <div class="progress-bar bg-danger" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">Bị hủy</div>
                                            </c:when>
                                            <c:when test="${order.status == 'Success'}">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">Thành công</div>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <!-- Back Button -->
                                    <div class="d-flex justify-content-end">
                                        <button type="button" class="btn btn-danger" onclick="javascript:history.go(-1);">
                                            <i class="bi bi-arrow-left"></i> Quay Lại
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="../include/footer.jsp" %>
        </div>
    </div>
</body>
</html>
