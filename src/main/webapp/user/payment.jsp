
<%@ include file="../include/header.jsp" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid">

                <div class="container mt-5">
                    <div class="card mb-4">
                        <div class="card-header">
                            Nạp Tiền
                        </div>
                        <div class="card-body">
                            <%-- Kiểm tra và hiển thị thông báo từ request attribute --%>
                            <c:if test="${not empty message}">
                                <div class="alert alert-dismissible alert-${message.startsWith('Nạp tiền') ? 'success' : 'danger'}">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <strong>${message}</strong>
                                </div>
                                <% session.removeAttribute("message"); %>                    
                            </c:if>
                            <form id="depositForm" action="${pageContext.request.contextPath}/payment" method="post">
                                <input type="hidden" name="action" value="napTien">
                                <div class="form-group">
                                    <label for="atmNumberDeposit">Số thẻ ATM:</label>
                                    <input type="text" class="form-control" id="atmNumberDeposit" name="atmNumber" required>
                                </div>
                                <div class="form-group">
                                    <label for="bankNameDeposit">Ngân hàng:</label>
                                    <select class="form-control" id="bankNameDeposit" name="bankName" required>
                                        <option value="MBBank">MB Bank</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="amountDeposit">Số tiền:</label>
                                    <input type="number" class="form-control" id="amountDeposit" name="amount" required>
                                </div>
                                <button type="button" class="btn btn-primary" id="openCodeModalBtn">Nạp Tiền</button>
                            </form>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-header">
                            Rút Tiền
                        </div>
                        <div class="card-body">
                            <form id="withdrawForm" action="${pageContext.request.contextPath}/payment" method="post">
                                <input type="hidden" name="action" value="rutTien">
                                <div class="form-group">
                                    <label for="atmNumberWithdraw">Số thẻ ATM:</label>
                                    <input type="text" class="form-control" id="atmNumberWithdraw" name="atmNumber" required>
                                </div>
                                <div class="form-group">
                                    <label for="bankNameWithdraw">Ngân hàng:</label>
                                    <select class="form-control" id="bankNameWithdraw" name="bankName" required>
                                        <option value="MBBank">MB Bank</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="amountWithdraw">Số tiền:</label>
                                    <input type="number" class="form-control" id="amountWithdraw" name="amount" required>
                                </div>
                                <button type="submit" class="btn btn-primary">Rút Tiền</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Modal for Account Code -->
                <div class="modal fade" id="accountCodeModal" tabindex="-1" role="dialog" aria-labelledby="accountCodeModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="accountCodeModalLabel">Nhập mã code của tài khoản</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="accountCodeForm">
                                    <div class="form-group">
                                        <label for="accountCodeInput">Mã code:</label>
                                        <input type="text" class="form-control" id="accountCodeInput" name="code" required>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                <button type="button" class="btn btn-primary" id="confirmAccountCodeBtn">Xác nhận</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bootstrap JS and jQuery -->
                <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

                <!-- Custom JavaScript -->
                <script>
                    $(document).ready(function () {
                        $('#openCodeModalBtn').click(function () {
                            $('#accountCodeModal').modal('show');
                        });

                        $('#confirmAccountCodeBtn').click(function () {
                            var accountCode = $('#accountCodeInput').val();
                            $('#accountCodeModal').modal('hide');

                            // Set account code to the hidden input and submit the form
                            $('#depositForm').append('<input type="hidden" name="code" value="' + accountCode + '">');
                            $('#depositForm').submit();
                        });
                    });
                </script>            
            </div>
        </div>
        <%@ include file="../include/right-slidebar.jsp" %>

    </div>
</body>
<%@ include file="../include/footer.jsp" %>

