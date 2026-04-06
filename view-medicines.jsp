<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Medicine Inventory - MedReminder</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', sans-serif; }

        body {
            /* Deep Space / Cyber Background */
            background: #0f172a;
            background-image: 
                radial-gradient(at 0% 0%, rgba(34, 197, 94, 0.05) 0px, transparent 50%),
                radial-gradient(at 100% 0%, rgba(59, 130, 246, 0.05) 0px, transparent 50%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
            color: #f8fafc;
        }

        .container {
            width: 100%;
            max-width: 1100px;
            background: rgba(30, 41, 59, 0.5);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 24px;
            box-shadow: 0 0 40px rgba(0,0,0,0.5);
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        h2 { 
            font-size: 30px; 
            font-weight: 800; 
            background: linear-gradient(to right, #22c55e, #3b82f6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        /* Futuristic Table Styling */
        .table-wrapper {
            background: rgba(15, 23, 42, 0.8);
            border-radius: 16px;
            overflow: hidden;
            border: 1px solid rgba(34, 197, 94, 0.2);
        }

        table { width: 100%; border-collapse: collapse; }
        
        th {
            padding: 20px;
            background: rgba(34, 197, 94, 0.05);
            color: #22c55e;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: 700;
            border-bottom: 1px solid rgba(34, 197, 94, 0.2);
        }

        td {
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.03);
            font-size: 14px;
            color: #cbd5e1;
        }

        tr:hover td { 
            background: rgba(34, 197, 94, 0.02); 
            color: #fff;
            border-bottom-color: rgba(34, 197, 94, 0.4);
        }

        /* Neon Status Badges */
        .qty-badge {
            background: rgba(34, 197, 94, 0.1);
            color: #22c55e;
            padding: 6px 14px;
            border-radius: 4px;
            font-weight: 700;
            border: 1px solid rgba(34, 197, 94, 0.3);
            box-shadow: 0 0 10px rgba(34, 197, 94, 0.1);
        }

        /* Danger/Expired Alert Style */
        .expired-row { background: rgba(239, 68, 68, 0.05) !important; }
        .expired-row td { color: #f87171 !important; }
        .expired-row .qty-badge { 
            background: rgba(239, 68, 68, 0.1); 
            color: #ef4444; 
            border-color: rgba(239, 68, 68, 0.3);
            box-shadow: 0 0 10px rgba(239, 68, 68, 0.1);
        }

        /* Cyber Buttons */
        .btn-edit {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 700;
            margin-right: 15px;
            transition: 0.3s;
            text-transform: uppercase;
            font-size: 12px;
        }
        .btn-edit:hover { color: #60a5fa; text-shadow: 0 0 8px #3b82f6; }

        .btn-delete {
            color: #ef4444;
            text-decoration: none;
            font-weight: 700;
            transition: 0.3s;
            text-transform: uppercase;
            font-size: 12px;
        }
        .btn-delete:hover { color: #f87171; text-shadow: 0 0 8px #ef4444; }

        /* Back Button */
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            margin-top: 30px;
            padding: 12px 24px;
            background: transparent;
            color: #94a3b8;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            border: 1px solid rgba(255,255,255,0.1);
            transition: 0.3s;
        }
        .back-btn:hover {
            border-color: #22c55e;
            color: #22c55e;
            box-shadow: 0 0 15px rgba(34, 197, 94, 0.2);
        }

    </style>
</head>
<body>

<div class="container">
    <div class="header-section">
        <h2>System_Inventory.exe</h2>
    </div>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Medicine_ID</th>
                    <th>Dosage_Spec</th>
                    <th>Stock_Level</th>
                    <th>Reminder</th>
                    <th>Expiry_Date</th>
                    <th>Control</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Map<String, String>> meds = (List<Map<String, String>>) request.getAttribute("medicines");
                    if (meds != null) {
                        for (Map<String, String> m : meds) {
                %>
                <tr>
                    <td><span style="color: #3b82f6;">#</span> <%= m.get("name") %></td>
                    <td><%= m.get("dosage") %></td>
                    <td>
                        <span class="qty-badge">
                            <%= (m.get("quantity") != null) ? m.get("quantity") : "0" %>
                        </span>
                    </td>
                    <td><i class="far fa-clock" style="font-size: 12px; opacity: 0.6;"></i> <%= m.get("time") %></td>
                    <td><%= m.get("expiry") %></td>
                    <td>
                        <a href="edit-medicine.jsp?id=<%= m.get("id") %>" class="btn-edit">Edit</a>
                        <a href="delete-medicine?id=<%= m.get("id") %>" class="btn-delete" onclick="return confirm('Confirm Deletion?')">Delete</a>
                    </td>
                </tr>
                <% } } %>
            </tbody>
        </table>
    </div>
    
    <a href="index.jsp" class="back-btn">
        <i class="fas fa-terminal"></i> Return_to_Dashboard
    </a>
</div>

<script>
    // Logic remains exactly as you had it
    window.onload = function() {
        var rows = document.querySelectorAll("table tbody tr");
        var today = new Date();
        today.setHours(0, 0, 0, 0); 
        var expiredMedsList = "";

        for (var i = 0; i < rows.length; i++) {
            var name = rows[i].cells[0].innerText; 
            var expDateStr = rows[i].cells[4].innerText; 
            if(expDateStr && expDateStr !== "null" && expDateStr.trim() !== "") {
                var expDate = new Date(expDateStr);
                if (expDate <= today) {
                    rows[i].classList.add("expired-row");
                    expiredMedsList += "• " + name + " (Expired)<br>";
                }
            }
        }

        if (expiredMedsList !== "") {
            Swal.fire({
                title: '<span style="color:#ef4444">CRITICAL EXPIRE ALERT</span>',
                html: '<div style="color:#cbd5e1">' + expiredMedsList + '</div>',
                icon: 'error',
                background: '#0f172a',
                confirmButtonColor: '#22c55e'
            });
        }
    };
</script>
</body>
</html>
