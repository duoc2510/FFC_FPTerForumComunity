/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author PC
 */
public class ManagerRegistr {
    private int managerRegistrId;
    private int userId;
    private Date registrationDate;
    private String status;
    private String remarks;
    private User user;
    // Constructors, getters, and setters

    public ManagerRegistr() {}

    public ManagerRegistr(String status, String remarks, User user) {
       
        this.registrationDate = new Date(); // current date
        this.status = status;
        this.remarks = remarks;
         this.user = user;
    }

    public ManagerRegistr(int userId, String remarks) {
        this.userId = userId;
        this.remarks = remarks;
    }

    // Getters and Setters

    public int getManagerRegistrId() {
        return managerRegistrId;
    }

    public void setManagerRegistrId(int managerRegistrId) {
        this.managerRegistrId = managerRegistrId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
}
