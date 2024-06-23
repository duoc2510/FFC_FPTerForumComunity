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

                                    <form action="">
                                         <p class="fw-bold mb-4 pb-2">Main method:</p>
                                        <div class="d-flex flex-row align-items-center mb-4 pb-1">
                                            <div class="flex-fill d-flex">
                                                <div class="form-outline col-8">
                                                    <label class="form-label" for="formControlLgXc">Money</label>
                                                    <input type="text" class="form-control" value="2000000" />
                                                </div>
                                                <div class="form-outline col-4" style="padding-left:2%">
                                                    <label class="form-label" for="formControlLgXc">Currency</label>
                                                    <input type="text"  class="form-control" value="VND" readonly/>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="fw-bold mb-4 pb-2">Main method:</p>
                                        <div class="d-flex flex-row align-items-center mb-4 pb-1">
                                            <img class="img-fluid" src="https://img.icons8.com/color/48/000000/mastercard-logo.png" />
                                            <div class="flex-fill mx-3">
                                                <div data-mdb-input-init class="form-outline">
                                                    <label class="form-label" for="formControlLgXc">Card Number [MAIN]</label>
                                                    <input type="text" id="formControlLgXc" class="form-control form-control" value="**** **** **** 3193" />
                                                </div>
                                            </div>
                                        </div>

                                        <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block">Deposit</button>


                                    </form>


                                </div>
                            </div>
                        </div>

                        <div class=" bg-white shadow rounded px-3 ">
                            <div class="row d-flex justify-content-center">
                                <div class="card-body p-4">
                                    <div class="mb-4">
                                        <h3>Settings</h3>
                                        <h6>Payment Method</h6>
                                    </div>
                                    <form action="">
                                        <p class="fw-bold mb-4 pb-2">My cards:</p>
                                        <div class="d-flex flex-row align-items-center mb-4 pb-1">
                                            <img class="img-fluid" src="https://img.icons8.com/color/48/000000/mastercard-logo.png" />
                                            <div class="flex-fill mx-3">
                                                <div data-mdb-input-init class="form-outline">
                                                    <label class="form-label" for="formControlLgXc">Card Number [MAIN]</label>
                                                    <input type="text" id="formControlLgXc" class="form-control form-control" value="**** **** **** 3193" />
                                                </div>
                                            </div>
                                            <a href="#!">Remove</a>
                                        </div>
                                        <div class="d-flex flex-row align-items-center mb-4 pb-1">
                                            <img class="img-fluid" src="https://img.icons8.com/color/48/000000/visa.png" />
                                            <div class="flex-fill mx-3">
                                                <div data-mdb-input-init class="form-outline">
                                                    <label class="form-label" for="formControlLgXs">Card Number | <a onclick="" href="javascript:void(0)">Set main</a></label>
                                                    <input type="text" id="formControlLgXs" class="form-control form-control" value="**** **** **** 4296" />
                                                </div>
                                            </div>
                                            <a href="#!">Remove</a>
                                        </div>
                                        <hr>
                                        <p class="mb-4">Add new card:</p>
                                        <div data-mdb-input-init class="form-outline mb-4">
                                            <label class="form-label" for="formControlLgXsd">Cardholder's Name</label>
                                            <input type="text" id="formControlLgXsd" class="form-control form-control" value="nguyen hari truong" style="text-transform:uppercase" />
                                        </div>
                                        <div class="mb-4 d-flex">
                                            <div class="col-6 ">
                                                <div data-mdb-input-init class="form-outline">
                                                    <label class="form-label" for="formControlLgXM">Card Number</label>
                                                    <input type="text" id="formControlLgXM" class="form-control form-control" value="1234 5678 1234 5678" />
                                                </div>
                                            </div>
                                            <div class="col-4 px-2">
                                                <div data-mdb-input-init class="form-outline">
                                                    <label class="form-label" for="formControlLgExpk">Expire</label>
                                                    <input type="password" id="formControlLgExpk" class="form-control form-control" placeholder="MM/YYYY" />
                                                </div>
                                            </div>
                                            <div class="col-2">
                                                <div data-mdb-input-init class="form-outline">
                                                    <label class="form-label" for="formControlLgcvv">CVV</label>
                                                    <input type="password" id="formControlLgcvv" class="form-control form-control" placeholder="Cvv" />
                                                </div>
                                            </div>
                                        </div>
                                        <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block">Add card</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body><%@ include file="../include/footer.jsp" %>