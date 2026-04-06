import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

// Servlet mapping annotation (web.xml lekapoyina idi pani chesthundhi)
@jakarta.servlet.annotation.WebServlet("/UpdateQuantityServlet")
public class UpdateQuantityServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // JSP nundi vache 'mid' (Medicine ID) ni lakkuntunnam
        String mid = request.getParameter("mid");
        
        if (mid != null) {
            try {
                // Database Connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedDB", "root", "Sneha@123");
                
                // SQL: Quantity ni 1 thagginchu, kaani stock 0 kante ekkuva unteనే
                String sql = "UPDATE medicines SET quantity = quantity - 1 WHERE mid = ? AND quantity > 0";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, mid);
                
                int rowsUpdated = ps.executeUpdate();
                
                con.close();
                
                // Stock thagginaka malli Dashboard (index.jsp) ki vellipothundi
                response.sendRedirect("index.jsp");
                
            } catch (Exception e) {
                // Error vachina dashboard ke pampisthunnam (Safety kosam)
                e.printStackTrace();
                response.sendRedirect("index.jsp");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}