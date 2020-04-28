package com.huang.sql;

import java.sql.*;

public class SQL {
    private static SQL instance = new SQL();
    final String url="jdbc:mysql://trackcloud.cn:3306/gouwu";
    Connection conn = null;
    private SQL(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url,"zhangwk","123456789");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            conn = null;
        }
    }
    public static SQL getInstance(){
        return instance;
    }
    public Connection getConn(){
        return conn;
    }
}
