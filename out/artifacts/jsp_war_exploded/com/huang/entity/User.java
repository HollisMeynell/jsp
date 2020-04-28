package com.huang.entity;

import java.io.Serializable;

public class User implements Serializable {
    private static final long serialVersionUID = 123456l;
    private int id = 0;
    private String name = null;
    private String passwd = null;
    public User() {
    }

    public User(int id, String name, String passwd) {
        this.id = id;
        this.name = name;
        this.passwd = passwd;
    }

    public User(String name, String passwd) {
        this.name = name;
        this.passwd = passwd;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }
}
