<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
                            <style>
                                .star-rating {
                                    display: inline-block;
                                    position: relative;
                                    top: -16px;
                                }
                                .star-rating span {
                                    display: inline-block;
                                    position: relative;
                                    width: 1.1em;
                                    cursor: pointer;
                                    color: grey; /* Màu xám cho các sao chưa chọn */
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
                                <div class="container">
                                    <h2 class="my-3">Đánh giá đơn hàng</h2>
                                    <form action="product" method="post">
                                        <div class="form-group my-2">
                                            <div >
                                                <label for="stars">Số sao:</label>
                                                <div class="star-rating">
                                                    <span><i></i></span>
                                                    <span><i></i></span>
                                                    <span><i></i></span>
                                                    <span><i></i></span>
                                                    <span><i></i></span>
                                                </div>
                                            </div>
                                            <input type="hidden" id="stars" name="stars">
                                        </div>
                                        <input class='my-2' type="text" name="action" value="danhgia" hidden/>
                                        <input class="my-2" type="text" name="orderid" value="${orderid}" hidden/>
                                        <div class="form-group my-2">
                                            <label for="comment">Comment:</label><br>
                                            <textarea id="comment" name="comment" rows="4" class="form-control my-2"></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-primary my-2">Send rate</button>
                                    </form>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</body>
<%@ include file="../include/footer.jsp" %>

