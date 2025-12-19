package com.keeptrucking.controllers;

import com.keeptrucking.dao.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DeleteServlet", urlPatterns = {"/DeleteServlet"})
public class DeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String type = request.getParameter("type"); // user, truck, client, warehouse, shipment
        String idParam = request.getParameter("id");
        
        if(type == null || idParam == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int id = Integer.parseInt(idParam);
        
        // 1. DELETE TRUCK
        if(type.equals("truck")) {
            ManagerDAO dao = new ManagerDAO();
            dao.deleteTruck(id);
            response.sendRedirect("manager_dashboard.jsp?tab=trucks");
        } 
        // 2. DELETE CLIENT
        else if(type.equals("client")) {
            ManagerDAO dao = new ManagerDAO();
            dao.deleteClient(id);
            response.sendRedirect("manager_dashboard.jsp?tab=clients");
        } 
        // 3. DELETE WAREHOUSE
        else if(type.equals("warehouse")) {
            ManagerDAO dao = new ManagerDAO();
            dao.deleteWarehouse(id);
            response.sendRedirect("manager_dashboard.jsp?tab=warehouses");
        }
        // 4. DELETE USER (For Admin)
        else if(type.equals("user")) {
            UserDAO dao = new UserDAO();
            dao.deleteUser(id);
            response.sendRedirect("admin_dashboard.jsp?msg=User Deleted");
        }
        // 5. DELETE SHIPMENT (For Manager)
        else if(type.equals("shipment")) {
            ShipmentDAO dao = new ShipmentDAO();
            dao.deleteShipment(id);
            response.sendRedirect("manager_dashboard.jsp?tab=shipments");
        }
    }
}