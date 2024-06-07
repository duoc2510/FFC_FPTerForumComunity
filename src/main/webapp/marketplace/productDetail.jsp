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
    .thumbnail img {
        width: 200px;
        height: 100px;
        object-fit: cover;
        cursor: pointer;
    }
    p {
        margin-bottom: 0;
    }
    .product-img {
        height: 300px;
        object-fit: cover;
    }
    #addtocart {
        display: flex;
        flex-direction: row;
        flex-wrap: nowrap;
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
                    <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(productid)}" />
                    <c:set var="product" value="${Shop_DB.getProductByID(productid)}" />
                    <div class="col-md card">
                        <div id="addtocart" class="mx-1 row">
                            <img id="main-image-${product.productId}" class="col card-img-top product-img" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}" alt="Card image cap">
                            <div class="col card-body">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="card-text">${product.price}đ</p>
                                <p class="card-text">Giới thiệu: ${product.productDescription}</p>
                                <form class="input-group mt-3" action="${pageContext.request.contextPath}/marketplace/cart" method="get">
                                    <input type="hidden" name="productid" value="${productid}">
                                    <input type="hidden" name="shopid" value="${shopid}">
                                    <input class="form-control" type="number" name="quantity" min="1" value="1" required>
                                    <button type="submit" class="btn btn-primary">Add to card</button>
                                </form>
                            </div>
                        </div>
                        <c:set var="imagelist" value="${Shop_DB.getAllUploadByProductID(productid)}" />

                        <div class="row">
                            <div class="col card-body">
                                <div class="thumbnail text-center">
                                    <c:forEach var="image" items="${imagelist}">
                                        <img class="images-list-item" onclick="change_image(this, ${product.productId})" src="${pageContext.request.contextPath}/static/${image.uploadPath}" alt="Thumbnail">
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    // Check if the message variable is set or not
    document.addEventListener("DOMContentLoaded", (event) => {
        var errorMessage = "${requestScope.message}";
        // Kiểm tra nếu errorMessage không rỗng, hiển thị thông báo lỗi
        if (errorMessage != "") {
            swal({
                title: "Error!",
                text: errorMessage,
                icon: "error",
                button: "OK",
            });
        }


    });


    function change_image(image, productId) {
        console.log("Changing main image to:", image.src);
        var container = document.getElementById("main-image-" + productId);
        if (container) {
            container.src = image.src;
        } else {
            console.error("Main image container not found for product ID:", productId);
        }
    }

    document.addEventListener("DOMContentLoaded", function (event) {
        // Ensure your DOM is fully loaded before executing any code
    });
</script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%@ include file="../include/footer.jsp" %>
