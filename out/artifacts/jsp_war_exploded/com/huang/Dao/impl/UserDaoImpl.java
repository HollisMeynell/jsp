package com.huang.Dao.impl;

import com.huang.Dao.UserDao;
import com.huang.entity.User;
import com.huang.sql.SQL;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDaoImpl implements UserDao {
    ArrayList<User> users = new ArrayList<User>();
    @Override
    public boolean login(String name, String pwd) throws SQLException {
        String sql = "select * from admin_info where name=? and pwd=?";
        PreparedStatement prep = SQL.getInstance().getConn().prepareStatement(sql);
        prep.setString(1,name);
        prep.setString(2,pwd);
        boolean f = prep.executeQuery().next();
        prep.close();
        return f;
    }

    @Override
    public boolean adduser(User user) throws SQLException {
        String sql = "insert into admin_info (name,pwd) value (?,?)";
        PreparedStatement prep = SQL.getInstance().getConn().prepareStatement(sql);
        prep.setString(1,user.getName());
        prep.setString(2,user.getPasswd());
        int n = prep.executeUpdate();
        prep.close();
        return n==1;
    }

    @Override
    public ArrayList<User> queryAll() throws SQLException {
        findUser("");
        return this.users;
    }

    @Override
    public ArrayList<User> findUser(String name) throws SQLException {
        String sql = "select * from admin_info where name like ?";
        PreparedStatement prep = SQL.getInstance().getConn().prepareStatement(sql);
        prep.setString(1,"%"+name+"%");
        ResultSet rs = prep.executeQuery();
        while (rs.next()){
            this.users.add(new User(rs.getInt(1),rs.getString(2),rs.getString(3)));
        }
        rs.close();
        prep.close();
        return this.users;
    }

    @Override
    public boolean delUser(int id) throws SQLException {
        String sql = "delete from admin_info where id=?";
        PreparedStatement prep = SQL.getInstance().getConn().prepareStatement(sql);
        prep.setInt(1,id);
        prep.executeUpdate();
        prep.close();
        return true;
    }

    @Override
    public int getId(String naem) throws SQLException {
        String sql = "select * from admin_info where name=?";
        PreparedStatement prep = SQL.getInstance().getConn().prepareStatement(sql);
        prep.setString(1,naem);
        ResultSet rs = prep.executeQuery();
        if (rs.next()){
            return rs.getInt(1);
        }else{
            return 0;
        }
    }

}
