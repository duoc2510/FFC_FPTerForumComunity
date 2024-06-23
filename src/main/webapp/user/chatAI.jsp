<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>ChatGPT Interface</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .chat-container {
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
                width: 400px;
                max-width: 100%;
                overflow: hidden;
            }

            .chat-box {
                padding: 20px;
            }

            .chat-box h1 {
                margin: 0 0 20px;
                text-align: center;
            }

            .messages {
                margin-bottom: 20px;
            }

            .message {
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 10px;
            }

            .user-message {
                background-color: #d1e7dd;
                text-align: left;
            }

            .bot-response {
                background-color: #f8d7da;
                text-align: left;
            }

            form {
                display: flex;
            }

            input[type="text"] {
                flex: 1;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px 0 0 5px;
                border-right: none;
            }

            button {
                padding: 10px;
                border: none;
                background-color: #007bff;
                color: #fff;
                border-radius: 0 5px 5px 0;
                cursor: pointer;
            }

            button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="chat-container">
            <div class="chat-box">
                <h1>ChatGPT Interface</h1>
                <div class="messages" id="messages">
                    <!-- Messages will be displayed here -->
                </div>
                <input type="text" id="userInput" name="message" placeholder="Type your message here..." required>
                <button type="button" onclick="handleButtonClick()">Send</button>
            </div>
        </div>

        <script type="importmap">
            {
            "imports": {
            "@google/generative-ai": "https://esm.run/@google/generative-ai"
            }
            }
        </script>

        <script type="module">
            import { GoogleGenerativeAI } from "@google/generative-ai";

            const API_KEY = "AIzaSyBiU9x-qZ67Y8F3Xu9QY58klyQlVw-p4M0"; // Replace with your actual API key

            const genAI = new GoogleGenerativeAI(API_KEY);
            const model = genAI.getGenerativeModel({model: "gemini-1.5-flash"});

            async function run(prompt) {
                const result = await model.generateContent(prompt);
                const response = await result.response;
                const text = await response.text();
                return text;
            }

            window.handleButtonClick = async function () {
                const userInput = document.getElementById("userInput").value;
                const messagesDiv = document.getElementById("messages");
                console.log(userInput);
                // Display user's message
                const userMessageDiv = document.createElement("div");
                userMessageDiv.className = "message user-message";
                userMessageDiv.innerHTML = "You: " + userInput;
                messagesDiv.appendChild(userMessageDiv);

                // Clear input field
                document.getElementById("userInput").value = '';

                // Get bot response
                const botResponse = await run(userInput);

                // Display bot's response
                const botResponseDiv = document.createElement("div");
                botResponseDiv.className = "message bot-response";
                botResponseDiv.innerHTML = "Bot: " + botResponse;
                messagesDiv.appendChild(botResponseDiv);
            }

            document.getElementById("userInput").addEventListener("keydown", function(event) {
                if (event.key === "Enter") {
                    handleButtonClick();
                }
            });
        </script>
    </body>
</html>
