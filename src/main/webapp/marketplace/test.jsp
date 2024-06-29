<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="model.*" import="model.DAO.*"%>
<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Chart</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>
        <h2>Order Chart by Month</h2>

        <%
            String[] statuses = {"Pending", "Accept", "Completed", "Cancelled", "Success", "Fail"};
            int year = 2024; // Set the year you want to query

            // Create a map to hold the order counts for each status
            Map<String, int[]> orderData = new HashMap<>();
        
            for (String status : statuses) {
                int[] monthlyCounts = new int[12];
                for (int month = 1; month <= 12; month++) {
                    monthlyCounts[month - 1] = Shop_DB.countOrdersByStatusAndMonth(status, month, year);
                }
                orderData.put(status, monthlyCounts);
            }
        %>

        <canvas id="orderChart" width="800" height="400"></canvas>
        <script>
            var ctx = document.getElementById('orderChart').getContext('2d');
            var orderChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                    datasets: [
                        {
                            label: 'Pending',
                            data: <%= Arrays.toString(orderData.get("Pending")) %>,
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 1
                        },
                        {
                            label: 'Accept',
                            data: <%= Arrays.toString(orderData.get("Accept")) %>,
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        },
                        {
                            label: 'Completed',
                            data: <%= Arrays.toString(orderData.get("Completed")) %>,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        },
                        {
                            label: 'Cancelled',
                            data: <%= Arrays.toString(orderData.get("Cancelled")) %>,
                            backgroundColor: 'rgba(153, 102, 255, 0.2)',
                            borderColor: 'rgba(153, 102, 255, 1)',
                            borderWidth: 1
                        },
                        {
                            label: 'Success',
                            data: <%= Arrays.toString(orderData.get("Success")) %>,
                            backgroundColor: 'rgba(255, 159, 64, 0.2)',
                            borderColor: 'rgba(255, 159, 64, 1)',
                            borderWidth: 1
                        },
                        {
                            label: 'Fail',
                            data: <%= Arrays.toString(orderData.get("Fail")) %>,
                            backgroundColor: 'rgba(255, 206, 86, 0.2)',
                            borderColor: 'rgba(255, 206, 86, 1)',
                            borderWidth: 1
                        }
                    ]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100,
                            ticks: {
                                stepSize: 10
                            }
                        }
                    }
                }
            });
        </script>
    </body>
</html>
