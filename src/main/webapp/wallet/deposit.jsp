<%-- 
    Document   : deposit
    Created on : Jun 23, 2024, 11:36:27 AM
    Author     : mac
--%><%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><%@ include file="../include/header.jsp" %> <body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed"><%@ include file="../include/slidebar.jsp" %> <div class="body-wrapper"><%@ include file="../include/navbar.jsp" %> <div class="container-fluid pb-2">
                <div class="row ">
                    <div id="profile-wrapper">
                        <style>
                            .post {
                                border: 1px solid #ccc;
                                border-radius: 8px;
                                padding: 10px;
                                margin-bottom: 20px;
                            }

                            .post-header {
                                display: flex;
                                align-items: center;
                            }

                            .avatar {
                                width: 40px;
                                height: 40px;
                                border-radius: 50%;
                                margin-right: 10px;
                            }

                            .user-info {
                                display: flex;
                                flex-direction: column;
                            }

                            .user-name {
                                margin: 0;
                            }

                            .post-status {
                                margin: 5px 0 0;
                                color: #888;
                                font-size: 14px;
                            }

                            .post-content {
                                margin-top: 10px;
                            }

                            .post-content p {
                                margin: 0;
                            }

                            .post-image {
                                max-width: 100%;
                                height: auto;
                                margin-top: 10px;
                            }

                            .img-preview {
                                margin-top: 20px;
                            }

                            .img-preview img {
                                max-width: 100%;
                                max-height: 300px;
                            }

                            .profile img {
                                top: 20em;
                            }
                        </style>
                        <div class="bg-white shadow rounded overflow-hidden ">
                            <div class="px-4 py-4 cover cover " style="background: url(${pageContext.request.contextPath}/upload/deli-2.png); height:250px;">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}" class="position-absolute rounded-circle img-thumbnail" style="object-fit: cover;">
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center ">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0 position-relative" style="left: 6.5em">${USER.userFullName}</h4>
                                </div>
                                <ul class="list-inline mb-0"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid pt-0">
                <div class="row form-settings d-flex justify-content-between">
                    <div class="col-12 col-sm-5 px-2"><%@include file="menuWallet.jsp" %> </div>
                    <div class="col-12 col-sm-7 px-2">
                        <div class=" bg-white shadow rounded px-3 mb-4">
                            <div class="row d-flex justify-content-center">
                                <div class="card-body p-4">
                                    <div class="mb-4">
                                        <h3>Deposit</h3>
                                        <h6>Recharge yout wallet</h6>
                                    </div>
                                    <%-- Kiểm tra và hiển thị thông báo từ request attribute --%>
                                    <c:if test="${not empty message}">
                                        <div class="alert alert-dismissible alert-${message.startsWith('Nạp tiền') ? 'success' : 'danger'}">
                                            <strong>${message}</strong>
                                        </div>
                                        <% session.removeAttribute("message"); %>                    
                                    </c:if>
                                    <div class="form-group pb-3">
                                        <div class="d-flex flex-row align-items-center mb-4 pb-1">
                                            <img class="img-fluid" src="https://img.icons8.com/?size=50&id=209&format=png&color=000000" />
                                            <div class="flex-fill mx-3 d-flex">
                                                <div data-mdb-input-init class="form-outline col-11">
                                                    <input type="password" id="totalValue" class="form-control" value="${USER.userWallet}" readonly/>
                                                </div>
                                                <div class="col-1 d-flex justify-content-center align-items-center">
                                                    <a href="javascript:void(0)" onclick="showHideTotal()" id="showHideIcon"><i class="ti ti-eye"></i></a>
                                                </div>
                                            </div>                                    
                                        </div>
                                    </div>
                                    <form id="depositForm" action="${pageContext.request.contextPath}/payment" method="post">
                                        <input type="hidden" name="action" value="napTien">
                                        <div class="d-flex flex-row align-items-center mb-4 pb-1">
                                            <div class="flex-fill d-flex">
                                                <div class="form-outline col-8">
                                                    <label class="form-label" for="amountDeposit">Money</label>
                                                    <input type="number" class="form-control" id="amountDeposit" name="amount" required>
                                                </div>
                                                <div class="form-outline col-4" style="padding-left:2%">
                                                    <label class="form-label" for="formControlLgXc">Currency</label>
                                                    <input type="text"  class="form-control" value="VND" readonly/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-row align-items-center mb-4 pb-1">
                                            <div class="flex-fill d-flex">
                                                <div class="form-outline col-8">
                                                    <label class="form-label" for="bankNameDeposit">Ngân hàng:</label>
                                                    <select class="form-control" id="bankNameDeposit" name="bankName" required>
                                                        <option value="MBBank">MB Bank</option>
                                                    </select>                                                
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-row align-items-center mb-4 pb-1">
                                            <div class="flex-fill d-flex">
                                                <div class="form-outline col-8">
                                                    <label class="form-label" for="formControlLgXc">Card Number [MAIN]</label>
                                                    <input type="text" id="atmNumberDeposit" name="atmNumber" required class="form-control form-control" />                                              
                                                </div>
                                            </div>
                                        </div>
                                        <button data-mdb-button-init data-mdb-ripple-init type="button" class="btn btn-primary btn-lg btn-block" id="openCodeModalBtn">Deposit</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
                                                        function showHideTotal() {
                                                            var totalValue = document.getElementById('totalValue');
                                                            var showHideIcon = document.getElementById('showHideIcon');


                                                            if (totalValue.type === 'text') {
                                                                totalValue.type = 'password';
                                                                showHideIcon.innerHTML = '<i class="ti ti-eye"></i>';


                                                            } else {
                                                                totalValue.type = 'text';
                                                                showHideIcon.innerHTML = '<i class="ti ti-lock"></i>';


                                                            }
                                                        }
    </script>  

</body>
<%@ include file="../include/footer.jsp" %>