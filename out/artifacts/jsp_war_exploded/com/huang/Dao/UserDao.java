package com.huang.Dao;

import com.huang.entity.User;

import java.sql.SQLException;
import java.util.ArrayList;

public interface UserDao {
    public boolean login(String name,String pwd) throws SQLException;
    public boolean adduser(User user) throws SQLException;
    ArrayList<User> queryAll() throws SQLException;
    ArrayList<User> findUser(String name) throws SQLException;
    boolean delUser(int id) throws SQLException;
    int getId(String naem) throws SQLException;
    boolean setuser(User user) throws SQLException;
}
