<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MedReminder - Secure Login</title>
    <link rel="stylesheet" type="text/css" href="login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <div class="main-wrapper">
        <div class="login-card">
            <div class="header">
                <i class="fas fa-heartbeat"></i>
                <h1>MedReminder</h1>
                <p>Digital Health Management</p>
            </div>

            <form action="login" method="post">
                <table class="login-table">
                    <tr>
                        <td class="label">Username</td>
                        <td>
                            <input type="text" name="uname" placeholder="Enter Username" required>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">Password</td>
                        <td>
                            <input type="password" name="pwd" placeholder="Enter Password" required>
                        </td>
                    </tr>
                </table>

                <button type="submit" class="login-btn">
                    Access Dashboard <i class="fas fa-arrow-right"></i>
                </button>
            </form>

            <div class="card-footer">
                New user? <a href="register.jsp">Create Account</a>
            </div>
        </div>
    </div>

</body>
</html>