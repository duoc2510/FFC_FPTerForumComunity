<%-- 
    Document   : myShop
    Created on : May 27, 2024, 9:19:01 PM
    Author     : Admin
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<%@ include file="../include/header.jsp" %>
<style>
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
        width: 80%; /* Điều chỉnh kích thước ảnh 'soldout.jpg' nếu cần */
        height: auto;
        opacity: 0.7; /* Điều chỉnh độ mờ của ảnh 'soldout.jpg' nếu cần */
        pointer-events: none; /* Để tránh ảnh hưởng đến việc click vào ảnh gốc */
    }
    .text-warning {
        color: #ffc107 !important;
    }

    .fas.fa-star {
        margin-right: 2px; /* Điều chỉnh khoảng cách giữa các ngôi sao nếu cần */
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

                <div class="w-100 row container">
                    <div class="col-md">
                        <div class="card mx-1">
                            <img class="card-img-top" src="${pageContext.request.contextPath}/static/${shop.image}" alt="Card image cap">
                            <div class="card-body">
                                <c:set var="orderlist" value="${Shop_DB.getOrdersByShopIdHasStatusNotNullandNotCancel(shop.shopID)}" />
                                <c:set var="starshop" value="0"/>
                                <c:forEach var="order" items="${orderlist}">
                                    <c:set var="starshop" value="${order.star + starshop}" />
                                </c:forEach>
                                <c:set var="starshop1" value="${Math.round(starshop/orderlist.size())}" />
                                <h5 class="card-title">${shop.name} 
                                    <c:forEach var="i" begin="1" end="${starshop1}">
                                        <i class="fas fa-star text-warning"></i>
                                    </c:forEach> 
                                </h5>

                                <p class="card-text">${shop.phone}</p>
                                <p class="card-text">${shop.campus}</p>
                                <p class="card-text">${shop.description}</p>
                            </div>
                        </div>
                    </div>



                </div>

                <!--All product of shop-->
                <div id="allProduct" class="w-100 row container">
                    <!--loop this-->
                    <c:forEach var="product" items="${productlist}">
                        <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(product.productId)}" />
                        <c:if test="${product.quantity != 0}">
                            <div class="col-md-4">
                                <div class="card mx-1">
                                    <a href="/FPTer/marketplace/allshop/shopdetail/productdetail?productid=${product.productId}&shopid=${shopid}" data-toggle="modal" data-target="#productID1">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="card-title"><a href="/FPTer/marketplace/allshop/shopdetail/productdetail?productid=${product.productId}&shopid=${shopid}">Name: ${product.name}</a></h5>
                                        <p class="card-text"><a href="/FPTer/marketplace/allshop/shopdetail/productdetail?productid=${product.productId}&shopid=${shopid}">Price: ${product.price}</a></p>
                                        <p class="card-text"><a href="/FPTer/marketplace/allshop/shopdetail/productdetail?productid=${product.productId}&shopid=${shopid}">Giới Thiệu: ${product.productDescription}</a></p>
                                        <a href="/FPTer/marketplace/allshop/shopdetail/productdetail?productid=${product.productId}&shopid=${shopid}" class="btn btn-primary mt-3 w-100">Buy now</a>
                                    </div>
                                </div>
                            </div>
                        </c:if> 
                        <c:if test="${product.quantity == 0}">
                            <div class="col-md-4">
                                <div class="card mx-1">
                                    <div class="position-relative image-container">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}">
                                        <img class="sold-out-overlay" src="${pageContext.request.contextPath}/static/images/soldout.jpg">
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><a>Name: ${product.name}</a></h5>
                                        <p class="card-text"><a>Price: ${product.price}</a></p>
                                        <p class="card-text"><a>Giới Thiệu: ${product.productDescription}</a></p>
                                        <a class="btn btn-danger mt-3 w-100">Sold out</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>



                    </c:forEach>





                </div>

                <!--RATING-->
                <div id="rating" class="w-100 row container">
                    <div class="col-md">
                        <div class="card mx-1">
                            <div class="card-body" style="overflow-x: auto">
                                <p class="mb-4"><span class="text-primary font-italic me-1">Shop's rating</span></p>




                                <!-- Loop this -->
                                <c:forEach var="order" items="${orderlist}">
                                    <c:set var="userorder" value="${User_DB.getUserById(order.userID)}" />
                                    <div class="d-flex justify-content-between align-items-center py-3">
                                        <div class="d-flex align-items-start">
                                            <div class="text-center">
                                                <img src="${pageContext.request.contextPath}/${userorder.userAvatar}" alt="" width="30" class="rounded-circle avatar-cover">
                                            </div>
                                            <div class="ms-2">
                                                <h6 class="card-title fw-semibold mb-0">${userorder.userFullName}</h6>
                                                <p class="s-4">${order.orderDate}</p>
                                                <p class="s-4">
                                                    <c:forEach var="i" begin="1" end="${order.star}">
                                                        <i class="fas fa-star text-warning"></i>
                                                    </c:forEach>
                                                </p>
                                                <p class="s-4">Đã mua:</p>
                                                <c:set var="orderitemlistbyid" value="${Shop_DB.getAllOrderItemByOrderID(order.order_ID)}" />
                                                <c:forEach var="orderitem" items="${orderitemlistbyid}">
                                                    <c:set var="productitem" value="${Shop_DB.getProductByID(orderitem.productID)}" />
                                                    <p class="s-4">+ ${productitem.name} : ${orderitem.quantity}</p>
                                                </c:forEach>
                                                <p class="s-4">Feed Back: ${order.feedback}</p>
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


</body>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%@ include file="../include/footer.jsp" %>
