package com.keeptrucking.controllers;
import com.keeptrucking.dao.ManagerDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddClientServlet", urlPatterns = {"/AddClientServlet"})
public class AddClientServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String company = request.getParameter("company");
        String contact = request.getParameter("contact");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        
        new ManagerDAO().addClient(company, contact, phone, email);
        response.sendRedirect("manager_dashboard.jsp?tab=clients");
    }
}