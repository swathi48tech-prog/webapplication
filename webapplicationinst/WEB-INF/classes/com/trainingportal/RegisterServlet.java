package com.trainingportal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet for handling student registration
 */
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String course = request.getParameter("course");
        
        // Validate input
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            course == null || course.trim().isEmpty()) {
            
            response.sendRedirect("register.html?error=" + 
                java.net.URLEncoder.encode("Please fill in all fields", "UTF-8"));
            return;
        }
        
        // Check password match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.html?error=" + 
                java.net.URLEncoder.encode("Passwords do not match", "UTF-8"));
            return;
        }
        
        // Validate password length
        if (password.length() < 6) {
            response.sendRedirect("register.html?error=" + 
                java.net.URLEncoder.encode("Password must be at least 6 characters", "UTF-8"));
            return;
        }
        
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            
            // Check if email already exists
            String checkSql = "SELECT student_id FROM students WHERE email = ?";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email);
            rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                response.sendRedirect("register.html?error=" + 
                    java.net.URLEncoder.encode("Email already registered", "UTF-8"));
                return;
            }
            
            // Insert new student
            String insertSql = "INSERT INTO students (full_name, email, phone, password, course, " +
                             "registration_date, status) VALUES (?, ?, ?, ?, ?, SYSDATE, 'active')";
            
            insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setString(1, fullName);
            insertStmt.setString(2, email);
            insertStmt.setString(3, phone);
            insertStmt.setString(4, password); // In production, hash the password!
            insertStmt.setString(5, course);
            
            int rowsInserted = insertStmt.executeUpdate();
            
            if (rowsInserted > 0) {
                // Registration successful
                response.sendRedirect("login.html?success=" + 
                    java.net.URLEncoder.encode("Registration successful! Please login.", "UTF-8"));
            } else {
                response.sendRedirect("register.html?error=" + 
                    java.net.URLEncoder.encode("Registration failed. Please try again.", "UTF-8"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.html?error=" + 
                java.net.URLEncoder.encode("Database error: " + e.getMessage(), "UTF-8"));
        } finally {
            DatabaseUtil.closeResources(rs, checkStmt, insertStmt, conn);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to registration page
        response.sendRedirect("register.html");
    }
}
