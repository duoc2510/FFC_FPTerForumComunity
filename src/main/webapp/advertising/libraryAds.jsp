<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                            <div class="px-4 py-4 cover" style="background: url(${pageContext.request.contextPath}/upload/deli-2.png); height:250px;">
                                <div class="media align-items-end profile-head">
                                    <div class="profile mr-3 d-flex justify-content-between align-items-end">
                                        <img src="${pageContext.request.contextPath}/${USER.userAvatar}" class="position-absolute rounded-circle img-thumbnail" style="object-fit: cover;">
                                    </div>
                                </div>
                            </div>
                            <div class="bg-light pt-4 px-4 d-flex justify-content-between text-center">
                                <div class="media-body mb-5 text-white">
                                    <h4 class="mt-0 mb-0 position-relative" style="left: 6.5em">${USER.userFullName}</h4>
                                </div>
                                <ul class="list-inline mb-0"></ul>
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
                    <div class="col-12 col-sm-9 px-2">
                        <div class="bg-white shadow rounded p-4">
                            <div>
                                <div class="mb-4">
                                    <span>To find an ad, search for keywords or an advertiser.</span>
                                    <h3>Advertising Library</h3>
                                    <h6>Search all the ads currently running across Meta technologies, as well as: <br/>
                                        Ads about social issues, event or activity that have run.<br/>
                                        Ads that have run anywhere in the Campus.<br/>
                                    </h6>
                                </div>
                                <div class="form-group pb-3">
                                    <div class="d-flex flex-row align-items-center mb-4 pb-1 row">
                                        <form class="form-inline my-3 mb-4">
                                            <div class=" d-flex mb-3"> 
                                                <select id="location" name="location" class="form-control form-select" style="margin-right:2%;">
                                                    <option value="all">All location</option>
                                                </select>
                                                <select class="form-control  form-select" name="targetSex">
                                                    <option selected value="all">All gender</option>
                                                    <option value="male">Male</option>
                                                    <option value="female">Female</option>
                                                </select>
                                            </div>

                                            <div class=" d-flex">
                                                <input class="form-control mr-sm-2" name="search" type="search" placeholder="Search" aria-label="Search" style="margin-right:2%;">
                                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                                            </div>
                                        </form>
                                        <div class=" mb-3 col-12" style="width: 100%;">
                                            <div id="cardAdvertising" class="row no-gutters px-3">


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $.getJSON('${pageContext.request.contextPath}/static/json/data.json', function (data) {
            // Iterate over each campus in the JSON data
            $.each(data.Campus, function (index, campus) {
                // Append a checkbox for each campus
                $('#location').append('  <option value="' + campus.ID + '">' + campus.Name + '</option>');
            });

        });
        // Safely embed JSON data
        // Get JSON data from JSP
        let adsWithComboDataJson = ${adsWithComboDataJson};
        let adUserMapJson = ${adUserMapJson};

        let formattedAdsJson = JSON.stringify(adsWithComboDataJson, null, 4);
        let formattedUserMapJson = JSON.stringify(adUserMapJson, null, 4);

        // Parse JSON data
        let adsWithComboData = JSON.parse(formattedAdsJson);
        let adUserMap = JSON.parse(formattedUserMapJson);

        // Function to create card HTML
        function convertToJsonString(str) {
            // Remove "Ads{" from the beginning and "}" from the end
            str = str.replace(/^Ads{/, '').replace(/}$/, '');

            // Split by commas to get key-value pairs
            let pairs = str.split(', ');

            // Create an object to store key-value pairs
            let obj = {};

            // Process each pair and add to the object
            pairs.forEach(pair => {
                // Split by "=" to separate key and value
                let parts = pair.split('=');
                let key = parts[0].trim(); // Trim to remove any leading or trailing spaces
                let value = parts[1].trim(); // Trim to remove any leading or trailing spaces

                // Adjust value if it's a string (enclose in double quotes)
                if (value.startsWith('"') && value.endsWith('"')) {
                    // Remove enclosing double quotes
                    value = value.slice(1, -1);
                } else if (!isNaN(value)) {
                    // Convert numeric strings to numbers
                    value = Number(value);
                } else if (value === "true" || value === "false") {
                    // Convert boolean strings to booleans
                    value = value === "true";
                }

                // Assign to the object
                obj[key] = value;
            });

            // Convert the object to JSON string
            return JSON.stringify(obj);
        }

        function createCardHtml(key, adUser) {
//            console.log(adUserMap[ad.adsDetailId].userFullName); // get name
//            console.log(ad.adsDetailId);
//            console.log(adUser);
            key = convertToJsonString(key);
            key = JSON.parse(key);


            console.log(adUser);
            console.log(key);

//            console.log(key.adsDetailId);
//            console.log(adUser[key.adsDetailId].userAvatar);

            return `
         <div class="col-6 px-2 mb-4">
             <img src="${pageContext.request.contextPath}/` + key.image + `" class="card-img w-100" style="height: 300px; object-fit: cover; border: 0px solid; border-radius: 10px 10px 0 0;">
             <div class="card p-4">
                 <p>Advertising ID: ` + key.adsId + `</p>
                 <h5 class="card-title mt-2">` + key.title + `</h5>
                 <div class="row mb-1 align-items-center">
                     <div class="col-3">
                         <img src="${pageContext.request.contextPath}/` + adUser[key.adsDetailId].userAvatar + `" class="card-img px-3" alt="avatarUser" style="object-fit: cover; border: 0px solid; border-radius: 50%;">
                     </div>
                     <div class="col-9">
                         <p class="ml-auto"><b>` + adUser[key.adsDetailId].userFullName + `</b></p>
                         <span>Sponsored</span>
                     </div>
                 </div>
                 <p class="mt-1">Started running on ` + key.startDate + `</p>
                 <p class="card-text mt-2">` + key.content + `</p>
                 <p class="card-text mt-2">URL: <a href="${pageContext.request.contextPath}/redirect?to=` + key.uri + `&a=` + key.adsId + `" target="_blank">` + key.uri + `</a></p>
                  <p class="card-text mt-2"> ` + (key.isActive == 1 ? 'Active' : 'Not active') + `</p>
             </div>
         </div>
     `;
        }

        // Render cards
//        console.log(adsWithComboData);
        const cardAdvertising = document.getElementById('cardAdvertising');

        // Function to render the ads asynchronously
        async function renderAds() {
            for (const [key, ad] of Object.entries(adsWithComboData)) {
                const adsIdMatch = key.match(/adsId=(\d+)/);
                if (adsIdMatch) {
                    const adsId = adsIdMatch[1]; // Extract adsId from the key
                    const adUser = adUserMap;

                    const cardHtml = createCardHtml(key, adUser);

                    cardAdvertising.innerHTML += cardHtml;

                }
            }
        }

        // Call the function to render ads
        renderAds();
    </script>



    <%@ include file="../include/footer.jsp" %>
</body>
