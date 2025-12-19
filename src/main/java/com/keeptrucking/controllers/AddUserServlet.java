package com.keeptrucking.controllers;

import com.keeptrucking.dao.UserDAO;
import com.keeptrucking.models.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddUserServlet", urlPatterns = {"/AddUserServlet"})
public class AddUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String role = request.getParameter("role");
        
        // Create User Object (ID is 0 because DB auto-increments it)
        User newUser = new User(0, username, role, fullname);
        
        UserDAO dao = new UserDAO();
        boolean success = dao.addUser(newUser, pass);
        
        if(success) {
            response.sendRedirect("admin_dashboard.jsp?msg=User Created Successfully");
        } else {
            response.sendRedirect("admin_dashboard.jsp?error=Failed to Create User");
        }
    }
}