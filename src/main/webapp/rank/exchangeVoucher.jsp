<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reward Exchange System</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.3/font/bootstrap-icons.min.css" rel="stylesheet">
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
        .rewards {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }
        .reward-item {
            width: 30%;
            margin-bottom: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .reward-item img {
            width: 100%;
            border-bottom: 1px solid #ddd;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .reward-item p {
            padding: 10px;
            font-size: 18px;
            font-weight: bold;
            margin: 0;
        }
        .reward-item .price {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
            cursor: pointer;
        }
    </style>
    <script>
        function exchangeReward(rewardId) {
            if (confirm("Are you sure you want to exchange this reward?")) {
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "${pageContext.request.contextPath}/rank/exchangevoucher", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            alert("Exchange successful! Discount applied: " + response.discount);
                        } else {
                            alert("Exchange failed: " + response.message);
                        }
                    }
                };
                xhr.send("rewardId=" + rewardId);
            } else {
                alert("Exchange canceled.");
            }
        }
    </script>
</head>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid">
                <div class="container rounded">
                    <div class="header"><i class="bi bi-gift-fill"></i> Reward Exchange System</div>
                    <div class="rewards">
                        <div class="reward-item">
                            <img src="${pageContext.request.contextPath}/static/images/30.png" alt="Reward 1">
                            <p><i class="bi bi-star-fill"></i> 2000 Points</p>
                            <input type="hidden" id="rewardId1" value="1">
                            <div class="price" onclick="exchangeReward(1)"><i class="bi bi-arrow-right-circle-fill"></i> Exchange Now</div>
                        </div>
                        <div class="reward-item">
                            <img src="${pageContext.request.contextPath}/static/images/50.png" alt="Reward 2">
                            <p><i class="bi bi-star-fill"></i> 3000 Points</p>
                            <input type="hidden" id="rewardId2" value="2">
                            <div class="price" onclick="exchangeReward(2)"><i class="bi bi-arrow-right-circle-fill"></i> Exchange Now</div>
                        </div>
                        <div class="reward-item">
                            <img src="${pageContext.request.contextPath}/static/images/70.png" alt="Reward 3">
                            <p><i class="bi bi-star-fill"></i> 4000 Points</p>
                            <input type="hidden" id="rewardId3" value="3">
                            <div class="price" onclick="exchangeReward(3)"><i class="bi bi-arrow-right-circle-fill"></i> Exchange Now</div>
                        </div>
                        <!-- Add more reward items as needed -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp" %>
</body>
</html>
