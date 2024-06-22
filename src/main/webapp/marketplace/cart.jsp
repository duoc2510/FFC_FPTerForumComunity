<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

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


                <!--check bag is empty-->
                <c:if test="${empty ORDERITEMLIST}">'
                    <style>
                        #billing{
                            display: none;
                        }
                    </style>
                    <div class='row mt-5'>
                        <div class='col-12 mx-auto text-center'>
                            <img src="${pageContext.request.contextPath}/static/images/bag-empty.jpg" alt="alt" width='200px'/>
                            <h1 class="text-uppercase text-bold my-3">bag is empty</h1>
                        </div>
                    </div>

                </c:if>
                <div class="row" id="billing">                    
                    <div class="col-md-6">
                        <div class=" mx-2">
                            <!--loop this-->
                            <form action="confirmorder" method="post">

                                <c:forEach var="item" items="${ORDERITEMLIST}">
                                    <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(item.getProductID())}" />
                                    <c:set var="product" value="${Shop_DB.getProductByID(item.getProductID())}" />

                                    <div class="card mb-3">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <div class="d-flex flex-row align-items-center">
                                                    <div>
                                                        <input type="checkbox" class="orderItemCheckbox" name="selectedItems" value="${item.getOrderItem_id()}" data-item-id="${item.getOrderItem_id()}" data-item-price="${item.price}" data-item-quantity="${item.quantity}" data-product-quantity="${product.quantity}" data-product-id="${item.getProductID()}" />
                                                    </div>
                                                    <div>
                                                        <img src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}" class="img-fluid rounded-3" style="width: 65px;">
                                                    </div>
                                                    <div class="ms-3">
                                                        <h5>${product.name}</h5>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-row align-items-center">
                                                    <div class="mx-1" style="width: 70px;">
                                                        <c:if test="${ product.quantity > 0}">
                                                            <input data-action="update" type="number" name="quantity" class="form-control" value="${item.quantity}" min="1" max="${product.quantity}" oninput="handleQuantityChange('${item.getOrderItem_id()}', this.value)">
                                                            <c:if test="${item.quantity == product.quantity}">
                                                                <p class="text-danger position-absolute">Quantity was maximum</p>
                                                            </c:if>    
                                                        </c:if>  
                                                        <c:if test="${ product.quantity == 0}">
                                                            <input type="number" class="form-control" name="quantity" value="0" readonly>
                                                            <p style=" font-size: 11px;" class="text-danger position-absolute">This product had sold out! Please delete!</p>
                                                        </c:if>
                                                    </div>
                                                    <c:set var="totalPrice1" value="${item.quantity * item.price}" />
                                                    <div class="mx-1" style="width: 80px;">
                                                        <h5 class="mb-0">${totalPrice1}</h5>
                                                    </div>
                                                    <c:set var="totalPrice" value="${totalPrice1 + totalPrice}" />
                                                    <a class="mx-1" onclick="moveOutProductFromCart('${item.getOrderItem_id()}')" style="color: #cecece;" data-action="delete"><i class="fas fa-trash-alt"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <!--loop this-->
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card ">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h5 class="mb-0">Billing</h5>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-outline form-white">
                                        <label class="form-label" for="typeText">Full Name </label>
                                        <input name="fullname" class="form-control form-control" placeholder="Full Name" value="${USER.userFullName}" readonly> 

                                        <label class="form-label mt-3" for="typeText">Phone</label>
                                        <input name="phone" class="form-control form-control" placeholder="Phone" required>

                                        <c:set var="shop" value="${Shop_DB.getShopHaveStatusIs1ByShopID(product.getShopId())}" />
                                        <label hidden class="form-label mt-3" for="typeText">Shop</label>
                                        <input name="shopid" class="form-control form-control" placeholder="shopid" value="${shop.shopID}" hidden>

                                        <label class="form-label mt-3" for="typeText">Campus</label>
                                        <input name="campus" class="form-control form-control" placeholder="Campus" value="${shop.campus}" readonly>

                                        <c:set var="discountlist" value="${Shop_DB.getAllDiscountOrder(USER.userId, product.getShopId())}" />
                                        <div id="discountSection" style="display: none;">
                                            <label class="form-label mt-3" for="typeText">Discount</label>
                                            <select id="discountSelect" class="form-control" name="discountSelect" onchange="updateDiscount()">
                                                <c:forEach var="discount" items="${discountlist}">
                                                    <option value="${discount.discountId}" data-percent="${discount.discountPercent}" data-condition="${discount.condition}">Giảm ${discount.discountPercent}% đơn từ ${discount.condition}VNĐ</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <input type="hidden" id="selectedPercent" name="percent" value="0" />

                                        <label class="form-label mt-3" for="typeText">Note</label>
                                        <input name="note" class="form-control" placeholder="Note" rows="4">
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between mt-3">
                                    <p class="mb-2">Sub total</p>
                                    <p class="mb-2" id="subtotal">0 VND</p>
                                </div>

                                <div class="d-flex justify-content-between">
                                    <p class="mb-2">Discount fee</p>
                                    <p class="mb-2" id="discountFee">-0 VND</p>
                                </div>

                                <div class="d-flex justify-content-between mb-4">
                                    <p class="mb-2">Total</p>
                                    <p class="mb-2" id="totalFee">0 VND</p>
                                </div>

                                <div class="mb-3" hidden="">
                                    <label class="form-label">Total</label>
                                    <input type="text" class="form-control" id="totalInput" name="total" value="0">
                                </div>
                                <input type="hidden" name="action" value="confirm1">
                                <div class="d-flex justify-content-between">
                                    <button type="submit" class="btn btn-info btn-block btn-lg">
                                        <span id="checkoutTotal">0 VND</span>
                                        <span>Checkout <i class="fas fa-long-arrow-alt-right ms-2"></i></span>
                                    </button>                                                    
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <script>
                                                function handleQuantityChange(orderItemId, newQuantity) {
                                                    var data = {
                                                        action: "update",
                                                        orderItemId: orderItemId,
                                                        newQuantity: newQuantity
                                                    };

                                                    $.ajax({
                                                        url: 'cart',
                                                        type: 'POST',
                                                        data: data,
                                                        dataType: 'json',
                                                        success: function (response) {
                                                            if (response.success) {
                                                                location.reload();
                                                            } else {
                                                                swal("Error!", response.message, "error");
                                                            }
                                                        },
                                                        error: function (xhr, status, error) {
                                                            swal("Error!", "Unable to update the item quantity.", "error");
                                                        }
                                                    });
                                                }

                                                function moveOutProductFromCart(id) {
                                                    swal({
                                                        title: "Are you sure?",
                                                        text: "Once deleted, you will not be able to recover this item!",
                                                        icon: "warning",
                                                        buttons: true,
                                                        dangerMode: true,
                                                    }).then((willDelete) => {
                                                        if (willDelete) {
                                                            $.ajax({
                                                                url: 'cart',
                                                                type: 'POST',
                                                                data: {id: id, action: 'delete'},
                                                                dataType: 'json',
                                                                success: function (response) {
                                                                    if (response.success) {
                                                                        swal("Success! Your item has been removed from the cart!", {
                                                                            icon: "success",
                                                                        }).then(() => {
                                                                            location.reload();
                                                                        });
                                                                    } else {
                                                                        swal("Error! Unable to remove the item from the cart.", {
                                                                            icon: "error",
                                                                        });
                                                                    }
                                                                },
                                                                error: function (xhr, status, error) {
                                                                    swal("Error! Unable to remove the item from the cart.", {
                                                                        icon: "error",
                                                                    });
                                                                }
                                                            });
                                                        } else {
                                                            swal("Your item is safe!");
                                                        }
                                                    });
                                                }

                                                var selectedItems = new Set();

                                                function updateSummary() {
                                                    var subtotal = 0;
                                                    selectedItems.forEach(function (item) {
                                                        subtotal += item.quantity * item.price;
                                                    });
                                                    document.getElementById("subtotal").textContent = subtotal.toFixed(2) + ' VND';

                                                    var discountSection = document.getElementById("discountSection");
                                                    var discountSelect = document.getElementById("discountSelect");
                                                    discountSection.style.display = selectedItems.size === 0 ? 'none' : 'block';
                                                    discountSelect.disabled = selectedItems.size === 0;
                                                    filterDiscountOptions(subtotal);
                                                    updateDiscount();
                                                }

                                                function filterDiscountOptions(subtotal) {
                                                    var discountSelect = document.getElementById("discountSelect");
                                                    var options = discountSelect.options;

                                                    for (var i = options.length - 1; i >= 0; i--) {
                                                        var condition = parseFloat(options[i].getAttribute("data-condition"));
                                                        if (subtotal >= condition) {
                                                            options[i].disabled = false;
                                                            options[i].style.display = 'block';
                                                        } else {
                                                            options[i].disabled = true;
                                                            options[i].style.display = 'none';
                                                        }
                                                    }
                                                }

                                                function updateDiscount() {
                                                    var discountSelect = document.getElementById("discountSelect");
                                                    var selectedOption = discountSelect.options[discountSelect.selectedIndex];
                                                    var percent = parseFloat(selectedOption.getAttribute("data-percent"));
                                                    var subtotal = parseFloat(document.getElementById("subtotal").textContent);
                                                    var discountFee = (percent * subtotal / 100).toFixed(2);

                                                    document.getElementById("discountFee").textContent = '-' + discountFee + ' VND';

                                                    var newTotal = subtotal - discountFee;
                                                    document.getElementById("totalFee").textContent = newTotal.toFixed(2) + ' VND';
                                                    document.getElementById("checkoutTotal").textContent = newTotal.toFixed(2) + ' VND';
                                                    document.getElementById("totalInput").value = newTotal.toFixed(2);
                                                }

                                                document.addEventListener("DOMContentLoaded", (event) => {
                                                    var checkboxes = document.querySelectorAll('.orderItemCheckbox');
                                                    checkboxes.forEach(function (checkbox) {
                                                        checkbox.addEventListener('change', function () {
                                                            var item = {
                                                                id: this.dataset.itemId,
                                                                price: parseFloat(this.dataset.itemPrice),
                                                                quantity: parseInt(this.dataset.itemQuantity),
                                                                productQuantity: parseInt(this.dataset.productQuantity)
                                                            };

                                                            if (this.checked) {
                                                                selectedItems.add(item);
                                                            } else {
                                                                selectedItems.forEach(function (selectedItem) {
                                                                    if (selectedItem.id === item.id) {
                                                                        selectedItems.delete(selectedItem);
                                                                    }
                                                                });
                                                            }

                                                            updateSummary();
                                                        });
                                                    });

                                                    var errorParam = "${param.error}";
                                                    if (errorParam) {
                                                        var errorMessage = decodeURIComponent(errorParam.replace(/\+/g, " "));
                                                        swal({
                                                            title: "Error!",
                                                            text: errorMessage,
                                                            icon: "error",
                                                            button: "OK",
                                                        });
                                                    }

                                                    // Initial call to hide the discount select box if no items are selected
                                                    updateSummary();
                                                });

                                                window.onload = function () {
                                                    listenForQuantityChange();
                                                }
    </script>
</body>
<script src="../static/js/validation.js"></script>
<%@ include file="../include/footer.jsp" %>
