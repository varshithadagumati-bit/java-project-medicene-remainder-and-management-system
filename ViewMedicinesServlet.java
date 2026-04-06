import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // ఇక్కడ HttpSession యాడ్ చేశాను

@WebServlet("/view-medicines")
public class ViewMedicinesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, String>> medicines = new ArrayList<>();
        
        // 1. సెషన్ నుండి user_id తీసుకోండి
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        // ఒకవేళ లాగిన్ అవ్వకుండా ఇక్కడికి వస్తే లాగిన్ పేజీకి పంపండి
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedDB", "root", "Sneha@123");
            
            // 2. WHERE user_id = ? యాడ్ చేశాను - దీనివల్ల కేవలం మీ మెడిసిన్స్ మాత్రమే వస్తాయి
            PreparedStatement ps = con.prepareStatement("SELECT * FROM medicines WHERE user_id = ?");
            ps.setInt(1, userId); 
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, String> med = new HashMap<>();
                med.put("id", rs.getString("mid")); 
                med.put("name", rs.getString("name"));
                med.put("quantity", rs.getString("quantity"));
                med.put("dosage", rs.getString("dosage"));
                med.put("time", rs.getString("remind_time"));
                med.put("expiry", rs.getString("expiry_date"));
                
                medicines.add(med);
            }
            con.close();
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        request.setAttribute("medicines", medicines);
        request.getRequestDispatcher("view-medicines.jsp").forward(request, response);
    }
}