<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<aside class="left-sidebar">
    <style>
        .sub-item{
            font-size: 13px;
            padding-left: 20px;
        }
        .invisible {
            opacity: 0.2;
        }

        .note {
            font-style: italic;
            font-size: 130%;
        }

        .video-container {
            position: relative;
            width: 100%;
            margin: auto;
        }

        video {
            display: block;
            width: 100%;
            transform: rotateY(180deg);
            -webkit-transform: rotateY(180deg);
            -moz-transform: rotateY(180deg);
        }

        .output_canvas {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            transform: rotateY(180deg);
            -webkit-transform: rotateY(180deg);
            -moz-transform: rotateY(180deg);
        }

        .detectOnClick {
            cursor: pointer;
            margin-bottom: 2em;
        }

        .detectOnClick img {
            width: 100%;
        }
    </style>

    <!-- Sidebar scroll-->  
    <div class="brand-logo d-flex align-items-center justify-content-between">
        <a href="${pageContext.request.contextPath}/home" class="text-nowrap logo-img">
            <img src="${pageContext.request.contextPath}/static/images/logo.png" width="100" alt="" />
        </a>
        <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
            <i class="ti ti-x fs-8"></i>
        </div>
    </div>
    <!-- Sidebar navigation-->
    <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
        <ul id="sidebarnav">
            <c:if test="${USER.userRole == 3}">
                <li class="sidebar-item">
                    <a class="rounded sidebar-link rounded has-arrow" href="javascript:void(0)" aria-expanded="false">
                        <span>
                            <i class="ti ti-users"></i>
                        </span>
                        <span class="hide-menu">Admin <i style="font-size: 13px" class="ti ti-arrow-down"></i></span>
                    </a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/ManageUsers?action=allUser" class="sidebar-link rounded" role="button">
                                <span class="hide-menu">- Manage users</span>
                            </a>
                        </li>
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/handelRpManager" class="sidebar-link rounded">
                                <span class="hide-menu">- Handle report manager</span>
                            </a>
                        </li>

                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/approveshop" class="sidebar-link rounded">
                                <span class="hide-menu">- Approve shop</span>
                            </a>
                        </li>

                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/createvoucher" class="sidebar-link rounded">
                                <span class="hide-menu">- Create voucher</span>
                            </a>
                        </li>
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/viewFeedBack" class="sidebar-link rounded">
                                <span class="hide-menu">- View feedback</span>
                            </a>
                        </li>
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/admin/transaction" class="sidebar-link rounded">
                                <span class="hide-menu">- Transaction Manage</span>
                            </a>
                        </li>
                    </ul>
                </li>
            </c:if>
            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/post" aria-expanded="false">
                    <span>
                        <i class="ti ti-article"></i>
                    </span>
                    <span class="hide-menu">News Feed</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/group" aria-expanded="false">
                    <span>
                        <i class="ti ti-users"></i>
                    </span>
                    <span class="hide-menu">Group</span>
                </a>
            </li>

            <c:if test="${USER.userRole > 1}">
                <li class="sidebar-item">
                    <a class="sidebar-link rounded has-arrow" href="javascript:void(0)" aria-expanded="false">
                        <span>
                            <i class="ti ti-users"></i>
                        </span>
                        <span class="hide-menu">Manager <i style="font-size: 13px" class="ti ti-arrow-down"></i></span>
                    </a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/manager/post" class="sidebar-link rounded">
                                <span class="hide-menu">- Approve Post</span>
                            </a>
                        </li>
                        <li class="sidebar-item sub-item">
                            <a href="${pageContext.request.contextPath}/manager/report" class="sidebar-link rounded">
                                <span class="hide-menu">- Handle report</span>
                            </a>
                        </li>
                    </ul>
                </li>
            </c:if>

            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/listEvent" aria-expanded="false">
                    <span>
                        <i class="ti ti-calendar-event"></i>
                    </span>
                    <span class="hide-menu">Event</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/advertising" aria-expanded="false">
                    <span>
                        <i class="ti ti-speakerphone"></i>
                    </span>
                    <span class="hide-menu">Advertising</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/rank" aria-expanded="false">
                    <span>
                        <i class="ti ti-trophy"></i>
                    </span>
                    <span class="hide-menu">Rank</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link rounded" href="${pageContext.request.contextPath}/marketplace" aria-expanded="false">
                    <span>
                        <i class="ti ti-basket"></i>
                    </span>
                    <span class="hide-menu">Marketplace</span>
                </a>
            </li>
        </ul>
        <c:choose>
            <c:when test="${USER.userRank == 3 && USER.userRole == 1}">
                <%@ include file="../user/managerRegistr.jsp" %>
            </c:when>
            <c:otherwise>
                <%@ include file="../ads/showAds.jsp" %>
            </c:otherwise>
        </c:choose>
        <c:if test="${USER.userRole != 3}">
            <%@ include file="../user/feedBackModal.jsp" %>
        </c:if>

        <div class="d-flex w-100">
            <div class="swipe-mode" style="width: 65px">
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
                    <path d="M11.251.068a.5.5 0 0 1 .227.58L9.677 6.5H13a.5.5 0 0 1 .364.843l-8 8.5a.5.5 0 0 1-.842-.49L6.323 9.5H3a.5.5 0 0 1-.364-.843l8-8.5a.5.5 0 0 1 .615-.09z"/>
                    </svg>
                </a>
            </div>
        </div>


        <!-- Webcam Modal -->
        <div class="webcam-popup modal fade" id="webcamModal" tabindex="-1" aria-labelledby="webcamModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content rounded1dot2">
                    <div class="modal-header">
                        <h3 class="modal-title" id="webcamModalLabel">Hand Tracking</h3>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <section id="demos">
                            <div class="video-container" class="mb-3" id="liveView">
                                <video id="webcam" autoplay playsinline></video>
                                <canvas class="output_canvas" id="output_canvas"></canvas>
                            </div>
                            <h3>Distance between Index and Middle Fingers: <span id="fingerDistance">0</span></h3>

                        </section>
                        <p> 1 finger to turn Dark Mode On </p>
                        <p> 3 fingers to turn Dark Mode Off </p>
                        <p> 2 fingers to scroll </p>
                        <p> 5 fingers to turn off Camera</p>

                    </div>
                </div>
            </div>
        </div>
        <!-- Webcam Modal -->


    </nav>
