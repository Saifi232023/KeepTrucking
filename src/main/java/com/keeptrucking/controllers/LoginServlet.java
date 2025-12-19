package com.keeptrucking.controllers;

import com.keeptrucking.dao.UserDAO;
import com.keeptrucking.models.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        
        UserDAO dao = new UserDAO();
        User loggedInUser = dao.checkLogin(user, pass);
        
        if (loggedInUser != null) {
            // Login Success: Save to Session
            HttpSession session = request.getSession();
            session.setAttribute("user", loggedInUser);
            
            // Redirect based on Role
            String role = loggedInUser.getRole();
            if (role.equalsIgnoreCase("Admin")) {
                response.sendRedirect("admin_dashboard.jsp");
            } else if (role.equalsIgnoreCase("Manager")) {
                response.sendRedirect("manager_dashboard.jsp");
            } else if (role.equalsIgnoreCase("Driver")) {
                response.sendRedirect("driver_dashboard.jsp");
            }
        } else {
            // Login Failed
            response.sendRedirect("login.jsp?error=Invalid Credentials");
        }
    }
}