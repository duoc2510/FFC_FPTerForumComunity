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
                                <h5 class="card-title">${shop.name}</h5>
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
                    </c:forEach>





                </div>

                <!--RATING-->
                <div id="rating" class="w-100 row container">
                    <div class="col-md">
                        <div class="card mx-1">
                            <div class="card-body" style="overflow-x: auto">
                                <p class="mb-4"><span class="text-primary font-italic me-1">Shop's rating</span></p>

                                <form action="/FPTer/comment" method="post" class="input-group">
                                    <input type="hidden" name="action" value="addComment">
                                    <input type="hidden" name="postId" value="3">
                                    <input type="hidden" name="userId" value="8">
                                    <input type="text" class="form-control" name="content" placeholder="What do you think about the shop?" required="">
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>


                                <!--loop this-->
                                <div class="d-flex justify-content-between align-items-center py-3">
                                    <div class="d-flex align-items-start">
                                        <div class="text-center">
                                            <img src="/FPTer/" alt="" width="30" class="rounded-circle avatar-cover">
                                        </div>
                                        <div class="ms-2">
                                            <h6 class="card-title fw-semibold mb-0">User</h6>
                                            <p class="s-4">2024-05-28</p>
                                            <p class="s-4">Áo đẹp lắm mn ạ, vải cũng đẹp và dày dặn  nữa mặc lên chuẩn form, shop thân thiện giao hàng nhanh, nói chung oke, chất khá mát chứ ko nóng đau ạ, mn nên mua thử</p>

                                        </div>
                                    </div>
                                </div>

                                <!--loop this-->
                                <div class="d-flex justify-content-between align-items-center py-3">
                                    <div class="d-flex align-items-start">
                                        <div class="text-center">
                                            <img src="/FPTer/" alt="" width="30" class="rounded-circle avatar-cover">
                                        </div>
                                        <div class="ms-2">
                                            <h6 class="card-title fw-semibold mb-0">User</h6>
                                            <p class="s-4">2024-05-28</p>
                                            <p class="s-4">Áo đẹp lắm mn ạ, vải cũng đẹp và dày dặn  nữa mặc lên chuẩn form, shop thân thiện giao hàng nhanh, nói chung oke, chất khá mát chứ ko nóng đau ạ, mn nên mua thử</p>

                                        </div>
                                    </div>
                                </div>
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
