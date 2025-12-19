package com.keeptrucking.controllers;

import com.keeptrucking.dao.ShipmentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddItemServlet", urlPatterns = {"/AddItemServlet"})
public class AddItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get Data
        int shipmentId = Integer.parseInt(request.getParameter("shipment_id"));
        String desc = request.getParameter("description");
        int qty = Integer.parseInt(request.getParameter("quantity"));
        double weight = Double.parseDouble(request.getParameter("weight"));
        
        // 2. Save to DB
        ShipmentDAO dao = new ShipmentDAO();
        dao.addItem(shipmentId, desc, qty, weight);
        
        // 3. Stay on the same page to add more items
        response.sendRedirect("add_items.jsp?shipment_id=" + shipmentId);
    }
}