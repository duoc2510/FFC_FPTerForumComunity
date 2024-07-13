<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Page Title</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- SweetAlert JS -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>

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
            <div class="container-fluid mt-4">
                <div class="col-lg-12">
                    <div class="card w-100 rounded shadow-sm">
                        <div class="card-body p-4">
                            <table class="table table-bordered">
                                <thead class="table-light text-center">
                                    <tr>
                                        <th>Benefits</th>
                                        <th><img src="${pageContext.request.contextPath}/static/images/rank/bronze.png" alt="Bronze" width="32"></th>
                                        <th><img src="${pageContext.request.contextPath}/static/images/rank/silver.png" alt="Silver" width="32"></th>
                                        <th><img src="${pageContext.request.contextPath}/static/images/rank/gold.png" alt="Gold" width="32"></th>
                                        <th><img src="${pageContext.request.contextPath}/static/images/rank/platinum.png" alt="Platinum" width="32"></th>
                                        <th><img src="${pageContext.request.contextPath}/static/images/rank/diamond.png" alt="Diamond" width="32"></th>
                                    </tr>
                                </thead>
                                <tbody class="text-center">
                                    <tr>
                                        <th scope="row">Required Score</th>
                                        <td>0</td>
                                        <td>100</td>
                                        <td>1000</td>
                                        <td>1500</td>
                                        <td>3000</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Avatar Frame</th>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Name Color</th>
                                        <td>-</td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">+1 Advertisement Post</th>
                                        <td>-</td>
                                        <td>-</td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">+3 Advertisement Posts</th>
                                        <td>-</td>
                                        <td>-</td>
                                        <td>-</td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">+5 Advertisement Posts</th>
                                        <td>-</td>
                                        <td>-</td>
                                        <td>-</td>
                                        <td>-</td>
                                        <td><i class="bi bi-star-fill text-warning"></i></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">(Note: No accumulation)</th>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="p-2 mx-auto w-100 text-center">
                                <button type="button" class="btn btn-primary mx-2" onclick="window.location.href = '${pageContext.request.contextPath}/rank/exchangevoucher'">Exchange Voucher</button>
                                <button type="button" class="btn btn-primary mx-2" onclick="window.location.href = '${pageContext.request.contextPath}/rank/userrank'">Your Rank</button>
                                <button type="button" class="btn btn-primary mx-2" data-bs-toggle="modal" data-bs-target="#exampleModal">View Instructions</button>
                                <button type="button" class="btn btn-secondary mx-2" onclick="window.location.href = '${pageContext.request.contextPath}/rank/topvip'">View Top VIP</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp" %>

    <!-- Popup -->
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content rounded">
                <div class="modal-header bg-primary text-white rounded-top">
                    <h1 class="modal-title text-center mx-auto" id="exampleModalLabel">
                        <i class="bi bi-info-circle-fill"></i> Introduction
                    </h1>
                </div>
                <div class="modal-body rounded-bottom" style="background-color: #e0f7fa;">
                    <p>
                        <i class="bi bi-gift-fill"></i> To appreciate those who have made positive contributions to help FFC grow further, FFC has created a points system for redeeming rewards. Just by posting approved posts or events as well as appropriate comments, everyone will receive corresponding bonus points. When the reward points reach certain milestones, users will receive attractive rewards.
                        <br>
                        <i class="bi bi-clock-fill"></i> Note: Reward points will reset once a month.
                    </p>
                    <hr/>
                    <h3 class="text-center mb-4 font-weight-bold">
                        <i class="bi bi-lightbulb-fill"></i> How to Play
                    </h3>
                    <p>
                        <i class="bi bi-chat-left-text-fill"></i> Just interact regularly with FFC by posting or creating events or commenting on posts. For each approved activity that does not violate the rules, you will receive corresponding points. When accumulated points reach the following milestones, you will level up in rank and receive corresponding rewards:
                    </p>
                    <table class="table table-bordered">
                        <thead class="table-light text-center">
                            <tr>
                                <th scope="col"><i class="bi bi-trophy-fill"></i> Rank</th>
                                <th scope="col"><i class="bi bi-arrow-up-right-circle-fill"></i> Score</th>
                                <th scope="col"><i class="bi bi-gift-fill"></i> Gift</th>
                            </tr>
                        </thead>
                        <tbody class="text-center">
                            <tr>
                                <td>Bronze</td>
                                <td>0</td>
                                <td>Avatar Frame</td>
                            </tr>
                            <tr>
                                <td>Silver</td>
                                <td>100</td>
                                <td>...+Name Color</td>
                            </tr>
                            <tr>
                                <td>Gold</td>
                                <td>1000</td>
                                <td>...+1 Advertisement Post</td>
                            </tr>
                            <tr>
                                <td>Platinum</td>
                                <td>1500</td>
                                <td>...+3 Advertisement Posts</td>
                            </tr>
                            <tr>
                                <td>Diamond</td>
                                <td>3000</td>
                                <td>...+5 Advertisement Posts</td>
                            </tr>
                            <tr>
                                <th>Note: Rewards will accumulate through ranks.</th>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer rounded-bottom" style="background-color: #e0f7fa;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="bi bi-x-circle-fill"></i> Close
                    </button>
                </div>
            </div>
        </div>
    </div>



    <!-- Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.0/js/bootstrap.bundle.min.js"></script>
</body>
