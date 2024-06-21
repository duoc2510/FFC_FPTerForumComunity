<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Ứng dụng Chat</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #1a1a1a;
                color: #f4f4f9;
                margin: 0;
                padding: 0;
            }

            h1 {
                text-align: center;
                color: #ddd;
            }

            .container {
                display: flex;
                justify-content: center;
                align-items: flex-start;
                margin-top: 50px;
                gap: 20px;
                padding: 20px;
            }

            .friend-list {
                width: 30%;
                background: #2a2a2a;
                padding: 20px;
                border-radius: 8px;
            }

            .friend {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }

            .friend img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
            }

            .friend button {
                background-color: #007BFF;
                color: white;
                border: none;
                border-radius: 5px;
                padding: 10px;
                cursor: pointer;
                flex-grow: 1;
            }

            .friend button:hover {
                background-color: #0056b3;
            }

            .chat-container {
                width: 70%;
                background: #333;
                padding: 20px;
                border-radius: 8px;
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            #friendName {
                color: #ddd;
                margin-bottom: 10px;
            }

            #chat {
                background: #444;
                border-radius: 8px;
                padding: 10px;
                overflow-y: auto;
                height:  400px;
                display: flex;
                flex-direction: column;
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

            .input-group {
                display: flex;
                width: 100%;
            }

            #message {
                flex-grow: 1;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
                background-color: #333;
                color: #f4f4f9;
            }

            .input-group button {
                padding: 10px 20px;
                margin-left: 10px;
                border: none;
                border-radius: 5px;
                background-color: #007BFF;
                color: white;
                cursor: pointer;
            }

            .input-group button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <h1>F Social Chat</h1>
        <div class="container">
            <div class="friend-list">
                <h2>Liên hệ của bạn</h2>
                <!-- Assuming friends is a list of objects containing userId, username, and userAvatar -->
                <c:forEach var="friend" items="${friends}">
                    <div class="friend">
                        <img src="${friend.userAvatar}" alt="${friend.username}">
                        <button onclick="setAndLoadMessages(${friend.userId}, '${friend.username}')">${friend.username}</button>
                    </div>
                </c:forEach>
            </div>
            <div class="chat-container">
                <div id="friendName"></div>
                <div id="chat" class="chat"></div>
                <div class="input-group">
                    <input type="text" id="message" placeholder="Nhập tin nhắn của bạn" required>
                    <button onclick="sendMessage()">Gửi</button>
                </div>
            </div>
        </div>

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

                // Display friend's name
                let friendNameDiv = document.getElementById("friendName");
                friendNameDiv.textContent = username;

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
    </body>
</html>