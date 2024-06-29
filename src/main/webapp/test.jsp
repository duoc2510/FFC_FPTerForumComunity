<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>
    <style>
        .friend img, .user-cover {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border: 0px solid;
            border-radius: 50%;
        }
        .username img {
            width: 40px !important;
            height: 40px !important;
        }
        .chat-container {
            width: 70%;
            padding: 20px;
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            position: relative;
            height: 100%;
        }
        #friendName {
            font-weight: 600;
            font-size: 20px;
        }
        .container-fluid {
            height: 100vh;
            display: flex;
        }
        .input-group {
            width: 94%;
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
        }
        .message {
            margin: 10px 0;
            padding: 10px;
            border-radius: 15px;
            word-wrap: break-word;
            max-width: 70%;
        }
        .message.user {
            background-color: #4CAF50;
            color: white;
            align-self: flex-end;
            text-align: right;
            margin-left: auto;
        }
        .message.other {
            background-color: #ddd;
            color: black;
            align-self: flex-start;
            text-align: left;
            margin-right: auto;
        }
        .message.other .username {
            font-weight: bold;
            margin-bottom: 5px;
        }
        #chat {
            border-radius: 8px;
            padding: 10px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            height: calc(100vh - 150px); /* Adjust height to account for header, input group, etc. */
            margin-bottom: 60px; /* Space for the input group */
        }
    </style>
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
                        <div class="friend-list col-12 col-md-4 px-3">
                            <!-- Danh sách bạn bè sẽ được tải động vào đây -->
                        </div>
                        <div class="chat-container col-12 col-md-8 p-2 card rounded pb-2 px-4">
                            <div id="friendName" class="pt-2"></div>
                            <div id="chat" class="chat"></div>
                            <div class="input-group mb-3 position-absolute pt-2">
                                <input class="form-control" type="text" id="message" placeholder="Nhập tin nhắn của bạn" required onkeypress="checkEnter(event)">
                                <button class="btn btn-primary" onclick="sendMessage()">Gửi</button>
                            </div>
                        </div>
                        <script>
                            let ws = new WebSocket("ws://localhost:8080/FPTer/chat");
                            let toId = null;
                            let loggedInUserId = ${USER.userId}; // Giả sử USER là biến JavaScript được truyền từ phía server

                            ws.onopen = function () {
                                console.log('WebSocket đã kết nối.');
                                loadFriends();
                            };

                            function loadFriends() {
                                let messageObj = {
                                    type: "loadFriends"
                                };
                                ws.send(JSON.stringify(messageObj));
                            }

                            ws.onmessage = function (event) {
                                let data = JSON.parse(event.data);

                                if (data.type === "chat") {
                                    handleChatMessage(data);
                                } else if (data.type === "loadMessages") {
                                    handleLoadMessages(data);
                                } else if (data.type === "loadFriends") {
                                    handleLoadFriends(data.friends, data.latestFriendId, data.latestFriendUsername);
                                }
                            };

                            function handleChatMessage(data) {
                                let chat = document.getElementById("chat");
                                let fromId = data.fromId;
                                let fromUsername = data.fromUsername;
                                let messageText = data.messageText;

                                let messageDiv = document.createElement("div");
                                messageDiv.classList.add("message");

                                if (fromId === loggedInUserId || toId === fromId) {
                                    if (fromId === loggedInUserId) {
                                        messageDiv.classList.add("user");
                                    } else {
                                        messageDiv.classList.add("other");
                                        let usernameDiv = document.createElement("div");
                                        usernameDiv.classList.add("username");
                                        usernameDiv.textContent = fromUsername;
                                        messageDiv.appendChild(usernameDiv);
                                    }

                                    messageDiv.appendChild(document.createTextNode(messageText));
                                    chat.appendChild(messageDiv);
                                    scrollToBottom();
                                } else {
                                    console.log("Received message not relevant to current chat window.");
                                }
                            }

                            function handleLoadMessages(data) {
                                let chat = document.getElementById("chat");
                                chat.innerHTML = "";
                                data.messages.forEach(function (message) {
                                    let fromId = message.fromId;
                                    let fromUsername = message.fromUsername;
                                    let messageText = message.messageText;

                                    let messageDiv = document.createElement("div");
                                    messageDiv.classList.add("message");

                                    if (fromId === loggedInUserId || toId === fromId) {
                                        if (fromId === loggedInUserId) {
                                            messageDiv.classList.add("user");
                                        } else {
                                            messageDiv.classList.add("other");
                                            let usernameDiv = document.createElement("div");
                                            usernameDiv.classList.add("username");
                                            usernameDiv.textContent = fromUsername;
                                            messageDiv.appendChild(usernameDiv);
                                        }

                                        messageDiv.appendChild(document.createTextNode(messageText));
                                        chat.appendChild(messageDiv);
                                        scrollToBottom();
                                    } else {
                                        console.log("Loaded message not relevant to current chat window.");
                                    }
                                });
                            }

                            function handleLoadFriends(friends, latestFriendId, latestFriendUsername) {
                                let friendList = document.querySelector(".friend-list");
                                friendList.innerHTML = "";

                                friends.forEach(function (friend) {
                                    let friendDiv = document.createElement("div");
                                    friendDiv.classList.add("friend", "list-group");

                                    let friendLink = document.createElement("a");
                                    friendLink.classList.add("list-group-item", "list-group-item-action");
                                    friendLink.href = "javascript:void(0)";
                                    friendLink.onclick = function () {
                                        setAndLoadMessages(friend.id, friend.username);
                                    };

                                    let friendContent = document.createElement("div");
                                    friendContent.classList.add("d-flex", "py-2");

                                    let friendImg = document.createElement("img");
                                    friendImg.classList.add("d-inline");

                                    // Kiểm tra và log đường dẫn của avatar
                                    if (friend.avatar == null || friend.avatar.trim() === "") {
                                        console.log("Avatar path is not available for", friend.username);
                                        // Đặt ảnh mặc định tại đây (đường dẫn của ảnh mặc định)
                                        friendImg.src = "/path/to/default/avatar.jpg"; // Thay đổi đường dẫn ảnh mặc định tại đây
                                    } else {
                                        friendImg.src = friend.avatar;
                                        console.log("Avatar path for", friend.username, "is", friend.avatar);
                                    }

                                    friendImg.alt = friend.username;

                                    let friendName = document.createElement("h4");
                                    friendName.classList.add("d-flex", "align-items-center", "px-3");
                                    friendName.textContent = friend.username;

                                    friendContent.appendChild(friendImg);
                                    friendContent.appendChild(friendName);
                                    friendLink.appendChild(friendContent);
                                    friendDiv.appendChild(friendLink);
                                    friendList.appendChild(friendDiv);
                                });

                                if (latestFriendId && latestFriendUsername) {
                                    setAndLoadMessages(latestFriendId, latestFriendUsername);
                                }
                            }

                            function setAndLoadMessages(userId, username) {
                                toId = userId;

                                let messageObj = {
                                    type: "loadMessages",
                                    toId: toId
                                };

                                let chat = document.getElementById("chat");
                                chat.innerHTML = "";

                                let friendNameDiv = document.getElementById("friendName");
                                friendNameDiv.textContent = username;

                                ws.send(JSON.stringify(messageObj));
                            }

                            function scrollToBottom() {
                                let chat = document.getElementById("chat");
                                chat.scrollTop = chat.scrollHeight;
                            }

                            function sendMessage() {
                                let messageInput = document.getElementById("message");
                                if (!messageInput.value.trim()) {
                                    alert("Tin nhắn không được để trống");
                                    return;
                                }

                                if (ws.readyState === WebSocket.OPEN) {
                                    let messageObj = {
                                        type: "chat",
                                        toId: toId,
                                        fromId: loggedInUserId,
                                        fromUsername: '${USER.username}', // Giả sử USER.username là biến JavaScript được truyền từ phía server
                                        messageText: messageInput.value
                                    };

                                    ws.send(JSON.stringify(messageObj));
                                    messageInput.value = '';
                                } else {
                                    console.log('Kết nối WebSocket không mở.');
                                }
                            }

                            function checkEnter(event) {
                                if (event.key === "Enter") {
                                    sendMessage();
                                }
                            }
                        </script>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</body>
<%@ include file="include/footer.jsp" %>
