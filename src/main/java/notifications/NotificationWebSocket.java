package notifications;

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
import org.json.JSONObject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import model.DAO.DBinfo;
import model.User;

@ServerEndpoint(value = "/notifications", configurator = NotificationWebSocket.Configurator.class)
public class NotificationWebSocket {

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
        // Handle incoming messages if needed
    }

    public void sendNotificationToClient(int userId, String message, String notificationLink) {
        JSONObject notificationObj = new JSONObject();
        notificationObj.put("type", "notification");
        notificationObj.put("userId", userId);
        notificationObj.put("message", message);
        notificationObj.put("notificationLink", notificationLink);

        String notification = notificationObj.toString();

        synchronized (clients) {
            for (Session client : clients) {
                HttpSession httpSession = (HttpSession) client.getUserProperties().get(HttpSession.class.getName());
                User user = (User) httpSession.getAttribute("USER");
                if (user.getUserId() == userId) {
                    try {
                        client.getBasicRemote().sendText(notification);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    public void saveNotificationToDatabase(int userId, String message, String notificationLink) {
        String query = "INSERT INTO Notification (User_id, Message, Created_at, Status, Notification_link) VALUES (?, ?, GETDATE(), 'Unread', ?)";
        try (Connection conn = DriverManager.getConnection(DBinfo.dbURL, DBinfo.dbUser, DBinfo.dbPass); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            stmt.setString(2, message);
            stmt.setString(3, notificationLink);

            stmt.executeUpdate();

            System.out.println("Notification saved to database successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static class Configurator extends ServerEndpointConfig.Configurator {

        @Override
        public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
            HttpSession httpSession = (HttpSession) request.getHttpSession();
            config.getUserProperties().put(HttpSession.class.getName(), httpSession);
        }
    }
}
