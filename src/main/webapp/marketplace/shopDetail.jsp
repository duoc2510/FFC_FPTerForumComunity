<%-- 
    Document   : myShop
    Created on : May 27, 2024, 9:19:01 PM
    Author     : Admin
--%>
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
<style>
    #allProduct .card .card-img-top{
        object-fit: cover;
        aspect-ratio: 1 / 1;
        height: 300px !important;
    }
    .card .card-img-top {
        height: 300px ;
        object-fit: cover;
    }
    .card-text{
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 1; /* number of lines to show */
        line-clamp: 1;
        -webkit-box-orient: vertical;
    }
    .thumbnail img{
        width: 200px;
        height: 100px;
        object-fit: cover;
    }
    p{
        margin-bottom: 0;
    }
    .position-relative {
        position: relative;
    }

    .image-container {
        position: relative;
        display: block;
    }

    .card-img-top {
        display: block;
        width: 100%;
        height: auto;
    }

    .sold-out-overlay {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 80%;
        height: auto;
        opacity: 0.7;
        pointer-events: none;
    }
    .text-warning {
        color: #ffc107 !important;
    }

    .fas.fa-star {
        margin-right: 2px;
    }

    .card-title1 {
        display: inline-block; /* Ensures the title doesn't take full width */
        margin-bottom: 0.5rem; /* Adjust margin as needed */
        font-size: 30px; /* Adjust font size as needed */
        font-weight: bold;
    }

    .card-title1 .fas.fa-star {
        font-size: 1rem; /* Adjust star icon size as needed */
        margin-right: 2px;
    }
    .thongtin{
        margin-left: 5px;
        margin-bottom: 5px;
    }

    .py-3 {
        padding-top: 0.75rem !important; /* Giảm khoảng cách trên */
        padding-bottom: 0.75rem !important; /* Giảm khoảng cách dưới */
    }

    .card-title {
        display: inline-block;
        margin-bottom: 0.25rem; /* Giảm margin dưới */
        font-size: 1rem; /* Đổi kích thước font */
    }

    .s-4 {
        margin-bottom: 0.25rem; /* Giảm khoảng cách dưới */
    }

    .s-4 .fas.fa-star {
        font-size: 0.75rem; /* Đổi kích thước sao */
        margin-right: 2px;
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

                <div class="row">
                    <div class="col-md">
                        <div class="card mx-2 rounded">
                            <img style="height: 100%;" class="card-img-top rounded-top" src="${pageContext.request.contextPath}/static/${shop.image}" alt="Card image cap">
                            <div class="card-body">
                                <c:set var="orderlist" value="${Shop_DB.getOrdersByShopIdWithStatusSuccess(shop.shopID)}" />
                                <c:set var="starshop" value="0"/>
                                <c:forEach var="order" items="${orderlist}">
                                    <c:set var="starshop" value="${order.star + starshop}" />
                                </c:forEach>
                                <c:set var="starshop1" value="${Math.round(starshop/orderlist.size())}" />
                                <h5 class="card-title1">${shop.name} 
                                    <c:forEach var="i" begin="1" end="${starshop1}">
                                        <i class="fas fa-star text-warning"></i>
                                    </c:forEach> 
                                </h5>
                                <c:set var="countorder" value="${Shop_DB.countSuccessAndCompletedOrdersByShopID(shop.shopID)}" />
                                <div class="row thongtin">
                                    <div class="col-md-6">
                                        <p style="font-size: 15px;  line-height: 2.0;" class="card-text"><i class="fas fa-check-circle"></i> Đã hoàn thành: ${countorder} Đơn</p>
                                        <p style="font-size: 15px;  line-height: 2.0;" class="card-text"><i class="fas fa-phone"></i> ${shop.phone}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p style="font-size: 15px;  line-height: 2.0;" class="card-text"><i class="fas fa-map-marker-alt"></i> ${shop.campus}</p>
                                        <p style="font-size: 15px;  line-height: 2.0;" class="card-text"><i class="fas fa-info-circle"></i> Giới thiệu: ${shop.description}</p>
                                    </div>
                                </div>

                                <c:if test="${shop.ownerID != USER.userId}">
                                    <a href="${pageContext.request.contextPath}/marketplace/confirmcontinue?shopid=${shopid}" class="btn btn-primary">Tiếp tục mua</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <!--All product of shop-->
                <div id="allProduct" class="row mb-4">
                    <c:forEach var="product" items="${productlist}">
                        <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(product.productId)}" />
                        <c:if test="${product.quantity != 0}">
                            <div style="width: 30%; " class="col-md-4 card-group">
                                <div class=" mx-2 rounded shadow card-group">
                                    <a href="/FPTer/marketplace/allshop/shopdetail/productdetail?productid=${product.productId}&shopid=${shopid}">
                                        <img class="card-img-top rounded-top" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="card-title">${product.name}</h5>
                                        <p class="card-text"><i class="fas fa-tag"></i> Price: ${product.price} VNĐ</p>
                                        <p class="card-text"><i class="fas fa-info-circle"></i> ${product.productDescription}</p>
                                        <a href="/FPTer/marketplace/allshop/shopdetail/productdetail?productid=${product.productId}&shopid=${shopid}" class="btn btn-primary mt-3 w-100 rounded">Buy now</a>
                                    </div>
                                </div>
                            </div>
                        </c:if> 
                        <c:if test="${product.quantity == 0}">
                            <div style="width: 30%; " class="col-md-4 card-group">
                                <div class="card mx-1">
                                    <div class="position-relative image-container">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}">
                                        <img class="sold-out-overlay" src="${pageContext.request.contextPath}/static/images/soldout.jpg">
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title">${product.name}</h5>
                                        <p class="card-text"><i class="fas fa-tag"></i> ${product.price} VNĐ</p>
                                        <p class="card-text"><i class="fas fa-info-circle"></i> ${product.productDescription}</p>
                                        <button class="btn btn-danger mt-3 w-100" disabled>Sold out</button>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

                <!--RATING-->
                <div id="rating" class="row">
                    <div class="col-md">
                        <div class=" mx-1 rounded shadow">
                            <div class="card-body" style="overflow-x: auto">
                                <p class="mb-4"><span class="text-primary font-italic me-1">Shop's rating</span></p>
                                <c:forEach var="order" items="${orderlist}">
                                    <c:set var="userorder" value="${User_DB.getUserById(order.userID)}" />
                                    <div class="d-flex justify-content-between align-items-center py-3">
                                        <div class="d-flex align-items-start">
                                            <div class="text-center">
                                                <img src="${pageContext.request.contextPath}/${userorder.userAvatar}" alt="" width="30" class="rounded-circle avatar-cover">
                                            </div>
                                            <div class="ms-2">
                                                <div class="w-100 d-flex">
                                                    <h6 class="card-title fw-semibold mb-0 d-inline">${userorder.userFullName}</h6>
                                                    <p class="s-4  d-inline mx-3 mb-1">
                                                        <c:forEach var="i" begin="1" end="${order.star}">
                                                            <i class="fas fa-star text-warning"></i>
                                                        </c:forEach>
                                                    </p>
                                                </div>
                                                <p class="s-4"><i class="fas fa-calendar-alt"></i> ${order.orderDate}</p>
                                                <c:set var="orderitemlistbyid" value="${Shop_DB.getAllOrderItemByOrderID(order.order_ID)}" />
                                                <c:forEach var="orderitem" items="${orderitemlistbyid}">
                                                    <c:set var="productitem" value="${Shop_DB.getProductByID(orderitem.productID)}" />
                                                    <p class="s-4"><i class="fas fa-box"></i> ${productitem.name} : ${orderitem.quantity}</p>
                                                </c:forEach>
                                                <p class="s-4"><i class="fas fa-comment"></i> Feed Back: ${order.feedback}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <hr class="px-4">
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%@ include file="../include/footer.jsp" %>
</body>
