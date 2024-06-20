package chat;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.CloseReason;
import jakarta.websocket.EndpointConfig;
import jakarta.websocket.HandshakeResponse;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.HandshakeRequest;
import jakarta.websocket.server.ServerEndpoint;
import jakarta.websocket.server.ServerEndpointConfig;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import model.DAO.DBinfo;
import model.User;

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

        // Do not send message history here, only when requested by the client
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

    private void saveMessageToDatabase(int fromId, int toId, String messageText) {
        try {
            String encryptedMessage = AESUtil.encrypt(messageText);

            System.out.println("Encrypted Message (before saving): " + encryptedMessage);

            String query = "INSERT INTO Message (From_id, To_id, MessageText) VALUES (?, ?, ?)";
            try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {

                stmt.setInt(1, fromId);
                stmt.setInt(2, toId);
                stmt.setString(3, encryptedMessage);

                stmt.executeUpdate();

                System.out.println("Message saved to database successfully.");

            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private String decrypt(String encryptedMessage) throws Exception {
        return AESUtil.decrypt(encryptedMessage);
    }

    private void sendExistingMessages(Session session, int fromId, int toId) {
        String query = "SELECT From_id, To_id, MessageText FROM Message "
                + "WHERE (From_id = ? AND To_id = ?) OR (From_id = ? AND To_id = ?)";

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

                    System.out.println("Encrypted Message (from DB): " + encryptedMessage);

                    // Decrypt message
                    String decryptedMessage = AESUtil.decrypt(encryptedMessage);

                    System.out.println("Decrypted Message: " + decryptedMessage);

                    JSONObject messageObj = new JSONObject();
                    messageObj.put("fromId", rsFromId);
                    messageObj.put("toId", rsToId);
                    messageObj.put("messageText", decryptedMessage);
                    messages.put(messageObj);
                }

                JSONObject response = new JSONObject();
                response.put("type", "loadMessages");
                response.put("messages", messages);

                session.getBasicRemote().sendText(response.toString());

            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("Received message: " + message);

        JSONObject jsonMessage = new JSONObject(message);
        String type = jsonMessage.getString("type");

        if (type.equals("chat")) {
            int toId = jsonMessage.getInt("toId");
            int fromId = jsonMessage.getInt("fromId");
            String fromUsername = jsonMessage.getString("fromUsername");
            String messageText = jsonMessage.getString("messageText");

            // Save message to database
            saveMessageToDatabase(fromId, toId, messageText);

            // Broadcast message to all clients
            broadcastMessage(fromId, fromUsername, toId, messageText);
        } else if (type.equals("loadMessages")) {
            int toId = jsonMessage.getInt("toId");
            int fromId = getUserId(session);

            // Send existing messages to the client
            sendExistingMessages(session, fromId, toId);
        } else {
            System.out.println("Invalid message type received: " + type);
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
                try {
                    client.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private int getUserId(Session session) {
        HttpSession httpSession = (HttpSession) session.getUserProperties().get(HttpSession.class.getName());
        User user = (User) httpSession.getAttribute("USER");
        return user.getUserId();
    }

    public static class Configurator extends ServerEndpointConfig.Configurator {

        @Override
        public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
            HttpSession httpSession = (HttpSession) request.getHttpSession();
            config.getUserProperties().put(HttpSession.class.getName(), httpSession);
        }
    }
}
