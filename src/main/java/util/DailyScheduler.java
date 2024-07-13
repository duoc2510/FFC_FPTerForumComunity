////package util;
////
////import jakarta.servlet.ServletContextEvent;
////import jakarta.servlet.ServletContextListener;
////import jakarta.servlet.annotation.WebListener;
////import org.quartz.JobBuilder;
////import org.quartz.JobDetail;
////import org.quartz.Scheduler;
////import org.quartz.SchedulerException;
////import org.quartz.Trigger;
////import org.quartz.TriggerBuilder;
////import org.quartz.impl.StdSchedulerFactory;
////import org.quartz.CronScheduleBuilder;
////
////@WebListener
////public class DailyScheduler implements ServletContextListener {
////
////    @Override
////    public void contextInitialized(ServletContextEvent sce) {
////        try {
////            Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();
////            JobDetail job = JobBuilder.newJob(OrderCheckJob.class).build();
////
////            // Schedule the job to run at midnight every day
////            Trigger trigger = TriggerBuilder.newTrigger()
////                    .withSchedule(CronScheduleBuilder.dailyAtHourAndMinute(0, 0))
////                    .build();
////
////            scheduler.scheduleJob(job, trigger);
////            scheduler.start();
////        } catch (SchedulerException e) {
////            e.printStackTrace();
////        }
////    }
////
////    @Override
////    public void contextDestroyed(ServletContextEvent sce) {
////        try {
////            StdSchedulerFactory.getDefaultScheduler().shutdown();
////        } catch (SchedulerException e) {
////            e.printStackTrace();
////        }
////    }
////}
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
import org.quartz.CronScheduleBuilder;

import java.util.Calendar;
import java.util.Date;

@WebListener
public class DailyScheduler implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();
            JobDetail job = JobBuilder.newJob(OrderCheckJob.class).build();

            // Set the trigger to run at 13:57 on June 30, 2024
            Calendar cal = Calendar.getInstance();
            cal.set(2024, Calendar.JULY, 8, 7, 46, 0);
            Date triggerDate = cal.getTime();

            Trigger trigger = TriggerBuilder.newTrigger()
                    .startAt(triggerDate)
                    .build();

            scheduler.scheduleJob(job, trigger);
            scheduler.start();
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            StdSchedulerFactory.getDefaultScheduler().shutdown();
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }
}
