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
                        <div class="col-md-12 p-2">
                            <h2>Create Your Brand To Have More Income</h2>
                            <img class="w-100 rounded" src="${pageContext.request.contextPath}/static/images/bannerShop.jpg"/>
                        </div>
                    </div>
                    <div class="w-100 row">
                        <div class="col-md-12 p-2">

                            <form action="myshop" method="POST">
                                <div class="mb-3">
                                    <label for="shopName" class="form-label">Shop Name</label>
                                    <input type="text" class="form-control" id="shopName" name="shopName" />
                                </div>

                                <div class="mb-3">
                                    <label for="campus" class="form-label">Campus</label>
                                    <select class="form-select form-control" aria-label="ConsciousSelect" id="campus" name="campus">
                                        <option value="Campus Ha Noi">Ha Noi</option>
                                        <option value="Campus Can Tho">Can Tho</option>
                                        <option value="Campus Quy Nhon">Quy Nhon</option>
                                        <option value="Campus Da Nang">Da Nang</option>
                                        <option value="Campus Ho Chi Minh">TP. HCM</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label for="shopPhone" class="form-label">Shop Phone</label>
                                    <input type="text" class="form-control" id="shopPhone" name="shopPhone">
                                </div>

                                <div class="mb-3">
                                    <label for="shopDescription" class="form-label">Shop Description</label>
                                    <input type="text" class="form-control" id="shopDescription" name="shopDescription">
                                </div>
                                <button type="submit" class="btn btn-primary float-end">Create</button>
                            </form>

                        </div>
                    </div>

                    <script>
                        //      Message error
                        document.addEventListener("DOMContentLoaded", function (event) {
                            // Ensure your DOM is fully loaded before executing any code
                            var errorMessage = "${requestScope.message}";
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
                    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

                    <%@ include file="../include/footer.jsp" %>