</aside>
<script type="module">
    import { HandLandmarker, FilesetResolver } from "https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@0.10.0";
    const demosSection = document.getElementById("demos");
    let handLandmarker = undefined;
    let runningMode = "IMAGE";
    let webcamRunning = false;
    const enableWebcamButton = document.getElementById("webcamButton");
    const video = document.getElementById("webcam");
    const canvasElement = document.getElementById("output_canvas");
    const canvasCtx = canvasElement.getContext("2d");
    let lastVideoTime = -1;
    let results = undefined;
    const checkbox = document.getElementById("checkbox");
    const webcamModal = document.getElementById("webcamModal");

    // Biến lưu trữ vị trí ngón tay trước đó để làm mượt
    let previousIndexTip = {x: 0, y: 0};
    let previousMiddleTip = {x: 0, y: 0};

    enableWebcamButton.addEventListener("click", toggleWebcam);

    async function createHandLandmarker() {
        const vision = await FilesetResolver.forVisionTasks("https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@0.10.0/wasm");
        handLandmarker = await HandLandmarker.createFromOptions(vision, {
            baseOptions: {
                modelAssetPath: `https://storage.googleapis.com/mediapipe-models/hand_landmarker/hand_landmarker/float16/1/hand_landmarker.task`,
                delegate: "GPU"
            },
            runningMode: runningMode,
            numHands: 2
        });
        demosSection.classList.remove("invisible");
    }
    createHandLandmarker();

    async function toggleWebcam() {
        if (!handLandmarker) {
            console.log("Wait! handLandmarker not loaded yet.");
            return;
        }

        if (webcamRunning) {
            stopWebcam();
        } else {
            startWebcam();
        }
    }

    function startWebcam() {
        navigator.mediaDevices.getUserMedia({video: true})
                .then((stream) => {
                    video.srcObject = stream;
                    video.addEventListener("loadeddata", () => {
                        runningMode = "VIDEO";
                        handLandmarker.setOptions({runningMode: "VIDEO"});
                        webcamRunning = true;
                        predictWebcam();
                    });
                })
                .catch((error) => {
                    console.error("Error accessing webcam:", error);
                });
    }

    function stopWebcam() {
        if (video.srcObject) {
            video.srcObject.getTracks().forEach(track => track.stop());
        }
        video.srcObject = null;
        webcamRunning = false;
    }

    async function predictWebcam() {
        canvasElement.style.width = "100%";
        canvasElement.style.height = "100%";
        canvasElement.width = video.videoWidth;
        canvasElement.height = video.videoHeight;

        if (runningMode === "IMAGE") {
            runningMode = "VIDEO";
            await handLandmarker.setOptions({runningMode: "VIDEO"});
        }
        let startTimeMs = performance.now();
        if (lastVideoTime !== video.currentTime) {
            lastVideoTime = video.currentTime;
            results = await handLandmarker.detectForVideo(video, startTimeMs);
        }
        canvasCtx.save();
        canvasCtx.clearRect(0, 0, canvasElement.width, canvasElement.height);

        if (results.landmarks) {
            for (const landmarks of results.landmarks) {
                drawConnectors(canvasCtx, landmarks, HAND_CONNECTIONS, {color: "#00FF00", lineWidth: 5});
                drawLandmarks(canvasCtx, landmarks, {color: "#FF0000", lineWidth: 2});

                const fingerCount = countFingers(landmarks);
                handleScroll(landmarks);

                if (fingerCount === 1) {
                    console.log("1 ngón tay được phát hiện, bật dark mode");
                    checkbox.checked = true;
                    document.body.classList.add("dark");
                    await delay(500); // Thêm delay 500ms trước khi tiếp tục
                } else if (fingerCount === 3) {
                    console.log("3 ngón tay được phát hiện, tắt dark mode");
                    checkbox.checked = false;
                    document.body.classList.remove("dark");
                    await delay(500); // Thêm delay 500ms trước khi tiếp tục
                } else if (fingerCount === 5) {
                    console.log("5 ngón tay được phát hiện, đóng webcam");
                    stopWebcam();
                    const modal = bootstrap.Modal.getInstance(webcamModal);
                    if (modal) {
                        modal.hide();
                    }
                    await delay(500); // Thêm delay 500ms trước khi tiếp tục
                } else if (fingerCount === 2) {
                    console.log("2 ngón tay được phát hiện");
                    const distance = calculateFingerDistance(landmarks);
                    if (distance > 10) {
                        const indexTip = landmarks[8];
                        const middleTip = landmarks[12];

                        // Tính toán vị trí trung bình động
                        const smoothedIndexTip = {
                            x: (indexTip.x + previousIndexTip.x) / 2,
                            y: (indexTip.y + previousIndexTip.y) / 2
                        };
                        const smoothedMiddleTip = {
                            x: (middleTip.x + previousMiddleTip.x) / 2,
                            y: (middleTip.y + previousMiddleTip.y) / 2
                        };

                        // Cập nhật vị trí ngón tay trước đó
                        previousIndexTip = smoothedIndexTip;
                        previousMiddleTip = smoothedMiddleTip;

                        if (smoothedIndexTip.y < 0.5 && smoothedMiddleTip.y < 0.5) {
                            // Scroll up
                            window.scrollBy(0, -1000);
                            await delay(500); // Thêm delay 500ms trước khi tiếp tục
                        } else if (smoothedIndexTip.y > 0.5 && smoothedMiddleTip.y > 0.5) {
                            // Scroll down
                            window.scrollBy(0, 1000);
                            await delay(500); // Thêm delay 500ms trước khi tiếp tục
                        }
                    }
                } else {
                    console.log("Không có hành động phù hợp với số lượng ngón tay được phát hiện");
                }
            }
        }

        canvasCtx.restore();

        if (webcamRunning === true) {
            window.requestAnimationFrame(predictWebcam);
        }
    }

    function countFingers(landmarks) {
        const fingerTips = [8, 12, 16, 20];
        let count = 0;

        if (landmarks[8].y < landmarks[6].y)
            count++;
        if (landmarks[12].y < landmarks[10].y)
            count++;
        if (landmarks[16].y < landmarks[14].y)
            count++;
        if (landmarks[20].y < landmarks[18].y)
            count++;
        if (landmarks[4].x < landmarks[3].x)
            count++; // Thumb detection
        return count;
    }

    function handleScroll(landmarks) {
        const canvasHeight = canvasElement.height;
        const indexTip = landmarks[8];
        const middleTip = landmarks[12];

        const distance = Math.abs(indexTip.y - middleTip.y) * canvasHeight;

        document.getElementById('fingerDistance').textContent = distance.toFixed(2);

        if (indexTip.y * canvasHeight > canvasHeight && middleTip.y * canvasHeight > canvasHeight) {
            window.scrollBy(0, 1000);
        } else if (indexTip.y * canvasHeight < 0 && middleTip.y * canvasHeight < 0) {
            window.scrollBy(0, -1000);
        }
    }

    function calculateFingerDistance(landmarks) {
        const fingerTips = [8, 12, 16, 20];
        let totalDistance = 0;
        let count = 0;
        for (let i = 0; i < fingerTips.length; i++) {
            for (let j = i + 1; j < fingerTips.length; j++) {
                const distance = Math.sqrt(
                        Math.pow(landmarks[fingerTips[i]].x - landmarks[fingerTips[j]].x, 2) +
                        Math.pow(landmarks[fingerTips[i]].y - landmarks[fingerTips[j]].y, 2)
                        );
                totalDistance += distance;
                count++;
            }
        }
        return totalDistance / count;
    }

    const HAND_CONNECTIONS = [
        [0, 1], [1, 2], [2, 3], [3, 4],
        [0, 5], [5, 6], [6, 7], [7, 8],
        [5, 9], [9, 10], [10, 11], [11, 12],
        [9, 13], [13, 14], [14, 15], [15, 16],
        [13, 17], [0, 17], [17, 18], [18, 19], [19, 20], [17, 20]
    ];

    function drawConnectors(ctx, landmarks, connections, { color, lineWidth }) {
        const canvasWidth = ctx.canvas.width;
        const canvasHeight = ctx.canvas.height;

        ctx.lineWidth = lineWidth;
        ctx.strokeStyle = color;

        connections.forEach(([start, end]) => {
            const startLandmark = landmarks[start];
            const endLandmark = landmarks[end];

            ctx.beginPath();
            ctx.moveTo(startLandmark.x * canvasWidth, startLandmark.y * canvasHeight);
            ctx.lineTo(endLandmark.x * canvasWidth, endLandmark.y * canvasHeight);
            ctx.stroke();
        });
    }

    function drawLandmarks(ctx, landmarks, { color, lineWidth }) {
        const canvasWidth = ctx.canvas.width;
        const canvasHeight = ctx.canvas.height;

        ctx.fillStyle = color;
        ctx.lineWidth = lineWidth;

        landmarks.forEach(landmark => {
            ctx.beginPath();
            ctx.arc(landmark.x * canvasWidth, landmark.y * canvasHeight, lineWidth, 0, 2 * Math.PI);
            ctx.fill();
        });
    }

    function setCookie(name, value, days) {
        const d = new Date();
        d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000));
        const expires = "expires=" + d.toUTCString();
        document.cookie = name + "=" + (value || "") + ";" + expires + ";path=/";
    }

    function getCookie(name) {
        const nameEQ = name + "=";
        const ca = document.cookie.split(';');
        for (let i = 0; i < ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) === ' ')
                c = c.substring(1);
            if (c.indexOf(nameEQ) === 0)
                return c.substring(nameEQ.length, c.length);
        }
        return null;
    }

    function applyDarkMode() {
        const darkMode = getCookie("darkMode");
        if (darkMode === "true") {
            document.body.classList.add("dark");
            checkbox.checked = true;
        } else {
            document.body.classList.remove("dark");
            checkbox.checked = false;
        }
    }

    checkbox.addEventListener("change", () => {
        const isChecked = checkbox.checked;
        if (isChecked) {
            document.body.classList.add("dark");
        } else {
            document.body.classList.remove("dark");
        }
        setCookie("darkMode", isChecked, 7); // Save the preference for 7 days
    });

    applyDarkMode();

    webcamModal.addEventListener("hidden.bs.modal", () => {
        stopWebcam();
    });

    function delay(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
</script>



<script>
    var contextPath = '<%= request.getContextPath() %>';
    var oldNotificationCount = 0;
    $(document).ready(function () {
        var socket = new WebSocket("ws://" + window.location.host + contextPath + "/notifications");
        socket.onmessage = function (event) {
            var data = JSON.parse(event.data);
            if (data.type === "notification") {
                loadNotifications();
            }
        };
        function loadNotifications() {
            $.ajax({
                url: contextPath + '/notifications',
                method: 'GET',
                success: function (data) {
                    $('#notificationList').empty();
                    if (data.length > 0) {
                        var newNotificationCount = data.length;
                        var newNotifications = newNotificationCount - oldNotificationCount;
                        if (newNotifications != oldNotificationCount) {
                            $('#notificationCount').text(newNotifications).show();
                        } else {
                            $('#notificationCount').text(oldNotificationCount).show();
                        }
                        $('#notificationList').prepend('<li class="notification-item px-4 pb-3 border-bottom"><p class="text-danger mb-0">Bạn có ' + newNotificationCount + ' thông báo chưa đọc</p> <a href="' + contextPath + '/allnotifications"><p class="text-primary ">Show all</p></a></li>');
                        var notificationsToShow = data.slice(0, 10);
                        $.each(notificationsToShow, function (index, notification) {
                            var listItem = $('<li class="notification-item"></li>');
                            var link = $('<a class="dropdown-item" href="' + contextPath + notification.notification_link + '"></a>');
                            link.click(function () {
                                updateNotificationStatus(notification.notificationId);
                            });
                            link.append(notification.message + '<br><span class="date">' + notification.date + '</span>');
                            listItem.append(link);
                            $('#notificationList').append(listItem);
                        });
                    } else {
                        $('#notificationList').empty();
                        $('#notificationCount').text(oldNotificationCount).show();
                        $('#notificationList').append('<li class="notification-item"><a class="dropdown-item" >No new notifications</a></li>');
                    }
                }
            });
        }

        function updateNotificationStatus(notificationId) {
            $.ajax({
                url: contextPath + '/notifications',
                method: 'POST',
                data: {notificationId: notificationId},
                success: function (response) {
                    console.log('Notification status updated successfully.');
                },
                error: function (xhr, status, error) {
                    console.error('Failed to update notification status:', error);
                }
            });
        }

        // Handle click event for reloading wallet
        $('#reloadWalletIcon').on('click', function (event) {
            event.preventDefault(); // Prevent the default action

            $.ajax({
                url: contextPath + '/reloadwallet', // Change this to your actual endpoint
                method: 'POST',
                success: function (data) {
                    // Assuming the response contains the updated wallet amount
                    $('#walletAmount').text('Wallet: ' + data.newWalletAmount);
                },
                error: function (xhr, status, error) {
                    console.error('Failed to reload wallet:', error);
                }
            });
        });

        $.ajax({
            url: contextPath + '/notifications',
            method: 'GET',
            success: function (data) {
                oldNotificationCount = data.length;
                $('#notificationCount').text(oldNotificationCount).show();
            }
        });
        loadNotifications();
//            setInterval(loadNotifications, 2000);

        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
        $('#dropdownMenuLink').on('click', function () {
            $('#notificationCount').hide();
            oldNotificationCount = 0;
            loadNotifications();
            $.ajax({
                url: contextPath + '/notifications',
                method: 'GET',
                success: function (data) {
                    oldNotificationCount = data.length;
                    $('#notificationCount').text(oldNotificationCount).show();
                }
            });
            loadNotifications();
        });
    });
    $(document).ready(function () {
        var userId = USER.userId; // Sử dụng USER.userId trực tiếp
        var searchInput = $('#searchInput');
        var searchDropdown = $('#searchDropdown');
        var searchHistoryKey = 'searchHistory_' + userId;

        // Load search history from localStorage
        var searchHistory = JSON.parse(localStorage.getItem(searchHistoryKey)) || [];
        console.log("Loaded search history for user " + userId + ":", searchHistory);

        // Function to save search query to search history
        function saveToSearchHistory(query) {
            // Remove query if already exists to maintain uniqueness
            var index = searchHistory.indexOf(query);
            if (index !== -1) {
                searchHistory.splice(index, 1);
            }
            // Add query to beginning of search history
            searchHistory.unshift(query);
            // Limit search history to 7 items
            if (searchHistory.length > 7) {
                searchHistory.pop();
            }
            // Save updated search history to localStorage
            localStorage.setItem(searchHistoryKey, JSON.stringify(searchHistory));
            console.log("Updated search history for user " + userId + ":", searchHistory);
        }

        // Function to render search history dropdown
        function renderSearchHistory() {
            console.log("Rendering search history for user " + userId + ":", searchHistory);
            searchDropdown.empty();

            // Add "History" title


            searchHistory.forEach(function (query) {
                searchDropdown.append('<div class="list-group-item history-item">' +
                        '<span class="query-text">' + query + '</span>' +
                        '<span class="close-btn">&times;</span>' +
                        '</div>');
            });
            searchDropdown.show();
        }

        // Function to perform search suggestions
        function performSearch(query) {
            $.ajax({
                url: '${pageContext.request.contextPath}/searchSuggestions',
                type: 'GET',
                data: {query: query},
                success: function (data) {
                    try {
                        var suggestions = JSON.parse(data);
                        searchDropdown.empty();
                        suggestions.forEach(function (user) {
                            searchDropdown.append('<a href="${pageContext.request.contextPath}/profile?username=' + user.username + '" class="list-group-item list-group-item-action">' + user.userFullName + '</a>');
                        });
                        searchDropdown.show();
                    } catch (e) {
                        console.error('JSON parse error: ', e);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('AJAX request error: ', status, error);
                }
            });
        }

        // Event handler for search input focus
        searchInput.on('focus', function () {
            console.log("Search input focused");
            if (searchHistory.length > 0) {
                renderSearchHistory();
            } else {
                console.log("No search history to show");
            }
        });

        // Event handler for typing in search input
        searchInput.on('input', function () {
            var query = $(this).val();
            console.log("Search input value:", query);
            if (query.length > 1) {
                performSearch(query);
            } else {
                searchDropdown.hide();
            }
        });

        // Event delegation for clicking on history items and close buttons
        $(document).on('click', '.history-item', function (event) {
            var target = $(event.target);
            if (target.hasClass('close-btn')) {
                // Handle delete history item
                var query = target.siblings('.query-text').text().trim();
                searchHistory = searchHistory.filter(function (item) {
                    return item !== query;
                });
                localStorage.setItem(searchHistoryKey, JSON.stringify(searchHistory));
                renderSearchHistory();
            } else {
                event.preventDefault();
                var query = $(this).find('.query-text').text().trim();
                searchInput.val(query);
                saveToSearchHistory(query); // Save selected history item to history
                performSearch(query); // Perform search based on selected history item
                searchDropdown.hide();
            }
        });

        // Click handler to hide dropdown when clicking outside searchInput and searchDropdown
        $(document).click(function (event) {
            if (!$(event.target).closest('#searchInput, #searchDropdown').length) {
                searchDropdown.hide();
            }
        });

        // Event handler for search form submission to save the query
        $('.d-flex').on('submit', function (event) {
            var query = searchInput.val().trim();
            if (query.length > 0) {
                saveToSearchHistory(query);
            }
        });
    });

</script>

