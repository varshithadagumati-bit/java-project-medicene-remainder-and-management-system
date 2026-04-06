<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 1. సెషన్ చెక్
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return; 
    }
    
    int currentUserId = (Integer) session.getAttribute("user_id");
    String currentUserName = (String) session.getAttribute("username");

    // --- QUANTITY UPDATE LOGIC ---
    String takenMid = request.getParameter("mid");
    if (takenMid != null && !takenMid.isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conUpdate = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedDB", "root", "Sneha@123");
            String updateSql = "UPDATE medicines SET quantity = quantity - 1 WHERE mid = ? AND user_id = ? AND quantity > 0";
            PreparedStatement psUpdate = conUpdate.prepareStatement(updateSql);
            psUpdate.setInt(1, Integer.parseInt(takenMid));
            psUpdate.setInt(2, currentUserId);
            psUpdate.executeUpdate();
            conUpdate.close();
            response.sendRedirect("index.jsp");
            return;
        } catch (Exception e) { e.printStackTrace(); }
    }

    // --- MEDICINE LOGIC ---
    StringBuilder sb = new StringBuilder();
    List<Map<String, String>> reminders = new ArrayList<>(); 
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedDB", "root", "Sneha@123");
        
        String sql = "SELECT mid, name, quantity, DATE_FORMAT(remind_time, '%H:%i') as r_time, " +
                     "expiry_date, DATEDIFF(expiry_date, CURDATE()) as days_left " +
                     "FROM medicines WHERE user_id = ?";
        
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, currentUserId);
        ResultSet rs = ps.executeQuery();

        while(rs.next()) {
            String mid = rs.getString("mid");
            String medName = rs.getString("name");
            int qty = rs.getInt("quantity");
            String rTime = rs.getString("r_time"); 
            int daysLeft = rs.getInt("days_left");

            if (daysLeft <= 0) sb.append("<b style='color:#e74c3c;'><i class='fas fa-skull-crossbones'></i> EXPIRED:</b> " + medName + "<br>");
            else if (daysLeft <= 3) sb.append("<b style='color:#f39c12;'><i class='fas fa-clock'></i> EXPIRING SOON:</b> " + medName + " (" + daysLeft + " days left)<br>");

            if(qty == 0) sb.append("<b style='color:#e74c3c;'><i class='fas fa-exclamation-triangle'></i> OUT OF STOCK:</b> " + medName + "<br>");
            else if(qty <= 5) sb.append("<b style='color:#e67e22;'><i class='fas fa-box'></i> LOW STOCK:</b> " + medName + " (" + qty + " left)<br>");

            if(qty > 0) {
                Map<String, String> m = new HashMap<>();
                m.put("id", mid); m.put("name", medName); m.put("time", rTime); 
                reminders.add(m);
            }
        }
        conn.close();
    } catch(Exception e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MedReminder | Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        * { box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0; display: flex; justify-content: center; align-items: center; 
            height: 100vh; color: #333; overflow: hidden;
        }
        .dashboard-card { 
            background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(20px);
            padding: 50px 40px; border-radius: 30px; border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 25px 50px rgba(0,0,0,0.2); text-align: center; width: 450px;
        }
        h1 { color: #fff; font-size: 2.5rem; margin: 0; font-weight: 700; }
        .welcome-text { color: rgba(255,255,255,0.9); margin-bottom: 40px; font-size: 1.1rem; }
        .welcome-text b { color: #fff; text-decoration: underline; text-transform: capitalize; }
        .menu-grid { display: flex; flex-direction: column; gap: 20px; }
        .btn { 
            padding: 16px; text-decoration: none; color: white; border-radius: 15px; 
            font-weight: 600; transition: all 0.4s ease; display: flex;
            align-items: center; justify-content: center; gap: 12px; border: none; cursor: pointer;
        }
        .btn-add { background: linear-gradient(to right, #00b09b, #96c93d); }
        .btn-view { background: linear-gradient(to right, #2193b0, #6dd5ed); }
        .btn-logout { background: linear-gradient(to right, #ee0979, #ff6a00); }
        .btn:hover { transform: scale(1.05) translateY(-5px); filter: brightness(1.1); }
        .alert-box { 
            text-align: left; background: #fff; padding: 15px; border-radius: 12px; 
            border-left: 6px solid #ff4444; max-height: 200px; overflow-y: auto; font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="dashboard-card">
    <i class="fas fa-heartbeat" style="font-size: 3rem; color: #fff; margin-bottom: 10px;"></i>
    <h1>MedReminder</h1>
    <p class="welcome-text">Welcome back, <b><%= currentUserName %></b></p>
    
    <div class="menu-grid">
        <a href="add-medicine.jsp" class="btn btn-add">
            <i class="fas fa-plus-circle"></i> Add New Medicine
        </a>
        <a href="view-medicines" class="btn btn-view">
            <i class="fas fa-pills"></i> View All Medicines
        </a>
        <a href="logout.jsp" class="btn btn-logout">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>

<script>
    // --- ALARM LOGIC ---
    var reminderSound = new Audio('alarm.wav'); 
    reminderSound.loop = true; 

    // Snooze ట్రాక్ చేయడానికి ఆబ్జెక్ట్
    var snoozedMedicines = {}; 

    var allReminders = [
        <% for(Map<String, String> m : reminders) { %>
            { id: "<%= m.get("id") %>", name: "<%= m.get("name") %>", time: "<%= m.get("time") %>" },
        <% } %>
    ];

    async function checkMedicineReminders() {
        var now = new Date();
        var currentTime = now.getHours().toString().padStart(2, '0') + ":" + now.getMinutes().toString().padStart(2, '0');

        for (const med of allReminders) {
            var sessionKey = "done_" + med.id + "_" + med.time;
            
            // Snooze లో ఉందో లేదో చెక్ చేయడం
            var isSnoozed = snoozedMedicines[med.id] && now < snoozedMedicines[med.id];

            if (currentTime === med.time && !sessionStorage.getItem(sessionKey) && !isSnoozed) {
                
                reminderSound.play().catch(e => console.log("Sound pending user click"));

                const result = await Swal.fire({
                    title: '⏰ Reminder: ' + med.name,
                    text: 'It is time to take your medicine. Did you take it?',
                    icon: 'info',
                    showCancelButton: true,
                    confirmButtonColor: '#28a745',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, I took it',
                    cancelButtonText: 'Snooze (2 min)',
                    allowOutsideClick: false
                });

                reminderSound.pause();
                reminderSound.currentTime = 0;

                if (result.isConfirmed) {
                    sessionStorage.setItem(sessionKey, "true");
                    window.location.href = "index.jsp?mid=" + med.id;
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    // Snooze టైమ్ సెట్ చేయడం (ప్రస్తుత టైమ్ + 2 నిమిషాలు)
                    snoozedMedicines[med.id] = new Date(new Date().getTime() + 2 * 60000);
                    
                    Swal.fire({
                        toast: true,
                        position: 'top-end',
                        icon: 'success',
                        title: 'Snoozed for 2 minutes',
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            }
        }
    }

    window.onload = function() {
        var alertHtml = `<%= sb.toString().trim() %>`;
        if (alertHtml !== "" && alertHtml !== "null") {
            Swal.fire({
                title: 'Health Status Alert!',
                icon: 'warning',
                html: '<div class="alert-box">' + alertHtml + '</div>',
                confirmButtonText: 'Understood',
                didOpen: () => {
                    reminderSound.play().catch(e => {});
                }
            }).then(() => {
                reminderSound.pause();
                reminderSound.currentTime = 0;
            });
        }
        setInterval(checkMedicineReminders, 10000); 
    };
</script>
</body>
</html>