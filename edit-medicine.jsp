<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Edit Medicine - Luxury Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', sans-serif; }

        body {
            background: radial-gradient(circle at top right, #fdfcfb 0%, #e2d1c3 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px; /* Zoom feel thaggadaniki padding thaggincha */
        }

        .glass-card {
            width: 100%;
            max-width: 480px; /* Card width ni control chesa */
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(10px);
            border-radius: 30px;
            padding: 35px; /* Internal padding adjust chesa */
            box-shadow: 0 30px 60px rgba(138, 109, 59, 0.15);
            border: 1px solid rgba(184, 134, 11, 0.2);
        }

        h2 { 
            color: #8a6d3b;
            text-align: center; 
            margin-bottom: 25px; 
            font-size: 26px; 
            font-weight: 800;
        }

        .form-group { margin-bottom: 18px; }
        
        label { 
            display: block; 
            font-size: 10px; 
            font-weight: 800; 
            color: #b38728; 
            text-transform: uppercase; 
            letter-spacing: 1.2px;
            margin-bottom: 8px;
        }

        .input-wrapper { position: relative; display: flex; align-items: center; }
        .input-wrapper i { position: absolute; left: 18px; color: #bf953f; font-size: 14px; }

        input { 
            width: 100%; 
            padding: 14px 15px 14px 50px; 
            background: #fffdfa;
            border: 1.5px solid #f1ece1; 
            border-radius: 15px; 
            font-size: 14px;
            font-weight: 600;
            color: #5c4a24;
            transition: 0.3s;
        }

        input:focus { 
            outline: none; 
            border-color: #bf953f; 
            box-shadow: 0 0 15px rgba(191, 149, 63, 0.1);
        }

        .row { display: flex; gap: 15px; }

        .btn-save { 
            background: linear-gradient(135deg, #bf953f 0%, #8a6d3b 100%);
            color: white; 
            border: none; 
            padding: 16px; 
            width: 100%; 
            border-radius: 15px; 
            margin-top: 15px; 
            cursor: pointer; 
            font-size: 15px; 
            font-weight: 800;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            box-shadow: 0 10px 20px rgba(138, 109, 59, 0.2);
            transition: 0.3s;
        }

        .btn-save:hover { 
            transform: translateY(-2px);
            filter: brightness(1.1);
        }

        .cancel-btn { 
            display: block; 
            margin-top: 20px; 
            color: #b2a48d; 
            text-decoration: none; 
            font-size: 13px; 
            text-align: center; 
            font-weight: 700;
        }

        /* Calendar icon color fix matching source */
        input::-webkit-calendar-picker-indicator { cursor: pointer; filter: sepia(0.5) saturate(2); }
    </style>
</head>
<body>

<div class="glass-card">
    <h2>Edit Medicine</h2>
    
    <%
        String id = request.getParameter("id");
        if(id != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedDB", "root", "Sneha@123");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM medicines WHERE mid = ?");
                ps.setInt(1, Integer.parseInt(id));
                ResultSet rs = ps.executeQuery();
                if(rs.next()) {
    %>
        <form action="update-medicine" method="POST">
            <input type="hidden" name="id" value="<%= rs.getInt("mid") %>">
            
            <div class="form-group">
                <label>Medicine Name</label>
                <div class="input-wrapper">
                    <i class="fas fa-pills"></i>
                    <input type="text" name="name" value="<%= rs.getString("name") %>" required>
                </div>
            </div>
            
            <div class="form-group">
                <label>Dosage</label>
                <div class="input-wrapper">
                    <i class="fas fa-vial"></i>
                    <input type="text" name="dosage" value="<%= rs.getString("dosage") %>">
                </div>
            </div>
            
            <div class="row">
                <div class="form-group" style="flex: 1;">
                    <label>Stock Qty</label>
                    <div class="input-wrapper">
                        <i class="fas fa-shopping-basket"></i>
                        <input type="number" name="quantity" value="<%= rs.getInt("quantity") %>" required>
                    </div>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Reminder Time</label>
                    <div class="input-wrapper">
                        <i class="fas fa-clock"></i>
                        <input type="time" name="remind_time" value="<%= rs.getString("remind_time") %>">
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label>Expiry Date</label>
                <div class="input-wrapper">
                    <i class="fas fa-calendar-alt"></i>
                    <input type="date" name="expiry_date" value="<%= rs.getString("expiry_date") %>">
                </div>
            </div>
            
            <button type="submit" class="btn-save">
                <i class="fas fa-save"></i> Save Inventory
            </button>
        </form>
    <% 
                }
                con.close();
            } catch(Exception e) {
                out.println("<p style='color:red;'>Error</p>");
            }
        }
    %>
    <a href="view-medicines" class="cancel-btn">Cancel & Return</a>
</div>

</body>
</html>