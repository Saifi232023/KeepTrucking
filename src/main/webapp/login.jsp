<%-- 
    Document   : login
    Created on : Dec 17, 2025, 9:22:03 PM
    Author     : saif kala
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>KeepTrucking Login</title>
        <!-- Bootstrap for styling -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-4">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white text-center">
                            <h3>KeepTrucking</h3>
                        </div>
                        <div class="card-body">
                            <% 
                                String error = request.getParameter("error");
                                if(error != null) {
                            %>
                                <div class="alert alert-danger"><%= error %></div>
                            <% } %>
                            
                            <form action="LoginServlet" method="POST">
                                <div class="mb-3">
                                    <label>Username</label>
                                    <input type="text" name="username" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label>Password</label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>
                                <button type="submit" class="btn btn-primary w-100">Login</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>