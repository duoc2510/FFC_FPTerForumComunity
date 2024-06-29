<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*" %>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<body>
    <c:choose>
        <c:when test="${empty sessionScope.USER}">
            <%@ include file="../index_guest.jsp" %>
        </c:when>
        <c:otherwise>
            <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
                 data-sidebar-position="fixed" data-header-position="fixed">
                <%@ include file="../include/slidebar.jsp" %>
                <div class="body-wrapper">
                    <%@ include file="../include/navbar.jsp" %>
                    <div class="container-fluid d-flex">
                        <div class="col-lg-12 w-100">
                            <div id="report-sections">
                                <div id="reported-posts-section">
                                    <h2>List of shops waiting for approval</h2>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Owner</th>
                                                <th>Shop Name</th>
                                                <th>Shop Phone</th>
                                                <th>Shop Campus</th>
                                                <th>Shop Description</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <c:set var="shopapprovelist" value="${Shop_DB.getAllShopHaveStatusIs2()}" />
                                        <tbody>
                                            <c:if test="${empty shopapprovelist}">
                                                <tr>
                                                    <td colspan="6">
                                                        <p>There aren't any shops needing approval.</p>
                                                    </td>
                                                </tr>
                                            </c:if>
                                            <c:forEach var="shop" items="${shopapprovelist}">
                                                <c:set var="user" value="${User_DB.getUserById(shop.ownerID)}" />
                                                <tr>
                                                    <td>${user.userFullName}</td>
                                                    <td>${shop.name}</td>
                                                    <td>${shop.phone}</td>
                                                    <td>${shop.campus}</td>
                                                    <td>${shop.description}</td>
                                                    <td>
                                                        <button class="btn btn-success approve-btn" data-shop-id="${shop.shopID}">Approve</button>
                                                        <button class="btn btn-danger not-approve-btn" data-shop-id="${shop.shopID}">Not Approve</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    <%@ include file="../include/footer.jsp" %>
    <script>
        // Approve button click event
        document.querySelectorAll('.approve-btn').forEach(button => {
            button.addEventListener('click', function () {
                const shopId = this.getAttribute('data-shop-id');
                handleShopApproval(shopId, 'approve');
            });
        });

        // Not Approve button click event
        document.querySelectorAll('.not-approve-btn').forEach(button => {
            button.addEventListener('click', function () {
                const shopId = this.getAttribute('data-shop-id');
                handleShopApproval(shopId, 'not-approve');
            });
        });

        // Function to handle shop approval
        function handleShopApproval(shopId, action) {
            const url = `${pageContext.request.contextPath}/admin/approveshop`;
            const params = new URLSearchParams();
            params.append('shopId', shopId);
            params.append('action', action);

            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params.toString()
            })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            swal("Success", data.message, "success").then(() => {
                                location.reload();
                            });
                        } else {
                            swal("Error", data.message, "error");
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        swal("Error", "An error occurred. Please try again.", "error");
                    });
        }
    </script>
</body>
</html>
