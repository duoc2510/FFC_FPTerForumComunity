<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VIP Information</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- SweetAlert JS -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
                    <div class="header"><i class="bi bi-trophy-fill"></i> Monthly VIP Benefits</div>
                    <div class="vip-info">
                        <div style="text-align: center;">
                            <p><i class="bi bi-person-fill"></i> Name: ${USER.userFullName}</p>
                            <p><i class="bi bi-envelope-fill"></i> Email: ${USER.userEmail}</p>
                            <p><i class="bi bi-gender-ambiguous"></i> Gender: ${USER.userSex}</p>
                        </div>
                        <div style="text-align: center;">
                            <p><i class="bi bi-person-badge-fill"></i> Username: ${USER.username}</p>
                            <p><i class="bi bi-star-fill"></i> Score: ${USER.userScore}</p>
                            <p><i class="bi bi-wallet-fill"></i> Wallet: ${USER.userWallet}đ</p>
                        </div>
                    </div>
                    <div class="vip-status">
                        <c:if test="${USER.userScore >= 0 && USER.userScore <100}">
                            <c:set var="ranknext" value="BRONZE" />
                            <c:set var="startrankimage" value="bronze" />
                            <c:set var="endrankimage" value="silver" />
                            <c:set var="tiendo" value="${USER.userScore / 100 *100}" />
                        </c:if>
                        <c:if test="${USER.userScore >= 100 && USER.userScore <1000}">
                            <c:set var="ranknext" value="SILVER" />
                            <c:set var="startrankimage" value="silver" />
                            <c:set var="endrankimage" value="gold" />
                            <c:set var="tiendo" value="${(USER.userScore - 100) / 900 *100}" />
                        </c:if>
                        <c:if test="${USER.userScore >= 1000 && USER.userScore <1500}">
                            <c:set var="ranknext" value="GOLD" />
                            <c:set var="startrankimage" value="gold" />
                            <c:set var="endrankimage" value="platinum" />
                            <c:set var="tiendo" value="${(USER.userScore-1000) / 500 *100}" />
                        </c:if>
                        <c:if test="${USER.userScore >= 1500 && USER.userScore <3000}">
                            <c:set var="ranknext" value="PLATINUM" />
                            <c:set var="startrankimage" value="platinum" />
                            <c:set var="endrankimage" value="diamond" />
                            <c:set var="tiendo" value="${(USER.userScore-1500) / 1500 *100}" />
                        </c:if>
                        <c:if test="${USER.userScore >= 3000 }">
                            <c:set var="ranknext" value="DIAMOND" />
                            <c:set var="startrankimage" value="platinum" />
                            <c:set var="endrankimage" value="diamond" />
                            <c:set var="tiendo" value="100" />
                        </c:if>

                        <div>   
                            <h3 style="text-align: center;"><i class="bi bi-arrow-up-circle-fill"></i> Accumulate Benefits for Next Month</h3>
                            <div style="text-align: center; width: 100%;">${tiendo}%</div>

                            <div class="progress-container">
                                <div style="flex: 2;"><img src="${pageContext.request.contextPath}/static/images/rank/${startrankimage}.png" alt="Start"></div>
                                <div class="progress-bar" style="flex: 6;">
                                    <div class="bar">
                                        <span style="width: ${tiendo}%;"></span>
                                    </div>
                                </div>
                                <div style="flex: 2;"><img src="${pageContext.request.contextPath}/static/images/rank/${endrankimage}.png" alt="End"></div>
                            </div>

                            <p><i class="bi bi-graph-up-arrow"></i> Accumulated: ${USER.userScore} Score</p>
                            <p><i class="bi bi-award-fill"></i> VIP Next Month: ${ranknext}</p>
                            <p><i class="bi bi-calendar-check-fill"></i> Will enjoy VIP Gold benefits from ${firstDayOfNextMonth} to ${lastDayOfNextMonth}</p>
                        </div>
                        <c:if test="${USER.userRank == 0}">
                            <c:set var="rank" value="BRONZE" />
                            <c:set var="rankimage" value="bronze" />
                        </c:if>
                        <c:if test="${USER.userRank == 1}">
                            <c:set var="rank" value="SILVER" />
                            <c:set var="rankimage" value="silver" />
                        </c:if>
                        <c:if test="${USER.userRank == 2}">
                            <c:set var="rank" value="GOLD" />
                            <c:set var="rankimage" value="gold" />
                        </c:if>
                        <c:if test="${USER.userRank == 3}">
                            <c:set var="rank" value="PLATINUM" />
                            <c:set var="rankimage" value="platinum" />
                        </c:if>
                        <c:if test="${USER.userRank == 4}">
                            <c:set var="rank" value="DIAMOND" />
                            <c:set var="rankimage" value="diamond" />
                        </c:if>
                        <div>
                            <h3 style="text-align: center;"><i class="bi bi-star-fill"></i> Current VIP Level</h3>
                            <p style="text-align: center; width: 100%;">${rank}</p>
                            <div style="text-align: center; width: 100%;">
                                <img src="${pageContext.request.contextPath}/static/images/rank/${rankimage}.png" alt="${rank} Class" width="100">
                            </div>
                            <p><i class="bi bi-calendar2-event-fill"></i> VIP benefits period: from ${firstDayOfMonth} to 23h on ${lastDayOfMonth}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp" %>
</body>
</html>
