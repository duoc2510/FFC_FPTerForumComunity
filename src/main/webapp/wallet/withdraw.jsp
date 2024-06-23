<%-- 
    Document   : withdraw
    Created on : Jun 23, 2024, 11:36:27 AM
    Author     : mac
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><%@ include file="../include/header.jsp" %> <body>
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
                            .bank-logo{
                                width:100px;
                                
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
                        <div class=" bg-white shadow rounded px-3 ">
                            <div class="row d-flex justify-content-center">
                                <div class="card-body p-4">
                                    <div class="mb-4">
                                        <h3>Settings</h3>
                                        <h6>Withdraw Method</h6>
                                    </div>
                                    <form action="">
                                        <p class="fw-bold mb-4 pb-2">My withdraw method:</p>

                                        <div class="d-flex flex-row align-items-center mb-4 pb-1">
                                            <img class="img-fluid bank-logo" src="https://upload.wikimedia.org/wikipedia/commons/2/25/Logo_MB_new.png"/>
                                            <div class="flex-fill mx-3">
                                                <div data-mdb-input-init class="form-outline">
                                                    <label class="form-label" for="formControlLgXc">Bank account number:</label>
                                                    <input type="text" id="formControlLgXc" class="form-control form-control" value="**** **** **** 8888" />
                                                </div>

                                            </div>
                                            <a href="#!">Remove</a>
                                        </div>
                                        <p class="mt-4">Our policy, you just can add only one bank account number to withdraw. To change withdraw method, please remove the current </p>

                                        <hr>
                                        <p class="mb-4">Add new withdraw method:</p>
                                      
                                        <div class="mb-4 d-flex">
                                            <div class="col-4">
                                                <div data-mdb-input-init class="form-outline">
                                                    <label class="form-label" for="formControlLgXM">Bank</label>
                                                    <select class="form-control">
                                                        <option selected value="mb">MB</option>
                                                        <option value="vcb">Vietcombank</option>
                                                        <option value="tp">TP Bank</option>
                                                    </select>

                                                </div>
                                            </div>
                                            <div class="col-8  px-2">
                                                <label class="form-label" for="formControlLgXsd">Bank account number</label>
                                            <input type="text" id="formControlLgXsd" class="form-control form-control" value="081408168888"/>
                                            </div>
                                           
                                            
                                        </div>
                                        <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block">Add withdraw method</button>
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