<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

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

                <div class="row">
                    <div class="col-md-6">
                        <div class=" mx-2">
                            <!--loop this-->
                            <c:forEach var="item" items="${ORDERITEMLIST}">
                                <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(item.getProductID())}" />
                                <c:set var="product" value="${Shop_DB.getProductByID(item.getProductID())}" />

                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div class="d-flex flex-row align-items-center">
                                                <div>
                                                    <img src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}" class="img-fluid rounded-3" style="width: 65px;">
                                                </div>
                                                <div class="ms-3">
                                                    <h5>${product.name}</h5>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-row align-items-center">
                                                <div class="mx-1" style="width: 70px;">
                                                    <input type="number" name="quantity" class="form-control" value="${item.quantity}" min="1" readonly>
                                                </div>
                                                <c:set var="totalPrice1" value="${item.quantity * item.price}" />
                                                <div class="mx-1" style="width: 80px;">
                                                    <h5 class="mb-0">${totalPrice1}</h5>
                                                </div>
                                                <c:set var="totalPrice" value="${totalPrice1 + totalPrice}" />
                                                <a class="mx-1" onclick="moveOutProductFromCart('${item.getOrderItem_id()}')" style="color: #cecece;"><i class="fas fa-trash-alt"></i></a>
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
                                <form action="confirmorder" method="post">
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
                                            <label class="form-label mt-3" for="typeText">Discount</label>
                                            <select id="discountSelect" class="form-control" name="discountSelect" onchange="updateDiscount()">
                                                <c:forEach var="discount" items="${discountlist}">
                                                    <option value="${discount.discountId}" data-percent="${discount.discountPercent}" data-condition="${discount.condition}">Giảm ${discount.discountPercent}% đơn từ ${discount.condition}VNĐ</option>
                                                </c:forEach>
                                            </select>

                                            <input type="hidden" id="selectedPercent" name="percent" value="0" />

                                            <label class="form-label mt-3" for="typeText">Note</label>
                                            <input name="note" class="form-control" placeholder="Note" rows="4">
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-between mt-3">
                                        <p class="mb-2">Sub total</p>
                                        <p class="mb-2">${totalPrice} VND</p>
                                    </div>

                                    <div class="d-flex justify-content-between">
                                        <p class="mb-2">Discount fee</p>
                                        <p class="mb-2" id="discountFee">-0 VND</p>
                                    </div>

                                    <div class="d-flex justify-content-between mb-4">
                                        <p class="mb-2">Total</p>
                                        <p class="mb-2" id="totalFee">${totalPrice} VND</p>
                                    </div>

                                    <div class="mb-3" hidden="">
                                        <label class="form-label">Total</label>
                                        <input type="text" class="form-control" id="totalInput" name="total" value="${totalPrice}">
                                    </div>
                                    <input type="hidden" name="action" value="confirm1">
                                    <div class="d-flex justify-content-between">
                                        <button type="submit" class="btn btn-info btn-block btn-lg">
                                            <span id="checkoutTotal">${totalPrice} VND</span>
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
    <script>
        function moveOutProductFromCart(id) {
            console.log("OrderItem ID to be removed:", id); // Log the product ID

            swal({
                title: "Are you sure?",
                text: "Once deleted, you will not be able to recover this item!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
                    .then((willDelete) => {
                        if (willDelete) {
                            console.log("User confirmed deletion");

                            $.ajax({
                                url: 'cart', // the URL to your server-side script that handles the removal
                                type: 'POST', // or 'GET' depending on your server-side handling
                                data: {id: id}, // the data to send to the server
                                dataType: 'json', // Expect a JSON response
                                success: function (response) {
                                    console.log("Server response:", response); // Log the server response

                                    // Handle the response from the server
                                    // Assuming the server responds with a success status
                                    if (response.success) {
                                        swal("Success! Your item has been removed from the cart!", {
                                            icon: "success",
                                        })
                                                .then(() => {
                                                    // Optionally, you can reload the page or update the cart UI dynamically
                                                    location.reload(); // Reloads the page to reflect changes
                                                });
                                    } else {
                                        console.error("Error response from server:", response); // Log the error response
                                        swal("Error! Unable to remove the item from the cart.", {
                                            icon: "error",
                                        });
                                    }
                                },
                                error: function (xhr, status, error) {
                                    console.error("AJAX error:", status, error); // Log the AJAX error
                                    swal("Error! Unable to remove the item from the cart.", {
                                        icon: "error",
                                    });
                                }
                            });
                        } else {
                            console.log("User cancelled deletion");
                            swal("Your item is safe!");
                        }
                    });
        }

        // Assuming totalPrice is available in the script scope
        var totalPrice = ${totalPrice};

        // Function to update the discount options
        function filterDiscounts() {
            var select = document.getElementById("discountSelect");
            var options = select.options;

            // Loop through options and remove those with condition <= totalPrice
            for (var i = options.length - 1; i >= 0; i--) {
                var condition = parseFloat(options[i].getAttribute("data-condition"));
                if (condition > totalPrice) {
                    select.remove(i);
                }
            }
        }

        // Function to update the discount fee
        function updateDiscount() {
            var select = document.getElementById("discountSelect");
            var selectedOption = select.options[select.selectedIndex];
            var percent = parseFloat(selectedOption.getAttribute("data-percent"));
            document.getElementById("selectedPercent").value = percent;

            var discountFee = (percent * totalPrice / 100).toFixed(2);
            document.getElementById("discountFee").textContent = '-' + discountFee + ' VND';

            var newTotal = totalPrice - discountFee;
            document.getElementById("totalFee").textContent = newTotal.toFixed(2) + ' VND';
            document.getElementById("checkoutTotal").textContent = newTotal.toFixed(2) + ' VND';
            document.getElementById("totalInput").value = newTotal.toFixed(2);
        }

        // Call filterDiscounts on page load to remove invalid discounts
        window.onload = function () {
            filterDiscounts();
            updateDiscount(); // Update the discount fee after filtering
        }
    </script>
</body>
<script src="../static/js/validation.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%@ include file="../include/footer.jsp" %>