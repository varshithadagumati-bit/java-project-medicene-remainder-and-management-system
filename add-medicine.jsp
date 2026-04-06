<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Medicine - MedReminder</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', sans-serif; }

        body {
            /* Background matching the sleek dark theme from your image */
            background: radial-gradient(circle at top right, #1e293b, #0f172a);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-card {
            background: rgba(30, 41, 59, 0.7);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            padding: 40px;
            border-radius: 28px;
            width: 460px;
            color: white;
            box-shadow: 0 30px 60px rgba(0,0,0,0.4);
        }

        /* Fixed the link to your index.jsp */
        .back-link {
            text-decoration: none;
            color: #94a3b8;
            font-size: 13px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 25px;
            padding: 8px 15px;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.03);
            transition: 0.3s;
        }
        .back-link:hover {
            color: #22c55e;
            background: rgba(34, 197, 94, 0.1);
        }

        h2 { font-size: 26px; font-weight: 700; margin-bottom: 5px; color: #f8fafc; }
        .sub { font-size: 13px; color: #64748b; margin-bottom: 30px; }

        .field { margin-bottom: 20px; }
        label { display: block; font-size: 11px; font-weight: 700; color: #94a3b8; text-transform: uppercase; margin-bottom: 8px; letter-spacing: 0.5px; }

        .input-wrapper { position: relative; display: flex; align-items: center; }
        .input-wrapper i { position: absolute; left: 16px; color: #22c55e; font-size: 15px; }

        input {
            width: 100%;
            padding: 14px 16px 14px 48px;
            background: rgba(15, 23, 42, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 14px;
            color: white;
            font-size: 14px;
            transition: 0.3s;
        }

        input:focus {
            outline: none;
            border-color: #22c55e;
            background: rgba(15, 23, 42, 0.8);
            box-shadow: 0 0 15px rgba(34, 197, 94, 0.1);
        }

        .flex-row { display: flex; gap: 20px; }

        .submit-btn {
            width: 100%;
            padding: 16px;
            background: #22c55e; /* Green button from your image */
            color: #052e16;
            border: none;
            border-radius: 14px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            transition: 0.3s;
        }

        .submit-btn:hover {
            background: #4ade80;
            transform: translateY(-2px);
            box-shadow: 0 15px 30px rgba(34, 197, 94, 0.3);
        }

        input::-webkit-calendar-picker-indicator { filter: invert(0.8); cursor: pointer; }
    </style>
</head>
<body>

<div class="form-card">
    <a href="index.jsp" class="back-link">
        <i class="fas fa-chevron-left"></i> Back to Dashboard
    </a>

    <h2>Add New Medicine</h2>
    <p class="sub">Log your medication into the system securely.</p>

    <form action="saveMed" method="post">
        <div class="field">
            <label>Medicine Name</label>
            <div class="input-wrapper">
                <i class="fas fa-pills"></i>
                <input type="text" name="mname" placeholder="e.g. Amoxicillin" required>
            </div>
        </div>

        <div class="field">
            <label>Dosage</label>
            <div class="input-wrapper">
                <i class="fas fa-vial"></i>
                <input type="text" name="dosage" placeholder="e.g. 500mg" required>
            </div>
        </div>

        <div class="flex-row">
            <div class="field" style="flex: 1;">
                <label>Qty</label>
                <div class="input-wrapper">
                    <i class="fas fa-layer-group"></i>
                    <input type="number" name="qty" placeholder="0" required>
                </div>
            </div>
            <div class="field" style="flex: 1.2;">
                <label>Expiry Date</label>
                <div class="input-wrapper">
                    <i class="fas fa-calendar-day"></i>
                    <input type="date" name="expiry" required>
                </div>
            </div>
        </div>

        <div class="field">
            <label>Reminder Time</label>
            <div class="input-wrapper">
                <i class="fas fa-clock"></i>
                <input type="time" name="remindTime" required>
            </div>
        </div>

        <button type="submit" class="submit-btn">
            <i class="fas fa-check-circle"></i> Save Medicine
        </button>
    </form>
</div>

</body>
</html>