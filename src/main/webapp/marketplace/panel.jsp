<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ include file="../include/header.jsp" %>

        <style>
            .slider {
                position: absolute;
                bottom: 0;
                left: 0;
                height: 3px; /* Taller slider */
                background-color: #05A3C8
                    ; /* Different color for slider */
                transition: all 0.3s ease;
            }
            .nav-pills {
                position: relative;
                   padding:10px 0;
               
            }
            .nav-pills .nav-link {
                position: relative;
            }
            .slider{
                background-color:#5e87ff;
            }
        </style>

    <body>
        <div class="container border rounded shadow mb-5">
            <div class="col-lg-12">
                <ul class="nav nav-pills nav-fill" id="nav-pills">
                    <li class="nav-item">
                        <a class="rounded nav-link nav-link-main-redirect" href="${pageContext.request.contextPath}/martketplace/allshop">All shop</a>
                    </li>
                    <li class="nav-item">
                        <a class="rounded nav-link nav-link-main-redirect" href="${pageContext.request.contextPath}/marketplace/myshop">My shop</a>
                    </li>
                    <li class="nav-item">
                        <a class="rounded nav-link nav-link-main-redirect" href="${pageContext.request.contextPath}/marketplace/cart">Cart</a>
                    </li>
                    <li class="nav-item">
                        <a class="rounded nav-link nav-link-main-redirect" href="${pageContext.request.contextPath}/marketplace/history">History</a>
                    </li>
                    <div class="slider" id="slider"></div>
                </ul>
            </div>
        </div>
        <!-- jQuery and Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script>
            $(document).ready(function () {
                var $slider = $('#slider');
                var $navLinks = $('.nav-link-main-redirect');

                function moveSlider($link) {
                    var left = $link.position().left;
                    var width = $link.outerWidth();
                    $slider.css({
                        left: left + 'px',
                        width: width + 'px'
                    });
                }

                $navLinks.click(function (e) {
                    e.preventDefault();
                    $navLinks.removeClass('active');
                    $(this).addClass('active');
                    moveSlider($(this));

                    // Điều hướng tới trang được chọn
                    window.location.href = $(this).attr('href');
                });

                // Đặt thanh trượt vào vị trí mục hiện tại
                var currentPath = window.location.pathname;
                var $activeLink = $navLinks.filter('[href="' + currentPath + '"]');

                if ($activeLink.length > 0) {
                    $activeLink.addClass('active');
                    moveSlider($activeLink);
                }
            });
        </script>

    </body>
</html>
