package com.keeptrucking.controllers;

import com.keeptrucking.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateStatusServlet", urlPatterns = {"/UpdateStatusServlet"})
public class UpdateStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get Parameters
            String idStr = request.getParameter("shipment_id");
            String status = request.getParameter("status");
            String remarks = request.getParameter("remarks");
            String wIdStr = request.getParameter("warehouse_id");

            if(idStr != null && status != null) {
                int shipmentId = Integer.parseInt(idStr);
                int warehouseId = 0;
                if(wIdStr != null && !wIdStr.isEmpty()) {
                    warehouseId = Integer.parseInt(wIdStr);
                }

                Connection con = DBConnection.getConnection();
                
                // 2. Update Shipment
                String sql = "UPDATE shipments SET status = ?, current_warehouse_id = ?, remarks = ? WHERE shipment_id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, status);
                
                if(status.equals("Stored") && warehouseId > 0) {
                    ps.setInt(2, warehouseId);
                } else {
                    ps.setNull(2, java.sql.Types.INTEGER);
                }
                
                ps.setString(3, remarks);
                ps.setInt(4, shipmentId);
                
                int rows = ps.executeUpdate();
                
                // 3. Free Truck Logic
                if(rows > 0 && (status.equals("Delivered") || status.equals("Stored"))) {
                    int truckId = 0;
                    PreparedStatement ps2 = con.prepareStatement("SELECT truck_id FROM shipments WHERE shipment_id = ?");
                    ps2.setInt(1, shipmentId);
                    ResultSet rs = ps2.executeQuery();
                    if(rs.next()) {
                        truckId = rs.getInt("truck_id");
                        con.createStatement().executeUpdate("UPDATE trucks SET status = 'Available' WHERE truck_id = " + truckId);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // 4. Redirect back to Dashboard
        response.sendRedirect("driver_dashboard.jsp");
    }
}