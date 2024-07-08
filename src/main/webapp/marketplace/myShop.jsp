<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ page import="java.util.*, java.sql.*" %>
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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
    .thumbnail img{
        height:100%;
        object-fit: cover;
        padding: 5px;
        opacity: .7;
    }
    .thumbnail img:hover{
         opacity: 1;
    }
    .table thead th{
        font-size: 14px;
    }
    .table-bordered td{
        font-size: 14px;
    }

</style>
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
                <!--Control panel-->
                <%@ include file="panel.jsp" %>

                <div class="col-lg-12">
                    <div class="w-100 row card-group">
                        <div class="col-md">
                            <div class="card mx-1 rounded">
                                <img style="height: 100%;" class="card-img-top" src="${pageContext.request.contextPath}/static/${SHOP.image}" alt="Card image cap">
                                <div class="card-body">
                                    <h5 style="font-size: 30px;" class="card-title">
                                        <i class="fas fa-store-alt"></i> ${SHOP.name}
                                    </h5>
                                    <div class="d-flex justify-content-between">
                                        <p style="font-size: 18px;" class="card-text">
                                            <i class="fas fa-phone"></i> ${SHOP.phone}
                                        </p>
                                        <p style="font-size: 18px;" class="card-text">
                                            <i class="fas fa-map-marker-alt"></i> ${SHOP.campus}
                                        </p>
                                        <p style="font-size: 18px;" class="card-text">
                                            <i class="fas fa-info-circle"></i> Giới thiệu: ${SHOP.description}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="w-100 row ">
                        <div class="col-md card-group">
                            <div class="card mx-1 rounded">
                                <ul class="list-group list-group-flush rounded-3">
                                    <li class="list-group-item d-flex align-items-center p-3">
                                        <i class="fas fa-globe fa-lg text-warning"></i>
                                        <a href="#" class="ms-3 mb-0" data-toggle="modal" data-target="#editBrand">Edit brand information</a>
                                    </li>
                                    <li class="list-group-item d-flex align-items-center p-3">
                                        <i class="fas fa-globe fa-lg text-warning"></i>
                                        <a href="#" class="ms-3 mb-0" data-toggle="modal" data-target="#deleteShop">Delete shop</a>
                                    </li>
                                    <li class="list-group-item d-flex align-items-center p-3">
                                        <i class="fas fa-globe fa-lg text-warning"></i>
                                        <a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${SHOP.shopID}" class="ms-3 mb-0" >Go to sales page</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-md card-group">
                            <div class="card mx-1 rounded">
                                <ul class="list-group list-group-flush rounded-3">
                                    <li class="list-group-item d-flex p-3">
                                        <div class="col-sm-3">
                                            <p class="mb-0"><i class="fas fa-user"></i> Full Name</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0">${USER.userFullName}</p>
                                        </div>
                                    </li>
                                    <li class="list-group-item d-flex p-3">
                                        <div class="col-sm-3">
                                            <p class="mb-0"><i class="fas fa-envelope"></i> Email</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0">${USER.userEmail}</p>
                                        </div>
                                    </li>
                                    <li class="list-group-item d-flex p-3">
                                        <div class="col-sm-3">
                                            <p class="mb-0"><i class="fas fa-wallet"></i> Wallet</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0">${USER.userWallet} VNĐ</p>
                                        </div>
                                    </li>
                                    <c:set var="count" value="${Shop_DB.countSuccessAndCompletedOrdersByShopID(SHOP.shopID)}" />
                                    <li class="list-group-item d-flex p-3">
                                        <div class="col-sm-3">
                                            <p class="mb-0"><i class="fas fa-check-circle"></i> Success orders</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0">${count}</p>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>



                    <div class="w-100 row rounded border  my-5">
                        <div class="col-md">
                            <div class="rounded">
                                <nav>
                                    <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                        <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">
                                            <i class="fas fa-tags"></i> All Discount
                                        </button>
                                        <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">
                                            <i class="fas fa-box-open"></i> All Product
                                        </button>
                                        <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">
                                            <i class="fas fa-shopping-cart"></i> All Order
                                        </button>
                                    </div>
                                </nav>




                                <div class="tab-content" id="nav-tabContent">
                                    <!--tab content 1-->
                                    <div class="tab-pane fade card-body show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0" style="overflow-x: auto">
                                        <table class="table table-responsive table-bordered">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Code</th>
                                                    <th>Valid from</th>
                                                    <th>Valid to</th>
                                                    <th>Usage Limit</th>
                                                    <th>Usage Count</th>
                                                    <th>Show</th>
                                                    <th>Edit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:choose>
                                                    <c:when test="${empty discounts}">
                                                        <tr>
                                                            <td colspan="7">Không có discount nào.</td>
                                                        </tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="discount" items="${discounts}">
                                                            <tr>
                                                                <td>${discount.code}</td>
                                                                <td>${discount.validFrom}</td>
                                                                <td>${discount.validTo}</td>
                                                                <td>${discount.usageLimit}</td>
                                                                <td>${discount.usageCount}</td>
                                                                <td>
                                                                    <input type="hidden" name="code" value="${discount.code}">
                                                                    <button type="button" class="btn rounded w-100 btn-primary" data-toggle="modal" data-target="#showdiscount${discount.discountId}">Show</button>
                                                                </td>
                                                                <td>
                                                                    <input type="hidden" name="name" value="${discount.code}">
                                                                    <button type="button" class="btn rounded w-100 btn-secondary" data-toggle="modal" data-target="#editDiscount${discount.discountId}">Edit</button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                        <div class="d-flex justify-content-end mb-2">
                                            <button type="button" class="btn rounded btn-primary" data-toggle="modal" data-target="#addDiscount">Add new discount</button>
                                        </div>
                                    </div>



                                    <!--tab content 2-->
                                    <div class="tab-pane card-body fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
                                        <table class="table table-responsive table-bordered">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Name Product</th>
                                                    <th>Price</th>
                                                    <th>Quantity</th>
                                                    <th>Show</th>
                                                    <th>Edit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="product" items="${products}">
                                                    <tr>
                                                        <td>${product.name}</td>
                                                        <td>${product.price} VNĐ</td>
                                                        <td>${product.quantity}</td>
                                                        <td>
                                                            <input type="hidden" name="name" value="${product.name}">
                                                            <button type="button" class="btn rounded w-100 btn-primary" data-toggle="modal" data-target="#show${product.productId}">Show</button>
                                                        </td>
                                                        <td>
                                                            <input type="hidden" name="name" value="${product.name}">
                                                            <button type="button" class="btn rounded w-100 btn-secondary" data-toggle="modal" data-target="#editProduct${product.productId}">Edit</button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="d-flex justify-content-end mb-2">
                                            <button type="button" class="btn rounded btn-primary" data-toggle="modal" data-target="#addProduct">Add new product</button>
                                        </div>
                                    </div>



                                    <!--tab content 3-->
                                    <div class="tab-pane card-body fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab" tabindex="0">
                                        <table class="table table-responsive table-bordered w-100">
                                            <thead class="table-light">
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
                                            <c:set var="orderlist" value="${Shop_DB.getOrdersByShopId(SHOP.shopID)}" />
                                            <tbody>
                                                <c:forEach var="order" items="${orderlist}">
                                                    <c:set var="userorder" value="${User_DB.getUserById(order.userID)}" />
                                                    <tr>
                                                        <td>${order.orderDate}</td>
                                                        <td>${userorder.userFullName}</td>
                                                        <td>${order.receiverPhone}</td>
                                                        <td>${order.note}</td>
                                                        <c:set var="orderitemlistbyid" value="${Shop_DB.getAllOrderItemByOrderID(order.order_ID)}" />
                                                        <td>
                                                            <c:forEach var="orderitem" items="${orderitemlistbyid}">
                                                                <c:set var="productitem" value="${Shop_DB.getProductByID(orderitem.productID)}" />
                                                                - ${productitem.name} : ${orderitem.quantity} <br> 
                                                            </c:forEach>
                                                        </td>
                                                        <td>${order.total} VNĐ</td>
                                                        <c:if test="${order.payment_status eq 'dathanhtoan'}">
                                                            <td>
                                                                <p class="text-success">Đã Thanh Toán Trước</p>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${order.payment_status eq 'thanhtoankhinhanhang'}">
                                                            <td>
                                                                <p class="text-success">Chưa Thanh Toán Trước</p>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${order.total * 5 / 100 >= USER.userWallet}">
                                                            <c:if test="${order.status eq 'Pending'}">
                                                                <td>
                                                                    <p class="text-danger">Ví bạn không đủ tiền để thanh toán thuế!</p>
                                                                    <form action="product" method="post">
                                                                        <input type="hidden" name="orderid" value="${order.order_ID}" />
                                                                        <input type="hidden" name="action" value="thatbai" />
                                                                        <button type="submit" class="btn rounded w-100 btn-danger my-1">Không Nhận Đơn Hàng</button>
                                                                    </form>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${order.status eq 'Accept'}">
                                                                <td>
                                                                    <form action="product" method="post">
                                                                        <input type="hidden" name="orderid" value="${order.order_ID}" />
                                                                        <input type="hidden" name="action" value="thanhcong" />
                                                                        <button type="submit" class="btn rounded w-100 btn-primary my-1">Giao hàng thành công</button>
                                                                    </form>
                                                                    <form action="product" method="post">
                                                                        <input type="hidden" name="orderid" value="${order.order_ID}" />
                                                                        <input type="hidden" name="action" value="thatbai" />
                                                                        <button type="submit" class="btn rounded w-100 btn-danger my-1">Giao hàng thất bại</button>
                                                                    </form>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${order.status eq 'Completed'}">
                                                                <td>
                                                                    <p class="text-success">Đã giao hàng</p>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${order.status eq 'Cancelled'}">
                                                                <td>
                                                                    <p class="text-danger">Đơn hàng bị người dùng hủy.</p>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${order.status eq 'Fail'}">
                                                                <td>
                                                                    <p class="text-danger">Đơn hàng bị shop hủy.</p>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${order.status eq 'Success'}">
                                                                <td>
                                                                    <p class="text-success">Success</p>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                        <c:if test="${order.total * 5 / 100 < USER.userWallet}">
                                                            <c:if test="${order.status eq 'Pending'}">
                                                                <td>
                                                                    <form action="product" method="post">
                                                                        <input type="hidden" name="orderid" value="${order.order_ID}" />
                                                                        <input type="hidden" name="action" value="chapnhan" />
                                                                        <button type="submit" class="btn rounded w-100 btn-primary my-1">Chấp Nhận Đơn Hàng</button>
                                                                    </form>
                                                                    <form action="product" method="post">
                                                                        <input type="hidden" name="orderid" value="${order.order_ID}" />
                                                                        <input type="hidden" name="action" value="thatbai" />
                                                                        <button type="submit" class="btn rounded w-100 btn-danger my-1">Không Nhận Đơn Hàng</button>
                                                                    </form>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${order.status eq 'Accept'}">
                                                                <td>
                                                                    <form action="product" method="post">
                                                                        <input type="hidden" name="orderid" value="${order.order_ID}" />
                                                                        <input type="hidden" name="action" value="thanhcong" />
                                                                        <button type="submit" class="btn rounded w-100 btn-primary my-1">Giao hàng thành công</button>
                                                                    </form>
                                                                    <form action="product" method="post">
                                                                        <input type="hidden" name="orderid" value="${order.order_ID}" />
                                                                        <input type="hidden" name="action" value="thatbai" />
                                                                        <button type="submit" class="btn rounded w-100 btn-danger my-1">Giao hàng thất bại</button>
                                                                    </form>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${order.status eq 'Completed'}">
                                                                <td>
                                                                    <p class="text-success">Đã giao hàng</p>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${order.status eq 'Cancelled'}">
                                                                <td>
                                                                    <p class="text-danger">Đơn hàng bị người dùng hủy.</p>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${order.status eq 'Fail'}">
                                                                <td>
                                                                    <p class="text-danger">Đơn hàng bị shop hủy.</p>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${order.status eq 'Success'}">
                                                                <td>
                                                                    <p class="text-success">Success</p>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="rounded shadow w-100 row p-4">
                        <h2 style="font-size: 25px;"><i class="fas fa-chart-bar"></i> Order Chart by Month</h2>


                        <%
                            String[] statuses = {"Pending", "Accept", "Completed", "Cancelled", "Success", "Fail"};
                            int year = 2024; // Set the year you want to query

                            // Create a map to hold the order counts for each status
                            Map<String, int[]> orderData = new HashMap<>();
        
                            for (String status : statuses) {
                                int[] monthlyCounts = new int[12];
                                for (int month = 1; month <= 12; month++) {
                                    monthlyCounts[month - 1] = Shop_DB.countOrdersByStatusAndMonth(status, month, year);
                                }
                                orderData.put(status, monthlyCounts);
                            }
                        %>

                        <canvas id="orderChart" width="800" height="400"></canvas>
                        <script>
                            var ctx = document.getElementById('orderChart').getContext('2d');
                            var orderChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                                    datasets: [
                                        {
                                            label: 'Pending',
                                            data: <%= Arrays.toString(orderData.get("Pending")) %>,
                                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                                            borderColor: 'rgba(255, 99, 132, 1)',
                                            borderWidth: 1
                                        },
                                        {
                                            label: 'Accept',
                                            data: <%= Arrays.toString(orderData.get("Accept")) %>,
                                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                            borderColor: 'rgba(54, 162, 235, 1)',
                                            borderWidth: 1
                                        },
                                        {
                                            label: 'Completed',
                                            data: <%= Arrays.toString(orderData.get("Completed")) %>,
                                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                            borderColor: 'rgba(75, 192, 192, 1)',
                                            borderWidth: 1
                                        },
                                        {
                                            label: 'Cancelled',
                                            data: <%= Arrays.toString(orderData.get("Cancelled")) %>,
                                            backgroundColor: 'rgba(153, 102, 255, 0.2)',
                                            borderColor: 'rgba(153, 102, 255, 1)',
                                            borderWidth: 1
                                        },
                                        {
                                            label: 'Success',
                                            data: <%= Arrays.toString(orderData.get("Success")) %>,
                                            backgroundColor: 'rgba(255, 159, 64, 0.2)',
                                            borderColor: 'rgba(255, 159, 64, 1)',
                                            borderWidth: 1
                                        },
                                        {
                                            label: 'Fail',
                                            data: <%= Arrays.toString(orderData.get("Fail")) %>,
                                            backgroundColor: 'rgba(255, 206, 86, 0.2)',
                                            borderColor: 'rgba(255, 206, 86, 1)',
                                            borderWidth: 1
                                        }
                                    ]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true,
                                            max: 100,
                                            ticks: {
                                                stepSize: 10
                                            }
                                        }
                                    }
                                }
                            });
                        </script>
                    </div>
                </div>


            </div>
        </div>
    </div>

    <!--UPLOAD PRODUCT-->
    <div class="modal fade" id="addProduct" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Add New Product</h5>
                    <button class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <form action="product" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="productNameInput">Product Name:</label>
                            <input type="text" class="form-control mb-2 rounded" id="productNameInput" name="productName" required>
                        </div>
                        <div class="form-group">
                            <label for="productPriceInput">Product Price:</label>
                            <input type="number" class="form-control mb-2 rounded" id="productPriceInput" name="productPrice" required>
                        </div>
                        <div class="form-group">
                            <label for="productQuantityInput">Product Quantity:</label>
                            <input type="number" class="form-control mb-2 rounded" id="productQuantityInput" name="productQuantity" min="0" required>
                        </div>
                        <div class="form-group">
                            <label for="productDescriptionInput">Product Description:</label>
                            <textarea class="form-control mb-2 rounded" id="productDescriptionInput" name="productDescription" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="fileInput">Choose Image File:</label>
                            <input multiple type="file" class="form-control mb-2 rounded-file" id="fileInput" name="file" accept="image/*" required>
                        </div>
                        <!-- Trường input ẩn -->
                        <input type="hidden" name="action" value="add">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn rounded w-100 btn-primary">Add New</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!--loop modal to show-->
    <c:forEach var="product" items="${products}">
        <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(product.productId)}" />
        <div class="modal fade" id="show${product.productId}" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Show Product</h5>
                        <button class="btn-close close" data-dismiss="modal" aria-label="Close">

                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <img id="main-image-${product.productId}" class="rounded-top mb-4" style="max-height: 250px; width:100%"
                                 src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}"/>
                            <c:set var="imagelist" value="${Shop_DB.getAllUploadByProductID(product.productId)}" />
                            <div class="row thumbnail text-center">

                                <div class="mb-3 row ps-4">
                                    <img class="col-3 images-list-item rounded" onclick="change_image(this, ${product.productId})" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}">
                                    <c:if test="${not empty imagelist}">
                                        <c:forEach var="image" items="${imagelist}" begin="1">
                                            <img class="col-3 product-images-detail rounded" onclick="change_image(this, ${product.productId})" src="${pageContext.request.contextPath}/static/${image.uploadPath}">
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productNameInput">Product Name:</label>
                            <input type="text" class="form-control mb-2 rounded" id="productNameInput" value="${product.name}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="productPriceInput">Product Price:</label>
                            <input type="text" class="form-control mb-2 rounded" value="${product.price} VND" readonly>
                        </div>
                        <div class="form-group">
                            <label for="productQuantityInput">Product Quantity:</label>
                            <input type="number" class="form-control mb-2 rounded" value="${product.quantity}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="productDescriptionInput">Product Description:</label>
                            <textarea class="form-control mb-2 rounded" id="productDescriptionInput" readonly>${product.productDescription}</textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>


    <!--loop modal to edit-->
    <c:forEach var="product" items="${products}">
        <div class="modal fade" id="editProduct${product.productId}" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Edit Product #${product.productId}</h5>
                        <button class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <form action="product" method="post" enctype="multipart/form-data">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="productNameInput" hidden>ID:</label>
                                <input type="hidden" class="form-control mb-2 rounded" id="productNameInput" name="id" value="${product.productId}" required>
                            </div>
                            <div class="form-group">
                                <label for="productNameInput">Product Name:</label>
                                <input type="text" class="form-control mb-2 rounded" id="productNameInput" name="productName" value="${product.name}" required>
                            </div>
                            <div class="form-group">
                                <label for="productPriceInput">Product Price:</label>
                                <input type="number" class="form-control mb-2 rounded" id="productPriceInput" name="productPrice" value="${product.price}" required>
                            </div>
                            <div class="form-group">
                                <label for="productQuantityInput">Product Quantity:</label>
                                <input type="number" class="form-control mb-2 rounded" id="productQuantityInput" name="productQuantity" min="0" value="${product.quantity}" required>
                            </div>
                            <div class="form-group">
                                <label for="productDescriptionInput">Product Description:</label>
                                <textarea class="form-control mb-2 rounded" id="productDescriptionInput" name="productDescription" required>${product.productDescription}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="fileInput">Choose Image File:</label>
                                <input multiple type="file" class="form-control mb-2 rounded-file" id="fileInput" name="file" accept="image/*">
                            </div>
                            <!-- Trường input ẩn -->
                            <input type="hidden" name="action" value="edit">
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn rounded w-100 btn-primary">Edit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>

    <!--DELETE SHOP-->
    <div class="modal fade" id="deleteShop" tabindex="-1" role="dialog"     aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form action="product"  method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">Delete Shop</h5>
                        <button class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">                   
                        <input type="text" name="action" value="deleteshop" hiden style="display: none">
                        <input type="text" name="id" value="${SHOP.shopID}" hiden style="display: none">

                        <div class="form-row">
                            <p>Do you want to Delete shop?</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn rounded w-100 btn-secondary" type="submit">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!--BRAND: loop modal to edit -->
    <!--NOT LOOP because brand point to user.id--> 
    <div class="modal fade" id="editBrand" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Edit Brand</h5>
                    <button class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <form action="product" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="productNameInput" hidden>ID:</label>
                            <input type="hidden" class="form-control mb-2 rounded" id="shopID" name="id" value="${SHOP.shopID}" required>
                        </div>
                        <div class="form-group">
                            <label for="productNameInput">Brand Name:</label>
                            <input type="text" class="form-control mb-2 rounded" id="shopName" name="shopName" value="${SHOP.name}" required>
                        </div>
                        <div class="form-group">
                            <label for="productPriceInput">Brand Phone:</label>
                            <input type="number" class="form-control mb-2 rounded" id="shopPhone" name="shopPhone" value="${SHOP.phone}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="productPriceInput">Campus</label>
                            <input type="text" class="form-control mb-2 rounded" id="shopPhone" name="shopCampus" value="${SHOP.campus}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="productDescriptionInput">Shop Description:</label>
                            <textarea class="form-control mb-2 rounded" id="shopDescriptionInput" name="shopDescription" required>${SHOP.description}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="fileInput">Choose Cover Image File:</label>
                            <input type="file" class="form-control mb-2 rounded-file" id="fileInput" name="file" accept="image/*">
                        </div>

                        <!-- Trường input ẩn -->
                        <input type="hidden" name="action" value="editbrand">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn rounded w-100 btn-primary">Edit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!--UPLOAD DISCOUNT-->
    <div class="modal fade" id="addDiscount" tabindex="-1" role="dialog" aria-labelledby="addDiscountLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addDiscountLabel">Add New Discount</h5>
                    <button class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <form action="product" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="discountCodeInput">Discount Code:</label>
                            <input type="text" class="form-control mb-2 rounded" id="discountCodeInput" name="discountCode" required>
                        </div>
                        <div class="form-group">
                            <label for="discountShopInput" hidden>Shop ID:</label>
                            <input type="number" class="form-control mb-2 rounded" id="discountShopInput" name="shopId" value="${SHOP.shopID}" hidden>
                        </div>
                        <div class="form-group">
                            <label for="discountPercentInput">Discount Percent:</label>
                            <input type="number" class="form-control mb-2 rounded" id="discountPercentInput" name="discountPercent" required>
                        </div>
                        <div class="form-group">
                            <label for="discountConditionInput">Discount Condition (Giá trị đơn hàng tối thiểu):</label>
                            <input type="number" class="form-control mb-2 rounded" id="discountConditionInput" name="discountConditionInput" required>
                        </div>
                        <div class="form-group">
                            <label for="validFromInput">Valid From:</label>
                            <input type="date" class="form-control mb-2 rounded" id="validFromInput" name="validFrom" required>
                        </div>
                        <div class="form-group">
                            <label for="validToInput">Valid To:</label>
                            <input type="date" class="form-control mb-2 rounded" id="validToInput" name="validTo" required>
                        </div>
                        <div class="form-group">
                            <label for="usageLimitInput">Usage Limit:</label>
                            <input type="number" class="form-control mb-2 rounded" id="usageLimitInput" name="usageLimit" required>
                        </div>
                        <!-- Hidden input to specify the action -->
                        <input type="hidden" name="action" value="adddiscount">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn rounded btn-primary">Add New</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Loop modal to showDiscount -->
    <c:forEach var="discount" items="${discounts}">
        <div class="modal fade" id="showdiscount${discount.discountId}" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Show Discount</h5>
                        <button class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="DiscountCodeInput${discount.discountId}">Discount Code:</label>
                            <input type="text" class="form-control mb-2 rounded" id="DiscountCodeInput${discount.discountId}" value="${discount.code}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="ConditionInput${discount.discountId}">Discount Condition Price:</label>
                            <input type="number" class="form-control mb-2 rounded" id="ConditionInput${discount.discountId}" value="${discount.condition}"VND readonly>
                        </div>
                        <div class="form-group">
                            <label for="DiscountPercentInput${discount.discountId}">Discount Percent:</label>
                            <input type="number" class="form-control mb-2 rounded" id="DiscountPercentInput${discount.discountId}" value="${discount.discountPercent}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="ValidFromInput${discount.discountId}">Valid From:</label>
                            <input type="date" class="form-control mb-2 rounded" id="ValidFromInput${discount.discountId}" value="${discount.validFrom}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="ValidToInput${discount.discountId}">Valid To:</label>
                            <input type="date" class="form-control mb-2 rounded" id="ValidToInput${discount.discountId}" value="${discount.validTo}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="UsageLimitInput${discount.discountId}">Usage Limit:</label>
                            <input type="number" class="form-control mb-2 rounded" id="UsageLimitInput${discount.discountId}" value="${discount.usageLimit}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="UsageCountInput${discount.discountId}">Usage Count:</label>
                            <input type="number" class="form-control mb-2 rounded" id="UsageCountInput${discount.discountId}" value="${discount.usageCount}" readonly>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!--loop modal to edit Discount-->
    <c:forEach var="discount" items="${discounts}">
        <div class="modal fade" id="editDiscount${discount.discountId}" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Edit Discount #${discount.discountId}</h5>
                        <button class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <form action="product" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="discountCodeInput">Discount Code:</label>
                                <input type="text" class="form-control mb-2 rounded" id="discountCodeInput" name="discountCode" value="${discount.code}" required>
                            </div>
                            <div class="form-group">
                                <label for="discountShopInput" hidden>Shop ID:</label>
                                <input type="number" class="form-control mb-2 rounded" id="discountShopInput" name="shopId" value="${SHOP.shopID}" hidden>
                            </div>
                            <div class="form-group">
                                <label for="discountShopInput" hidden>Discount ID:</label>
                                <input type="number" class="form-control mb-2 rounded" id="discountIDInput" name="discountId" value="${discount.discountId}" hidden>
                            </div>
                            <div class="form-group">
                                <label for="discountPercentInput">Discount Percent:</label>
                                <input type="number" class="form-control mb-2 rounded" id="discountPercentInput" name="discountPercent" value="${discount.discountPercent}" required>
                            </div>
                            <div class="form-group">
                                <label for="discountConditionInput">Discount Condition (Giá trị đơn hàng tối thiểu):</label>
                                <input type="number" class="form-control mb-2 rounded" id="discountConditionInput" name="discountConditionInput" value="${discount.condition}" required>
                            </div>
                            <div class="form-group">
                                <label for="validFromInput">Valid From:</label>
                                <input type="date" class="form-control mb-2 rounded" id="validFromInput" name="validFrom" value="${discount.validFrom}" required>
                            </div>
                            <div class="form-group">
                                <label for="validToInput">Valid To:</label>
                                <input type="date" class="form-control mb-2 rounded" id="validToInput" name="validTo" value="${discount.validTo}" required>
                            </div>
                            <div class="form-group">
                                <label for="usageLimitInput">Usage Limit:</label>
                                <input type="number" class="form-control mb-2 rounded" id="usageLimitInput" name="usageLimit" value="${discount.usageLimit}" required>
                            </div>
                            <!-- Hidden input to specify the action -->
                            <input type="hidden" name="action" value="editdiscount">
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn rounded  btn-primary">Edit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>

    <script>

        function change_image(n, o) {
            console.log(n.src);
            var e = document.getElementById("main-image-" + o);
            e ? e.src = n.src : console.error("Main image container not found for product ID: " + o)
        }</script>
</body>

<%@ include file="../include/footer.jsp" %>