

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
                    <div class="w-100 row">
                        <div class="col-md">
                            <div class="card mx-1">
                                <img class="card-img-top" src="${pageContext.request.contextPath}/static/${SHOP.image}" alt="Card image cap">
                                <div class="card-body">
                                    <h5 class="card-title">${SHOP.name}</h5>
                                    <p class="card-text">${SHOP.phone}</p>
                                    <p class="card-text">${SHOP.campus}</p>
                                    <p class="card-text">${SHOP.description}</p>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="w-100 row">
                        <div class="col-md">
                            <div class="card mx-1">
                                <ul class="list-group list-group-flush rounded-3">
                                    <li class="list-group-item d-flex p-3">
                                        <i style="display: inline-block;
                                           margin-top: 1px;" class="fas fa-globe fa-lg text-warning"></i>
                                        <a style="margin-left:10px" class="mb-0" href="" data-toggle="modal" data-target="#editBrand">Edit brand information</a>
                                    </li>
                                    <li class="list-group-item d-flex p-3">
                                        <i style="display: inline-block;
                                           margin-top: 1px;" class="fas fa-globe fa-lg text-warning"></i>
                                        <a style="margin-left:10px" class="mb-0" href="" data-toggle="modal" data-target="#deleteShop">Delete shop</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md">
                            <div class="card mx-1">
                                <ul class="list-group list-group-flush rounded-3">
                                    <li class="list-group-item d-flex p-3">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Full Name</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0">${USER.userFullName}</p>
                                        </div>
                                    </li>
                                    <li class="list-group-item d-flex p-3">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Email</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0">${USER.userEmail}</p>
                                        </div>
                                    </li>
                                    <li class="list-group-item d-flex p-3">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Wallet</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0">${USER.userWallet} VNĐ</p>
                                        </div>
                                    </li>
                                    <li class="list-group-item d-flex p-3">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Score</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0">${USER.userScore}</p>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="w-100 row">
                        <div class="col-md">
                        </div>
                    </div>


                    <div class="w-100 row">
                        <div class="col-md">
                            <div class="card mx-1">
                                <nav>
                                    <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                        <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">All Discount</button>
                                        <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">All Product</button>
                                        <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">All Order</button>
                                    </div>
                                </nav>



                                <div class="tab-content" id="nav-tabContent">
                                    <!--tab content 1-->
                                    <div class="tab-pane fade card-body show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0" style="overflow-x: auto">
                                        <table class="table table-responsive table-bordered w-auto">
                                            <thead>
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
                                                                    <a class="btn btn-primary" data-toggle="modal" data-target="#showdiscount${discount.discountId}">Show</a>
                                                                </td>
                                                                <td>
                                                                    <input type="hidden" name="name" value="${discount.code}">
                                                                    <a class="btn btn-secondary" data-toggle="modal" data-target="#editDiscount${discount.discountId}">Edit</a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>

                                            </tbody>
                                        </table>
                                        <div class="d-flex justify-content-end mb-2">
                                            <a class="btn btn-primary" data-toggle="modal" data-target="#addDiscount">Add new discount</a>
                                        </div>
                                    </div>


                                    <!--tab content 2-->
                                    <div class="tab-pane card-body fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
                                        <table class="table table-responsive table-bordered w-auto">
                                            <thead>
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
                                                            <a class="btn btn-primary" data-toggle="modal" data-target="#show${product.productId}">Show</a>
                                                        </td>
                                                        <td>
                                                            <input type="hidden" name="name" value="${product.name}">
                                                            <a class="btn btn-secondary" data-toggle="modal" data-target="#editProduct${product.productId}">Edit</a>
                                                        </td>

                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="d-flex justify-content-end mb-2">
                                            <a class="btn btn-primary" data-toggle="modal" data-target="#addProduct">Add new product</a>
                                        </div>
                                    </div>


                                    <!--tab content 3-->
                                    <div class="tab-pane card-body fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab" tabindex="0">
                                        <table class="table table-responsive table-bordered w-auto">
                                            <thead>
                                                <tr>
                                                    <th>Order Date</th>
                                                    <th>Name Receiver</th>
                                                    <th>Phone </th>
                                                    <th>Note</th>
                                                    <th>Item</th>
                                                    <th>Total</th>
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

                                                        <c:if test="${order.total * 5 / 100 >= USER.userWallet}">
                                                            <c:if test="${order.status eq 'Pending'}">
                                                                <td>
                                                                    <p class="text-danger"> Ví bạn không đủ tiền để thanh toán thuế!</p>
                                                                    <form action="product" method="post">
                                                                        <input type="text" name="orderid" value="${order.order_ID}" hidden/>
                                                                        <input type="text" name="action" value="thatbai" hidden/>
                                                                        <button type="submit" class="btn btn-danger my-1">Khong Nhan Don Hang</button>
                                                                    </form>
                                                                </td>

                                                            </c:if>
                                                            <c:if test="${order.status eq 'Accept'}">
                                                                <td>
                                                                    <form action="product" method="post">
                                                                        <input type="text" name="orderid" value="${order.order_ID}" hidden/>
                                                                        <input type="text" name="action" value="thanhcong" hidden/>
                                                                        <button type="submit" class="btn btn-primary my-1">Giao hang thanh cong</button>
                                                                    </form>
                                                                    <form action="product" method="post">
                                                                        <input type="text" name="orderid" value="${order.order_ID}" hidden/>
                                                                        <input type="text" name="action" value="thatbai" hidden/>
                                                                        <button type="submit" class="btn btn-danger my-1">Giao hang that bai</button>
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
                                                                    <p class="text-danger">Đơn hàng bị hủy</p>
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
                                                                        <input type="text" name="orderid" value="${order.order_ID}" hidden/>
                                                                        <input type="text" name="action" value="chapnhan" hidden/>
                                                                        <button type="submit" class="btn btn-primary my-1">Chap Nhan Don Hang</button>
                                                                    </form>
                                                                    <form action="product" method="post">
                                                                        <input type="text" name="orderid" value="${order.order_ID}" hidden/>
                                                                        <input type="text" name="action" value="thatbai" hidden/>
                                                                        <button type="submit" class="btn btn-danger my-1">Khong Nhan Don Hang</button>
                                                                    </form>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${order.status eq 'Accept'}">
                                                                <td>
                                                                    <form action="product" method="post">
                                                                        <input type="text" name="orderid" value="${order.order_ID}" hidden/>
                                                                        <input type="text" name="action" value="thanhcong" hidden/>
                                                                        <button type="submit" class="btn btn-primary my-1">Giao hang thanh cong</button>
                                                                    </form>
                                                                    <form action="product" method="post">
                                                                        <input type="text" name="orderid" value="${order.order_ID}" hidden/>
                                                                        <input type="text" name="action" value="thatbai" hidden/>
                                                                        <button type="submit" class="btn btn-danger my-1">Giao hang that bai</button>
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
                                                                    <p class="text-danger">Đơn hàng bị hủy</p>
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
                            <input type="text" class="form-control" id="productNameInput" name="productName" required>
                        </div>
                        <div class="form-group">
                            <label for="productPriceInput">Product Price:</label>
                            <input type="number" class="form-control" id="productPriceInput" name="productPrice" required>
                        </div>
                        <div class="form-group">
                            <label for="productQuantityInput">Product Quantity:</label>
                            <input type="number" class="form-control" id="productQuantityInput" name="productQuantity" min="0" required>
                        </div>
                        <div class="form-group">
                            <label for="productDescriptionInput">Product Description:</label>
                            <textarea class="form-control" id="productDescriptionInput" name="productDescription" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="fileInput">Choose Image File:</label>
                            <input multiple type="file" class="form-control-file" id="fileInput" name="file" accept="image/*" required>
                        </div>
                        <!-- Trường input ẩn -->
                        <input type="hidden" name="action" value="add">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Add New</button>
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
                        <button class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <img id="main-image-${product.productId}" style="max-height: 250px; width:100%"
                                 src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}"/>
                            <c:set var="imagelist" value="${Shop_DB.getAllUploadByProductID(product.productId)}" />
                            <div class="thumbnail text-center">
                                <img class="images-list-item" onclick="change_image(this, ${product.productId})" src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}">
                                <c:if test="${not empty imagelist}">
                                    <c:forEach var="image" items="${imagelist}" begin="1">
                                        <img onclick="change_image(this, ${product.productId})" src="${pageContext.request.contextPath}/static/${image.uploadPath}">
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productNameInput">Product Name:</label>
                            <input type="text" class="form-control" id="productNameInput" value="${product.name}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="productPriceInput">Product Price:</label>
                            <input type="text" class="form-control" value="${product.price} VND" readonly>
                        </div>
                        <div class="form-group">
                            <label for="productQuantityInput">Product Quantity:</label>
                            <input type="number" class="form-control" value="${product.quantity}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="productDescriptionInput">Product Description:</label>
                            <textarea class="form-control" id="productDescriptionInput" readonly>${product.productDescription}</textarea>
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
                                <input type="hidden" class="form-control" id="productNameInput" name="id" value="${product.productId}" required>
                            </div>
                            <div class="form-group">
                                <label for="productNameInput">Product Name:</label>
                                <input type="text" class="form-control" id="productNameInput" name="productName" value="${product.name}" required>
                            </div>
                            <div class="form-group">
                                <label for="productPriceInput">Product Price:</label>
                                <input type="number" class="form-control" id="productPriceInput" name="productPrice" value="${product.price}" required>
                            </div>
                            <div class="form-group">
                                <label for="productQuantityInput">Product Quantity:</label>
                                <input type="number" class="form-control" id="productQuantityInput" name="productQuantity" min="0" value="${product.quantity}" required>
                            </div>
                            <div class="form-group">
                                <label for="productDescriptionInput">Product Description:</label>
                                <textarea class="form-control" id="productDescriptionInput" name="productDescription" required>${product.productDescription}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="fileInput">Choose Image File:</label>
                                <input multiple type="file" class="form-control-file" id="fileInput" name="file" accept="image/*">
                            </div>
                            <!-- Trường input ẩn -->
                            <input type="hidden" name="action" value="edit">
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Edit</button>
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
                        <button class="btn btn-secondary" type="submit">Delete</button>
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
                            <input type="hidden" class="form-control" id="shopID" name="id" value="${SHOP.shopID}" required>
                        </div>
                        <div class="form-group">
                            <label for="productNameInput">Brand Name:</label>
                            <input type="text" class="form-control" id="shopName" name="shopName" value="${SHOP.name}" required>
                        </div>
                        <div class="form-group">
                            <label for="productPriceInput">Brand Phone:</label>
                            <input type="number" class="form-control" id="shopPhone" name="shopPhone" value="${SHOP.phone}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="productPriceInput">Campus</label>
                            <input type="text" class="form-control" id="shopPhone" name="shopCampus" value="${SHOP.campus}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="productDescriptionInput">Shop Description:</label>
                            <textarea class="form-control" id="shopDescriptionInput" name="shopDescription" required>${SHOP.description}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="fileInput">Choose Cover Image File:</label>
                            <input type="file" class="form-control-file" id="fileInput" name="file" accept="image/*">
                        </div>

                        <!-- Trường input ẩn -->
                        <input type="hidden" name="action" value="editbrand">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Edit</button>
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
                            <input type="text" class="form-control" id="discountCodeInput" name="discountCode" required>
                        </div>
                        <div class="form-group">
                            <label for="discountShopInput" hidden>Shop ID:</label>
                            <input type="number" class="form-control" id="discountShopInput" name="shopId" value="${SHOP.shopID}" hidden>
                        </div>
                        <div class="form-group">
                            <label for="discountPercentInput">Discount Percent:</label>
                            <input type="number" class="form-control" id="discountPercentInput" name="discountPercent" required>
                        </div>
                        <div class="form-group">
                            <label for="discountConditionInput">Discount Condition (Giá trị đơn hàng tối thiểu):</label>
                            <input type="number" class="form-control" id="discountConditionInput" name="discountConditionInput" required>
                        </div>
                        <div class="form-group">
                            <label for="validFromInput">Valid From:</label>
                            <input type="date" class="form-control" id="validFromInput" name="validFrom" required>
                        </div>
                        <div class="form-group">
                            <label for="validToInput">Valid To:</label>
                            <input type="date" class="form-control" id="validToInput" name="validTo" required>
                        </div>
                        <div class="form-group">
                            <label for="usageLimitInput">Usage Limit:</label>
                            <input type="number" class="form-control" id="usageLimitInput" name="usageLimit" required>
                        </div>
                        <!-- Hidden input to specify the action -->
                        <input type="hidden" name="action" value="adddiscount">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Add New</button>
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
                            <input type="text" class="form-control" id="DiscountCodeInput${discount.discountId}" value="${discount.code}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="ConditionInput${discount.discountId}">Discount Condition Price:</label>
                            <input type="number" class="form-control" id="ConditionInput${discount.discountId}" value="${discount.condition}"VND readonly>
                        </div>
                        <div class="form-group">
                            <label for="DiscountPercentInput${discount.discountId}">Discount Percent:</label>
                            <input type="number" class="form-control" id="DiscountPercentInput${discount.discountId}" value="${discount.discountPercent}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="ValidFromInput${discount.discountId}">Valid From:</label>
                            <input type="date" class="form-control" id="ValidFromInput${discount.discountId}" value="${discount.validFrom}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="ValidToInput${discount.discountId}">Valid To:</label>
                            <input type="date" class="form-control" id="ValidToInput${discount.discountId}" value="${discount.validTo}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="UsageLimitInput${discount.discountId}">Usage Limit:</label>
                            <input type="number" class="form-control" id="UsageLimitInput${discount.discountId}" value="${discount.usageLimit}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="UsageCountInput${discount.discountId}">Usage Count:</label>
                            <input type="number" class="form-control" id="UsageCountInput${discount.discountId}" value="${discount.usageCount}" readonly>
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
                                <input type="text" class="form-control" id="discountCodeInput" name="discountCode" value="${discount.code}" required>
                            </div>
                            <div class="form-group">
                                <label for="discountShopInput" hidden>Shop ID:</label>
                                <input type="number" class="form-control" id="discountShopInput" name="shopId" value="${SHOP.shopID}" hidden>
                            </div>
                            <div class="form-group">
                                <label for="discountShopInput" hidden>Discount ID:</label>
                                <input type="number" class="form-control" id="discountIDInput" name="discountId" value="${discount.discountId}" hidden>
                            </div>
                            <div class="form-group">
                                <label for="discountPercentInput">Discount Percent:</label>
                                <input type="number" class="form-control" id="discountPercentInput" name="discountPercent" value="${discount.discountPercent}" required>
                            </div>
                            <div class="form-group">
                                <label for="discountConditionInput">Discount Condition (Giá trị đơn hàng tối thiểu):</label>
                                <input type="number" class="form-control" id="discountConditionInput" name="discountConditionInput" value="${discount.condition}" required>
                            </div>
                            <div class="form-group">
                                <label for="validFromInput">Valid From:</label>
                                <input type="date" class="form-control" id="validFromInput" name="validFrom" value="${discount.validFrom}" required>
                            </div>
                            <div class="form-group">
                                <label for="validToInput">Valid To:</label>
                                <input type="date" class="form-control" id="validToInput" name="validTo" value="${discount.validTo}" required>
                            </div>
                            <div class="form-group">
                                <label for="usageLimitInput">Usage Limit:</label>
                                <input type="number" class="form-control" id="usageLimitInput" name="usageLimit" value="${discount.usageLimit}" required>
                            </div>
                            <!-- Hidden input to specify the action -->
                            <input type="hidden" name="action" value="editdiscount">
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Edit</button>
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

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%@ include file="../include/footer.jsp" %>