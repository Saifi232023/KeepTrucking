package com.keeptrucking.dao;

import com.keeptrucking.models.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShipmentDAO {

    // 1. Create Shipment
    public int createShipment(int clientId, int driverId, int truckId, String origin, String dest) {
        int generatedId = -1;
        try {
            Connection con = DBConnection.getConnection();
            String sql1 = "INSERT INTO shipments (client_id, driver_id, truck_id, origin, destination, status) VALUES (?, ?, ?, ?, ?, 'Pending')";
            PreparedStatement ps1 = con.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
            ps1.setInt(1, clientId);
            ps1.setInt(2, driverId);
            ps1.setInt(3, truckId);
            ps1.setString(4, origin);
            ps1.setString(5, dest);
            ps1.executeUpdate();

            ResultSet rs = ps1.getGeneratedKeys();
            if(rs.next()) generatedId = rs.getInt(1);

            // Update Truck Status
            con.createStatement().executeUpdate("UPDATE trucks SET status = 'On Trip' WHERE truck_id = " + truckId);

        } catch (Exception e) { e.printStackTrace(); }
        return generatedId;
    }

    // 2. Get Available Trucks
    public List<Truck> getAvailableTrucks() {
        List<Truck> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM trucks WHERE status = 'Available'");
            while(rs.next()){
                list.add(new Truck(rs.getInt("truck_id"), rs.getString("plate_number"), rs.getString("model"), rs.getString("status")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 3. Get Drivers
    public List<User> getDrivers() {
        List<User> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM users WHERE role = 'Driver'");
            while(rs.next()){
                list.add(new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("role"), rs.getString("full_name")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    // 4. Add Items
    public boolean addItem(int shipmentId, String desc, int qty, double weight) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO shipment_items (shipment_id, description, quantity, weight) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, shipmentId);
            ps.setString(2, desc);
            ps.setInt(3, qty);
            ps.setDouble(4, weight);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 5. Get Items
    public List<ShipmentItem> getItemsByShipment(int shipmentId) {
        List<ShipmentItem> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM shipment_items WHERE shipment_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, shipmentId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                list.add(new ShipmentItem(rs.getInt("item_id"), rs.getInt("shipment_id"), rs.getString("description"), rs.getInt("quantity"), rs.getDouble("weight")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 6. Get All Shipments (Manager View)
    public List<Shipment> getAllShipments() {
        List<Shipment> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT s.shipment_id, c.company_name, u.full_name, t.plate_number, s.origin, s.destination, s.status, s.created_at " +
                         "FROM shipments s " +
                         "JOIN clients c ON s.client_id = c.client_id " +
                         "JOIN users u ON s.driver_id = u.user_id " +
                         "JOIN trucks t ON s.truck_id = t.truck_id " +
                         "ORDER BY s.shipment_id DESC";
            ResultSet rs = con.createStatement().executeQuery(sql);
            while(rs.next()){
                list.add(new Shipment(rs.getInt("shipment_id"), rs.getString("company_name"), rs.getString("full_name"), rs.getString("plate_number"), rs.getString("origin"), rs.getString("destination"), rs.getString("status"), rs.getTimestamp("created_at")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 7. Get Driver Shipments
    public List<Shipment> getShipmentsByDriver(int driverId) {
        List<Shipment> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT s.shipment_id, c.company_name, u.full_name, t.plate_number, s.origin, s.destination, s.status, s.created_at " +
                         "FROM shipments s " +
                         "JOIN clients c ON s.client_id = c.client_id " +
                         "JOIN users u ON s.driver_id = u.user_id " +
                         "JOIN trucks t ON s.truck_id = t.truck_id " +
                         "WHERE s.driver_id = ? AND s.status != 'Delivered' ORDER BY s.shipment_id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, driverId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                list.add(new Shipment(rs.getInt("shipment_id"), rs.getString("company_name"), rs.getString("full_name"), rs.getString("plate_number"), rs.getString("origin"), rs.getString("destination"), rs.getString("status"), rs.getTimestamp("created_at")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 8. Delete Shipment (NEW)
    public boolean deleteShipment(int shipmentId) {
        try {
            Connection con = DBConnection.getConnection();
            
            // Step 1: Find the Truck ID used in this shipment
            int truckId = 0;
            PreparedStatement ps1 = con.prepareStatement("SELECT truck_id FROM shipments WHERE shipment_id = ?");
            ps1.setInt(1, shipmentId);
            ResultSet rs = ps1.executeQuery();
            if(rs.next()) {
                truckId = rs.getInt("truck_id");
            }

            // Step 2: Delete the Shipment
            // (Note: Shipment Items will delete automatically if Foreign Key is CASCADE, otherwise this might fail)
            // To be safe, we delete items first manually in code if DB isn't set up perfectly
            con.createStatement().executeUpdate("DELETE FROM shipment_items WHERE shipment_id = " + shipmentId);
            con.createStatement().executeUpdate("DELETE FROM expenses WHERE shipment_id = " + shipmentId);

            PreparedStatement ps2 = con.prepareStatement("DELETE FROM shipments WHERE shipment_id = ?");
            ps2.setInt(1, shipmentId);
            int rows = ps2.executeUpdate();

            // Step 3: If deleted, make Truck Available again
            if(rows > 0 && truckId > 0) {
                con.createStatement().executeUpdate("UPDATE trucks SET status = 'Available' WHERE truck_id = " + truckId);
                return true;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}