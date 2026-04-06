<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MedReminder - Create Account</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap');

        * { 
            margin: 0; padding: 0; box-sizing: border-box; 
            font-family: 'Poppins', sans-serif; 
        }

        body {
            background: url('loginback.jpeg') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(3px); /* లాగిన్ లాగే బ్యాక్‌గ్రౌండ్ బ్లర్ */
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95); 
            padding: 40px;
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .branding-icon { 
            font-size: 40px; 
            color: #007bff; 
            margin-bottom: 10px;
        }

        h2 { color: #222; font-size: 26px; margin-bottom: 5px; font-weight: 700; }
        .subtitle { color: #666; font-size: 13px; margin-bottom: 25px; }

        .login-form { text-align: left; }

        .input-group { margin-bottom: 15px; }

        .input-group label {
            display: block;
            font-weight: 600;
            color: #444;
            margin-bottom: 6px;
            font-size: 13px;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i {
            position: absolute;
            left: 15px;
            color: #007bff;
            font-size: 16px;
        }

        .input-wrapper input {
            width: 100%;
            padding: 12px 15px 12px 42px; /* ఐకాన్ కోసం స్పేస్ */
            border: 2px solid #eee;
            border-radius: 10px;
            outline: none;
            transition: 0.3s ease;
            font-size: 14px;
        }

        .input-wrapper input:focus {
            border-color: #007bff;
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.05);
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
            margin-bottom: 15px; /* కింద లింక్ నుండి గ్యాప్ */
        }

        .btn-register:hover {
            background: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.2);
        }

        .footer-links {
            font-size: 13px;
            color: #666;
            line-height: 1.6;
        }

        .footer-links a {
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="logo-area">
            <div class="branding-icon"><i class="fas fa-user-plus"></i></div>
            <h2>Create Account</h2>
            <p class="subtitle">Join MedReminder for Better Health</p>
        </div>

        <form action="register" method="post" class="login-form">
            
            <div class="input-group">
                <label>Username</label>
                <div class="input-wrapper">
                    <i class="fas fa-user"></i>
                    <input type="text" name="uname" placeholder="Choose a username" required>
                </div>
            </div>

            <div class="input-group">
                <label>Email Address</label>
                <div class="input-wrapper">
                    <i class="fas fa-envelope"></i>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </div>
            </div>

            <div class="input-group">
                <label>Password</label>
                <div class="input-wrapper">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="pwd" placeholder="Create a password" required>
                </div>
            </div>

            <button type="submit" class="btn-register">
                Sign Up
            </button>
        </form>
        
        <div class="footer-links">
            Already have an account? <br>
            <a href="login.jsp">Login here</a>
        </div>
    </div>

</body>
</html>