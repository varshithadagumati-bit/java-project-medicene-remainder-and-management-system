import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.ArrayList; // List kosam idi kachithamga undali
import java.util.List;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname = request.getParameter("uname"); 
        String pass = request.getParameter("pwd");
        HttpSession session = request.getSession();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedDB", "root", "Sneha@123");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
            ps.setString(1, uname);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("uid");
                session.setAttribute("user_id", userId); 
                session.setAttribute("username", rs.getString("username"));

                // --- EXPIRY CHECK LOGIC STARTS ---
                List<String> expiredMeds = new ArrayList<>();
                try {
                    // Ee user ki sambandhinchi expire ayina medicines mathrame teesukuntundi
                    PreparedStatement psExpiry = con.prepareStatement("SELECT name FROM medicines WHERE user_id=? AND expiry_date <= CURDATE()");
                    psExpiry.setInt(1, userId);
                    ResultSet rsExpiry = psExpiry.executeQuery();
                    while (rsExpiry.next()) {
                        expiredMeds.add(rsExpiry.getString("name"));
                    }
                } catch (Exception e) { e.printStackTrace(); }
                
                // Session lo list ni store chesthunnam
                session.setAttribute("expiredList", expiredMeds);
                // --- EXPIRY CHECK LOGIC ENDS ---

                response.sendRedirect("index.jsp");
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('Invalid Credentials!'); location='login.jsp';</script>");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}