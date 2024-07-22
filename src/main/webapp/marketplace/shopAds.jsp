<%-- 
    Document   : shopAds.jsp
    Created on : Jul 17, 2024, 10:12:31 PM
    Author     : mac
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>

<div class="col-md-4">
    <div class="card mx-2">
        <img id="adsImageMessage" style="height: 100%" class="card-img-top">
        <div class="card-body">
            <h5 style="text-align: center;" class="card-title">
                <a style="color: black; font-size: 20px; font-weight: bold;" href="" class="text-decoration-none" id="adsOrganizer"></a>
            </h5>
            <p class="card-text">
                <i class="fas fa-university me-2"></i>
                <a style="color: black;" class="text-decoration-none" id="adsContentMessage"></a>
            </p>
            <p class="card-text">
                <i class="fas fa-info-circle me-2"></i>
                <a style="color: black;" class="text-decoration-none" id="adsInfo"></a>
            </p>
            <p class="card-text">
                <i class="fa-solid fa-shield-halved me-2"></i>
                <a style="color: black;" class="text-decoration-none">Advertising</a>
            </p>
            <a href="#" id="adsURL" class="btn btn-primary mt-3 w-100">
                Sponsored
            </a>
        </div>
    </div>
</div>

<script>
    function loadAdMessage() {
        var comboTypeMessage = 'message'; // Example comboType
        var targetSexMessage = '${USER.userSex}'.toLowerCase(); // Replace with your dynamic value from server

        var urlMessage = '${pageContext.request.contextPath}/advertising/show?comboType=' + comboTypeMessage + '&targetSex=' + targetSexMessage;

        fetch(urlMessage)
                .then(response => response.json())
                .then(dataAdsMessage => {
                    console.log(dataAdsMessage);

                    if (dataAdsMessage.ad && dataAdsMessage.ad.adsId) { // Check if valid ad dataAdsMessage is returned
                        document.getElementById('adsImageMessage').src = '${pageContext.request.contextPath}/' + dataAdsMessage.ad.image;
                        document.getElementById('adsImageMessage').alt = dataAdsMessage.ad.title;

                        document.getElementById('adsContentMessage').innerText = dataAdsMessage.ad.title;
                        document.getElementById('adsURL').href = '${pageContext.request.contextPath}/redirect?to=' + dataAdsMessage.ad.uri;

                        // Assuming additional fields exist, set them as well
                        document.getElementById('adsOrganizer').innerText = dataAdsMessage.ad.title; // Sponsor name
                        document.getElementById('adsInfo').innerText = dataAdsMessage.ad.content || 'No additional info'; // Additional info
                        document.getElementById('adsPhone').innerText = dataAdsMessage.ad.phone || 'No phone number'; // Phone number
                    } else {
                        console.log('No ad found');
                    }
                })
                .catch(error => {
                    console.error('Error loading ad details:', error);
                });
    }

    // Call loadAdMessage() when the window loads
    window.onload = function () {
        loadAdMessage(); // Only load the message ad
        loadAdTraffic();

    };
</script>
