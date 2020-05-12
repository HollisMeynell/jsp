package com.huang.test;

import com.huang.Dao.UserDao;
import com.huang.entity.User;
import com.huang.factory.DaoFactory;

import java.sql.SQLException;
import java.util.Scanner;

public class usertest {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        int b = sc.nextInt();
        int d = (int)Math.ceil((double) a/b);
        System.out.println(d);
    }
}
