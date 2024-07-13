<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ include file="../include/header.jsp" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Page Title</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <!-- SweetAlert JS -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <style>
        .star-rating {
            display: flex;
            justify-content: center;
            margin-top: 16px;
        }
        .star-rating span {
            display: inline-block;
            position: relative;
            width: 2em;
            cursor: pointer;
            color: grey; /* Màu xám cho các sao chưa chọn */
            font-size: 4em; /* Kích thước to hơn cho các sao */
        }
        .star-rating span i {
            font-style: normal;
        }
        .star-rating span i::before {
            content: "☆";
            position: absolute;
        }
        .star-rating span.selected i::before {
            content: "★";
            color: gold; /* Màu vàng cho các sao được chọn */
        }
        .form-group label {
            display: flex;
            align-items: center;
        }
        .form-group label i {
            margin-right: 8px;
        }
    </style>
    <script>
        $(document).ready(function () {
            var rating = 5; // Default rating
            $('#stars').val(rating);
            $('.star-rating span').slice(0, rating).addClass('selected');

            $('.star-rating span').click(function () {
                var index = $(this).index();
                var stars = $('.star-rating span');

                if ($(this).hasClass('selected')) {
                    // Nếu ngôi sao này và tất cả ngôi sao sau nó đã được chọn, bỏ chọn tất cả
                    stars.removeClass('selected');
                    rating = 0;
                } else {
                    // Nếu ngôi sao này chưa được chọn, chọn ngôi sao này và tất cả ngôi sao trước đó
                    stars.removeClass('selected');
                    $(this).addClass('selected');
                    $(this).prevAll().addClass('selected');
                    rating = index + 1;
                }

                $('#stars').val(rating); // Update hidden input value
            });
        });
    </script>
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
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card w-100">
                            <div class="card-body p-4">
                                <div class="container">
                                    <h2 class="my-3 text-center"><i class="fas fa-star"></i> Rate Your Order</h2>
                                    <form action="product" method="post">
                                        <div class="form-group my-3 text-center">
                                            <div class="star-rating">
                                                <span><i></i></span>
                                                <span><i></i></span>
                                                <span><i></i></span>
                                                <span><i></i></span>
                                                <span><i></i></span>
                                            </div>
                                            <input type="hidden" id="stars" name="stars">
                                        </div>
                                        <input class="my-2" type="text" name="action" value="danhgia" hidden/>
                                        <input class="my-2" type="text" name="orderid" value="${orderid}" hidden/>
                                        <br>
                                        <div class="form-group my-3">
                                            <label for="comment"><i class="fas fa-comment"></i> Comment:</label>
                                            <textarea id="comment" name="comment" rows="4" class="form-control my-2"></textarea>
                                        </div>
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-primary my-2"><i class="fas fa-paper-plane"></i> Send rate</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%@ include file="../include/footer.jsp" %>
            </div>
        </div>
    </div>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
