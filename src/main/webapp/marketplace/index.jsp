<%-- 
    Document   : index
    Created on : May 25, 2024, 9:43:06 PM
    Author     : mac
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
    .card-img-top{
        height:250px;
        object-fit: cover;
    }
    .card-text{
        text-overflow: ellipsis;
        white-space: nowrap;
        width: 200px;
        overflow: hidden;
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
                <div class="col-lg-12 mb-4">
                    <ul class="nav nav-pills nav-fill">
                        <li class="nav-item">
                            <a class="nav-link" href="#">All product</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="#">My product</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#">Check progress</a>
                        </li>

                    </ul>
                </div>


                <div class="col-lg-12 ">
                    <!--Tao shop-->
                    <%--<%@ include file="createShop.jsp" %>--%>
                    
                    <!--Xem tat ca san pham cua minh-->
                    <%--<%@ include file="myProduct.jsp" %>--%>
                    
                     <!--Tao san pham -->
                    <%--<%@ include file="createProduct.jsp" %>--%>

                    <!--Xem tat ca san pham-->
                    <%--<%@ include file="allProduct.jsp" %>--%>

                    <!--Xem tien trinh giao hang -->
                    <%@ include file="checkProgress.jsp" %>
                </div>
            </div>
        </div>
    </div>


    <%@ include file="../include/footer.jsp" %>



