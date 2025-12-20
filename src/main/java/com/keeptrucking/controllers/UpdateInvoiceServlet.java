package com.keeptrucking.controllers;

import com.keeptrucking.dao.ShipmentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateInvoiceServlet", urlPatterns = {"/UpdateInvoiceServlet"})
public class UpdateInvoiceServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int shipmentId = Integer.parseInt(request.getParameter("shipment_id"));
        double amount = Double.parseDouble(request.getParameter("amount"));
        
        new ShipmentDAO().updateInvoiceAmount(shipmentId, amount);
        response.sendRedirect("shipment_details.jsp?id=" + shipmentId);
    }
}