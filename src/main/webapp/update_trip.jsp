<%@page import="com.keeptrucking.dao.ManagerDAO"%>
<%@page import="com.keeptrucking.models.Warehouse"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int shipmentId = Integer.parseInt(request.getParameter("id"));
    ManagerDAO mgrDao = new ManagerDAO(); // To get warehouses list
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Trip</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-success text-white">Update Status for Shipment #<%= shipmentId %></div>
            <div class="card-body">
                <form action="UpdateStatusServlet" method="POST">
                    <input type="hidden" name="shipment_id" value="<%= shipmentId %>">
                    
                    <div class="mb-3">
                        <label class="form-label">Select New Status</label>
                        <select name="status" class="form-select" id="statusSelect" onchange="toggleWarehouse()">
                            <option value="In Transit">In Transit (On Road)</option>
                            <option value="Stored">Stored at Warehouse</option>
                            <option value="Delivered">Delivered (Complete Trip)</option>
                        </select>
                    </div>

                    <!-- Warehouse Selection (Hidden by default) -->
                    <div class="mb-3" id="warehouseDiv" style="display:none;">
                        <label>Select Warehouse</label>
                        <select name="warehouse_id" class="form-select">
                            <option value="0">-- Select --</option>
                            <% for(Warehouse w : mgrDao.getAllWarehouses()) { %>
                                <option value="<%= w.getWarehouseId() %>"><%= w.getName() %></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label>Remarks (Optional)</label>
                        <textarea name="remarks" class="form-control"></textarea>
                    </div>

                    <button class="btn btn-success w-100">Update Status</button>
                    <a href="driver_dashboard.jsp" class="btn btn-secondary w-100 mt-2">Cancel</a>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleWarehouse() {
            var status = document.getElementById("statusSelect").value;
            var div = document.getElementById("warehouseDiv");
            if(status === "Stored") {
                div.style.display = "block";
            } else {
                div.style.display = "none";
            }
        }
    </script>
</body>
</html>