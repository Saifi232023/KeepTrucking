package com.keeptrucking.dao;

import com.keeptrucking.models.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ManagerDAO {
    
    // --- TRUCKS ---
    public boolean addTruck(String plate, String model, String type, double capacity) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO trucks (plate_number, model, status, type, capacity) VALUES (?, ?, 'Available', ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, plate);
            ps.setString(2, model);
            ps.setString(3, type);
            ps.setDouble(4, capacity);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public List<Truck> getAllTrucks() {
        List<Truck> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM trucks");
            while(rs.next()){
                list.add(new Truck(
                    rs.getInt("truck_id"), rs.getString("plate_number"), rs.getString("model"), 
                    rs.getString("status"), rs.getString("type"), rs.getDouble("capacity")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    public boolean deleteTruck(int id) {
        try { return DBConnection.getConnection().createStatement().executeUpdate("DELETE FROM trucks WHERE truck_id=" + id) > 0; } 
        catch (Exception e) { return false; }
    }

    // --- CLIENTS ---
    public boolean addClient(String company, String contact, String phone, String email) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO clients (company_name, contact_name, phone, email) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, company);
            ps.setString(2, contact);
            ps.setString(3, phone);
            ps.setString(4, email);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
    
    public List<Client> getAllClients() {
        List<Client> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM clients");
            while(rs.next()){
                list.add(new Client(rs.getInt("client_id"), rs.getString("company_name"), rs.getString("contact_name"), rs.getString("phone"), rs.getString("email")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    public boolean deleteClient(int id) {
        try { return DBConnection.getConnection().createStatement().executeUpdate("DELETE FROM clients WHERE client_id=" + id) > 0; } 
        catch (Exception e) { return false; }
    }

    // --- WAREHOUSES ---
    public boolean addWarehouse(String name, String street, String city, String zip) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO warehouses (name, street, city, zip_code) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, street);
            ps.setString(3, city);
            ps.setString(4, zip);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public List<Warehouse> getAllWarehouses() {
        List<Warehouse> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM warehouses");
            while(rs.next()){
                list.add(new Warehouse(rs.getInt("warehouse_id"), rs.getString("name"), rs.getString("street"), rs.getString("city"), rs.getString("zip_code")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    public boolean deleteWarehouse(int id) {
        try { return DBConnection.getConnection().createStatement().executeUpdate("DELETE FROM warehouses WHERE warehouse_id=" + id) > 0; } 
        catch (Exception e) { return false; }
    }
}