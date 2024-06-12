<%-- 
    Document   : index
    Created on : May 25, 2024, 9:43:06 PM
    Author     : mac
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
    .card-img-top{
        height:250px;
        object-fit: cover;
    }
    .card-text{
        text-overflow: ellipsis;
        white-space: nowrap;
        width: 200px;
        overflow: hidden;
    }
    .imgs-grid{
        display: grid;
        grid-template-columns: repeat(27, 1fr);
        position: relative;
    }
    .imgs-grid .grid.grid-1 {
        -ms-grid-column: 1;
        -ms-grid-column-span: 18;
        grid-column: 1 / span 18;
        -ms-grid-row: 1;
        -ms-grid-row-span: 27;
        grid-row: 1 / span 27;
    }
    .imgs-grid .grid.grid-2 {
        -ms-grid-column: 19;
        -ms-grid-column-span: 27;
        grid-column: 19 / span 27;
        -ms-grid-row: 1;
        -ms-grid-row-span: 5;
        grid-row: 1 / span 5;
        padding-left: 20px;
    }
    .imgs-grid .grid.grid-3 {
        -ms-grid-column: 14;
        -ms-grid-column-span: 16;
        grid-column: 14 / span 16;
        -ms-grid-row: 6;
        -ms-grid-row-span: 27;
        grid-row: 6 / span 27;
        padding-top: 20px;
    }
    .imgs-grid .grid img {
        border-radius: 20px;
        max-width: 100%;
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
                    <div class="w-100 row">
                        <div class="col-md-12 p-2">
                            <img class="w-100 rounded" src="${pageContext.request.contextPath}/static/images/bannerShop.jpg"/>
                        </div>
                    </div>

                    <div class="w-100 row mt-5">
                        <div class="col-md-7 p-2">
                            <div class="imgs-grid">
                                <div class="grid grid-1"><img src="${pageContext.request.contextPath}/static/images/rank/sanpham.jpg"></div>
                                <div class="grid grid-2"><img src="${pageContext.request.contextPath}/static/images/rank/sanpham2.jpg"></div>
                                <div class="grid grid-3"><img src="${pageContext.request.contextPath}/static/images/rank/sanpham3.jpg"></div>
                            </div>
                        </div>
                        <div class="col-md-5 p-2">
                            <h3>FFC Shop - Nơi Trao Đổi Mua Bán Các Mặt Hàng Giữa FPTer</h3>
                            <p>Rất Nhiều Sản Phẩm Đa Dạng</p>
                            <ul class="list-unstyled custom-list my-4">
                                <li>Nhận ưu đãi đặc biệt, dịch vụ chăm sóc tận tâm</li>
                                <li>Tiết kiệm chi phí mua hàng và giao hàng</li>
                                <li>An tâm mua sắm với dịch vụ chăm sóc</li>
                                <li>Tiện lợi, an toàn, trả tiền khi nhận hàng</li>
                            </ul>
                            <a href="${pageContext.request.contextPath}/marketplace/allshop" class="btn btn-primary mt-3">Buy Now</a>
                        </div>
                    </div>

                    <div class="w-100 row mt-5">
                        <div class="col-md-5 p-2">
                            <h3>Hàng Ngàn Ưu Đãi Quyền Lợi Dành Cho Shop Owner</h3>
                            <p>Tạo shop dễ dàng và bán hàng nhanh chóng</p>
                            <ul class="list-unstyled custom-list my-4">
                                <li>Hỗ trợ voucher</li>
                                <li>Bán hàng lành mạnh 2 bên cùng có lợi</li>
                                <li>An tâm làm đối tác với nhau vì có sự minh bạch</li>
                                <li>Bảo vệ quyền lợi cho Shop Owner</li>
                                <a href="${pageContext.request.contextPath}/marketplace/myshop" class="btn btn-primary mt-3">Join with us</a>
                            </ul>
                        </div>
                        <div class="col-md-7 p-2">
                            <div class="imgs-grid">
                                <div class="grid grid-1"><img src="${pageContext.request.contextPath}/static/images/rank/giaohang.jpg"></div>
                                <div class="grid grid-2"><img src="${pageContext.request.contextPath}/static/images/rank/doitac1.jpg"></div>
                                <div class="grid grid-3"><img src="${pageContext.request.contextPath}/static/images/rank/doitac.jpg"></div>
                            </div>
                        </div>
                    </div>

                    <div class="w-100 row mt-5">
                        <div class="col-md-7 p-2">
                            <div class="imgs-grid">
                                <div class="grid grid-1"><img src="${pageContext.request.contextPath}/static/images/rank/sale3.jpg"></div>
                                <div class="grid grid-2"><img src="${pageContext.request.contextPath}/static/images/rank/sale2.jpg"></div>
                                <div class="grid grid-3"><img src="${pageContext.request.contextPath}/static/images/rank/sale1.jpg"></div>
                            </div>
                        </div>
                        <div class="col-md-5 p-2">
                            <h3>Hàng Ngàn Voucher Hấp Dẫn</h3>
                            <ul class="list-unstyled custom-list my-4">
                                <li>Nhận ưu đãi đặc biệt,hàng ngàn voucher miễn phí</li>
                                <li>Chính sách mở hoàn toàn mới</li>
                                <li>Lần đầu tiên xuất hiện : Leo rank cao, voucher khủng</li>
                                <li>Đa dạng các loại voucher của shop và của hệ thống</li>
                            </ul>
                            <a href="${pageContext.request.contextPath}/marketplace/cart" class="btn btn-primary mt-3">Go to cart now</a>
                        </div>
                    </div>
                </div>
                <div>
                    <!--Tao shop-->
                    <%--<%@ include file="createShop.jsp" %>--%>

                    <!--Xem tat ca san pham cua minh-->
                    <%--<%@ include file="myProduct.jsp" %>--%>

                    <!--Tao san pham -->
                    <%--<%@ include file="createProduct.jsp" %>--%>

                    <!--Xem tat ca san pham-->
                    <%--<%@ include file="allProduct.jsp" %>--%>

                    <!--Xem tien trinh giao hang -->
                    <%--<%@ include file="checkProgress.jsp" %>--%>
                </div>
            </div>
        </div>
    </div>


    <%@ include file="../include/footer.jsp" %>



