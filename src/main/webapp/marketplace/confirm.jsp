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
                        <div class="row">
                            <div class="mx-2">
                                <div class="card mb-3">

                                    <div class="card-header">
                                        <div class="text-center p-2 px-5" style="padding-top: 30px !important;">
                                            <img src="/FPTer/static/images/logo.png" width="100" alt="">
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="invoice p-5">
                                            <c:set var="shop" value="${Shop_DB.getShopHaveStatusIs1ByShopID(shopid)}" />
                                            <h5>Your order Confirmed!</h5>
                                            <span class="font-weight-bold d-block mt-4">Hello,${fullname} </span>
                                            <span>The order will not be changed if you confirm!</span>

                                            <div class="payment border-top mt-3 mb-3 border-bottom table-responsive">

                                                <table class="my-3">

                                                    <tbody class="table table-reponsive mx-0">
                                                        <tr>
                                                            <td>
                                                                <div class="py-2">

                                                                    <span class="d-block text-muted">Shop Name:</span>
                                                                    <span>${shop.name}</span>

                                                                </div>
                                                            </td>

                                                            <td>
                                                                <div class="py-2">
                                                                    <span class="d-block text-muted">Shop Phone:</span>
                                                                    <span> ${shop.phone}</span>
                                                                </div>
                                                            </td>

                                                            <td>
                                                                <div class="py-2">
                                                                    <span class="d-block text-muted">Shop campus:</span>
                                                                    <span>${shop.campus}</span>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <div class="my-2">
                                                <c:forEach var="item" items="${ORDERITEMLIST}">
                                                    <c:set var="imagefirst" value="${Shop_DB.getUploadFirstByProductID(item.getProductID())}" />
                                                    <c:set var="product" value="${Shop_DB.getProductByID(item.getProductID())}" />
                                                    <div class="d-flex justify-content-between mx-3">
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
                                                                <input type="number" name="quantity" class="form-control" value="${item.quantity}" min="1" readonly="">
                                                            </div>
                                                            <c:set var="totalPrice1" value="${item.quantity * item.price}" />
                                                            <div class="mx-1" style="width: 80px;">
                                                                <h5 class="mb-0">${totalPrice1}</h5>
                                                            </div>
                                                            <c:set var="totalPrice" value="${totalPrice1 + totalPrice}" />

                                                        </div>
                                                    </div>
                                                </c:forEach>

                                            </div>

                                            <style>
                                                .text-right{
                                                    margin: 0 20px;
                                                }
                                                .text-right span{
                                                    text-align: right;
                                                }
                                            </style>

                                            <div class="row d-flex justify-content-end mt-5">
                                                <div class="col-md-6 d-flex justify-content-end">
                                                    <table>
                                                        <tbody class="totals">
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

                                                            <c:set var="discount" value="${Shop_DB.getDiscountByID(discountId)}" />
                                                            <tr>
                                                                <td>
                                                                    <div class="text-left">
                                                                        <span class="text-muted">Discount Fee</span>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-right">
                                                                        <span> -${totalPrice*discount.discountPercent/100} VND</span>
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
                                                                        <span class="font-weight-bold text-success">=${total}VNĐ</span>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="payment border-top mt-3 mb-3">



                                                <table class="table">

                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <div class="py-2">

                                                                    <span class="d-block text-muted">Order Receiver:</span>
                                                                    <span>${fullname}</span>

                                                                </div>
                                                            </td>

                                                            <td>
                                                                <div class="py-2">
                                                                    <span class="d-block text-muted">Order Date:</span>
                                                                    <span> ${date}</span>
                                                                </div>
                                                            </td>

                                                            <td>
                                                                <div class="py-2">
                                                                    <span class="d-block text-muted">Receiver Phone</span>
                                                                    <span> ${phone}</span>
                                                                </div>
                                                            </td>

                                                            <td>
                                                                <div class="py-2">
                                                                    <span class="d-block text-muted">Note :</span>
                                                                    <span>${note}</span>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="d-flex w-100 justify-content-end row">
                                                <p class="col-6">If you really want to buy, click the confirmation button!</p>
                                                <div class="col-6 d-flex justify-content-end">
                                                    <form action="confirmorder" method="post">
                                                        <input type="hidden" name="shopid" value="${shop.shopID}">
                                                        <input type="hidden" name="fullname" value="${fullname}">
                                                        <input type="hidden" name="phone" value="${phone}">
                                                        <input type="hidden" name="campus" value="${campus}">
                                                        <input type="hidden" name="note" value="${note}">
                                                        <input type="hidden" name="date" value="${date}">
                                                        <input type="hidden" name="discountSelect" value="${discountId}">
                                                        <input type="hidden" name="total" value="${total}">
                                                        <input type="hidden" name="action" value="confirm2">
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
            </div>
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
