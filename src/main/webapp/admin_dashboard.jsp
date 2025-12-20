<%-- 
    Document   : admin_dashboard
    Created on : Dec 17, 2025, 9:20:13 PM
    Author     : saif kala
--%>

<%@page import="com.keeptrucking.models.*"%>
<%@page import="com.keeptrucking.dao.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("user");
    if(currentUser == null || !currentUser.getRole().equals("Admin")){
        response.sendRedirect("login.jsp");
        return;
    }
    UserDAO userDAO = new UserDAO();
    ManagerDAO mgrDAO = new ManagerDAO();
    ShipmentDAO shipDAO = new ShipmentDAO();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">KeepTrucking | Admin</a>
        <a href="login.jsp" class="btn btn-sm btn-outline-danger">Logout</a>
    </div>
</nav>

<div class="container">
    <% if(request.getParameter("msg") != null) { %>
        <div class="alert alert-success"><%= request.getParameter("msg") %></div>
    <% } %>

    <!-- Admin Tabs -->
    <ul class="nav nav-tabs mb-3" id="adminTabs" role="tablist">
        <li class="nav-item"><button class="nav-link active" data-bs-toggle="tab" data-bs-target="#users">User Management</button></li>
        <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#viewData">System Overview (Read-Only)</button></li>
    </ul>

    <div class="tab-content">
        <!-- USER MANAGEMENT -->
        <div class="tab-pane fade show active" id="users">
            <div class="row">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h5>Create User</h5>
                        <form action="AddUserServlet" method="POST">
                            <input type="text" name="fullname" class="form-control mb-2" placeholder="Full Name" required>
                            <input type="text" name="username" class="form-control mb-2" placeholder="Username" required>
                            <input type="password" name="password" class="form-control mb-2" placeholder="Password" required>
                            <select name="role" class="form-control mb-2">
                                <option value="Manager">Fleet Manager</option>
                                <option value="Driver">Driver</option>
                                <option value="Admin">Admin</option>
                            </select>
                            <button class="btn btn-success w-100">Create</button>
                        </form>
                    </div>
                </div>
                <div class="col-md-8">
                    <table class="table table-striped table-bordered">
                        <thead class="table-dark"><tr><th>ID</th><th>Name</th><th>Role</th><th>Action</th></tr></thead>
                        <tbody>
                            <% for(User u : userDAO.getAllUsers()) { %>
                            <tr>
                                <td><%= u.getUserId() %></td>
                                <td><%= u.getFullName() %></td>
                                <td><%= u.getRole() %></td>
                                <td>
                                    <% if(!u.getRole().equals("Admin")) { %>
                                    <a href="DeleteServlet?type=user&id=<%= u.getUserId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Delete User?')">Delete</a>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- READ-ONLY SYSTEM OVERVIEW -->
        <div class="tab-pane fade" id="viewData">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <div class="card">
                        <div class="card-header bg-info text-white">Trucks</div>
                        <div class="card-body">
                            <table class="table table-sm">
                                <thead><tr><th>Plate</th><th>Type</th><th>Status</th></tr></thead>
                                <tbody>
                                    <% for(Truck t : mgrDAO.getAllTrucks()) { %>
                                    <tr><td><%= t.getPlateNumber() %></td><td><%= t.getType() %></td><td><%= t.getStatus() %></td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <div class="card">
                        <div class="card-header bg-warning text-dark">Shipments</div>
                        <div class="card-body">
                            <table class="table table-sm">
                                <thead><tr><th>ID</th><th>Client</th><th>Status</th></tr></thead>
                                <tbody>
                                    <% for(Shipment s : shipDAO.getAllShipments()) { %>
                                    <tr><td>#<%= s.getShipmentId() %></td><td><%= s.getClientName() %></td><td><%= s.getStatus() %></td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>