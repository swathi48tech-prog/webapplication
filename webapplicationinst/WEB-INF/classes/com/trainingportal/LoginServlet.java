package com.trainingportal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet for handling student login
 */
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate input
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.html?error=" + 
                java.net.URLEncoder.encode("Please fill in all fields", "UTF-8"));
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            
            // Query to check credentials
            String sql = "SELECT student_id, full_name, email, phone, course, status " +
                        "FROM students WHERE email = ? AND password = ? AND status = 'active'";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password); // In production, use hashed passwords!
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Login successful - create session
                HttpSession session = request.getSession();
                session.setAttribute("studentId", rs.getInt("student_id"));
                session.setAttribute("studentName", rs.getString("full_name"));
                session.setAttribute("studentEmail", rs.getString("email"));
                session.setAttribute("studentCourse", rs.getString("course"));
                session.setMaxInactiveInterval(30 * 60); // 30 minutes
                
                // Redirect to dashboard
                response.sendRedirect("dashboard.html");
            } else {
                // Login failed
                response.sendRedirect("login.html?error=" + 
                    java.net.URLEncoder.encode("Invalid email or password", "UTF-8"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.html?error=" + 
                java.net.URLEncoder.encode("Database error: " + e.getMessage(), "UTF-8"));
        } finally {
            DatabaseUtil.closeResources(rs, pstmt, conn);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to login page
        response.sendRedirect("login.html");
    }
}
