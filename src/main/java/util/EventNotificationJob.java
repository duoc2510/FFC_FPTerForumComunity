/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import model.DAO.Event_DB;
import model.Event;
import notifications.NotificationWebSocket;

/**
 *
 * @author PC
 */
public class EventNotificationJob implements Job {

    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException {
        List<Event> events = Event_DB.checkEvents();
         NotificationWebSocket nw = new NotificationWebSocket();
        for (Event event : events) {
            List<Integer> userIds = Event_DB.getUsersFollowingEvent(event.getEventId());
            for (int userId : userIds) {
              nw.saveNotificationToDatabase(userId, "The event day has arrived " + event.getTitle() + " has started, please attend the event!", "/viewEvent?eventId="+event.getEventId());
              nw.sendNotificationToClient(userId, "The event day has arrived " + event.getTitle() + " has started, please attend the event!",  "/viewEvent?eventId="+event.getEventId());
            }
        }
    }

}
