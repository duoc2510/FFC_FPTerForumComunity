/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.ArrayList;
import model.DAO.User_DB;
import model.User;
import notifications.NotificationWebSocket;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class RankResetJob implements Job {

    public void execute(JobExecutionContext context) throws JobExecutionException {
        NotificationWebSocket nw = new NotificationWebSocket();
        User_DB udb = new User_DB();
        ArrayList<User> userlist = udb.getAllUsers();

        for (User u : userlist) {
            if (u.getUserScore() >= 0 && u.getUserScore() < 100) {
                udb.updateRankByEmail(u.getUserEmail(), 0);
            } else if (u.getUserScore() >= 100 && u.getUserScore() < 1000) {
                udb.updateRankByEmail(u.getUserEmail(), 1);
            } else if (u.getUserScore() >= 1000 && u.getUserScore() < 1500) {
                udb.updateRankByEmail(u.getUserEmail(), 2);
            } else if (u.getUserScore() >= 1500 && u.getUserScore() < 3000) {
                udb.updateRankByEmail(u.getUserEmail(), 3);
            } else if (u.getUserScore() >= 3000) {
                udb.updateRankByEmail(u.getUserEmail(), 4);
            }

            udb.updateScoreByEmail(u.getUserEmail(), 0);

            nw.saveNotificationToDatabase(u.getUserId(), "Rank của bạn đã được cập nhật!", "/rank/userrank");
            nw.sendNotificationToClient(u.getUserId(), "Rank của bạn đã được cập nhật!", "/rank/userrank");
        }
    }
}
