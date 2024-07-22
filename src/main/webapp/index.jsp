<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
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
                            <%@ include file="topic/tabTopic.jsp" %>
                            <%-- Hiển thị tin nhắn thành công nếu có --%>
                            <c:if test="${sessionScope.USER ne null}">
                                <%@ include file="topic/newPost.jsp" %>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </body>
    </c:otherwise>
</c:choose>

<script>
    function loadAdView() {
        var comboType = 'view'; // Example comboType
                var targetSex = '${USER.userSex}'.toLowerCase(); // Replace with your dynamic value from server

                var url = '${pageContext.request.contextPath}/advertising/show?comboType=' + comboType + '&targetSex=' + targetSex;

        fetch(url)
                .then(response => response.json())
                .then(data => {
                    if (data.ad && data.ad.adsId) { // Check if valid ad data is returned
                                document.getElementById('adURL').href = '${pageContext.request.contextPath}/redirect?to=' + data.ad.uri + '&a=' + data.ad.adsId;
                        document.getElementById('adTitle').innerText = data.ad.title;
                                document.getElementById('adImage').src = '${pageContext.request.contextPath}/' + data.ad.image;
                        document.getElementById('adImage').alt = data.ad.title;
                        document.getElementById('adDate').innerText = data.ad.startDate; // Assuming startDate is a valid date field
                        document.getElementById('adOrganizer').innerText = 'Sponsored by: ' + data.user.userFullName; // Use userFullName for the sponsor name

                        document.getElementById('showAds').style.display = 'block';
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
        loadAdView();
    };
</script>





<%@ include file="include/footer.jsp" %>
