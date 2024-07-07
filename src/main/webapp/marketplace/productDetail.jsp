<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
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
    .owl-item {
        opacity: .8
    }
    .owl-item:hover{
        opacity: 1;
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
                <!-- Control panel -->
                <%@ include file="panel.jsp" %>

                <c:if test="${not empty message}">
                    <%
                        session.removeAttribute("message");
                    %>
                </c:if>

                <div class="w-100  container">
                    <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(productid)}" />
                    <c:set var="product" value="${Shop_DB.getProductByID(productid)}" />
                    <div class="col-md rounded shadow">
                        <div id="addtocart">
                            <div class="row card-body pt-1">
                                <div class="col-12 col-md-6 p-2">
                                    <img id="main-image-${product.productId}" class="rounded card-img-top product-img" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}" alt="Card image cap">
                                </div>

                                <div class="col-12 col-md-6 p-3">
                                    <h5 class="card-title mb-2">${product.name}</h5>
                                    <p class="card-text">${product.price} VNĐ</p>
                                    <p class="card-text">${product.productDescription}</p>
                                    <form class="input-group mt-3" action="${pageContext.request.contextPath}/marketplace/cart" method="get">
                                        <input type="hidden" name="productid" value="${productid}">
                                        <input type="hidden" name="shopid" value="${shopid}">
                                        <input class="form-control rounded me-3" type="number" name="quantity" min="1" max="${product.quantity}" value="1" required onchange="checkQuantity(this, ${product.quantity})">

                                        <button type="submit" class="btn rounded btn-primary">Add to cart</button>
                                    </form>
                                    <p id="maxQuantityAlert" class="text-danger"  style="display: none;">Maximum number of products!</p>
                                </div>


                            </div>
                        </div>
                        <c:set var="imagelist" value="${Shop_DB.getAllUploadByProductID(productid)}" />
                        <div class="row row w-100 mx-auto" style="background-color: var(--bs-card-cap-bg);">
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
//            nav: true,
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

    // Check if the message variable is set or not
    document.addEventListener("DOMContentLoaded", (event) => {
        var errorMessage = "${message}";
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

</script>

<%@ include file="../include/footer.jsp" %>
