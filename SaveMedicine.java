import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class SaveMedicine extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String mname = request.getParameter("mname");
        String dosage = request.getParameter("dosage"); 
        String qty = request.getParameter("qty");
        String expiry = request.getParameter("expiry");
        String rtime = request.getParameter("remindTime");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedDB", "root", "Sneha@123");

            // --- 1. DUPLICATE CHECK LOGIC START ---
            // Ee user id tho, ee medicine name already unda ani check chestham
            String checkSql = "SELECT mid FROM medicines WHERE name = ? AND user_id = ?";
            PreparedStatement psCheck = con.prepareStatement(checkSql);
            psCheck.setString(1, mname);
            psCheck.setInt(2, userId);
            ResultSet rsCheck = psCheck.executeQuery();

            if (rsCheck.next()) {
                // Medicine already unte, alert icchi add page ki redirect chestham
                out.println("<script>alert('Error: This medicine already exists in your records!'); window.history.back();</script>");
                con.close();
                return; // Code ikkade aagipothundi, INSERT query run avvadu
            }
            // --- DUPLICATE CHECK LOGIC END ---

            // --- 2. INSERT LOGIC (No changes to your functionality) ---
            String sql = "INSERT INTO medicines(user_id, name, dosage, quantity, expiry_date, remind_time) VALUES(?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setInt(1, userId);
            ps.setString(2, mname);
            ps.setString(3, dosage);
            ps.setString(4, qty);
            ps.setString(5, expiry);
            ps.setString(6, rtime);

            int i = ps.executeUpdate();
            if(i > 0) {
                out.println("<script>alert('Medicine Saved Successfully!'); window.location='index.jsp';</script>");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
}