package com.huang.test;

import com.huang.Dao.UserDao;
import com.huang.entity.User;
import com.huang.factory.DaoFactory;

import java.sql.SQLException;

public class usertest {
    public static void main(String[] args) {
        try {
            UserDao c = DaoFactory.getUserDao();
            System.out.println(c.login("admin","123456"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
