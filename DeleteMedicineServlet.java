import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delete-medicine")
public class DeleteMedicineServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Ikkada mee correct DB Details pettandi (MedDB vs medicine_db)
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedDB", "root", "Sneha@123");
            
            // Mee database table lo column peru 'mid' aa leka 'id' aa check chesi ikkada pettandi
            PreparedStatement ps = con.prepareStatement("DELETE FROM medicines WHERE mid=?"); 
            ps.setString(1, id);
            ps.executeUpdate();
            con.close();
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        // Redirection must match your mapped URL
        response.sendRedirect("view-medicines"); 
    }
}