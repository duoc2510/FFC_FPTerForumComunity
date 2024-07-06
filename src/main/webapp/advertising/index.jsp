<%-- 
    Document   : index
    Created on : May 25, 2024, 9:43:06 PM
    Author     : mac
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../include/header.jsp" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid pb-2">
                <div class="row">
                    <div id="profile-wrapper">
                        <div class="bg-white shadow rounded overflow-hidden">
                            <div class="p-5 cover" style="background: linear-gradient(to right, #7f7fd5, #86a8e7, #91eae4); height:250px;">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 ">

                                        <h2 class="text-light">Your customers are here. Find them with FFC ads.</h2>
                                        <p class="text-light">Reach new and existing customers as they connect with people and find communities on FFC.</p>
                                        <img src="${pageContext.request.contextPath}/static/images/fb.webp" class="mx-2 position-absolute w-25 h-auto " style="top: 9em;right: 3em;" width="100%">
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid pt-0">
                <div class="row form-settings d-flex justify-content-between">
                    <div class="col-12 col-sm-3 px-2">
                        <%@include file="menuAds.jsp" %>
                    </div>
                    <div class="col-12 col-sm-9 px-3">
                        <div class="bg-white shadow rounded p-4">
                            <div>
                                <div class="mb-4">
                                    <h3>What are FFC ads?</h3>
                                    <h6>All advertising activity running</h6>
                                    <p>Build lasting connections with customers with Facebook ads, Instagram ads and ads clicking to WhatsApp and Messenger. <BR><BR>
                                        Billions of people use Meta apps to connect with people and explore topics they care about. Your Meta ads can show up as your customers explore their Facebook Feed or watch Instagram Reels or check their Messenger inbox. <BR><BR>
                                        Businesses like yours use Meta ads to increase online sales, drive in-store traffic and find new customers. Whether you're new to online advertising or are an experienced marketer, Meta is here to give you the resources and support you need to succeed. <BR><BR>
                                    </p>
                                </div>
                                <div class="form-group pb-3">
                                    <div class="d-flex flex-row align-items-center mb-4 pb-1 row">

                                        <div class="col-6 px-2">
                                            <img src="https://maisonoffice.vn/wp-content/uploads/2023/12/0-tru-so-fpt.jpg" class="card-img w-100" alt="${ads.content}" style="height: 300px; object-fit: cover; border: 0px solid; border-radius: 10px 10px 0 0;">

                                            <div class="card p-4">

                                                <h5 class="card-title mt-2">${ads.title}</h5>

                                                <div class="row mb-1 align-items-center">
                                                    <div class="col-3  px-3 ">
                                                        <img src="https://yt3.googleusercontent.com/ytc/AIdro_mM0vTEH0LMtwoQCZ5d52gd0Rpv5KbfBoGtm3GHeEH2Gg=s900-c-k-c0x00ffffff-no-rj" class="card-img" alt="avatarUser" style="object-fit: cover; border: 0px solid; border-radius: 50%;">
                                                    </div>
                                                    <div class="col-9">
                                                        <p class="ml-auto"><b> FPT Corporate</b></p>
                                                        <span>Sponsored</span>
                                                    </div>
                                                </div>


                                                <p class="card-text mt-2">
                                                    ${ads.title}
                                                </p>

                                                <p class="card-text mt-2">

                                                </p>
                                            </div>
                                        </div>
                                        <div class="col-6 px-4">
                                            <h3>Find a budget that works for your business.</h3>
                                            <p class=" mb-4">You can start, stop and pause your ads at any time, so you're always in control. We also recommend a budget based on ads like yours, so you feel informed when you decide what to spend..</p>
                                            <a href="${pageContext.request.contextPath}/advertising/campaign">
                                                <button class="btn btn-primary mt-3">Go to campaign</button>
                                            </a>
                                        </div>



                                    </div>
                                </div>
                                <div class="form-group pb-3">
                                    <div class="d-flex flex-row align-items-center mb-4 pb-1 row">
                                        <div class="col-6 px-4">
                                            <h3> Download information and track spending</h3>
                                            <p>For ads about social issues, elections or politics, use the Ad Library report to see overall spending totals and details about spending by advertiser and location.
                                                Who the report is for
                                                Anyone who wants to quickly explore, filter and download data on ads about social issues, elections or politics.</p>
                                            <a href="${pageContext.request.contextPath}/advertising/report">
                                                <button class="btn btn-primary mt-3">Go to report</button>
                                            </a>
                                        </div>


                                        <div class="col-6 px-2">
                                            <img src="${pageContext.request.contextPath}/static/images/ads2.png" class="card-img w-100" alt="${ads.content}" style="height: 300px; object-fit: cover; border: 0px solid; border-radius: 10px 10px 0 0;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</body>
<script>
    function handleActiveChange(adsId, isActive) {
        if (isActive == false) {
            isActive = 0;
        } else {
            isActive = 1;
        }
        var data = {
            action: "changeActive",
            adsId: adsId,
            isActive: isActive  // Convert boolean to integer (1 or 0)
        };

        $.ajax({
            url: '${pageContext.request.contextPath}/advertising/boost', // Update URL according to your servlet mapping
            type: 'POST',
            data: data,
            dataType: 'json',
            success: function (response) {
                if (response.success) {
                    swal("Success! Your advertising status has been changed!", {
                        icon: "success",
                    }).then(() => {
                        location.reload();
                    });
                } else {
                    swal("Error!", response.message, "error");
                }
            },
            error: function (xhr, status, error) {
                swal("Error!", "Unable to update advertising status.", "error");
            }
        });
    }
</script>
<%@ include file="../include/footer.jsp" %>
