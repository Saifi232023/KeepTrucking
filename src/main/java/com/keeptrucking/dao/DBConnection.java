/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.keeptrucking.dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    // MariaDB/MySQL credentials
    private static final String URL = "jdbc:mysql://localhost:3306/keeptrucking_db";
    private static final String USER = "root"; // Default XAMPP user
    private static final String PASS = "";     // Default XAMPP password is empty

    public static Connection getConnection() {
        Connection con = null;
        try {
            // 1. Load the Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 2. Establish Connection
            con = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.out.println("Connection Failed: " + e.getMessage());
        }
        return con;
    }

    // Main method just to test if it works right now
    public static void main(String[] args) {
        if(getConnection() != null) {
            System.out.println("SUCCESS! Database Connected.");
        } else {
            System.out.println("ERROR! Could not connect.");
        }
    }
}