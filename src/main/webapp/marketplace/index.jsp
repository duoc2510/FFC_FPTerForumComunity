<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ include file="../include/header.jsp" %>

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
                <!--Control panel-->
                <%@ include file="panel.jsp" %>
                <div class="row my-5">
                    <div class="col-md-12 p-2">
                        <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel" data-bs-interval="2000">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="${pageContext.request.contextPath}/static/images/bannerdangkishop.png" class="d-block w-100" alt="Banner 2">
                                </div>
                                <div class="carousel-item">
                                    <img src="${pageContext.request.contextPath}/static/images/bannermonan.png" class="d-block w-100" alt="Banner 3">
                                </div>
                                <div class="carousel-item">
                                    <img src="${pageContext.request.contextPath}/static/images/bannersale.png" class="d-block w-100" alt="Banner 4">
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

                <div class="row mt-5">
                    <div class="col-md-7 p-2">
                        <div class="section-container">
                            <h3 class="section-title">FFC Shop - Nơi Trao Đổi Mua Bán Các Mặt Hàng Giữa FPTer</h3>
                            <div class="imgs-grid">
                                <div class="grid grid-1"><img src="${pageContext.request.contextPath}/static/images/rank/sanpham.jpg"></div>
                                <div class="grid grid-2"><img src="${pageContext.request.contextPath}/static/images/rank/sanpham2.jpg"></div>
                                <div class="grid grid-3"><img src="${pageContext.request.contextPath}/static/images/rank/sanpham3.jpg"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5 p-2">
                        <div class="section-container">
                            <h3>Rất Nhiều Sản Phẩm Đa Dạng</h3>
                            <ul class="list-unstyled custom-list my-4">
                                <li>Nhận ưu đãi đặc biệt, dịch vụ chăm sóc tận tâm</li>
                                <li>Tiết kiệm chi phí mua hàng và giao hàng</li>
                                <li>An tâm mua sắm với dịch vụ chăm sóc</li>
                                <li>Tiện lợi, an toàn, trả tiền khi nhận hàng</li>
                            </ul>
                            <a href="${pageContext.request.contextPath}/marketplace/allshop" class="btn btn-primary btn-custom mt-3">Buy Now</a>
                        </div>
                    </div>
                </div>

                <div class="row mt-5">
                    <div class="col-md-5 p-2">
                        <div class="section-container bg-light">
                            <h3 class="section-title">Hàng Ngàn Ưu Đãi Quyền Lợi Dành Cho Shop Owner</h3>
                            <p>Tạo shop dễ dàng và bán hàng nhanh chóng</p>
                            <ul class="list-unstyled custom-list my-4">
                                <li>Hỗ trợ voucher</li>
                                <li>Bán hàng lành mạnh 2 bên cùng có lợi</li>
                                <li>An tâm làm đối tác với nhau vì có sự minh bạch</li>
                                <li>Bảo vệ quyền lợi cho Shop Owner</li>
                            </ul>
                            <a href="${pageContext.request.contextPath}/marketplace/myshop" class="btn btn-primary btn-custom mt-3">Join with us</a>
                        </div>
                    </div>
                    <div class="col-md-7 p-2">
                        <div class="section-container">
                            <div class="imgs-grid">
                                <div class="grid grid-1"><img src="${pageContext.request.contextPath}/static/images/rank/giaohang.jpg"></div>
                                <div class="grid grid-2"><img src="${pageContext.request.contextPath}/static/images/rank/doitac1.jpg"></div>
                                <div class="grid grid-3"><img src="${pageContext.request.contextPath}/static/images/rank/doitac.jpg"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-5">
                    <div class="col-md-7 p-2">
                        <div class="section-container">
                            <div class="imgs-grid">
                                <div class="grid grid-1"><img src="${pageContext.request.contextPath}/static/images/rank/sale3.jpg"></div>
                                <div class="grid grid-2"><img src="${pageContext.request.contextPath}/static/images/rank/sale2.jpg"></div>
                                <div class="grid grid-3"><img src="${pageContext.request.contextPath}/static/images/rank/sale1.jpg"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5 p-2">
                        <div class="section-container">
                            <h3 class="section-title">Hàng Ngàn Voucher Hấp Dẫn</h3>
                            <ul class="list-unstyled custom-list my-4">
                                <li>Nhận ưu đãi đặc biệt, hàng ngàn voucher miễn phí</li>
                                <li>Chính sách mở hoàn toàn mới</li>
                                <li>Lần đầu tiên xuất hiện: Leo rank cao, voucher khủng</li>
                                <li>Đa dạng các loại voucher của shop và của hệ thống</li>
                            </ul>
                            <a href="${pageContext.request.contextPath}/marketplace/cart" class="btn btn-primary btn-custom mt-3">Go to cart now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

        <%@ include file="../include/footer.jsp" %>