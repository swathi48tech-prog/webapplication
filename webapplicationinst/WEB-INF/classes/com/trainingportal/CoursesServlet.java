package com.trainingportal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet for fetching courses data
 */
public class CoursesServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PrintWriter out = response.getWriter();
        
        try {
            conn = DatabaseUtil.getConnection();
            
            String sql = "SELECT course_id, course_name, description, duration, " +
                        "mode, certification, status FROM courses WHERE status = 'active'";
            
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            JSONArray coursesArray = new JSONArray();
            
            while (rs.next()) {
                JSONObject course = new JSONObject();
                course.put("courseId", rs.getInt("course_id"));
                course.put("courseName", rs.getString("course_name"));
                course.put("description", rs.getString("description"));
                course.put("duration", rs.getString("duration"));
                course.put("mode", rs.getString("mode"));
                course.put("certification", rs.getString("certification"));
                
                coursesArray.put(course);
            }
            
            out.print(coursesArray.toString());
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", "Database error: " + e.getMessage());
            out.print(error.toString());
        } finally {
            DatabaseUtil.closeResources(rs, pstmt, conn);
        }
    }
}
