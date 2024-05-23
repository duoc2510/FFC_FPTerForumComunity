<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>



        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
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
                                        <td class="text-center">10</td>
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
                                    <button type="button" class="btn btn-primary float-end mx-2" onclick="window.location.href = '${pageContext.request.contextPath}/userrank'">Rank của bạn</button>
                                </div>
                                <div class="col-4 d-inline">
                                    <button type="button" class="btn btn-secondary float-end mx-2" onclick="window.location.href = '${pageContext.request.contextPath}/huongdan'">Xem hướng dẫn</button>
                                </div>
                                <div class="col-4 d-inline">
                                    <button type="button" class="btn btn-secondary float-end mx-2" onclick="window.location.href = '${pageContext.request.contextPath}/topvip'">View Top Vip</button>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>

            </div>
        </div>

        <%@ include file="../include/right-slidebar.jsp" %>


    </div>
</body>
<%@ include file="../include/footer.jsp" %>
