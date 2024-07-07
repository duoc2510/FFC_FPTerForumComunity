<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ include file="../include/header.jsp" %>

<style>
    .shop-group {
        padding: 20px; /* Padding inside the box */
        margin-bottom: 20px; /* Space between shop groups */
    }

    .shop-name a {
        color: inherit; /* Màu chữ sẽ kế thừa từ thẻ cha (.shop-name) */
        text-decoration: none; /* Bỏ gạch chân mặc định của liên kết */
    }

    .shop-name a:hover {
        color: inherit; /* Màu chữ khi hover, kế thừa từ thẻ cha (.shop-name) */
    }

    .shop-name a:visited {
        color: inherit; /* Màu chữ của liên kết đã truy cập, kế thừa từ thẻ cha (.shop-name) */
    }
    .responsive-text {
        font-size: calc(2px + 0.8vw);
        min-font-size: 5px;
        max-font-size: 12px;
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


                <!--check bag is empty-->
                <c:if test="${empty ORDERITEMLIST}">
                    <style>
                        #billing{
                            display: none;
                        }
                    </style>
                    <div class='row mt-5 '>
                        <div class='col-12 mx-auto text-center rounded'>
                            <img src="${pageContext.request.contextPath}/static/images/bag-empty.jpg" alt="alt" width='200px'/>
                            <h1 class="text-uppercase text-bold my-3">bag is empty</h1>
                        </div>
                    </div>

                </c:if>

                <c:if test="${not empty message}">
                    <%
                        session.removeAttribute("message");
                    %>
                </c:if>

                <c:if test="${not empty ORDERITEMLIST}">
                    <div class="row card-group" id="billing">                    
                        <div class="col-md-6 rounded">
                            <div class="mx-3 ">
                                <!--loop this-->
                                <form action="confirmorder" method="post">

                                    <c:set var="previousShopId" value="-1" />
                                    <c:forEach var="item" items="${ORDERITEMLIST}">
                                        <c:set var="product" value="${Shop_DB.getProductByID(item.getProductID())}" />
                                        <c:set var="currentShopId" value="${product.shopId}" />

                                        <c:if test="${previousShopId != currentShopId}">
                                            <c:if test="${previousShopId != -1}">
                                                <!-- Close the previous shop group and add discount/total sections -->
                                                <div id="discountSection-${previousShopId}" style="display: none;">
                                                    <label class="form-label mt-3" for="typeText">Discount</label>
                                                    <select id="discountSelect-${previousShopId}" class="rounded form-control discountSelect" name="discountSelect" data-shop-id="${previousShopId}" onchange="updateDiscount('${previousShopId}')">
                                                        <option value="" data-percent="0" data-condition="0">No Discount</option>
                                                        <c:forEach var="discount" items="${Shop_DB.getAllDiscountOrder(USER.userId, previousShopId)}">
                                                            <option value="${discount.discountId}" data-percent="${discount.discountPercent}" data-condition="${discount.condition}">Giảm ${discount.discountPercent}% đơn từ ${discount.condition}VNĐ</option>
                                                        </c:forEach>
                                                    </select>

                                                </div>
                                                <hr>
                                                <div class="d-flex justify-content-between mt-3">
                                                    <p class="mb-2">Sub total</p>
                                                    <p class="mb-2" id="subtotal-${previousShopId}">0 VND</p>
                                                </div>

                                                <div class="d-flex justify-content-between">
                                                    <p class="mb-2">Discount fee</p>
                                                    <p class="mb-2" id="discountFee-${previousShopId}">-0 VND</p>
                                                </div>
                                                <div class="d-flex justify-content-between mb-4">
                                                    <p class="mb-2">Total</p>
                                                    <p class="mb-2" id="totalFee-${previousShopId}">0 VND</p>
                                                </div>
                                        </div> <!-- Close the previous shop group -->
                                    </c:if>
                                    <div class="shop-group rounded shadow rounded border">
                                        <h3 class="shop-name">
                                            <a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${currentShopId}">
                                                <i class="ti ti-basket"></i> <!-- Icon before -->
                                                ${Shop_DB.getShopHaveStatusIs1ByShopID(currentShopId).getName()}
                                                <i class="ti ti-arrow-right-square"></i> <!-- Icon after -->
                                            </a>
                                        </h3>
                                        <hr>
                                    </c:if>

                                    <div class="shadow mb-3 rounded ">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <div class="d-flex flex-row align-items-center">
                                                    <div>
                                                        <input type="checkbox" class="orderItemCheckbox" name="selectedItems" value="${item.getOrderItem_id()}" data-item-id="${item.getOrderItem_id()}" data-item-price="${item.price}" data-item-quantity="${item.quantity}" data-product-quantity="${product.quantity}" data-product-id="${item.getProductID()}" data-shop-id="${currentShopId}" />
                                                    </div>
                                                    <div>
                                                        <img src="${pageContext.request.contextPath}/static/${Shop_DB.getUploadFirstByProductID(item.getProductID()).uploadPath}" class="img-fluid rounded-3" style="width: 65px;">
                                                    </div>
                                                    <div class="ms-3">
                                                        <h5>${product.name}</h5>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-row align-items-center">
                                                    <div class="mx-1" style="width: 70px;">
                                                        <c:if test="${product.quantity > 0}">
                                                            <input data-action="update" type="number" name="quantity" class="rounded form-control" value="${item.quantity}" min="1" max="${product.quantity}" oninput="handleQuantityChange('${item.getOrderItem_id()}', this.value)">
                                                            <c:if test="${item.quantity == product.quantity}">
                                                                <p class="text-danger position-absolute">Quantity was maximum</p>
                                                            </c:if>
                                                        </c:if>
                                                        <c:if test="${product.quantity == 0}">
                                                            <input type="number" class="rounded form-control" name="quantity" value="0" readonly>
                                                            <p style="font-size: 11px;" class="text-danger position-absolute">This product had sold out! Please delete!</p>
                                                        </c:if>
                                                    </div>
                                                    <c:set var="totalPrice1" value="${item.quantity * item.price}" />
                                                    <div class="mx-1" style="width: 80px; display: flex; justify-content: center; align-items: center;">
                                                        <h5 class="mb-0 responsive-text">${totalPrice1}</h5>
                                                    </div>
                                                    <c:set var="totalPrice" value="${totalPrice1 + totalPrice}" />
                                                    <a class="mx-1" onclick="moveOutProductFromCart('${item.getOrderItem_id()}')" data-action="delete">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <c:set var="previousShopId" value="${currentShopId}" />
                                </c:forEach>

                                <!-- Close the last shop group -->
                                <c:if test="${previousShopId != -1}">
                                    <div id="discountSection-${previousShopId}" style="display: none;">
                                        <label class="form-label mt-3" for="typeText">Discount</label>
                                        <select id="discountSelect-${previousShopId}" class="rounded form-control discountSelect" name="discountSelect" data-shop-id="${previousShopId}" onchange="updateDiscount('${previousShopId}')">
                                            <option value="" data-percent="0" data-condition="0">No Discount</option>
                                            <c:forEach var="discount" items="${Shop_DB.getAllDiscountOrder(USER.userId, previousShopId)}">
                                                <option value="${discount.discountId}" data-percent="${discount.discountPercent}" data-condition="${discount.condition}">Giảm ${discount.discountPercent}% đơn từ ${discount.condition}VNĐ</option>
                                            </c:forEach>
                                        </select>

                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between mt-3">
                                        <p class="mb-2">Sub total</p>
                                        <p class="mb-2" id="subtotal-${previousShopId}">0 VND</p>
                                    </div>

                                    <div class="d-flex justify-content-between">
                                        <p class="mb-2">Discount fee</p>
                                        <p class="mb-2" id="discountFee-${previousShopId}">-0 VND</p>
                                    </div>
                                    <div class="d-flex justify-content-between mb-4">
                                        <p class="mb-2">Total</p>
                                        <p class="mb-2" id="totalFee-${previousShopId}">0 VND</p>
                                    </div>
                                </c:if>



                            </div> <!-- Close the last shop group -->
                            <!--loop this-->
                        </div>
                    </div>

                    <div class="col-md-6 pe-3">
                        <div class=" rounded shadow border card-group">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h5 class="mb-0">Billing</h5>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-outline form-white">
                                        <label class="form-label" for="typeText">Full Name </label>
                                        <input name="fullname" class="rounded form-control" placeholder="Full Name" value="${USER.userFullName}" readonly> 

                                        <label class="form-label mt-3" for="typeText">Phone</label>
                                        <input name="phone" class="rounded form-control" placeholder="Phone" required>

                                        <c:set var="shop" value="${Shop_DB.getShopHaveStatusIs1ByShopID(product.getShopId())}" />
                                        <label hidden class="form-label mt-3" for="typeText">Shop</label>
                                        <input name="shopid" class="rounded form-control" placeholder="shopid" value="${shop.shopID}" hidden>

                                        <label class="form-label mt-3" for="typeText">Campus</label>
                                        <input name="campus" class="rounded form-control" placeholder="Campus" value="${shop.campus}" readonly>


                                        <label class="form-label mt-3" for="typeText">Note</label>
                                        <input name="note" class="rounded form-control" placeholder="Note" rows="4">
                                    </div>
                                </div>





                                <div class="mb-3" hidden="">
                                    <label class="form-label">Total</label>
                                    <input type="text" class="rounded form-control" id="totalInput" name="total" value="0">
                                </div>
                                <input type="hidden" name="action" value="confirm1">
                                <div class="d-flex justify-content-between">
                                    <button stype="submit" class="rounded btn btn-info btn-block btn-lg mt-4">
                                        <span id="checkoutTotal">0 VND</span>
                                        <span>Checkout <i class="fas fa-long-arrow-alt-right ms-2"></i></span>
                                    </button>                                                    
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<!--<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>-->

