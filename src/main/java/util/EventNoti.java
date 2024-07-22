package util;

import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class EventNoti implements ServletContextListener {

    private Scheduler scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            // Create an instance of Scheduler
            scheduler = StdSchedulerFactory.getDefaultScheduler();

            // Define the job and tie it to EventNotificationJob class
            JobDetail job = JobBuilder.newJob(EventNotificationJob.class)
                    .withIdentity("eventNotificationJob", "group1")
                    .build();

            // Set the hour and minute for testing
            int hour = 7; // Change this to the hour you want
            int minute = 40; // Change this to the minute you want

            // Create a trigger that fires every day at the specified hour and minute
            Trigger trigger = TriggerBuilder.newTrigger()
                    .withIdentity("eventNotificationTrigger", "group1")
                    .withSchedule(CronScheduleBuilder.dailyAtHourAndMinute(hour, minute))
                    .build();

            // Check if the job already exists
            if (scheduler.checkExists(job.getKey())) {
                // If it exists, replace the job
                scheduler.deleteJob(job.getKey());
            }

            // Schedule the job using the trigger
            scheduler.scheduleJob(job, trigger);

            // Start the scheduler
            scheduler.start();
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            if (scheduler != null) {
                scheduler.shutdown();
            }
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }
}