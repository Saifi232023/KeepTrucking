<%@page import="com.keeptrucking.dao.*"%>
<%@page import="com.keeptrucking.models.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("user") == null) { response.sendRedirect("login.jsp"); return; }
    ManagerDAO mgrDao = new ManagerDAO();
    ShipmentDAO shipDao = new ShipmentDAO();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard - KeepTrucking</title>
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

<nav class="navbar navbar-dark bg-primary mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">KeepTrucking | Manager</a>
        <a href="login.jsp" class="btn btn-sm btn-light">Logout</a>
    </div>
</nav>

<div class="container">
    <ul class="nav nav-tabs mb-3" id="myTab" role="tablist">
        <li class="nav-item"><button class="nav-link active" data-bs-toggle="tab" data-bs-target="#shipments">Active Shipments</button></li>
        <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#trucks">Trucks</button></li>
        <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#clients">Clients</button></li>
        <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#warehouses">Warehouses</button></li>
    </ul>

    <div class="tab-content">
        <!-- 1. SHIPMENTS -->
        <div class="tab-pane fade show active" id="shipments">
            <div class="d-flex justify-content-between mb-3">
                <h4>All Shipments</h4>
                <a href="create_shipment.jsp" class="btn btn-warning fw-bold">+ New Shipment</a>
            </div>
            <div class="row mb-4">
    <!-- Card 1 -->
    <div class="col-md-3">
        <div class="card text-white bg-primary h-100">
            <div class="card-body d-flex align-items-center">
                <div class="fs-1 me-3"><i class="fas fa-box"></i></div>
                <div>
                    <h5 class="card-title mb-0">Total Shipments</h5>
                    <h2 class="mb-0"><%= shipDao.getAllShipments().size() %></h2>
                </div>
            </div>
        </div>
    </div>
    <!-- Card 2 -->
    <div class="col-md-3">
        <div class="card text-white bg-success h-100">
            <div class="card-body d-flex align-items-center">
                <div class="fs-1 me-3"><i class="fas fa-dollar-sign"></i></div>
                <div>
                    <h5 class="card-title mb-0">Revenue</h5>
                    <h2 class="mb-0">$<%= String.format("%,.0f", shipDao.getAllShipments().stream().mapToDouble(s -> 0).sum()) %>+</h2> 
                    <!-- (Replace sum logic with real data later) -->
                </div>
            </div>
        </div>
    </div>
    <!-- Card 3 -->
    <div class="col-md-3">
        <div class="card text-white bg-warning h-100">
            <div class="card-body d-flex align-items-center">
                <div class="fs-1 me-3"><i class="fas fa-truck-moving"></i></div>
                <div>
                    <h5 class="card-title mb-0">Active Trucks</h5>
                    <h2 class="mb-0"><%= mgrDao.getAllTrucks().size() %></h2>
                </div>
            </div>
        </div>
    </div>
