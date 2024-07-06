<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>
    <c:choose>
        <c:when test="${empty sessionScope.USER}">
            <%@ include file="index_guest.jsp" %>
        </c:when>
        <c:otherwise>
            <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
                 data-sidebar-position="fixed" data-header-position="fixed">
                <%@ include file="include/slidebar.jsp" %>
                <div class="body-wrapper">
                    <%@ include file="include/navbar.jsp" %>
                    <div class="container-fluid d-flex">
                        <div class="col-lg-12 w-100">

                            <style>
                                .slider{
                                    width:100%;
                                    height:2px;
                                }
                                .line{
                                    position:absolute;
                                    background:#4a8df8;
                                    width:400px;
                                    height:2px;
                                }
                                .break{
                                    position:absolute;
                                    background:#222;
                                    width:6px;
                                    height:2px;
                                }

                                .dot1{
                                    -webkit-animation: loading 2s infinite;
                                    -moz-animation: loading 2s infinite;
                                    -ms-animation: loading 2s infinite;
                                    -o-animation: loading 2s infinite;
                                    animation: loading 2s infinite;
                                }
                                .dot2{
                                    -webkit-animation: loading 2s 0.5s infinite;
                                    -moz-animation: loading 2s 0.5s infinite;
                                    -ms-animation: loading 2s 0.5s infinite;
                                    -o-animation: loading 2s 0.5s infinite;
                                    animation: loading 2s 0.5s infinite;
                                }
                                .dot3{
                                    -webkit-animation: loading 2s 1s infinite;
                                    -moz-animation: loading 2s 1s infinite;
                                    -ms-animation: loading 2s 1s infinite;
                                    -o-animation: loading 2s 1s infinite;
                                    animation: loading 2s 1s infinite;
                                }

                                @keyframes "loading" {
                                    from {
                                        left: 0;
                                    }
                                    to {
                                        left: 400px;
                                    }
                                }
                                @-moz-keyframes loading {
                                    from {
                                        left: 0;
                                    }
                                    to {
                                        left: 400px;
                                    }
                                }
                                @-webkit-keyframes "loading" {
                                    from {
                                        left: 0;
                                    }
                                    to {
                                        left: 400px;
                                    }
                                }
                                @-ms-keyframes "loading" {
                                    from {
                                        left: 0;
                                    }
                                    to {
                                        left: 400px;
                                    }
                                }
                                @-o-keyframes "loading" {
                                    from {
                                        left: 0;
                                    }
                                    to {
                                        left: 400px;
                                    }
                                }
                            </style>

                            <div class="mt-4">

                                <h1>Just a moment...</h1>
                                <h4 id="countdown">10 seconds </h4>

                                <div class="slider">
                                    <div class="line"></div>
                                    <div class="break dot1"></div>
                                    <div class="break dot2"></div>
                                    <div class="break dot3"></div>
                                </div>

                                <div class="my-4">
                                    <span class="mt-4">Double Check Redirect URL</span>
                                    <input class="form-control mt-2 mb-4" type="text" value="${redirectTo}" readonly/>
                                    <p class="mb-4">We're redirecting you to out FFC System... Check again and be safe? <a href="javascript:history.back()">Click here to go back.</a></p>
                                    <button class="btn btn-light" id="cancelButton" style="margin-right: 2em">Cancel Redirect</button>
                                    <button class="btn btn-primary" id="redirectNowButton">Redirect Now</button>
                                </div>




                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <script>
        // Retrieve the URL to redirect to
        var url = '${redirectTo}';
        console.log(url); // Outputs the complete URL

// Check if the URL contains the context path
        if (url.includes("${pageContext.request.contextPath}")) {
            // chuyen trang lien 
            window.location.href = url;
        } else {
            let countdown = 10;
            let countdownElement = document.getElementById('countdown');

            // Start the countdown interval
            let interval = setInterval(() => {
                countdown--;
                countdownElement.textContent = countdown + ' seconds';
                if (countdown === 0) {
                    clearInterval(interval);
                    window.location.href = url;
                }
            }, 1000);

            // Add event listener for the cancel button
            document.getElementById('cancelButton').addEventListener('click', () => {
                clearInterval(interval);
                countdownElement.textContent = 'Redirect cancelled';
            });

            // Add event listener for the redirect now button
            document.getElementById('redirectNowButton').addEventListener('click', () => {
                clearInterval(interval);
                window.location.href = url;
            });
        }



    </script>
    <%@ include file="include/footer.jsp" %>
</body>
