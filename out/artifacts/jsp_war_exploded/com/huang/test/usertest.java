package com.huang.test;

import com.huang.Dao.UserDao;
import com.huang.entity.User;
import com.huang.factory.DaoFactory;

import java.sql.SQLException;

public class usertest {
    public static void main(String[] args) {
        try {
            UserDao c = DaoFactory.getUserDao();
            c.adduser(new User("aasdad","6456464"));
            System.out.println(c.login("aasdad","6456464"));
            System.out.println(c.delUser(c.getId("aasdad")));
            System.out.println(c.login("aasdad","6456464"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
