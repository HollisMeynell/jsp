package com.huang.factory;

import com.huang.Dao.impl.UserDaoImpl;

public class DaoFactory {
    public static UserDaoImpl getUserDao(){
        return new UserDaoImpl();
    }
}
