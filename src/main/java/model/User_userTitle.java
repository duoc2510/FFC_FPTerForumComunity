/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PC
 */
public class User_userTitle {

    private int userTitleId;
    private int userId;
    private int titleId;

    public User_userTitle() {
    }

    public User_userTitle(int userTitleId, int userId, int titleId) {
        this.userTitleId = userTitleId;
        this.userId = userId;
        this.titleId = titleId;
    }

    public int getUserTitleId() {
        return userTitleId;
    }

    public void setUserTitleId(int userTitleId) {
        this.userTitleId = userTitleId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTitleId() {
        return titleId;
    }

    public void setTitleId(int titleId) {
        this.titleId = titleId;
    }
}
