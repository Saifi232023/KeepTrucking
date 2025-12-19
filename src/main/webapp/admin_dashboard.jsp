<%-- 
    Document   : admin_dashboard
    Created on : Dec 17, 2025, 9:20:13 PM
    Author     : saif kala
--%>

<%@page import="java.util.List"%>
<%@page import="com.keeptrucking.models.User"%>
<%@page import="com.keeptrucking.dao.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Security Check: If not logged in, kick them out
    User currentUser = (User) session.getAttribute("user");
    if(currentUser == null || !currentUser.getRole().equals("Admin")){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-dark bg-dark mb-4">
            <div class="container">
                <a class="navbar-brand" href="#">KeepTrucking | Admin</a>
                <span class="navbar-text text-white">
                    Welcome, <%= currentUser.getFullName() %> | 
                    <a href="login.jsp" class="btn btn-sm btn-outline-danger ms-2">Logout</a>
                </span>
            </div>
        </nav>

        <div class="container">
            <!-- Messages -->
            <% if(request.getParameter("msg") != null) { %>
                <div class="alert alert-success"><%= request.getParameter("msg") %></div>
            <% } %>

            <div class="row">
                <!-- LEFT COLUMN: Create User Form -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header bg-primary text-white">Create New User</div>
                        <div class="card-body">
                            <form action="AddUserServlet" method="POST">
                                <div class="mb-3">
                                    <label>Full Name</label>
                                    <input type="text" name="fullname" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label>Username</label>
                                    <input type="text" name="username" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label>Password</label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label>Role</label>
                                    <select name="role" class="form-control">
                                        <option value="Manager">Fleet Manager</option>
                                        <option value="Driver">Driver</option>
                                        <option value="Admin">Admin</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-success w-100">Create Account</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- RIGHT COLUMN: User List -->
                <div class="col-md-8">
                    <h4>System Users</h4>
                    <table class="table table-striped table-bordered">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Username</th>
                                <th>Role</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                UserDAO dao = new UserDAO();
                                List<User> users = dao.getAllUsers();
                                for(User u : users) {
                            %>
                            <tr>
                                <td><%= u.getUserId() %></td>
                                <td><%= u.getFullName() %></td>
                                <td><%= u.getUsername() %></td>
                                <td>
                                    <span class="badge bg-<%= u.getRole().equals("Admin")?"danger": u.getRole().equals("Manager")?"warning":"info" %>">
                                        <%= u.getRole() %>
                                    </span>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
