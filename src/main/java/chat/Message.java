package chat;

import com.google.gson.Gson;

public class Message {

    private int toId;
    private int fromId;
    private String messageText;
    private String command;

    public Message(int toId, int fromId, String messageText) {
        this.toId = toId;
        this.fromId = fromId;
        this.messageText = messageText;
    }

    public Message(String command, String toId) {
        this.command = command;
        this.toId = Integer.parseInt(toId);
    }

    public int getToId() {
        return toId;
    }

    public void setToId(int toId) {
        this.toId = toId;
    }

    public int getFromId() {
        return fromId;
    }

    public void setFromId(int fromId) {
        this.fromId = fromId;
    }

    public String getMessageText() {
        return messageText;
    }

    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }

    public String getCommand() {
        return command;
    }

    public void setCommand(String command) {
        this.command = command;
    }

    public String toJson() {
        Gson gson = new Gson();
        return gson.toJson(this);
    }

    public static Message fromJson(String json) {
        Gson gson = new Gson();
        return gson.fromJson(json, Message.class);
    }
}
