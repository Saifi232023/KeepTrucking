package com.keeptrucking.dao;

import com.keeptrucking.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    // 1. Check Login
    public User checkLogin(String username, String password) {
        User user = null;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("role"),
                    rs.getString("full_name")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return user;
    }

    // 2. Add New User
    public boolean addUser(User user, String password) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO users (username, password, role, full_name) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, password);
            ps.setString(3, user.getRole());
            ps.setString(4, user.getFullName());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 3. Get All Users
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM users";
            ResultSet rs = con.createStatement().executeQuery(sql);
            while(rs.next()){
                list.add(new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("role"),
                    rs.getString("full_name")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 4. Delete User (NEW)
    public boolean deleteUser(int id) {
        try {
            Connection con = DBConnection.getConnection();
            // Prevent deleting the main Admin (Assuming ID 1 is the main admin)
            if(id == 1) return false; 
            
            String sql = "DELETE FROM users WHERE user_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}