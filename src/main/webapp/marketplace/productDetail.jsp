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
    .owl-item {
        opacity: .8
    }
    .owl-item:hover {
        opacity: 1;
    }
</style>
<script>
    document.addEventListener("DOMContentLoaded", (event) => {
        var errorMessage = "${message}";
        if (errorMessage != "") {
            swal({
                title: "Error!",
                text: errorMessage,
                icon: "error",
                button: "OK",
            });
        }
    });
</script>

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

                <c:if test="${not empty message}">
                    <%
                        session.removeAttribute("message");
                    %>
                </c:if>

                <div class="w-100 container">
                    <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(productid)}" />
                    <c:set var="product" value="${Shop_DB.getProductByID(productid)}" />
                    <div class="col-md rounded shadow">
                        <div id="addtocart" class="d-flex">
                            <div class="row card-body pt-1">
                                <div class="col-12 col-md-6 p-2">
                                    <img id="main-image-${product.productId}" class="rounded card-img-top product-img" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}" alt="Card image cap">
                                </div>
                                <div class="col-12 col-md-6 p-3">
                                    <h5 class="card-title mb-2">
                                        <i class="fas fa-tag"></i> ${product.name}
                                    </h5>
                                    <p style="margin-left: 24px; line-height: 1.6;" class="card-text">
                                        <i class="fas fa-dollar-sign"></i> ${product.price} VNĐ
                                    </p>
                                    <p style="margin-left: 20px; line-height: 1.6;" class="card-text">
                                        <i class="fas fa-info-circle"></i> ${product.productDescription}
                                    </p>
                                    <form class="input-group mt-3" action="${pageContext.request.contextPath}/marketplace/cart" method="get">
                                        <input type="hidden" name="productid" value="${productid}">
                                        <input type="hidden" name="shopid" value="${shopid}">
                                        <input class="form-control rounded me-3" type="number" name="quantity" min="1" max="${product.quantity}" value="1" required onchange="checkQuantity(this, ${product.quantity})">
                                        <button type="submit" class="btn rounded btn-primary">
                                            <i class="fas fa-cart-plus"></i> Add to cart
                                        </button>
                                    </form>
                                    <p id="maxQuantityAlert" class="text-danger" style="display: none;">
                                        <i class="fas fa-exclamation-triangle"></i> Maximum number of products!
                                    </p>
                                </div>
                            </div>
                        </div>
                        <c:set var="imagelist" value="${Shop_DB.getAllUploadByProductID(productid)}" />
                        <div class="row w-100 mx-auto" style="background-color: var(--bs-card-cap-bg);">
                            <div class="col card-body">
                                <div class="thumbnail text-center owl-carousel d-flex justify-content-start">
                                    <c:forEach var="image" items="${imagelist}">
                                        <img class="images-list-item px-1 rounded" onclick="change_image(this, ${product.productId})" src="${pageContext.request.contextPath}/static/${image.uploadPath}" alt="Thumbnail">
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
    function change_image(image, productId) {
        console.log("Changing main image to:", image.src);
        var container = document.getElementById("main-image-" + productId);
        if (container) {
            container.src = image.src;
        } else {
            console.error("Main image container not found for product ID:", productId);
        }
    }

    $(document).ready(function () {
        $('.owl-carousel').owlCarousel({
            loop: true,
            margin: 10,
            responsive: {
                0: {
                    items: 2
                },
                600: {
                    items: 3
                },
                1000: {
                    items: 5
                }
            }
        });
    });

    function checkQuantity(input, maxQuantity) {
        if (input.value == maxQuantity) {
            document.getElementById('maxQuantityAlert').style.display = 'block';
        } else {
            document.getElementById('maxQuantityAlert').style.display = 'none';
        }
    }


</script>

<%@ include file="../include/footer.jsp" %>
