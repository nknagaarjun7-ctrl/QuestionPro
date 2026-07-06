package com.questionpro.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
        "jdbc:mysql://hopper.proxy.rlwy.net:53256/railway?useSSL=true&serverTimezone=Asia/Kolkata";

    private static final String USER = "root";
    private static final String PASSWORD = "BRWiWYjRBCbfSTusWBBiQmevqKkRUKWD";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver Not Found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}