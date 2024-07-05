<%-- 
    Document   : showAds
    Created on : May 15, 2024, 4:26:01â¯PM
    Author     : mac
show this in right index

Không pull cái này lên chỉ test Advertising

--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>


<div class="showAds card">
    <a id="adURL" href="" target="_blank">

        <img id="adImage" class="card-img-top event-img" alt="...">
    </a>
    <div class="card-body">
        <h5 id="adTitle" class="card-title  my-3"><strong>Loading ad...</strong></h5>

        <small><p id="adOrganizer" class="card-text"></p></small>
        <small><p id="adDate" class="card-text"></p></small>
    </div>
</div>


<script>
    function loadAd() {
        var comboType = 'like'; // Example comboType
        var targetSex = '${USER.userSex}'.toLowerCase(); // Replace with your dynamic value from server

        var url = '${pageContext.request.contextPath}/advertising/show?comboType=' + comboType + '&targetSex=' + targetSex;

        fetch(url)
                .then(response => response.json())
                .then(data => {
                    if (data.ad && data.ad.adsId) { // Check if valid ad data is returned
                        document.getElementById('adURL').href = '${pageContext.request.contextPath}/redirect?to='+data.ad.uri+'&a='+data.ad.adsId;
                        document.getElementById('adTitle').innerText = data.ad.title;
                        document.getElementById('adImage').src = '${pageContext.request.contextPath}/'+data.ad.image;
                        document.getElementById('adImage').alt = data.ad.title;
                        document.getElementById('adDate').innerText = data.ad.startDate; // Assuming startDate is a valid date field
                        document.getElementById('adOrganizer').innerText = 'Sponsored by: ' + data.user.userFullName; // Use userFullName for the sponsor name
                    } else {
                        document.getElementById('adTitle').innerText = 'No ad found';
                        document.getElementById('adImage').src = ''; // Clear image if no ad found
                        document.getElementById('adDate').innerText = '';
                        document.getElementById('adOrganizer').innerText = '';
                    }
                })
                .catch(error => {
                    console.error('Error loading ad details:', error);
                    document.getElementById('adTitle').innerText = 'Error loading ad details.';
                    document.getElementById('adImage').src = ''; // Clear image on error
                    document.getElementById('adDate').innerText = '';
                    document.getElementById('adOrganizer').innerText = '';
                });
    }

// Call loadAd() when the window loads
    window.onload = function () {
        loadAd();
    };

</script>
