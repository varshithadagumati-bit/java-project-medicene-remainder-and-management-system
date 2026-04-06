import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.sql.*;

@WebServlet("/update-medicine")
public class UpdateMedicineServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String dosage = request.getParameter("dosage");
            int qty = Integer.parseInt(request.getParameter("quantity"));
            String time = request.getParameter("remind_time");
            String expiry = request.getParameter("expiry_date");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedDB", "root", "Sneha@123");
            String sql = "UPDATE medicines SET name=?, dosage=?, quantity=?, remind_time=?, expiry_date=? WHERE mid=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name); ps.setString(2, dosage); ps.setInt(3, qty);
            ps.setString(4, time); ps.setString(5, expiry); ps.setInt(6, id);
            
            ps.executeUpdate();
            con.close();
            response.sendRedirect("view-medicines");
        } catch (Exception e) { e.printStackTrace(); }
    }
}