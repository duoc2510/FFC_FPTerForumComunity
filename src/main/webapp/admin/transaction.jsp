<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
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
                    <h2 class="mb-4">Danh sách thanh toán</h2>
                    <table class="table table-striped table-bordered">
                        <thead class="thead-dark">
                            <tr>
                                <th>ATM Number</th>
                                <th>ATM Name</th>
                                <th>ATM Bank</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>User</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="payment" items="${payments}">
                                <tr>
                                    <td>${payment.atmNumber}</td>
                                    <td>${payment.atmName}</td>
                                    <td>${payment.atmBank}</td>
                                    <td>${payment.amount}</td>
                                    <td>${payment.status}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/profile?username=${payment.username}">${payment.username}</a>
                                    </td>
                                    <td>
                                        <c:if test="${payment.status eq 'Pending'}">
                                            <form action="${pageContext.request.contextPath}/admin/transaction" method="post" class="form-inline">
                                                <input type="hidden" name="paymentId" value="${payment.paymentId}">
                                                <select name="newStatus" class="form-control mr-2">
                                                    <option value="Pending">Pending</option>
                                                    <option value="Accept">Accept</option>
                                                    <option value="Denied">Denied</option>
                                                </select>
                                                <button type="submit" class="btn btn-primary">Cập nhật trạng thái</button>
                                            </form>
                                        </c:if>
                                        <ul class="list-group mt-3">
                                            <c:forEach var="notification" items="${Shop_DB.getBalanceNotificationsByUserId(payment.userId)}">
                                                <li class="list-group-item">
                                                    <div class="content">
                                                        <a style="color: black;" class="message">${notification.message}</a>
                                                        <p class="date">${notification.date}</p>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    <%@ include file="../include/footer.jsp" %>
</body>