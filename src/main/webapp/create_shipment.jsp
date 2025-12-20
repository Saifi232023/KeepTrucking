<%-- 
    Document   : create_shipment
    Created on : Dec 18, 2025, 8:41:41 PM
    Author     : saif kala
--%>
<%@page import="com.keeptrucking.dao.*"%>
<%@page import="com.keeptrucking.models.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Helper DAOs to populate dropdowns
    ManagerDAO mgrDao = new ManagerDAO();
    ShipmentDAO shipDao = new ShipmentDAO();
    
    List<Client> clients = mgrDao.getAllClients();
    List<Truck> availableTrucks = shipDao.getAvailableTrucks();
    List<User> drivers = shipDao.getDrivers();
%>
<!DOCTYPE html>
<html>
    <head>
    <title>Create Shipment - KeepTrucking</title>
    <!-- 1. Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 2. Google Font: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- 3. FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- 4. YOUR CUSTOM CSS -->
    <link href="css/style.css" rel="stylesheet">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">
                            <h4>Create New Shipment</h4>
                        </div>
                        <div class="card-body">
                            <form action="CreateShipmentServlet" method="POST">
                                
                                <!-- Client Dropdown -->
                                <div class="mb-3">
                                    <label>Select Client</label>
                                    <select name="client_id" class="form-select" required>
                                        <option value="">-- Choose Client --</option>
                                        <% for(Client c : clients) { %>
                                            <option value="<%= c.getClientId() %>"><%= c.getCompanyName() %></option>
                                        <% } %>
                                    </select>
                                </div>

                                <!-- Driver Dropdown -->
                                <div class="mb-3">
                                    <label>Assign Driver</label>
                                    <select name="driver_id" class="form-select" required>
                                        <option value="">-- Choose Driver --</option>
                                        <% for(User d : drivers) { %>
                                            <option value="<%= d.getUserId() %>"><%= d.getFullName() %></option>
                                        <% } %>
                                    </select>
                                </div>

                                <!-- Truck Dropdown -->
                                <div class="mb-3">
                                    <label>Assign Truck</label>
                                    <select name="truck_id" class="form-select" required>
                                        <option value="">-- Choose Available Truck --</option>
                                        <% for(Truck t : availableTrucks) { %>
                                            <option value="<%= t.getTruckId() %>">
                                                <%= t.getPlateNumber() %> - <%= t.getModel() %>
                                            </option>
                                        <% } %>
                                    </select>
                                    <% if(availableTrucks.isEmpty()) { %>
                                        <small class="text-danger">No trucks available!</small>
                                    <% } %>
                                </div>

                                <div class="mb-3">
                                    <label>Origin</label>
                                    <input type="text" name="origin" class="form-control" required>
                                </div>

                                <div class="mb-3">
                                    <label>Destination</label>
                                    <input type="text" name="destination" class="form-control" required>
                                </div>

                                <button type="submit" class="btn btn-success w-100">Next: Add Items</button>
                                <a href="manager_dashboard.jsp" class="btn btn-secondary w-100 mt-2">Cancel</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>