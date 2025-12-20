/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.keeptrucking.controllers;

import com.keeptrucking.dao.ShipmentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddExpenseServlet", urlPatterns = {"/AddExpenseServlet"})
public class AddExpenseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int shipmentId = Integer.parseInt(request.getParameter("shipment_id"));
        String desc = request.getParameter("description");
        double amount = Double.parseDouble(request.getParameter("amount"));
        
        ShipmentDAO dao = new ShipmentDAO();
        dao.addExpense(shipmentId, desc, amount);
        
        response.sendRedirect("shipment_details.jsp?id=" + shipmentId);
    }
}