<%-- 
    Document   : manager_dashboard
    Created on : Dec 17, 2025, 9:20:41 PM
    Author     : saif kala
--%>
<%@page import="com.keeptrucking.dao.ShipmentDAO"%>
<%@page import="com.keeptrucking.models.Shipment"%>
<%@page import="com.keeptrucking.models.*"%>
<%@page import="com.keeptrucking.dao.ManagerDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Security Check
    if(session.getAttribute("user") == null) { response.sendRedirect("login.jsp"); return; }
    ManagerDAO dao = new ManagerDAO();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-dark bg-primary mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">KeepTrucking | Manager</a>
        <a href="login.jsp" class="btn btn-sm btn-light">Logout</a>
    </div>
</nav>

<div class="container">
    
    <!-- Navigation Tabs -->
    <!-- Navigation Tabs -->
    <ul class="nav nav-tabs mb-3" id="myTab" role="tablist">
        <!-- 1. Shipments (Active) -->
        <li class="nav-item">
            <button class="nav-link active" id="shipments-tab" data-bs-toggle="tab" data-bs-target="#shipments" type="button">Active Shipments</button>
        </li>
        <!-- 2. Trucks (Not Active) -->
        <li class="nav-item">
            <button class="nav-link" id="trucks-tab" data-bs-toggle="tab" data-bs-target="#trucks" type="button">Trucks</button>
        </li>
        <!-- 3. Clients (Not Active) -->
        <li class="nav-item">
            <button class="nav-link" id="clients-tab" data-bs-toggle="tab" data-bs-target="#clients" type="button">Clients</button>
        </li>
        <!-- 4. Warehouses (Not Active) -->
        <li class="nav-item">
            <button class="nav-link" id="warehouses-tab" data-bs-toggle="tab" data-bs-target="#warehouses" type="button">Warehouses</button>
        </li>
    </ul>

    <div class="tab-content" id="myTabContent">
        <!-- SHIPMENTS TAB -->
        <div class="tab-pane fade show active" id="shipments">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4>All Shipments</h4>
                <a href="create_shipment.jsp" class="btn btn-warning fw-bold">+ New Shipment</a>
            </div>
            
            <table class="table table-hover table-bordered bg-white">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Client</th>
                        <th>Route</th>
                        <th>Driver / Truck</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        ShipmentDAO shipDao = new ShipmentDAO();
                        List<Shipment> myShipments = shipDao.getAllShipments();
                        for(Shipment s : myShipments) { 
                    %>
                    <tr>
                        <td>#<%= s.getShipmentId() %></td>
                        <td><%= s.getClientName() %></td>
                        <td>
                            <small class="text-muted">From:</small> <%= s.getOrigin() %><br>
                            <small class="text-muted">To:</small> <%= s.getDestination() %>
                        </td>
                        <td>
                            <%= s.getDriverName() %><br>
                            <span class="badge bg-secondary"><%= s.getTruckPlate() %></span>
                        </td>
                        <td>
                            <span class="badge bg-<%= s.getStatus().equals("Pending")?"warning":s.getStatus().equals("Delivered")?"success":"primary" %>">
                                <%= s.getStatus() %>
                            </span>
                        </td>
                        <td>
                            <a href="add_items.jsp?shipment_id=<%= s.getShipmentId() %>" class="btn btn-sm btn-info text-white">View/Add Items</a>
                        </td>
                    </tr>
                    <% } %>
                    
                    <% if(myShipments.isEmpty()) { %>
                        <tr><td colspan="6" class="text-center">No active shipments found.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <!-- TRUCKS TAB -->
        <div class="tab-pane fade show active" id="trucks">
            <div class="row">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h5>Add New Truck</h5>
                        <form action="AddTruckServlet" method="POST">
                            <input type="text" name="plate" class="form-control mb-2" placeholder="Plate Number" required>
                            <input type="text" name="model" class="form-control mb-2" placeholder="Model (e.g. Volvo FH)" required>
                            <button class="btn btn-primary w-100">Add Truck</button>
                        </form>
                    </div>
                </div>
                <div class="col-md-8">
                    <table class="table table-bordered bg-white">
                        <thead><tr><th>ID</th><th>Plate</th><th>Model</th><th>Status</th></tr></thead>
                        <tbody>
                            <% for(Truck t : dao.getAllTrucks()) { %>
                            <tr>
                                <td><%= t.getTruckId() %></td>
                                <td><%= t.getPlateNumber() %></td>
                                <td><%= t.getModel() %></td>
                                <td><span class="badge bg-success"><%= t.getStatus() %></span></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- CLIENTS TAB -->
        <div class="tab-pane fade" id="clients">
            <div class="row">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h5>Add Client</h5>
                        <form action="AddClientServlet" method="POST">
                            <input type="text" name="name" class="form-control mb-2" placeholder="Company Name" required>
                            <input type="text" name="phone" class="form-control mb-2" placeholder="Phone" required>
                            <input type="email" name="email" class="form-control mb-2" placeholder="Email" required>
                            <button class="btn btn-primary w-100">Add Client</button>
                        </form>
                    </div>
                </div>
                <div class="col-md-8">
                    <table class="table table-bordered bg-white">
                        <thead><tr><th>ID</th><th>Company</th><th>Phone</th><th>Email</th></tr></thead>
                        <tbody>
                            <% for(Client c : dao.getAllClients()) { %>
                            <tr>
                                <td><%= c.getClientId() %></td>
                                <td><%= c.getCompanyName() %></td>
                                <td><%= c.getPhone() %></td>
                                <td><%= c.getEmail() %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- WAREHOUSES TAB -->
        <div class="tab-pane fade" id="warehouses">
            <div class="row">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h5>Add Warehouse</h5>
                        <form action="AddWarehouseServlet" method="POST">
                            <input type="text" name="name" class="form-control mb-2" placeholder="Name (e.g. North Hub)" required>
                            <input type="text" name="location" class="form-control mb-2" placeholder="Location" required>
                            <button class="btn btn-primary w-100">Add Warehouse</button>
                        </form>
                    </div>
                </div>
                <div class="col-md-8">
                    <table class="table table-bordered bg-white">
                        <thead><tr><th>ID</th><th>Name</th><th>Location</th></tr></thead>
                        <tbody>
                            <% for(Warehouse w : dao.getAllWarehouses()) { %>
                            <tr>
                                <td><%= w.getWarehouseId() %></td>
                                <td><%= w.getName() %></td>
                                <td><%= w.getLocation() %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>