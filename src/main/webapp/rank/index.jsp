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

                <div class="col-lg-12 ">
                    <div class="card w-100">
                        <div class="card-body p-4">
                            <table class="table">
                                <thead class="">
                                    <tr>
                                        <th>Ưu đãi</th>
                                        <th> <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/bronze.png" alt="" width="32"></th>
                                        <th> <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/silver.png" alt="" width="32"></th>
                                        <th> <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/gold.png" alt="" width="32"></th>
                                        <th> <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/platinum.png" alt="" width="32"></th>
                                        <th> <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/diamond.png" alt="" width="32"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">Cần tích lũy(Score)</th>
                                        <td class="text-center">0</td>
                                        <td class="text-center">100</td>
                                        <td class="text-center">1000</td>
                                        <td class="text-center">1500</td>
                                        <td class="text-center">3000</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Khung Avatar</th>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Màu Tên</th>
                                        <td class="text-center">-</td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                    </tr>   
                                    <tr>
                                        <th scope="row">+1 đăng quảng cáo</th>
                                        <td class="text-center">-</td>
                                        <td class="text-center">-</td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                    </tr>   
                                    <tr>
                                        <th scope="row">+3 đăng quảng cáo</th>
                                        <td class="text-center">-</td>
                                        <td class="text-center">-</td>
                                        <td class="text-center">-</td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                    </tr>  
                                    <tr>
                                        <th scope="row">+5 đăng quảng cáo</th>
                                        <td class="text-center">-</td>
                                        <td class="text-center">-</td>
                                        <td class="text-center">-</td>
                                        <td class="text-center">-</td>
                                        <td class="text-center"><img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/star.png" alt="" width="15"></td>
                                    </tr> 
                                    <tr>
                                        <th scope="row">(Note: Không tích lũy)</th>
                                    </tr> 
                                </tbody>
                            </table>
                            <div class="p-2 mx-auto w-100">
                                <div class="col-4 d-inline">
                                    <button type="button" class="btn btn-primary float-end mx-2" onclick="window.location.href = '${pageContext.request.contextPath}/rank/userrank'">Rank của bạn</button>
                                </div>
                                <div class="col-4 d-inline">
                                    <button type="button" class="btn btn-primary float-end mx-2" data-bs-toggle="modal" data-bs-target="#exampleModal">Xem hướng dẫn</button>
                                </div>
                                <div class="col-4 d-inline">
                                    <button type="button" class="btn btn-secondary float-end mx-2" onclick="window.location.href = '${pageContext.request.contextPath}/rank/topvip'">View Top Vip</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp" %>

    <!-- Popup -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="text-center mb-4 font-weight-bold mx-auto" id="exampleModalLabel">Giới thiệu</h1>

                </div>
                <div class="modal-body">
                    Nhằm tri ân những người có đóng góp tích cực để giúp FFC ngày càng phát triển hơn.
                    FFC đã tạo ra hệ thống tích điểm đổi quà.
                    Chỉ cần là những bài post hay event được duyệt cũng như những comment phù hợp thì mọi người sẽ nhận được số điểm thưởng tương ứng.
                    Khi điểm thưởng đạt đến những cột mốc nhất định thì người dùng sẽ nhận được những phần thưởng hấp dẫn.
                    Lưu ý: điểm thưởng sẽ reset mỗi lần 1 tháng.
                    <hr/>
                    <h3 class="text-center mb-4 font-weight-bold">Hướng dẫn chơi</h3>
                    <p>
                        Chỉ cần bạn tương tác thường xuyên với FFC bằng cách đăng bài post hay tạo event hoặc comment bài.
                        Với mỗi hoạt động được duyệt và không vi phạm thì bạn sẽ nhận được số điểm tương ứng.
                        Khi điểm tích lũy đạt được các cột mốc sau thì bạn sẽ lên rank và nhận được các phần thưởng tương ứng:
                    </p>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Rank</th>
                                <th scope="col">Score</th>
                                <th scope="col">GIft</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Bronze</td>
                                <td>0</td>
                                <td>Khung Avatar</td>
                            </tr>
                            <tr>
                                <td>Silver</td>
                                <td>100</td>
                                <td>...+Màu tên</td>
                            </tr>
                            <tr>
                                <td>Gold</td>
                                <td>1000</td>
                                <td>...+1 advertisement</td>
                            </tr>
                            <tr>
                                <td>Platinum</td>
                                <td>1500</td>
                                <td>...+3 advertisement</td>
                            </tr>
                            <tr>
                                <td>Diamond</td>
                                <td>3000</td>
                                <td>...+5 advertisement</td>
                            </tr>
                            <tr>
                                <th>Lưu ý: Phần thưởng sẽ cộng dồn qua các rank.</th>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</body>
