<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>VIP Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #fff;
                color: #000;
            }
            .container {
                max-width: 900px;
                margin: 50px auto;
                background-color: #f9f9f9;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            }
            .header {
                text-align: center;
                font-size: 24px;
                font-weight: bold;
                padding: 10px 0;
                background-color: orange;
                border-radius: 10px;
                margin-bottom: 20px;
                color: #fff;
            }
            .vip-info, .vip-status {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                border-bottom: 1px solid #ddd;
            }
            .vip-info div, .vip-status div {
                width: 48%;
            }
            .vip-info div {
                padding-right: 10px;
            }
            .progress-bar {
                height: 23px;
                background-color: #ddd;
                position: relative;
            }
            .progress-bar .bar span {
                display: block;
                height: 100%;
                background-color: orange;
                position: absolute;
                top: 0;
                left: 0;
            }
            .progress-container {
                width: 100% !important;
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin: 10px 0;
            }


            .progress-container > div {
                flex: 1;
                text-align: center;
            }
            .progress-container > div img {
                width: 50px;
                height: 50px;
            }
            .progress-container .bar-container {
                flex: 8;
                padding: 0 10px;
            }
            .footer {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                margin-top: 20px;
                border-top: 1px solid #ddd;
            }
            .footer button {
                padding: 10px 20px;
                background-color: orange;
                border: none;
                color: #fff;
                cursor: pointer;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
             data-sidebar-position="fixed" data-header-position="fixed">
            <%@ include file="../include/slidebar.jsp" %>

            <div class="body-wrapper">
                <%@ include file="../include/navbar.jsp" %>
                <div class="container-fluid">
                    <div class="container">
                        <div class="header">QUYỀN LỢI VIP THÁNG</div>
                        <div class="vip-info">
                            <div style="text-align: center;">
                                <p>Tên: ***Phúc</p>
                                <p>Email: ***@gmail.com</p>
                                <p>Giới tính: ***Male</p>
                            </div>
                            <div style="text-align: center;">
                                <p>Username: ***Lep</p>
                                <p>Score: 147515061</p>
                                <p>Wallet: 0đ</p>
                            </div>
                        </div>
                        <div class="vip-status">
                            <div>
                                <h3 style="text-align: center;">TÍCH ƯU ĐÃI THÁNG SAU</h3>
                               <div style="text-align: center; width: 100%;">50%</div>

                                <div class="progress-container">
                                    <div style="flex: 2;"><img src="${pageContext.request.contextPath}/static/images/rank/silver.png" alt="Start"></div>
                                    <div class="progress-bar" style="flex: 6;">
                                        <div class="bar">
                                            <span style="width: 50%;"></span>
                                        </div>
                                    </div>
                                    <div style="flex: 2;"><img src="${pageContext.request.contextPath}/static/images/rank/gold.png" alt="End"></div>
                                </div>

                                <p>Đã tích: 10,330 FC+MC</p>
                                <p>VIP tháng sau: Vàng</p>
                                <p>Sẽ hưởng ưu đãi VIP Vàng từ 01.05.2024 đến 31.05.2024</p>
                            </div>
                            <div>
                                <h3 style="text-align: center;">BẬC VIP HIỆN TẠI</h3>
                                <p style="text-align: center; width: 100%;">VÀNG</p>
                                <div style="text-align: center; width: 100%;">
                                    <img src="${pageContext.request.contextPath}/static/images/rank/gold.png" alt="Gold Class" width="100">
                                </div>
                                <p>Thời gian hưởng ưu đãi VIP từ 23h ngày 30.04.2024 đến 23h ngày 31.05.2024</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="../include/right-slidebar.jsp" %>
        </div>
        <%@ include file="../include/footer.jsp" %>
    </body>
</html>
