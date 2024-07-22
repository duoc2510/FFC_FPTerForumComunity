<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Page Title</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <!-- SweetAlert JS -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
    <script>
        // Check if the message variable is set or not
        document.addEventListener("DOMContentLoaded", (event) => {
            var errorMessage = "${message}";
            // Kiểm tra nếu errorMessage không rỗng, hiển thị thông báo lỗi
            if (errorMessage != "") {
                swal({
                    title: "Thanks for your order!",
                    text: errorMessage,
                    icon: "success",
                    button: "OK!",
                });
            }
        });
    </script>
    <style>
        .container-fluid .card img {
            aspect-ratio: 1 / 1;
            object-fit: cover;
        }
    </style>
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

                <c:if test="${not empty message}">
                    <%
                        session.removeAttribute("message");
                    %>
                </c:if>
                <div class="col-lg-12">
                    <div class="w-100 row">

                        <!--QUANG CAO MESSAGE-->
                        <%@ include file="shopAds.jsp" %>
                        <!--QUANG CAO MESSAGE-->


                        <c:forEach var="shop" items="${shoplist}">
                            <div class="col-md-4">
                                <div class="card mx-2">
                                    <a href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}">
                                        <img style="height: 100%" class="card-img-top" src="${pageContext.request.contextPath}/static/${shop.getImage()}">
                                    </a>
                                    <div class="card-body">
                                        <h5 style="text-align: center;" class="card-title"><a style="color: black; font-size: 20px; font-weight: bold;" href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}" class="text-decoration-none">${shop.getName()}</a></h5>
                                        <p class="card-text"><i class="fas fa-university me-2"></i><a style="color: black;" href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}" class="text-decoration-none">${shop.getCampus()}</a></p>
                                        <p class="card-text"><i class="fas fa-info-circle me-2"></i><a style="color: black;" href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}" class="text-decoration-none">${shop.getDescription()}</a></p>
                                        <p class="card-text"><i class="fas fa-phone-alt me-2"></i><a style="color: black;" href="${pageContext.request.contextPath}/marketplace/allshop/shopdetail?shopid=${shop.shopID}" class="text-decoration-none">${shop.getPhone()}</a></p>
                                        <a href="#" class="btn btn-primary mt-3 w-100"><i class="fas fa-envelope me-1"></i> Message</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
