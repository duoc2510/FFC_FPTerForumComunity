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
    <style>
        .custom-list li {
            line-height: 2.0; /* Adjust this value as needed */
        }
    </style>
</head>

<body class="marketplace">
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

                <div class="row my-4 rounded shadow">
                    <div class="col-md-12 p-2">
                        <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel" data-bs-interval="2000">
                            <div class="carousel-inner">
                                <div class="carousel-item rounded active">
                                    <div class="cel-overplay"></div>
                                    <img src="${pageContext.request.contextPath}/static/images/bannerdangkishop.png" class="rounded d-block w-100" alt="Banner 2">
                                </div>
                                <div class="carousel-item rounded">
                                    <div class="cel-overplay"></div>
                                    <img src="${pageContext.request.contextPath}/static/images/bannermonan.png" class="rounded d-block w-100" alt="Banner 3">
                                </div>
                                <div class="carousel-item rounded">
                                    <div class="cel-overplay"></div>
                                    <img src="${pageContext.request.contextPath}/static/images/bannersale.png" class="rounded d-block w-100" alt="Banner 4">
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                </div>

                <!--Control panel-->
                <%@ include file="panel.jsp" %>

                <div class="row mt-5 rounded px-3 py-5 shadow">
                    <div class="col-md-7 p-2">
                        <div>
                            <h3 class="section-title"><i class="fas fa-store me-2"></i>FFC Shop - The Place for FPTer to Buy and Sell Products</h3>
                            <div class="imgs-grid">
                                <div class="grid grid-1 rounded"><img src="${pageContext.request.contextPath}/static/images/rank/sanpham.jpg"></div>
                                <div class="grid grid-2 rounded"><img src="${pageContext.request.contextPath}/static/images/rank/sanpham2.jpg"></div>
                                <div class="grid grid-3 rounded"><img src="${pageContext.request.contextPath}/static/images/rank/sanpham3.jpg"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5 p-4 d-flex align-items-center">
                        <div>
                            <h3><i class="fas fa-shopping-cart me-2"></i>Various Products</h3>
                            <ul class="list-unstyled custom-list my-4">
                                <li>Receive special offers and attentive service</li>
                                <li>Save on purchase and delivery costs</li>
                                <li>Shop with peace of mind with attentive service</li>
                                <li>Convenient, safe, pay on delivery</li>
                            </ul>

                            <a href="${pageContext.request.contextPath}/martketplace/allshop" class="btn btn-primary btn-custom mt-3">Shop Now</a>
                        </div>
                    </div>
                </div>

                <div class="row mt-5 rounded px-3 py-5 shadow">
                    <div class="col-md-5 p-4 d-flex align-items-center">
                        <div>
                            <h3 class="section-title"><i class="fas fa-medal me-2"></i>Thousands of Benefits for Shop Owners</h3>
                            <p>Easy shop setup and fast sales</p>
                            <ul class="list-unstyled custom-list my-4">
                                <li>Voucher support</li>
                                <li>Healthy sales for mutual benefit</li>
                                <li>Peace of mind with transparent partnerships</li>
                                <li>Protection of Shop Owner rights</li>
                            </ul>
                            <a href="${pageContext.request.contextPath}/marketplace/myshop" class="btn btn-primary btn-custom mt-3">Join Now</a>
                        </div>
                    </div>
                    <div class="col-md-7 p-2">
                        <div>
                            <div class="imgs-grid">
                                <div class="grid grid-1"><img src="${pageContext.request.contextPath}/static/images/rank/giaohang.jpg"></div>
                                <div class="grid grid-2"><img src="${pageContext.request.contextPath}/static/images/rank/doitac1.jpg"></div>
                                <div class="grid grid-3"><img src="${pageContext.request.contextPath}/static/images/rank/doitac.jpg"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-5 rounded px-3 py-5 shadow">
                    <div class="col-12 col-md-7 p-2">
                        <div>
                            <div class="imgs-grid">
                                <div class="grid grid-1"><img src="${pageContext.request.contextPath}/static/images/30.png"></div>
                                <div class="grid grid-2"><img src="${pageContext.request.contextPath}/static/images/50.png"></div>
                                <div class="grid grid-3"><img src="${pageContext.request.contextPath}/static/images/70.png"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-5 p-4 d-flex align-items-center">
                        <div>
                            <h3 class="section-title"><i class="fas fa-gift me-2"></i>Thousands of Attractive Vouchers</h3>
                            <ul class="list-unstyled custom-list my-4">
                                <li>Receive special offers, thousands of free vouchers</li>
                                <li>Completely new open policy</li>
                                <li>First time ever: High rank, huge vouchers</li>
                                <li>Various types of shop and system vouchers</li>
                            </ul>
                            <a href="${pageContext.request.contextPath}/marketplace/cart" class="btn btn-primary btn-custom mt-3">Go to Cart</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../include/footer.jsp" %>
</body>
