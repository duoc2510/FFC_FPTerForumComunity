<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/home.css" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">

        <body>
            <style>
                .carousel-item {
                    transition: transform 0.6s ease, opacity 0.6s ease; /* Adjust the timing and easing function for smoother transitions */
                }

            </style>
            <nav id="legends-nav" class="navbar navbar-expand-lg navbar-light bg-light px-5">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo03" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <a class="navbar-brand" href="#"> <img src="${pageContext.request.contextPath}/static/images/logo.png" width="100" alt="" /></a>

                <div class="collapse navbar-collapse justify-content-between" id="navbarTogglerDemo03">
                    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                        <li class="nav-item active">
                            <a class="nav-link" href="${pageContext.request.contextPath}">Home </a>
                        </li>
                    </ul>
                    <div class="my-2 my-lg-0 w-100 d-flex justify-content-end align-items-center">
                        <a href="${pageContext.request.contextPath}/logingooglehandler?value=login" class="btn btn-outline-success my-2 my-sm-0">Login</a>

                        <div class="h-100 d-flex">
                            <div class="swipe-mode px-2 mx-3" style="width: 60px">
                                <input type="checkbox" class="checkbox" id="checkbox">
                                    <label for="checkbox" class="checkbox-label">
                                        <i class="fas fa-moon"></i>
                                        <i class="fas fa-sun"></i>
                                        <span class="ball"></span>
                                    </label>
                            </div>
                            <div style="width: 50px">
                                <a id="webcamButton" class="nav-link" data-bs-toggle="modal" data-bs-target="#webcamModal">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="currentColor" class="bi bi-lightning-charge-fill" viewBox="0 0 16 16">
                                        <path d="M11.251.068a.5.5 0 0 1 .227.58L9.677 6.5H13a.5.5 0 0 1 .364.843l-8 8.5a.5.5 0 0 1-.842-.49L6.323 9.5H3a.5.5 0 0 1-.364-.843l8-8.5a.5.5 0 0 1 .615-.09z"></path>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
            <main class="main">
                <section id="hero" class="hero section" style="padding-top: 60px;">
                    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#carouselExampleIndicators" data-slide-to="0" ></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="1" class="active"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                        </ol>
                        <div class="carousel-inner">
                            <!--                    <div class="carousel-item">
                                                    <video class="d-block w-100 h-100 fill hide-for-small" preload="" playsinline="" autoplay="" muted="" loop="">
                                                        <source src="${pageContext.request.contextPath}/static/fpt.mp4" type="video/mp4">	</video>
                                                </div>-->

                            <div class="carousel-item">
                                <img class="d-block w-100" src="${pageContext.request.contextPath}/static/images/banner_desktop.jpg" alt="First slide">
                            </div>
                            <div class="carousel-item active">
                                <img class="d-block w-100" src="${pageContext.request.contextPath}/static/images/banner_fpt_v.league.jpg" alt="Second slide">
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-100" src="${pageContext.request.contextPath}/static/images/2048x560-gtbb_t3-2024.png" alt="Third slide">
                            </div>

                        </div>
                        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </section>

                <section id="section-map" class="section-map" style="background-image: url(&quot;${pageContext.request.contextPath}/static/images/building/map0.jpg&quot;);">
                    <div class="overplay-map"></div>
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <div id="map-0" class="building-map position-relative">
                                    <div class="cel-overlay"></div>
                                    <img class="img-fluid shadow" src="${pageContext.request.contextPath}/static/images/building/map0.jpg">
                                        <div class="content position-absolute bottom-0 p-4">
                                            <h2>Campus Ha Noi</h2>
                                        </div>
                                </div>
                                <div id="map-1" class="d-none building-map position-relative">
                                    <div class="cel-overlay"></div>
                                    <img class="img-fluid shadow" src="${pageContext.request.contextPath}/static/images/building/map1.jpg">
                                        <div class="content position-absolute bottom-0 p-4">
                                            <h2>Campus Hue</h2>
                                        </div>
                                </div>

                                <div id="map-2" class="d-none building-map position-relative">
                                    <div class="cel-overlay"></div>
                                    <img class="img-fluid shadow" src="${pageContext.request.contextPath}/static/images/building/map2.jpg">
                                        <div class="content position-absolute bottom-0 p-4">
                                            <h2>Campus Da Nang</h2>
                                        </div>
                                </div>
                                <div id="map-3" class="d-none building-map position-relative">
                                    <div class="cel-overlay"></div>
                                    <img class="img-fluid shadow" src="${pageContext.request.contextPath}/static/images/building/map3.jpg">
                                        <div class="content position-absolute bottom-0 p-4">
                                            <h2>Campus Quy Nhon</h2>
                                        </div>
                                </div>
                                <div id="map-4" class="d-none building-map position-relative">
                                    <div class="cel-overlay"></div>
                                    <img class="img-fluid shadow" src="${pageContext.request.contextPath}/static/images/building/map4.jpg">
                                        <div class="content position-absolute bottom-0 p-4">
                                            <h2>Campus Can Tho</h2>
                                        </div>
                                </div>
                                <div id="map-5" class="d-none building-map position-relative">
                                    <div class="cel-overlay"></div>
                                    <img class="img-fluid shadow" src="${pageContext.request.contextPath}/static/images/building/map5.jpeg">
                                        <div class="content position-absolute bottom-0 p-4">
                                            <h2>Campus Ho Chi Minh</h2>
                                        </div>
                                </div>

                            </div>
                            <div class="col-12 col-md-5 ps-5">

                                <!--<p class="text-uppercase text-rounded font-weight-300 mx-auto text-center my-4 text-light">The Building</p>-->
                                <h2 class="title text-black">The Building</h2>
                                <p class="sub-title mb-4 text-black">Acts as a gateway to the campus with a green façade clearly dictating the future direction of the campus</p>
                                <div class="position-relative px-5">
                                    <img class="img-fluid" src="${pageContext.request.contextPath}/static/images/building/flag.png">
                                        <div class="building-select position-absolute w-100 h-100 top-0 left-0">
                                            <a href="javascript:void(0)" onclick="showID('map-0')">
                                                <svg class="pulse rounded" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16">
                                                    <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"></path>
                                                </svg> Ha Noi</a>
                                            <a href="javascript:void(0)" onclick="showID('map-1')">
                                                <svg class="pulse rounded" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16">
                                                    <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10m0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6"></path>
                                                </svg> Hue</a>
                                            <a href="javascript:void(0)" onclick="showID('map-2')">
                                                <svg class="pulse rounded" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16">
                                                    <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10m0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6"></path>
                                                </svg> Da Nang</a>
                                            <a href="javascript:void(0)" onclick="showID('map-3')">
                                                <svg class="pulse rounded" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16">
                                                    <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10m0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6"></path>
                                                </svg> Quy Nhon</a>
                                            <a href="javascript:void(0)" onclick="showID('map-4')">
                                                <svg class="pulse rounded" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16">
                                                    <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10m0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6"></path>
                                                </svg> Can Tho</a>
                                            <a href="javascript:void(0)" onclick="showID('map-5')">
                                                <svg class="pulse rounded" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16">
                                                    <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10m0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6"></path>
                                                </svg> Ho Chi Minh</a>

                                            <a href="javascript:void(0)">
                                                <svg class=" " xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                                                    <path d="M6.634 1.135A7 7 0 0 1 15 8a.5.5 0 0 1-1 0 6 6 0 1 0-6.5 5.98v-1.005A5 5 0 1 1 13 8a.5.5 0 0 1-1 0 4 4 0 1 0-4.5 3.969v-1.011A2.999 2.999 0 1 1 11 8a.5.5 0 0 1-1 0 2 2 0 1 0-2.5 1.936v-1.07a1 1 0 1 1 1 0V15.5a.5.5 0 0 1-1 0v-.518a7 7 0 0 1-.866-13.847"></path>
                                                </svg> Hoang Sa</a>

                                            <a href="javascript:void(0)">
                                                <svg class=" " xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                                                    <path d="M6.634 1.135A7 7 0 0 1 15 8a.5.5 0 0 1-1 0 6 6 0 1 0-6.5 5.98v-1.005A5 5 0 1 1 13 8a.5.5 0 0 1-1 0 4 4 0 1 0-4.5 3.969v-1.011A2.999 2.999 0 1 1 11 8a.5.5 0 0 1-1 0 2 2 0 1 0-2.5 1.936v-1.07a1 1 0 1 1 1 0V15.5a.5.5 0 0 1-1 0v-.518a7 7 0 0 1-.866-13.847"></path>
                                                </svg> Truong Sa</a>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- About Section -->
                <section id="about" class="about section">
                    <div class="container" data-aos="fade-up">
                        <div class="row gx-0">
                            <div class="col-lg-6 d-flex flex-column justify-content-center" data-aos="fade-up" data-aos-delay="200">
                                <div class="content">
                                    <h2>Who We Are</h2>
                                    <h3>FFC Forum and Social - Connect the world</h3>
                                    <p>
                                        Where we are dedicated to connecting the world through meaningful conversations and community engagement. Our platform provides a space for individuals from diverse backgrounds to come together, share their experiences, and build lasting connections. 
                                    </p>
                                    <div class="text-center text-lg-start">
                                        <a href="${pageContext.request.contextPath}/logingooglehandler?value=login" class="btn-read-more d-inline-flex align-items-center justify-content-center align-self-center">
                                            <span>Join</span>
                                            <i class="bi bi-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 px-4 d-flex align-items-center" data-aos="zoom-out" data-aos-delay="200">
                                <img src="${pageContext.request.contextPath}/static/images/group-27@2x-2.png" class="img-fluid" alt="">
                            </div>
                        </div>
                    </div>
                </section><!-- /About Section -->

                <!-- Values Section -->
                <section id="values" class="values section">
                    <!-- Section Title -->
                    <div class="container section-title" data-aos="fade-up">
                        <h2> Values</h2>
                        <p>What we value most<br></p>
                    </div><!-- End Section Title -->
                    <div class="container">
                        <div class="row gy-4">
                            <div class="col-lg-4 px-2" data-aos="fade-up" data-aos-delay="100">
                                <div class="card">
                                    <h3>Inclusivity</h3>
                                    <p>We are committed to creating a welcoming environment where everyone feels valued and respected. We celebrate diversity and ensure that every voice is heard, fostering a community where differences are not only accepted but cherished.</p>
                                </div>
                            </div><!-- End Card Item -->
                            <div class="col-lg-4 px-2" data-aos="fade-up" data-aos-delay="200">
                                <div class="card">
                                    <h3>Engagement</h3>
                                    <p> We believe in the power of active participation and open dialogue. Our platform encourages members to share their thoughts, experiences, and ideas, promoting meaningful connections and insightful discussions that enrich our collective understanding.</p>
                                </div>
                            </div><!-- End Card Item -->
                            <div class="col-lg-4 px-2" data-aos="fade-up" data-aos-delay="300">
                                <div class="card">
                                    <h3>Empowerment</h3>
                                    <p>We strive to empower individuals by providing a supportive space for personal growth and development. By facilitating access to information, resources, and a network of supportive peers, make positive contributions to the world.</p>
                                </div>
                            </div><!-- End Card Item -->
                        </div>
                    </div>
                </section><!-- /Values Section -->

                <!-- Faq Section -->
                <section id="faq" class="faq section">
                    <!-- Section Title -->
                    <div class="container section-title" data-aos="fade-up">
                        <h2>F.A.Q</h2>
                        <p>Frequently Asked Questions</p>
                    </div><!-- End Section Title -->
                    <div class="container">
                        <div class="row">
                            <div class="px-2 col-lg-6" data-aos="fade-up" data-aos-delay="100">
                                <div class="faq-container">
                                    <div class="accordion w-100" id="accordionLeft">
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingLeftOne">
                                                <button data-mdb-button-init data-mdb-collapse-init class="accordion-button collapsed" type="button"
                                                        data-mdb-target="#collapseLeftOne" aria-expanded="false" aria-controls="collapseLeftOne">
                                                    How do I create an account on FFC Forum and Social?
                                                </button>
                                            </h2>
                                            <div id="collapseLeftOne" class="accordion-collapse collapse" aria-labelledby="headingLeftOne"
                                                 data-mdb-parent="#accordionLeft">
                                                <div class="accordion-body">
                                                    <strong>To create an account,</strong> click on the 'Sign Up' button on the top right corner of the homepage. Fill in the required information, such as your name, email address, and a password. Once you've completed the form, click 'Submit' to create your account.
                                                </div>
                                            </div>
                                        </div>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingLeftTwo">
                                                <button data-mdb-button-init data-mdb-collapse-init class="accordion-button collapsed" type="button"
                                                        data-mdb-target="#collapseLeftTwo" aria-expanded="false" aria-controls="collapseLeftTwo">
                                                    How can I reset my password?
                                                </button>
                                            </h2>
                                            <div id="collapseLeftTwo" class="accordion-collapse collapse" aria-labelledby="headingLeftTwo"
                                                 data-mdb-parent="#accordionLeft">
                                                <div class="accordion-body">
                                                    <strong>If you’ve forgotten your password,</strong> click on the 'Forgot Password' link on the login page. Enter your email address, and we will send you instructions on how to reset your password.
                                                </div>
                                            </div>
                                        </div>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingLeftThree">
                                                <button data-mdb-button-init data-mdb-collapse-init class="accordion-button collapsed" type="button"
                                                        data-mdb-target="#collapseLeftThree" aria-expanded="false" aria-controls="collapseLeftThree">
                                                    How do I join a discussion group?
                                                </button>
                                            </h2>
                                            <div id="collapseLeftThree" class="accordion-collapse collapse" aria-labelledby="headingLeftThree"
                                                 data-mdb-parent="#accordionLeft">
                                                <div class="accordion-body">
                                                    <strong>To join a discussion group,</strong> navigate to the 'Groups' section of the site. Browse or search for a group that interests you, and click 'Join Group'. If the group is private, you may need to wait for approval from the group moderator.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End Faq Column -->

                            <div class="px-2 col-lg-6" data-aos="fade-up" data-aos-delay="200">
                                <div class="faq-container">
                                    <div class="accordion w-100" id="accordionRight">
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingRightOne">
                                                <button data-mdb-button-init data-mdb-collapse-init class="accordion-button collapsed" type="button"
                                                        data-mdb-target="#collapseRightOne" aria-expanded="false" aria-controls="#collapseRightOne">
                                                    What should I do if I encounter inappropriate content?
                                                </button>
                                            </h2>
                                            <div id="collapseRightOne" class="accordion-collapse collapse" aria-labelledby="headingRightOne"
                                                 data-mdb-parent="#accordionRight">
                                                <div class="accordion-body">
                                                    <strong>If you come across content that violates our community guidelines,</strong> click the 'Report' button next to the post. Our moderation team will review the report and take appropriate action.
                                                </div>
                                            </div>
                                        </div>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingRightTwo">
                                                <button data-mdb-button-init data-mdb-collapse-init class="accordion-button collapsed" type="button"
                                                        data-mdb-target="#collapseRightTwo" aria-expanded="false" aria-controls="collapseRightTwo">
                                                    How do I customize my profile?
                                                </button>
                                            </h2>
                                            <div id="collapseRightTwo" class="accordion-collapse collapse" aria-labelledby="headingRightTwo"
                                                 data-mdb-parent="#accordionRight">
                                                <div class="accordion-body">
                                                    <strong>To customize your profile,</strong> click on your profile picture or username at the top of the page to go to your profile. From there, you can update your profile picture, bio, and other personal details by clicking the 'Edit Profile' button.
                                                </div>
                                            </div>
                                        </div>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingRightThree">
                                                <button data-mdb-button-init data-mdb-collapse-init class="accordion-button collapsed" type="button"
                                                        data-mdb-target="#collapseRightThree" aria-expanded="false" aria-controls="collapseRightThree">
                                                    Can I make my profile private?
                                                </button>
                                            </h2>
                                            <div id="collapseRightThree" class="accordion-collapse collapse" aria-labelledby="headingRightThree"
                                                 data-mdb-parent="#accordionRight">
                                                <div class="accordion-body">
                                                    <strong>Yes, you can make your profile private.</strong> Go to the 'Settings' section of your profile and adjust the privacy settings to control who can see your posts, profile information, and activities.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End Faq Column -->
                        </div>
                    </div>
                </section><!-- /Faq Section -->
            </main>

            <footer id="footer" class="footer">
                <div class="footer-newsletter">
                    <div class="container">
                        <div class="row justify-content-center text-center">
                            <div class="col-lg-6">
                                <h4>Join Our Newsletter</h4>
                                <p>Subscribe to our newsletter and receive the latest news about our products and services!</p>
                                <form action="forms/newsletter.php" method="post" class="php-email-form">
                                    <div class="newsletter-form form-control"><input type="email" name="email" class="mx-2"><input type="submit" value="Subscribe"></div>
                                                <div class="loading">Loading</div>
                                                <div class="error-message"></div>
                                                <div class="sent-message">Your subscription request has been sent. Thank you!</div>
                                                </form>
                                                </div>
                                                </div>
                                                </div>
                                                </div>
                                                <div class="container footer-top">
                                                    <div class="row gy-4">
                                                        <div class="col-lg-4 col-md-12">
                                                            <a class="navbar-brand" href="#"> <img src="${pageContext.request.contextPath}/static/images/logo.png" width="100" alt="" /></a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="container copyright text-center mt-4">
                                                    <p>© <span>Copyright</span> <strong class="px-1 sitename">FPTer Developer Team 2024</strong> <span>All Rights Reserved</span></p>
                                                </div>
                                                </footer>

                                                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
                                                <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.0/js/bootstrap.bundle.min.js"></script>
                                                <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
                                                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.purecounter/0.3.4/jquery.purecounter.min.js"></script>

                                                <script>
                                                $(document).ready(function () {
                                                    $('#carouselExampleIndicators').carousel({
                                                        interval: 3000, // Adjust the interval as needed (3000ms = 3 seconds)
                                                        ride: 'carousel'
                                                    });
                                                });





                                                function showID(id) {
                                                    // Hide all images
                                                    const images = document.querySelectorAll('.building-map');
                                                    images.forEach(image => image.classList.add('d-none'));

                                                    const sectionMap = document.getElementById("section-map");

                                                    // Show the selected image and update the background image of the section
                                                    const selectedImageContainer = document.getElementById(id);
                                                    if (selectedImageContainer) {
                                                        selectedImageContainer.classList.remove('d-none');
                                                        const imgElement = selectedImageContainer.querySelector('img');
                                                        if (imgElement) {
                                                            const imageUrl = imgElement.getAttribute('src');
                                                            const section = document.getElementById('section-map');
                                                            sectionMap.style.backgroundImage = 'url(' + imageUrl + ')';
                                                            console.log(imageUrl);
                                                        }
                                                    }
                                                }

                                                // Optionally, show the first image by default
                                                document.addEventListener('DOMContentLoaded', () => {
                                                    showID('map-0'); // Show the first image initially
                                                });


                                                </script>
                                                </body>

                                                <%@ include file="include/footer.jsp" %>
                                                <script>
                                                    document.addEventListener('DOMContentLoaded', function () {
                                                    var nav = document.getElementById('legends-nav');
                                                            var navOffset = nav.offsetTop; // Get the initial offset position of the navbar
                                                </script>
