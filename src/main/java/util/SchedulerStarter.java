/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

import java.util.Date;
import java.util.Calendar;

@WebListener
public class SchedulerStarter implements ServletContextListener {

    public void contextInitialized(ServletContextEvent sce) {
        try {
            Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();
            JobDetail job = JobBuilder.newJob(RankResetJob.class).build();

            // Set the date and time for the trigger
            Calendar calendar = Calendar.getInstance();
            calendar.set(2024, Calendar.JUNE, 29, 18, 10, 0);
            Date triggerDate = calendar.getTime();

            Trigger trigger = TriggerBuilder.newTrigger()
                    .startAt(triggerDate)
                    .build();

            scheduler.scheduleJob(job, trigger);
            scheduler.start();
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    public void contextDestroyed(ServletContextEvent sce) {
        try {
            StdSchedulerFactory.getDefaultScheduler().shutdown();
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }
}