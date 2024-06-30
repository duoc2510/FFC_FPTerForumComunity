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
                    <div class="col-md-12">
                        <div class="card mb-3">
                            <div class="card-header text-center">
                                <img src="/FPTer/static/images/logo.png" width="100" alt="">
                            </div>
                            <div class="card-body">
                                <div class="invoice p-5">
                                    <h5>Your order Confirmed!</h5>
                                    <span class="font-weight-bold d-block mt-4">Hello, ${fullname}</span>
                                    <span>The order will not be changed if you confirm!</span>
                                    <c:set var="totalfinal" value="0" />
                                    <c:forEach var="order" items="${orderList}">
                                        <c:set var="orderitemlist" value="${Shop_DB.getAllOrderItemByOrderID(order.order_ID)}" />
                                        <c:set var="firstItem" value="${orderitemlist[0]}" />
                                        <c:set var="product1" value="${Shop_DB.getProductByID(firstItem.getProductID())}" />
                                        <c:set var="shop1" value="${Shop_DB.getShopHaveStatusIs1ByShopID(product1.shopId)}" />

                                        <div class="border-top mt-3 mb-3 border-bottom">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <div class="py-2">
                                                                <span style="font-weight: bold;" class="d-block text-muted">Shop Name:</span>
                                                                <span>${shop1.name}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="py-2">
                                                                <span style="font-weight: bold;" class="d-block text-muted">Shop Phone:</span>
                                                                <span>${shop1.phone}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="py-2">
                                                                <span style="font-weight: bold;" class="d-block text-muted">Shop Campus:</span>
                                                                <span>${shop1.campus}</span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>

                                        <div class="my-2">
                                            <c:forEach var="item" items="${orderitemlist}">
                                                <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(item.getProductID())}" />
                                                <c:set var="product" value="${Shop_DB.getProductByID(item.getProductID())}" />
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <div class="d-flex align-items-center">
                                                        <img src="${pageContext.request.contextPath}/static/${imagefirst.uploadPath}" class="img-fluid rounded-3" style="width: 65px;">
                                                        <div class="ms-3">
                                                            <h5>${product.name}</h5>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex align-items-center">
                                                        <input type="number" name="quantity" class="form-control mx-1" value="${item.quantity}" min="1" readonly="">
                                                        <c:set var="totalPrice1" value="${item.quantity * item.price}" />
                                                        <h5 class="mb-0 mx-1">${totalPrice1}</h5>
                                                        <c:set var="totalPrice" value="${totalPrice1 + totalPrice}" />
                                                    </div>
                                                </div>
                                                <input type="hidden" name="selectedItems" value="${item.getOrderItem_id()}">
                                            </c:forEach>
                                        </div>

                                        <div class="row d-flex justify-content-end mt-5">
                                            <div class="col-md-6">
                                                <table class="table">
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <div class="text-left">
                                                                    <span class="text-muted">Subtotal</span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="text-right">
                                                                    <span>${totalPrice} VND</span>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <c:set var="discount" value="${Shop_DB.getDiscountByID(order.discountid)}" />
                                                        <tr>
                                                            <td>
                                                                <div class="text-left">
                                                                    <span class="text-muted">Discount Fee</span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="text-right">
                                                                    <span>- ${totalPrice * discount.discountPercent / 100} VND</span>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr class="border-top border-bottom">
                                                            <td>
                                                                <div class="text-left">
                                                                    <span class="font-weight-bold">Subtotal</span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="text-right">
                                                                    <span class="font-weight-bold text-success">=${order.total} VND</span>
                                                                </div>
                                                            </td>
                                                            <c:set var="totalfinal" value="${order.total + totalfinal}" />
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <div class="text-right font-weight-bold mb-3">Total Final: ${totalfinal} VND</div>
                                    <div class="border-top mt-3 mb-3">
                                        <table class="table">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <div class="py-2">
                                                            <span style="font-weight: bold;" class="d-block text-muted">Order Receiver:</span>
                                                            <span>${fullname}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="py-2">
                                                            <span style="font-weight: bold;" class="d-block text-muted">Order Date:</span>
                                                            <span>${date}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="py-2">
                                                            <span style="font-weight: bold;" class="d-block text-muted">Receiver Phone:</span>
                                                            <span>${phone}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="py-2">
                                                            <span style="font-weight: bold;" class="d-block text-muted">Note:</span>
                                                            <span>${note}</span>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="d-flex justify-content-end">
                                        <form action="confirmorder" method="post">
                                            <input type="hidden" name="fullname" value="${fullname}">
                                            <input type="hidden" name="phone" value="${phone}">
                                            <input type="hidden" name="note" value="${note}">
                                            <input type="hidden" name="date" value="${date}">
                                            <input type="hidden" name="total" value="${totalfinal}">
                                            <input type="hidden" name="action" value="confirm2">
                                            <c:forEach var="order" items="${orderList}">
                                                <input type="hidden" name="orderlist" value="${order.getOrder_ID()}">
                                            </c:forEach>
                                            <c:forEach var="item" items="${selectedOrderItems}">
                                                <input type="hidden" name="selectedItems" value="${item.getOrderItem_id()}">
                                            </c:forEach>
                                            <!-- Payment Options -->
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="cod" checked>
                                                <label class="form-check-label" for="cod">
                                                    Cash on Delivery
                                                </label>
                                            </div>
                                            <c:if test="${sessionScope.USER.userWallet >= totalfinal}">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="paymentMethod" id="systemWallet" value="systemWallet">
                                                    <label class="form-check-label" for="systemWallet">
                                                        System Wallet
                                                    </label>
                                                </div>
                                            </c:if>
                                            <button type="button" class="btn btn-danger mx-2" onclick="javascript:history.go(-1);">Back</button>
                                            <input type="submit" value="Confirm" class="btn btn-primary">
                                        </form>
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
<%@ include file="../include/footer.jsp" %>
