<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>
    <style>
        .friend img, .user-cover{
            width:60px;
            height:60px;
            object-fit:cover;
            border: 0px solid;
            border-radius: 50%;
        }
        .username img{
            width:40px !important;
            height:40px !important;
        }
        .chat .message {
            display: flex;
            padding: 5px 0;
            align-items: center;
        }
        .chat .user{
            justify-content: flex-end;
        }
        .chat .username{
            font-weight: 600;
            margin-right: 10px;
        }
        #friendName{
            font-weight: 600;
            font-size:20px;
        }
        .container-fluid{
            height: 100vh;
        }
        .input-group{
            width: 94%;
            bottom: 0;
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
                        <!--<div class="container">-->
                        <div class="friend-list col-12 col-md-4 px-3">
                            <!--<h2>Liên hệ của bạn</h2>-->
                            <!-- Assuming friends is a list of objects containing userId, username, and userAvatar -->
                            <c:forEach var="friend" items="${friends}">
                                <div class="friend list-group">

                                    <a onclick="setAndLoadMessages(${friend.userId}, '${friend.username}')" class="list-group-item list-group-item-action" href="javascript:void(0)">
                                        <div class="d-flex py-2">
                                            <img class="d-inline" src="${friend.userAvatar}" alt="${friend.username}"> 
                                            <h4  class="d-flex align-items-center px-3">${friend.username}</h4>
                                        </div>
                                    </a>

                                </div>
                            </c:forEach>
                        </div>
                        <div class="chat-container col-12 col-md-8 p-2 card rounded  pb-2 px-4">
                            <div id="friendName" class="pt-2"></div>
                            <div id="chat" class="chat"></div>
                            <div class="input-group mb-3 position-absolute pt-2"> 

                                <input  class="form-control"  type="text" id="message" placeholder="Nhập tin nhắn của bạn" required>
                                <button  class="btn btn-primary" onclick="sendMessage()">Gửi</button>
                            </div>
                        </div>
                        <!--</div>-->

                        <script>
                            let ws = new WebSocket("ws://localhost:8080/FPTer/chat");
                            let toId = null;
                            let loggedInUserId = ${USER.userId}; // Assuming USER is a JavaScript variable passed from server-side

                            ws.onopen = function () {
                                console.log('WebSocket đã kết nối.');
                            };

                            function setAndLoadMessages(userId, username) {
                                toId = userId;

                                let messageObj = {
                                    type: "loadMessages",
                                    toId: toId
                                };

                                // Clear chat window
                                let chat = document.getElementById("chat");
                                chat.innerHTML = "";

                            <c:forEach var="friend" items="${friends}">

                                // Display friend's name
                                let friendNameDiv = document.getElementById("friendName");
                                friendNameDiv.innerHTML = `
                            <div class="d-flex">
                        <img class="user-cover" src="${friend.userAvatar}" alt="${friend.username}"> 
                            <h4 class="d-flex align-items-center px-3">${friend.username}</h4>
</div>`;
                            </c:forEach>

                                // Send request to server to load messages
                                if (ws.readyState === WebSocket.OPEN) {
                                    ws.send(JSON.stringify(messageObj));
                                } else {
                                    console.log('Kết nối WebSocket không mở.');
                                }
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
                                        fromUsername: '${USER.username}', // Assuming USER.username is a JavaScript variable passed from server-side
                                        messageText: messageInput.value
                                    };

                                    ws.send(JSON.stringify(messageObj));
                                    messageInput.value = '';
                                } else {
                                    console.log('Kết nối WebSocket không mở.');
                                }
                            }

                            ws.onmessage = function (event) {
                                let data = JSON.parse(event.data);
                                let chat = document.getElementById("chat");

                                if (data.type === "chat") {
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
                                } else if (data.type === "loadMessages") {
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
                            <c:forEach var="friend" items="${friends}">

                                                usernameDiv.innerHTML = ' <img class="user-cover" src="${friend.userAvatar}" alt="${friend.username}"> ';
                            </c:forEach>
                                                messageDiv.appendChild(usernameDiv);
                                            }

                                            let messageContent = document.createElement("div");
                                            messageContent.classList.add("messageContent");

                                            messageDiv.appendChild(document.createTextNode(messageText));
                                            chat.appendChild(messageDiv);
                                            scrollToBottom();
                                        } else {
                                            console.log("Loaded message not relevant to current chat window.");
                                        }
                                    });
                                }
                            };

                            ws.onerror = function (event) {
                                console.error('Lỗi WebSocket đã được quan sát:', event);
                            };

                            ws.onclose = function (event) {
                                console.log('WebSocket đã đóng.');
                            };

                            function scrollToBottom() {
                                let chat = document.getElementById("chat");
                                chat.scrollTop = chat.scrollHeight;
                            }
                        </script>
                    </div>
                </div>
            </div>
        </body>
    </c:otherwise>
</c:choose>
<%@ include file="include/footer.jsp" %>
