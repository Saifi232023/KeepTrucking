<%-- 
    Document   : add_items
    Created on : Dec 18, 2025, 8:44:38 PM
    Author     : saif kala
--%>

<%@page import="com.keeptrucking.models.ShipmentItem"%>
<%@page import="java.util.List"%>
<%@page import="com.keeptrucking.dao.ShipmentDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 1. Get the Shipment ID from URL
    String idParam = request.getParameter("shipment_id");
    if(idParam == null) {
        response.sendRedirect("manager_dashboard.jsp");
        return;
    }
    int shipmentId = Integer.parseInt(idParam);

    // 2. Fetch existing items
    ShipmentDAO dao = new ShipmentDAO();
    List<ShipmentItem> items = dao.getItemsByShipment(shipmentId);
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Shipment Items</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row">
                <!-- LEFT: Add Item Form -->
                <div class="col-md-4">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">
                            <h5>Add Item to Shipment #<%= shipmentId %></h5>
                        </div>
                        <div class="card-body">
                            <form action="AddItemServlet" method="POST">
                                <input type="hidden" name="shipment_id" value="<%= shipmentId %>">
                                
                                <div class="mb-3">
                                    <label>Description</label>
                                    <input type="text" name="description" class="form-control" placeholder="e.g. Samsung TV" required>
                                </div>
                                <div class="mb-3">
                                    <label>Quantity</label>
                                    <input type="number" name="quantity" class="form-control" value="1" required>
                                </div>
                                <div class="mb-3">
                                    <label>Total Weight (kg)</label>
                                    <input type="number" step="0.01" name="weight" class="form-control" required>
                                </div>
                                
                                <button type="submit" class="btn btn-success w-100">Add to List</button>
                            </form>
                        </div>
                    </div>
                    <br>
                    <a href="manager_dashboard.jsp" class="btn btn-secondary w-100">Finish & Back to Dashboard</a>
                </div>

                <!-- RIGHT: List of Items -->
                <div class="col-md-8">
                    <h4>Current Manifest</h4>
                    <table class="table table-bordered bg-white">
                        <thead class="table-dark">
                            <tr>
                                <th>Description</th>
                                <th>Qty</th>
                                <th>Weight</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(ShipmentItem item : items) { %>
                            <tr>
                                <td><%= item.getDescription() %></td>
                                <td><%= item.getQuantity() %></td>
                                <td><%= item.getWeight() %> kg</td>
                            </tr>
                            <% } %>
                            
                            <% if(items.isEmpty()) { %>
                                <tr><td colspan="3" class="text-center">No items added yet.</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
