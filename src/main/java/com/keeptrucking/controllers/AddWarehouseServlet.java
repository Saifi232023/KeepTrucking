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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String zip = request.getParameter("zip");
        
        new ManagerDAO().addWarehouse(name, street, city, zip);
        response.sendRedirect("manager_dashboard.jsp?tab=warehouses");
    }
}