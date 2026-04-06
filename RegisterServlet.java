import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname = request.getParameter("uname");
        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedDB", "root", "Sneha@123");

            // 1. యూజర్‌ని రిజిస్టర్ చేయడం
            PreparedStatement ps = con.prepareStatement("INSERT INTO users(username, email, password) VALUES(?,?,?)", Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, uname);
            ps.setString(2, email);
            ps.setString(3, pwd);
            
            int result = ps.executeUpdate();

            if (result > 0) {
                // 2. కొత్తగా క్రియేట్ అయిన User ID ని పొందడం
                int userId = -1;
                ResultSet rsKeys = ps.getGeneratedKeys();
                if (rsKeys.next()) {
                    userId = rsKeys.getInt(1);
                }

                // 3. సెషన్ క్రియేట్ చేసి డేటా ని సెట్ చేయడం
                HttpSession session = request.getSession();
                session.setAttribute("username", uname); // index.jsp లో వెల్కమ్ మెసేజ్ కోసం
                session.setAttribute("user_id", userId);  // index.jsp లో డేటాబేస్ క్వెరీ కోసం (ముఖ్యమైనది)

                // 4. అలర్ట్ ఇచ్చి డైరెక్ట్‌గా index.jsp (Dashboard) కి పంపడం
                out.println("<script>");
                out.println("alert('Registration Successful! Welcome " + uname + "');");
                out.println("window.location='index.jsp';");
                out.println("</script>");
            } else {
                out.println("<script>alert('Registration Failed!'); window.history.back();</script>");
            }
            con.close();
        } catch (Exception e) {
            out.println("<html><body><p style='color:red;'>Error: " + e.getMessage() + "</p></body></html>");
            e.printStackTrace();
        }
    }
}