<script>
    function listenForQuantityChange(){
        console.log(1);
         loadAd();
    }
                                            var selectedItemsMap = new Map();
                                            var selectedDiscounts = [];

                                            function handleQuantityChange(orderItemId, newQuantity) {
                                                // Nếu newQuantity là null hoặc rỗng, gán giá trị là 0
                                                if (!newQuantity) {
                                                    newQuantity = 0;
                                                }

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

                                            function updateSummary(shopId) {
                                                var subtotal = 0;
                                                var selectedItems = selectedItemsMap.get(shopId) || new Set();

                                                selectedItems.forEach(function (item) {
                                                    subtotal += item.quantity * item.price;
                                                });

                                                var subtotalElement = document.getElementById("subtotal-" + shopId);
                                                var discountSection = document.getElementById("discountSection-" + shopId);
                                                var discountSelect = document.getElementById("discountSelect-" + shopId);
                                                var discountFeeElement = document.getElementById("discountFee-" + shopId);
                                                var totalFeeElement = document.getElementById("totalFee-" + shopId);

                                                if (!subtotalElement || !discountSection || !discountSelect || !discountFeeElement || !totalFeeElement) {
                                                    console.error(`Missing elements for shopId: ${shopId}`);
                                                    return;
                                                }

                                                subtotalElement.textContent = subtotal.toFixed(2) + ' VND';

                                                discountSection.style.display = selectedItems.size === 0 ? 'none' : 'block';
                                                discountSelect.disabled = selectedItems.size === 0;
                                                if (selectedItems.size === 0) {
                                                    discountSelect.value = ""; // Reset discount to "No Discount"
                                                }
                                                filterDiscountOptions(shopId, subtotal);
                                                updateDiscount(shopId);
                                            }

                                            function filterDiscountOptions(shopId, subtotal) {
                                                var discountSelect = document.getElementById("discountSelect-" + shopId);

                                                if (!discountSelect) {
                                                    console.error(`Missing discountSelect element for shopId: ${shopId}`);
                                                    return;
                                                }

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

                                            function updateDiscount(shopId) {
                                                var discountSelect = document.getElementById("discountSelect-" + shopId);
                                                var subtotalElement = document.getElementById("subtotal-" + shopId);
                                                var discountFeeElement = document.getElementById("discountFee-" + shopId);
                                                var totalFeeElement = document.getElementById("totalFee-" + shopId);

                                                if (!discountSelect || !subtotalElement || !discountFeeElement || !totalFeeElement) {
                                                    console.error(`Missing elements for shopId: ${shopId}`);
                                                    return;
                                                }

                                                var selectedOption = discountSelect.options[discountSelect.selectedIndex];
                                                var subtotal = parseFloat(subtotalElement.textContent);
                                                var discountFee = 0;

                                                if (selectedOption && selectedOption.value !== "") {
                                                    var percent = parseFloat(selectedOption.getAttribute("data-percent"));
                                                    discountFee = (percent * subtotal / 100).toFixed(2);
                                                    discountFeeElement.textContent = '-' + discountFee + ' VND';
                                                } else {
                                                    discountFeeElement.textContent = '-0.00 VND';
                                                }

                                                var newTotal = subtotal - parseFloat(discountFee);
                                                totalFeeElement.textContent = newTotal.toFixed(2) + ' VND';

                                                updateCheckoutTotal();

                                                // Update selected discounts array
                                                var discountId = selectedOption && selectedOption.value !== "" ? selectedOption.value : "0";
                                                var existingDiscount = selectedDiscounts.find(discount => discount.shopId === shopId);
                                                if (existingDiscount) {
                                                    existingDiscount.discountId = discountId;
                                                    existingDiscount.total = newTotal;
                                                } else {
                                                    selectedDiscounts.push({shopId: shopId, discountId: discountId, total: newTotal});
                                                }
                                            }

                                            function updateCheckoutTotal() {
                                                var totalFees = 0;
                                                document.querySelectorAll('[id^="totalFee-"]').forEach(function (totalFeeElement) {
                                                    var total = parseFloat(totalFeeElement.textContent);
                                                    if (!isNaN(total)) {
                                                        totalFees += total;
                                                    }
                                                });

                                                document.getElementById("checkoutTotal").textContent = totalFees.toFixed(2) + ' VND';
                                                document.getElementById("totalInput").value = totalFees.toFixed(2);
                                            }

                                            document.addEventListener("DOMContentLoaded", (event) => {
                                                var checkboxes = document.querySelectorAll('.orderItemCheckbox');
                                                checkboxes.forEach(function (checkbox) {
                                                    checkbox.addEventListener('change', function () {
                                                        var itemId = this.dataset.itemId;
                                                        var shopId = this.getAttribute("data-shop-id");
                                                        var item = {
                                                            id: this.dataset.itemId,
                                                            price: parseFloat(this.dataset.itemPrice),
                                                            quantity: parseInt(this.dataset.itemQuantity),
                                                            productQuantity: parseInt(this.dataset.productQuantity)
                                                        };

                                                        if (!selectedItemsMap.has(shopId)) {
                                                            selectedItemsMap.set(shopId, new Set());
                                                        }

                                                        var selectedItems = selectedItemsMap.get(shopId);

                                                        if (this.checked) {
                                                            selectedItems.add(item);
                                                        } else {
                                                            selectedItems.forEach(function (selectedItem) {
                                                                if (selectedItem.id === item.id) {
                                                                    selectedItems.delete(selectedItem);
                                                                }
                                                            });
                                                        }

                                                        updateSummary(shopId);
                                                    });
                                                });

                                                // Initial call to hide the discount select box if no items are selected
                                                checkboxes.forEach(function (checkbox) {
                                                    var shopId = checkbox.getAttribute("data-shop-id");
                                                    updateSummary(shopId);
                                                });
                                            });

// Append discount information to the form before submission
                                            document.querySelector('form[action="confirmorder"]').addEventListener('submit', function (e) {
                                                var discountInput = document.createElement('input');
                                                discountInput.type = 'hidden';
                                                discountInput.name = 'selectedDiscounts';
                                                discountInput.value = JSON.stringify(selectedDiscounts);
                                                this.appendChild(discountInput);
                                            });

                                            window.onload = function () {
                                                listenForQuantityChange();
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

</body>
<script src="../static/js/validation.js"></script>
<%@ include file="../include/footer.jsp" %>