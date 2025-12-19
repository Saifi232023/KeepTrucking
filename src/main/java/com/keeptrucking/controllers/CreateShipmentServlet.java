package com.keeptrucking.controllers;

import com.keeptrucking.dao.ShipmentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CreateShipmentServlet", urlPatterns = {"/CreateShipmentServlet"})
public class CreateShipmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int clientId = Integer.parseInt(request.getParameter("client_id"));
        int driverId = Integer.parseInt(request.getParameter("driver_id"));
        int truckId = Integer.parseInt(request.getParameter("truck_id"));
        String origin = request.getParameter("origin");
        String dest = request.getParameter("destination");
        
        ShipmentDAO dao = new ShipmentDAO();
        int newShipmentId = dao.createShipment(clientId, driverId, truckId, origin, dest);
        
        if(newShipmentId > 0) {
            // Success! Go to Step 2: Add Items
            response.sendRedirect("add_items.jsp?shipment_id=" + newShipmentId);
        } else {
            response.sendRedirect("manager_dashboard.jsp?error=Failed to Create Shipment");
        }
    }
}