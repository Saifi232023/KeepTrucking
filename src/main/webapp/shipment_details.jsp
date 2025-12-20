<%@page import="java.sql.*, com.keeptrucking.dao.*, com.keeptrucking.models.*, java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ShipmentDAO dao = new ShipmentDAO();
    
    // Manual Fetch for Invoice Amount (Simple logic)
    Shipment s = dao.getShipmentById(id);
    double invoiceAmount = 0;
    try {
        Connection con = DBConnection.getConnection();
        ResultSet rs = con.createStatement().executeQuery("SELECT invoice_amount FROM shipments WHERE shipment_id="+id);
        if(rs.next()) invoiceAmount = rs.getDouble("invoice_amount");
    } catch(Exception e){}

    List<ShipmentItem> items = dao.getItemsByShipment(id);
    List<Expense> expenses = dao.getExpenses(id);
    
    double totalExpenses = 0;
    for(Expense e : expenses) totalExpenses += e.getAmount();
    double netProfit = invoiceAmount - totalExpenses;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Shipment Details - KeepTrucking</title>
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
        <style>
            @media print { .no-print { display: none; } }
        </style>
</head>
<body class="bg-light">

<div class="container mt-4">
    <div class="d-flex justify-content-between no-print mb-3">
        <a href="manager_dashboard.jsp" class="btn btn-secondary">&larr; Dashboard</a>
        <button onclick="window.print()" class="btn btn-primary">Print Invoice</button>
    </div>

    <!-- Invoice Header -->
    <div class="card p-4 mb-4">
        <div class="row">
            <div class="col-6">
                <h2>KeepTrucking Co.</h2>
                <p><strong>Shipment #<%= id %></strong> | Date: <%= s.getCreatedAt() %></p>
            </div>
            <div class="col-6 text-end">
                <h4><%= s.getClientName() %></h4>
                <p>Route: <%= s.getOrigin() %> &rarr; <%= s.getDestination() %></p>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- ITEMS -->
        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-dark text-white">Manifest</div>
                <div class="card-body">
                    <table class="table table-sm">
                        <thead><tr><th>Item</th><th>Qty</th><th>Weight</th></tr></thead>
                        <tbody>
                            <% for(ShipmentItem item : items) { %>
                            <tr><td><%= item.getDescription() %></td><td><%= item.getQuantity() %></td><td><%= item.getWeight() %> kg</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- FINANCE -->
        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-success text-white">Financials</div>
                <div class="card-body">
                    
                    <!-- INVOICE AMOUNT (Editable) -->
                    <div class="alert alert-light border">
                        <div class="d-flex justify-content-between">
                            <h5>Invoice Amount:</h5>
                            <h4 class="text-primary">$<%= invoiceAmount %></h4>
                        </div>
                        <form action="UpdateInvoiceServlet" method="POST" class="d-flex gap-2 no-print mt-2">
                            <input type="hidden" name="shipment_id" value="<%= id %>">
                            <input type="number" step="0.01" name="amount" class="form-control form-control-sm" placeholder="Set Amount">
                            <button class="btn btn-sm btn-primary">Update</button>
                        </form>
                    </div>

                    <!-- EXPENSES -->
                    <h6>Expenses:</h6>
                    <table class="table table-sm">
                        <% for(Expense e : expenses) { %>
                        <tr><td><%= e.getDescription() %></td><td class="text-danger text-end">-$<%= e.getAmount() %></td></tr>
                        <% } %>
                    </table>

                    <form action="AddExpenseServlet" method="POST" class="d-flex gap-2 no-print mb-3">
                        <input type="hidden" name="shipment_id" value="<%= id %>">
                        <input type="text" name="description" class="form-control form-control-sm" placeholder="Desc" required>
                        <input type="number" name="amount" class="form-control form-control-sm" placeholder="Cost" required>
                        <button class="btn btn-sm btn-danger">Add Expense</button>
                    </form>

                    <hr>
                    <div class="d-flex justify-content-between alert alert-<%= netProfit>=0?"success":"danger" %>">
                        <strong>NET PROFIT:</strong>
                        <strong>$<%= netProfit %></strong>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>