<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Đánh giá đơn hàng</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <style>
            .star-rating {
                direction: rtl;
                display: inline-block;
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
            <h2 class="my-4">Đánh giá đơn hàng</h2>
            <form action="product" method="post">
                <div class="form-group">
                    <label for="stars">Số sao:</label><br>
                    <div class="star-rating">
                        <span><i></i></span>
                        <span><i></i></span>
                        <span><i></i></span>
                        <span><i></i></span>
                        <span><i></i></span>
                    </div>
                    <input type="hidden" id="stars" name="stars">
                </div>
                <input type="text" name="action" value="danhgia" hidden/>
                <input type="text" name="orderid" value="${orderid}" hidden/>
                <div class="form-group">
                    <label for="comment">Bình luận:</label><br>
                    <textarea id="comment" name="comment" rows="4" class="form-control"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
            </form>
        </div>
    </body>
</html>
