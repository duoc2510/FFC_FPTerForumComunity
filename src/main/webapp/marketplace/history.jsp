<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ include file="../include/header.jsp" %>
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

                <c:set var="orderlist" value="${Shop_DB.getAllOrdersByUserID(USER.userId)}" />
                <div class="col-lg-12">
                    <div class="w-100 row">
                        <div class="card">
                            <div class="tab-pane card-body fade active show" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab" tabindex="0">
                                <table class="table table-responsive table-bordered">
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

                                    <tbody>
                                        <c:forEach var="order" items="${orderlist}">

                                            <tr>
                                                <td>${order.orderDate}</td>
                                                <td>${USER.userFullName}</td>
                                                <td>${order.receiverPhone}</td>
                                                <td>${order.note}</td>
                                                <c:set var="orderitemlistbyid" value="${Shop_DB.getAllOrderItemByOrderID(order.order_ID)}" />   
                                                <td>
                                                    <c:forEach var="orderitem" items="${orderitemlistbyid}">
                                                        <c:set var="productitem" value="${Shop_DB.getProductByID(orderitem.productID)}" />
                                                        - ${productitem.name} : ${orderitem.quantity} <br> 
                                                    </c:forEach>
                                                </td>
                                                <td>${order.total}</td>

                                                <c:if test="${order.status eq 'Pending'}">
                                                    <td>
                                                        <input type="text" class="form-control" name="role" value="Đang chờ Shop xác nhận." readonly>

                                                        <form action="product" method="post">
                                                            <input type="text" name="orderid" value="${order.order_ID}" hidden/>
                                                            <input type="text" name="action" value="huydon" hidden/>
                                                            <button type="submit" class="btn btn-secondary">Hủy Đơn Hàng</button>
                                                        </form>
                                                    </td>
                                                </c:if>
                                                <c:if test="${order.status eq 'Accept'}">
                                                    <td>
                                                        <input type="text" class="form-control" name="role" value="Đơn đã được xác nhận và sẽ sớm gửi đến bạn." readonly>
                                                    </td>
                                                </c:if>
                                                <c:if test="${order.status eq 'Completed'}">
                                                    <td>
                                                        <form action="product" method="post">
                                                            <input type="text" name="orderid" value="${order.order_ID}" hidden/>
                                                            <input type="text" name="action" value="danhanhang" hidden/>
                                                            <button type="submit" class="btn btn-primary">Vui lòng bấm đã nhận hàng.</button>
                                                        </form>

                                                    </td>
                                                </c:if>
                                                <c:if test="${order.status eq 'Cancelled'}">
                                                    <td>
                                                        <input type="text" class="form-control" name="role" value="Đơn hàng bị hủy" readonly>
                                                    </td>
                                                </c:if>
                                                <c:if test="${order.status eq 'Success'}">
                                                    <td>
                                                        <input type="text" class="form-control" name="role" value="Success" readonly>
                                                    </td>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>
                </div>


                </body>
                <%@ include file="../include/footer.jsp" %>