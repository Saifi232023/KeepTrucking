/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.keeptrucking.controllers;

import com.keeptrucking.dao.ManagerDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddWarehouseServlet", urlPatterns = {"/AddWarehouseServlet"})
public class AddWarehouseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String location = request.getParameter("location");
        
        ManagerDAO dao = new ManagerDAO();
        dao.addWarehouse(name, location);
        
        response.sendRedirect("manager_dashboard.jsp?tab=warehouses");
    }
}