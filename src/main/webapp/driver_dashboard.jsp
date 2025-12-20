<%@page import="com.keeptrucking.dao.ShipmentDAO"%>
<%@page import="com.keeptrucking.models.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("user");
    if(currentUser == null || !currentUser.getRole().equals("Driver")){
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Fetch ALL jobs
    ShipmentDAO dao = new ShipmentDAO();
    List<Shipment> allJobs = dao.getShipmentsByDriver(currentUser.getUserId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Driver Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">Driver Portal</a>
        <span class="navbar-text text-white">Driver: <%= currentUser.getFullName() %></span>
        <a href="login.jsp" class="btn btn-sm btn-danger ms-2">Logout</a>
    </div>
</nav>

<div class="container">
    
    <!-- TABS -->
    <ul class="nav nav-tabs mb-3" id="driverTab" role="tablist">
        <li class="nav-item"><button class="nav-link active" data-bs-toggle="tab" data-bs-target="#active">Current Jobs</button></li>
        <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#history">Trip History</button></li>
    </ul>

    <div class="tab-content">
        
        <!-- TAB 1: CURRENT JOBS (Pending, In Transit, Stored) -->
        <div class="tab-pane fade show active" id="active">
            <div class="row">
                <% 
                boolean hasActive = false;
                for(Shipment s : allJobs) { 
                    if(!s.getStatus().equals("Delivered")) { 
                        hasActive = true;
                %>
                <div class="col-md-6 mb-4">
                    <div class="card shadow-sm border-primary h-100">
                        <div class="card-header d-flex justify-content-between text-white bg-primary">
                            <strong>#<%= s.getShipmentId() %></strong>
                            <span class="badge bg-light text-dark"><%= s.getStatus() %></span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title"><%= s.getClientName() %></h5>
                            <p class="card-text">
                                <strong>From:</strong> <%= s.getOrigin() %><br>
                                <strong>To:</strong> <%= s.getDestination() %><br>
                                <strong>Truck:</strong> <%= s.getTruckPlate() %>
                            </p>
                            <hr>
                            <a href="update_trip.jsp?id=<%= s.getShipmentId() %>" class="btn btn-success w-100">Update Status</a>
                        </div>
                    </div>
                </div>
                <% }} %>

                <% if(!hasActive) { %>
                    <div class="col-12"><div class="alert alert-info">No active jobs. You are free! ☕</div></div>
                <% } %>
            </div>
        </div>

        <!-- TAB 2: HISTORY (Delivered) -->
        <div class="tab-pane fade" id="history">
            <table class="table table-striped bg-white border">
                <thead><tr><th>ID</th><th>Client</th><th>Route</th><th>Date</th><th>Status</th></tr></thead>
                <tbody>
                    <% 
                    for(Shipment s : allJobs) { 
                        if(s.getStatus().equals("Delivered")) { 
                    %>
                    <tr>
                        <td>#<%= s.getShipmentId() %></td>
                        <td><%= s.getClientName() %></td>
                        <td><%= s.getOrigin() %> &rarr; <%= s.getDestination() %></td>
                        <td><%= s.getCreatedAt() %></td>
                        <td><span class="badge bg-success">Delivered</span></td>
                    </tr>
                    <% }} %>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>