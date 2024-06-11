<%-- 
    Document   : index_guest
    Created on : Jun 10, 2024, 7:20:33 AM
    Author     : Admin
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/home.css" />
<!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>-->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">

<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light px-5">
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
            <div class="my-2 my-lg-0">
                <a href="${pageContext.request.contextPath}/logingooglehandler?value=login" class="btn btn-outline-success my-2 my-sm-0">Login</a>
            </div>
        </div>
    </nav>
    <main class="main">
        <section id="hero" class="hero section" style="padding-top: 60px;">
            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img class="d-block w-100" src="${pageContext.request.contextPath}/static/images/banner_desktop.jpg" alt="First slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="${pageContext.request.contextPath}/static/images/banner_fpt_v.league.jpg" alt="Second slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="${pageContext.request.contextPath}/static/images/2048x560-gtbb_t3-2024.png" alt="Third slide">
                    </div>
                </div>
                <a class="carousel-control-prev"  role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
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
                            <img src="assets/img/values-1.png" class="img-fluid" alt="">
                            <h3>Inclusivity</h3>
                            <p>We are committed to creating a welcoming environment where everyone feels valued and respected. We celebrate diversity and ensure that every voice is heard, fostering a community where differences are not only accepted but cherished.</p>
                        </div>
                    </div><!-- End Card Item -->

                    <div class="col-lg-4 px-2" data-aos="fade-up" data-aos-delay="200">
                        <div class="card">
                            <img src="assets/img/values-2.png" class="img-fluid" alt="">
                            <h3>Engagement</h3>
                            <p> We believe in the power of active participation and open dialogue. Our platform encourages members to share their thoughts, experiences, and ideas, promoting meaningful connections and insightful discussions that enrich our collective understanding.</p>
                        </div>
                    </div><!-- End Card Item -->

                    <div class="col-lg-4 px-2" data-aos="fade-up" data-aos-delay="300">
                        <div class="card">
                            <img src="assets/img/values-3.png" class="img-fluid" alt="">
                            <h3>Empowerment.</h3>
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
                                        data-mdb-target="#collapseRightOne" aria-expanded="false" aria-controls="collapseRightOne">
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
                            <div class="newsletter-form"><input type="email" name="email"><input type="submit" value="Subscribe"></div>
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
    <script>
        $(document).ready(function () {
            $('.carousel').carousel({
                interval: 1000
            });
        });
    </script>

</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.purecounter/0.3.4/jquery.purecounter.min.js"></script>

<%@ include file="include/footer.jsp" %>
