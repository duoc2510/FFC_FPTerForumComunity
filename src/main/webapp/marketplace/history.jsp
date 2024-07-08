<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ include file="../include/header.jsp" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Page Title</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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
                <!-- Control panel -->
                <%@ include file="panel.jsp" %>

                <c:set var="orderlist" value="${Shop_DB.getAllOrdersByUserID(USER.userId)}" />
                <div class="col-lg-12">
                    <div class="row">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th>Order Date</th>
                                                <th>Name Receiver</th>
                                                <th>Phone</th>
                                                <th>Note</th>
                                                <th>Item</th>
                                                <th>Total</th>
                                                <th>Payment Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${orderlist}">
                                                <tr>
                                                    <td>${order.orderDate}</td>
                                                    <td>${USER.userFullName}</td>
                                                    <td>${order.receiverPhone}</td>
                                                    <td>${order.note}</td>
                                                    <c:set var="orderitemlistbyid" value="${Shop_DB.getAllOrderItemByOrderID(order.order_ID)}" />   
                                                    <td>
                                                        <c:forEach var="orderitem" items="${orderitemlistbyid}">
                                                            <c:set var="productitem" value="${Shop_DB.getProductByID(orderitem.productID)}" />
                                                            - ${productitem.name} : ${orderitem.quantity} <br> 
                                                        </c:forEach>
                                                    </td>
                                                    <td>${order.total}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${order.payment_status eq 'dathanhtoan'}">
                                                                <span class="badge bg-success">Đã Thanh Toán Trước</span>
                                                            </c:when>
                                                            <c:when test="${order.payment_status eq 'thanhtoankhinhanhang'}">
                                                                <span class="badge bg-warning text-dark">Chưa Thanh Toán Trước</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${order.status eq 'Pending'}">
                                                                <p class="text-warning">Đang chờ Shop xác nhận..</p>
                                                                <form class="my-1" action="product" method="post">
                                                                    <input type="hidden" name="orderid" value="${order.order_ID}" />
                                                                    <input type="hidden" name="action" value="huydon" />
                                                                    <button type="submit" class="btn btn-danger w-100 mt-2">Hủy Đơn Hàng</button>
                                                                </form>
                                                            </c:when>
                                                            <c:when test="${order.status eq 'Accept'}">
                                                                <p class="text-info">Đơn đã được xác nhận và sẽ sớm gửi đến bạn.</p>
                                                            </c:when>
                                                            <c:when test="${order.status eq 'Completed'}">
                                                                <form class="my-1" action="product" method="post">
                                                                    <input type="hidden" name="orderid" value="${order.order_ID}" />
                                                                    <input type="hidden" name="action" value="danhanhang" />
                                                                    <button type="submit" class="btn btn-primary w-100 mt-2">Vui lòng bấm đã nhận hàng.</button>
                                                                </form>
                                                            </c:when>
                                                            <c:when test="${order.status eq 'Cancelled'}">
                                                                <p class="text-danger">Đơn hàng bị người dùng hủy.</p>
                                                            </c:when>
                                                            <c:when test="${order.status eq 'Fail'}">
                                                                <p class="text-danger">Đơn hàng bị shop hủy.</p>
                                                            </c:when>
                                                            <c:when test="${order.status eq 'Success'}">
                                                                <p class="text-success">Success.</p>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </body>
                <%@ include file="../include/footer.jsp" %>
