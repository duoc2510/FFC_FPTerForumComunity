<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
    /* Popup container - can be anything you want */
    .popup {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        padding-top: 100px; /* Location of the box */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        animation: fadeIn 0.3s ease-out; /* Hiệu ứng fade-in */
        border-radius: 20px; /* Bo góc */
    }

    /* Popup Content */
    .popup-content {
        overflow-x: scroll;
        max-height: 400px; /* Thiết lập chiều cao tối đa của thanh trượt */
        background-color: #fefefe;
        margin: auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 600px; /* Maximum width */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        animation: slideIn 0.3s ease-out; /* Hiệu ứng slide-in */
        border-radius: 10px; /* Bo góc */
    }
    .scroll-container {
        width: 100%; /* Đảm bảo rằng nội dung bên trong có thể cuộn ngang */
        padding: 10px; /* Khoảng cách giữa nội dung và các cạnh của container */
    }

    /* Close button */
    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    /* Animation */
    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }

    @keyframes slideIn {
        from {
            transform: translateY(-50px);
        }
        to {
            transform: translateY(0);
        }
    }

    /* Căng chữ */
    .popup-content h2, .popup-content h3, .popup-content h4, .popup-content p, .popup-content ul {
        color: black; /* Màu chữ */
    }
</style>
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
                                    <button type="button" class="btn btn-secondary float-end mx-2" onclick="showPopup()">Xem hướng dẫn</button>
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

    <%@ include file="../include/footer.jsp" %>

    <!-- Popup -->
    <div id="myPopup" class="popup">
        <div class="popup-content">
            <span class="close" onclick="hidePopup()">&times;</span>
            <div class="scroll-container">
                <div class="container">
                    <h2 class="text-center mb-4 font-weight-bold">Giới thiệu</h2>
                    <p class="lead">
                        Nhằm tri ân những người có đóng góp tích cực để giúp FFC ngày càng phát triển hơn.
                        FFC đã tạo ra hệ thống tích điểm đổi quà.
                        Chỉ cần là những bài post hay event được duyệt cũng như những comment phù hợp thì mọi người sẽ nhận được số điểm thưởng tương ứng.
                        Khi điểm thưởng đạt đến những cột mốc nhất định thì người dùng sẽ nhận được những phần thưởng hấp dẫn.
                    </p>
                    <ul class="list-unstyled">
                        <li>Lưu ý: điểm thưởng sẽ reset mỗi lần 1 tháng.</li>
                    </ul>
                    <h3 class="text-center mb-4 font-weight-bold">Hướng dẫn chơi</h3>
                    <p>
                        Chỉ cần bạn tương tác thường xuyên với FFC bằng cách đăng bài post hay tạo event hoặc comment bài.
                        Với mỗi hoạt động được duyệt và không vi phạm thì bạn sẽ nhận được số điểm tương ứng.
                        Khi điểm tích lũy đạt được các cột mốc sau thì bạn sẽ lên rank:
                    </p>
                    <ul class="list-unstyled">
                        <li>+/ Bronze   : Cần 10 Score</li>
                        <li>+/ Silver   : Cần 100 Score</li>
                        <li>+/ Gold     : Cần 1000 Score</li>
                        <li>+/ Platinum : Cần 1500 Score</li>
                        <li>+/ Diamond  : Cần 3000 Score</li>
                    </ul>
                    <h4 class="text-center mb-3 font-weight-bold">Quà nhận được:</h4>
                    <p>Bronze :</p>
                    <ul class="list-unstyled">
                        <li>+/Khung Avatar</li>
                    </ul>
                    <p>Silver :</p>
                    <ul class="list-unstyled">
                        <li>+/Khung Avatar</li>
                        <li>+/Màu tên</li>
                    </ul>
                    <p>Gold :</p>
                    <ul class="list-unstyled">
                        <li>+/Khung Avatar</li>
                        <li>+/Màu tên</li>
                        <li>+/Nhận 1 lượt đăng quảng cáo</li>
                    </ul>
                    <p>Platinum :</p>
                    <ul class="list-unstyled">
                        <li>+/Khung Avatar</li>
                        <li>+/Màu tên</li>
                        <li>+/Nhận 1 lượt đăng quảng cáo</li>
                        <li>+/Nhận 3 lượt đăng quảng cáo</li>
                    </ul>
                    <p>Diamond :</p>
                    <ul class="list-unstyled">
                        <li>+/Khung Avatar</li>
                        <li>+/Màu tên</li>
                        <li>+/Nhận 1 lượt đăng quảng cáo</li>
                        <li>+/Nhận 3 lượt đăng quảng cáo</li>
                        <li>+/Nhận 5 lượt đăng quảng cáo</li>
                    </ul>
                </div>
            </div>

        </div>
    </div>


    <script>
        // Show the popup
        function showPopup() {
            document.getElementById("myPopup").style.display = "block";
        }

        // Hide the popup
        function hidePopup() {
            document.getElementById("myPopup").style.display = "none";
        }
    </script>
</body>
