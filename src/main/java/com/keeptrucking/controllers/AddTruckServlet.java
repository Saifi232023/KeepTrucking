package com.keeptrucking.controllers;

import com.keeptrucking.dao.ManagerDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddTruckServlet", urlPatterns = {"/AddTruckServlet"})
public class AddTruckServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get data from form
        String plate = request.getParameter("plate");
        String model = request.getParameter("model");
        
        // 2. Save to Database
        ManagerDAO dao = new ManagerDAO();
        dao.addTruck(plate, model);
        
        // 3. Redirect back to dashboard
        response.sendRedirect("manager_dashboard.jsp?tab=trucks");
    }
}