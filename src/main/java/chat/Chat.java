package chat;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.*;
import jakarta.websocket.server.HandshakeRequest;
import jakarta.websocket.server.ServerEndpoint;
import jakarta.websocket.server.ServerEndpointConfig;
import model.User;
import org.json.JSONArray;
import org.json.JSONObject;
import java.io.IOException;
import java.sql.*;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.DAO.DBinfo;
import model.DAO.User_DB;
import notifications.NotificationWebSocket;

@ServerEndpoint(value = "/chat", configurator = Chat.Configurator.class)
public class Chat {

    private static final Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) throws IOException {
        HttpSession httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
        if (httpSession == null || httpSession.getAttribute("USER") == null) {
            System.out.println("User not found in session. Closing connection.");
            session.close(new CloseReason(CloseReason.CloseCodes.UNEXPECTED_CONDITION, "User not authenticated."));
            return;
        }

        clients.add(session);
        System.out.println("New connection with client: " + session.getId());

        // Load message senders list and messages from the latest sender when a new session opens
        handleLoadMessageSenders(session);
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
        System.out.println("Client disconnected: " + session.getId());
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        clients.remove(session);
        throwable.printStackTrace();
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("Received message: " + message);

        try {
            JSONObject jsonMessage = new JSONObject(message);
            String type = jsonMessage.getString("type");

            if ("chat".equals(type)) {
                handleChatMessage(jsonMessage, session);
            } else if ("loadMessages".equals(type)) {
                handleLoadMessages(jsonMessage, session);
            } else if ("loadMessageSenders".equals(type)) {
                handleLoadMessageSenders(session);
            } else {
                System.out.println("Invalid message type received: " + type);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void handleChatMessage(JSONObject jsonMessage, Session session) throws Exception {
        NotificationWebSocket nw = new NotificationWebSocket();
        int toId = jsonMessage.getInt("toId");
        int fromId = jsonMessage.getInt("fromId");
        String messageText = jsonMessage.getString("messageText");

        // Save message to database
        saveMessageToDatabase(fromId, toId, messageText);

        // Get fromUsername from database
        String fromUsername = getUsername(fromId);

        // Broadcast message to relevant clients
        broadcastMessage(fromId, fromUsername, toId, messageText);
        String notificationMessage = fromUsername + " sent you a message.";
        nw.saveNotificationToDatabase(toId, notificationMessage, "/messenger");
        nw.sendNotificationToClient(toId, notificationMessage, "/messenger");

        // Update message senders list for both sender and receiver without interrupting the current chat
        updateMessageSenders(session, fromId);
        Session receiverSession = getSessionById(toId);
        if (receiverSession != null) {
            updateMessageSenders(receiverSession, toId);
        }
    }

    private void handleLoadMessages(JSONObject jsonMessage, Session session) throws Exception {
        int toId = jsonMessage.getInt("toId");
        int fromId = getUserId(session);

        // Send existing messages to the client
        sendExistingMessages(session, fromId, toId);
    }

    private void handleLoadMessageSenders(Session session) {
        int userId = getUserId(session);

        // Get users who have sent messages to the current user (toId = userId), ordered by the latest message
        List<User> messageSenders = User_DB.getUsersWhoMessagedUserOrderByLatestMessage(userId);

        // Create JSON array from the users list
        JSONArray sendersArray = new JSONArray();
        JSONObject response = new JSONObject();

        if (!messageSenders.isEmpty()) {
            User latestSender = messageSenders.get(0);  // Get the most recent sender
            response.put("latestSenderId", latestSender.getUserId());
            response.put("latestSenderUsername", latestSender.getUsername());
        }

        for (User sender : messageSenders) {
            JSONObject senderObj = new JSONObject();
            senderObj.put("id", sender.getUserId());
            senderObj.put("username", sender.getUsername());
            senderObj.put("avatar", sender.getUserAvatar());
            sendersArray.put(senderObj);
        }

        // Create response JSON
        response.put("type", "loadMessageSenders");
        response.put("senders", sendersArray);

        // Send the senders list to the client
        session.getAsyncRemote().sendText(response.toString());

        // Automatically load messages from the latest sender if there is one
        if (!messageSenders.isEmpty()) {
            try {
                JSONObject jsonMessage = new JSONObject();
                jsonMessage.put("toId", messageSenders.get(0).getUserId());
                handleLoadMessages(jsonMessage, session);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void updateMessageSenders(Session session, int userId) {
        // Get users who have sent messages to the current user (toId = userId), ordered by the latest message
        List<User> messageSenders = User_DB.getUsersWhoMessagedUserOrderByLatestMessage(userId);

        // Create JSON array from the users list
        JSONArray sendersArray = new JSONArray();
        JSONObject response = new JSONObject();

        for (User sender : messageSenders) {
            JSONObject senderObj = new JSONObject();
            senderObj.put("id", sender.getUserId());
            senderObj.put("username", sender.getUsername());
            senderObj.put("avatar", sender.getUserAvatar());
            sendersArray.put(senderObj);
        }

        // Create response JSON
        response.put("type", "updateMessageSenders");
        response.put("senders", sendersArray);

        // Send the senders list to the client
        session.getAsyncRemote().sendText(response.toString());
    }

    void saveMessageToDatabase(int fromId, int toId, String messageText) throws Exception {
        String fromUsername = getUsername(fromId);

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass)) {
            String insertMessageQuery = "INSERT INTO Message (From_id, To_id, MessageText, FromUsername) VALUES (?, ?, ?, ?)";
            try (PreparedStatement insertMessageStmt = conn.prepareStatement(insertMessageQuery)) {
                insertMessageStmt.setInt(1, fromId);
                insertMessageStmt.setInt(2, toId);
                String encryptedMessage = AESUtil.encrypt(messageText);
                insertMessageStmt.setString(3, encryptedMessage);
                insertMessageStmt.setString(4, fromUsername);
                insertMessageStmt.executeUpdate();
            }
            System.out.println("Message saved to database successfully.");
        }
    }

    private void sendExistingMessages(Session session, int fromId, int toId) throws Exception {
        String query = "SELECT From_id, To_id, MessageText, FromUsername FROM Message "
                + "WHERE ((From_id = ? AND To_id = ?) OR (From_id = ? AND To_id = ?)) AND MessageText IS NOT NULL";

        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, fromId);
            stmt.setInt(2, toId);
            stmt.setInt(3, toId);
            stmt.setInt(4, fromId);

            try (ResultSet rs = stmt.executeQuery()) {
                JSONArray messages = new JSONArray();
                while (rs.next()) {
                    int rsFromId = rs.getInt("From_id");
                    int rsToId = rs.getInt("To_id");
                    String encryptedMessage = rs.getString("MessageText");
                    String decryptedMessage = AESUtil.decrypt(encryptedMessage);
                    String fromUsername = rs.getString("FromUsername");

                    JSONObject messageObj = new JSONObject();
                    messageObj.put("fromId", rsFromId);
                    messageObj.put("toId", rsToId);
                    messageObj.put("messageText", decryptedMessage);
                    messageObj.put("fromUsername", fromUsername);
                    messages.put(messageObj);
                }

                JSONObject response = new JSONObject();
                response.put("type", "loadMessages");
                response.put("messages", messages);

                // Convert to string and send to the session asynchronously
                session.getAsyncRemote().sendText(response.toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void broadcastMessage(int fromId, String fromUsername, int toId, String messageText) {
        JSONObject messageObj = new JSONObject();
        messageObj.put("type", "chat");
        messageObj.put("fromId", fromId);
        messageObj.put("fromUsername", fromUsername);
        messageObj.put("toId", toId);
        messageObj.put("messageText", messageText);
        String message = messageObj.toString();

        synchronized (clients) {
            for (Session client : clients) {
                HttpSession httpSession = (HttpSession) client.getUserProperties().get(HttpSession.class.getName());
                User user = (User) httpSession.getAttribute("USER");
                int userId = user.getUserId();

                // Only send message to relevant sessions (fromId and toId match the current user)
                if (userId == fromId || userId == toId) {
                    try {
                        client.getBasicRemote().sendText(message);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    private String getUsername(int userId) {
        String username = null;
        String getUserQuery = "SELECT Username FROM Users WHERE User_id = ?";
        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement getUserStmt = conn.prepareStatement(getUserQuery)) {

            getUserStmt.setInt(1, userId);
            try (ResultSet rs = getUserStmt.executeQuery()) {
                if (rs.next()) {
                    username = rs.getString("Username");
                } else {
                    System.out.println("User not found for UserId: " + userId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return username;
    }

    private int getUserId(Session session) {
        HttpSession httpSession = (HttpSession) session.getUserProperties().get(HttpSession.class.getName());
        User user = (User) httpSession.getAttribute("USER");
        return user.getUserId();
    }

    private Session getSessionById(int userId) {
        synchronized (clients) {
            for (Session client : clients) {
                HttpSession httpSession = (HttpSession) client.getUserProperties().get(HttpSession.class.getName());
                User user = (User) httpSession.getAttribute("USER");
                if (user.getUserId() == userId) {
                    return client;
                }
            }
        }
        return null;
    }

    public static class Configurator extends ServerEndpointConfig.Configurator {

        @Override
        public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
            HttpSession httpSession = (HttpSession) request.getHttpSession();
            config.getUserProperties().put(HttpSession.class.getName(), httpSession);
        }
    }
}
