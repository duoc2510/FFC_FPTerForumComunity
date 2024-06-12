<%-- 
    Document   : allProduct
    Created on : May 31, 2024, 8:00:58 AM
    Author     : Admin
--%>

<%-- 
    Document   : allShop
    Created on : May 27, 2024, 9:02:58 PM
    Author     : Admin
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
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


                <div class="col-lg-12">
                    <div class="w-100 row">
                        <c:forEach var="shop" items="${shoplist}" >
                            <div class="col-md-4">
                                <div class="card mx-1">
                                    <a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}" data-toggle="modal" data-target="#productID1">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/static/${shop.getImage()}">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="card-title"><a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?id=${shop.shopID}">${shop.getName()}</a></h5>
                                        <p class="card-text"><a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?id=${shop.shopID}">Phone : ${shop.getPhone()}</a></p>
                                        <p class="card-text"><a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?id=${shop.shopID}">Campus : ${shop.getCampus()}</a></p>
                                        <p class="card-text"><a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?id=${shop.shopID}">Giới Thiệu : ${shop.getDescription()}</a></p>
                                        <a href="#" class="btn btn-primary mt-3 w-100">Message</a>
                                    </div>

                                </div>
                            </div>
                        </c:forEach>

                    </div>
                </div>
            </div>
        </div>
</body>
<%@ include file="../include/footer.jsp" %>