</div>
            <table class="table table-bordered bg-white">
                <thead class="table-dark"><tr><th>ID</th><th>Client</th><th>Route</th><th>Driver/Truck</th><th>Status</th><th>Action</th></tr></thead>
                <tbody>
                    <% for(Shipment s : shipDao.getAllShipments()) { %>
                    <tr>
                        <td>#<%= s.getShipmentId() %></td>
                        <td><%= s.getClientName() %></td>
                        <td><%= s.getOrigin() %> &rarr; <%= s.getDestination() %></td>
                        <td><%= s.getDriverName() %><br><small><%= s.getTruckPlate() %></small></td>
                        <td><span class="badge bg-primary"><%= s.getStatus() %></span></td>
                        <td>
                            <a href="shipment_details.jsp?id=<%= s.getShipmentId() %>" class="btn btn-sm btn-success">Details/Invoice</a>
                            <a href="DeleteServlet?type=shipment&id=<%= s.getShipmentId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Delete?')">Delete</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- 2. TRUCKS (With Type & Capacity) -->
        <div class="tab-pane fade" id="trucks">
            <div class="row">
                <div class="col-md-4">
                    <form action="AddTruckServlet" method="POST" class="card p-3 mb-3">
                        <h5>Add Truck</h5>
                        <input name="plate" class="form-control mb-2" placeholder="Plate Number" required>
                        <input name="model" class="form-control mb-2" placeholder="Model" required>
                        <select name="type" class="form-control mb-2">
                            <option value="Box Truck">Box Truck</option>
                            <option value="Flatbed">Flatbed</option>
                            <option value="Refrigerated">Refrigerated</option>
                        </select>
                        <input name="capacity" type="number" step="0.01" class="form-control mb-2" placeholder="Capacity (kg)" required>
                        <button class="btn btn-primary w-100">Add</button>
                    </form>
                </div>
                <div class="col-md-8">
                    <table class="table table-bordered bg-white">
                        <thead><tr><th>Plate</th><th>Model</th><th>Type</th><th>Capacity</th><th>Status</th><th>Action</th></tr></thead>
                        <tbody>
                            <% for(Truck t : mgrDao.getAllTrucks()) { %>
                            <tr>
                                <td><%= t.getPlateNumber() %></td>
                                <td><%= t.getModel() %></td>
                                <td><%= t.getType() %></td>
                                <td><%= t.getCapacity() %> kg</td>
                                <td><%= t.getStatus() %></td>
                                <td><a href="DeleteServlet?type=truck&id=<%= t.getTruckId() %>" class="btn btn-sm btn-danger">Delete</a></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 3. CLIENTS (With Contact Name) -->
        <div class="tab-pane fade" id="clients">
            <div class="row">
                <div class="col-md-4">
                    <form action="AddClientServlet" method="POST" class="card p-3 mb-3">
                        <h5>Add Client</h5>
                        <input name="company" class="form-control mb-2" placeholder="Company Name" required>
                        <input name="contact" class="form-control mb-2" placeholder="Contact Person" required>
                        <input name="phone" class="form-control mb-2" placeholder="Phone" required>
                        <input name="email" class="form-control mb-2" placeholder="Email" required>
                        <button class="btn btn-primary w-100">Add</button>
                    </form>
                </div>
                <div class="col-md-8">
                    <table class="table table-bordered bg-white">
                        <thead><tr><th>Company</th><th>Contact</th><th>Phone</th><th>Email</th><th>Action</th></tr></thead>
                        <tbody>
                            <% for(Client c : mgrDao.getAllClients()) { %>
                            <tr>
                                <td><%= c.getCompanyName() %></td>
                                <td><%= c.getContactName() %></td>
                                <td><%= c.getPhone() %></td>
                                <td><%= c.getEmail() %></td>
                                <td><a href="DeleteServlet?type=client&id=<%= c.getClientId() %>" class="btn btn-sm btn-danger">Delete</a></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 4. WAREHOUSES (With Full Address) -->
        <div class="tab-pane fade" id="warehouses">
             <div class="row">
                <div class="col-md-4">
                    <form action="AddWarehouseServlet" method="POST" class="card p-3 mb-3">
                        <h5>Add Warehouse</h5>
                        <input name="name" class="form-control mb-2" placeholder="Name" required>
                        <input name="street" class="form-control mb-2" placeholder="Street Address" required>
                        <input name="city" class="form-control mb-2" placeholder="City" required>
                        <input name="zip" class="form-control mb-2" placeholder="Zip Code" required>
                        <button class="btn btn-primary w-100">Add</button>
                    </form>
                </div>
                <div class="col-md-8">
                    <table class="table table-bordered bg-white">
                        <thead><tr><th>Name</th><th>Address</th><th>Action</th></tr></thead>
                        <tbody>
                            <% for(Warehouse w : mgrDao.getAllWarehouses()) { %>
                            <tr>
                                <td><%= w.getName() %></td>
                                <td><%= w.getStreet() %>, <%= w.getCity() %> <%= w.getZipCode() %></td>
                                <td><a href="DeleteServlet?type=warehouse&id=<%= w.getWarehouseId() %>" class="btn btn-sm btn-danger">Delete</a></td>
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