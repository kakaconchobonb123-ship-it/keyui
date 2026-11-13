<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VNHub - Hệ Thống Key Bảo Mật 24H</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #0d0d0d;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }

        /* Chữ VNHUB ẩn ở rất xa theo yêu cầu bảo mật */
        .hidden-brand-token {
            position: absolute;
            top: -9999px;
            left: -9999px;
            opacity: 0;
            visibility: hidden;
            pointer-events: none;
        }

        .container {
            text-align: center;
            background: linear-gradient(145deg, #161616, #1c1c1c);
            border: 2px solid #ff3b3b;
            box-shadow: 0 0 25px rgba(255, 59, 59, 0.4);
            border-radius: 20px;
            padding: 30px;
            width: 90%;
            max-width: 420px;
        }

        h2 {
            color: #ff3b3b;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 5px;
        }

        .brand {
            font-size: 13px;
            color: #888;
            margin-bottom: 20px;
            letter-spacing: 1px;
        }

        .key-box {
            background-color: #111;
            border: 1px dashed #ff3b3b;
            padding: 12px;
            font-size: 15px;
            font-weight: bold;
            color: #00ffcc;
            border-radius: 8px;
            margin-bottom: 15px;
            word-break: break-all;
        }

        .timer {
            font-size: 14px;
            color: #ffcc00;
            margin-bottom: 15px;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            background: #111;
            border: 1px solid #444;
            color: #fff;
            border-radius: 6px;
            box-sizing: border-box;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14px;
        }

        button {
            background: linear-gradient(135deg, #ff3b3b, #b30000);
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 15px;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s;
            width: 100%;
            margin-bottom: 8px;
        }

        button:hover {
            opacity: 0.9;
        }

        .status {
            font-size: 13px;
            color: #aaa;
            margin-top: 10px;
        }

        /* Màn hình khóa khi chưa vượt link hoặc hết hạn */
        #lockScreen {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: #0d0d0d;
            z-index: 9999;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 20px;
        }
        #lockScreen h1 {
            color: #ff3b3b;
            margin-bottom: 10px;
        }
        #lockScreen p {
            color: #ccc;
            font-size: 15px;
            max-width: 400px;
        }
    </style>
</head>
<body>

    <!-- Thẻ ẩn chứa chữ VNHUB ở rất xa -->
    <div class="hidden-brand-token" id="secretBrand">VNHUB</div>

    <!-- Giao diện chính -->
    <div class="container" id="mainContainer">
        <h2>VNHUB</h2>
        <div class="brand">XÁC THỰC KEY BẢO MẬT (24H)</div>

        <div class="key-box" id="keyDisplay">Đang tải key...</div>
        <div class="timer" id="timerDisplay">Thời gian: Đang cập nhật...</div>

        <!-- Ô để người chơi nhập key -->
        <input type="text" id="userInputKey" placeholder="Nhập key của bạn vào đây...">
        <button onclick="verifyKey()">Kiểm tra & Xác thực Key</button>
        
        <button id="actionBtn" style="background: #333;" onclick="handleAction()">Sao chép key</button>
        
        <div class="status" id="statusMsg">Trạng thái: Sẵn sàng</div>
    </div>

    <!-- Màn hình khóa khi chưa vượt link hoặc hết hạn -->
    <div id="lockScreen">
        <h1>🔒 YÊU CẦU VƯỢT LINK</h1>
        <p id="lockMsg">Phiên làm việc đã kết thúc hoặc truy cập không hợp lệ. Vui lòng bấm vượt link để lấy key mới!</p>
        <button style="max-width: 280px; margin-top: 15px; background: linear-gradient(135deg, #ff9900, #cc6600);" onclick="goToBypassLink()">Vượt Link Lấy Key Mới</button>
        <button style="max-width: 280px; margin-top: 10px; background: linear-gradient(135deg, #333, #555);" onclick="closeTabAction()">Đóng Tab</button>
    </div>

    <script>
        const EXPIRATION_TIME = 24 * 60 * 60 * 1000; // Hiệu lực 24 giờ
        const DESTROY_TIME = 5 * 60 * 1000; // Đóng web sau 5 phút kể từ lúc copy
        const POSSIBLE_CODES = ["71", "92", "13"]; // 3 số ngẫu nhiên chọn 1 đuôi
        const BYPASS_URL = "https://link4m.net/WMuZuX"; // Link vượt của bạn

        // Chống bấm nút Back (Quay lại) của trình duyệt
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
            triggerLockScreen("Truy cập không hợp lệ! Vui lòng vượt link chính thống để lấy key.");
        };

        function getBrandPrefix() {
            let element = document.getElementById("secretBrand");
            let val = element ? element.innerText.trim() : "";
            return (val !== "") ? val : "VNHUB";
        }

        function createSignature(str) {
            let secretSalt = "vnhub_secure_fixed_v12";
            let hash = 0;
            let combined = str + secretSalt;
            for (let i = 0; i < combined.length; i++) {
                let char = combined.charCodeAt(i);
                hash = ((hash << 5) - hash) + char;
                hash |= 0; 
            }
            return Math.abs(hash).toString(36).toUpperCase();
        }

        function initKeySystem() {
            const urlParams = new URLSearchParams(window.location.search);
            let isFromBypass = urlParams.has("bypass");

            // Nếu có tham số bypass từ link vượt, tạo key mới ngay lập tức
            if (isFromBypass) {
                localStorage.removeItem("vnhub_key_v12");
                let brandPrefix = getBrandPrefix();
                let chosenIdentifier = POSSIBLE_CODES[Math.floor(Math.random() * POSSIBLE_CODES.length)];
                let randomPart = Math.random().toString(36).substring(2, 7).toUpperCase();
                let rawString = brandPrefix + "-" + randomPart + "-" + new Date().getTime();
                let signature = createSignature(rawString);
                let secureKey = brandPrefix + "-" + randomPart + "-" + signature + "-" + chosenIdentifier;

                let currentKeyData = {
                    key: secureKey,
                    identifier: chosenIdentifier, 
                    expiresAt: new Date().getTime() + EXPIRATION_TIME,
                    destroyAt: null
                };
                localStorage.setItem("vnhub_key_v12", JSON.stringify(currentKeyData));
                sessionStorage.setItem("vnhub_passed", "true");
                
                // Xóa tham số bypass trên URL cho gọn gàng
                window.history.replaceState({}, document.title, window.location.pathname);
            }

            let hasPassed = sessionStorage.getItem("vnhub_passed") === "true";
            let currentKeyData = JSON.parse(localStorage.getItem("vnhub_key_v12"));
            let now = new Date().getTime();

            // Nếu chưa vượt link (không có session) hoặc không có key hợp lệ -> Khóa màn hình
            if (!hasPassed || !currentKeyData || now > currentKeyData.expiresAt || (currentKeyData.destroyAt && now > currentKeyData.destroyAt)) {
                triggerLockScreen("Phát hiện truy cập không hợp lệ hoặc phiên đã kết thúc!");
                return;
            }

            updateUI();
        }

        function updateUI() {
            let currentKeyData = JSON.parse(localStorage.getItem("vnhub_key_v12"));
            if (!currentKeyData) return;

            let now = new Date().getTime();

            if (currentKeyData.destroyAt) {
                let timeLeftDestroy = currentKeyData.destroyAt - now;
                if (timeLeftDestroy <= 0) {
                    triggerLockScreen("Đã hết thời gian 5 phút. Trang web đã tự động đóng!");
                    return;
                }
                let min = Math.floor((timeLeftDestroy % (1000 * 60 * 60)) / (1000 * 60));
                let sec = Math.floor((timeLeftDestroy % (1000 * 60)) / 1000);
                document.getElementById("timerDisplay").innerText = `⚠️ Web sẽ tự đóng sau: ${min}m ${sec}s`;
                document.getElementById("keyDisplay").innerText = currentKeyData.key;
                document.getElementById("actionBtn").innerText = "Đã sao chép";
                document.getElementById("actionBtn").style.background = "#222";
                return;
            }

            let timeLeft = currentKeyData.expiresAt - now;
            if (timeLeft <= 0) {
                triggerLockScreen("Key đã hết hạn 24 giờ. Vui lòng vượt link lấy key mới!");
            } else {
                document.getElementById("keyDisplay").innerText = currentKeyData.key;
                let hours = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                let minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));
                let seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);
                
                document.getElementById("timerDisplay").innerText = `Hết hạn sau: ${hours}h ${minutes}m ${seconds}s`;
                document.getElementById("actionBtn").innerText = "Sao chép key";
                document.getElementById("actionBtn").style.background = "linear-gradient(135deg, #333, #555)";
            }
        }

        function triggerLockScreen(msg) {
            localStorage.removeItem("vnhub_key_v12");
            sessionStorage.removeItem("vnhub_passed");
            document.getElementById("mainContainer").style.display = "none";
            document.getElementById("lockMsg").innerText = msg;
            document.getElementById("lockScreen").style.display = "flex";
        }

        function goToBypassLink() {
            window.location.href = BYPASS_URL;
        }

        function closeTabAction() {
            localStorage.removeItem("vnhub_key_v12");
            sessionStorage.removeItem("vnhub_passed");
            window.close();
            window.location.href = "about:blank";
        }

        function verifyKey() {
            let inputVal = document.getElementById("userInputKey").value.trim();
            let currentKeyData = JSON.parse(localStorage.getItem("vnhub_key_v12"));
            let now = new Date().getTime();

            if (!currentKeyData || now > currentKeyData.expiresAt) {
                triggerLockScreen("Key đã hết hạn! Vui lòng vượt link lấy key mới.");
                return;
            }

            if (inputVal === currentKeyData.key && inputVal.startsWith("VNHUB") && inputVal.endsWith(currentKeyData.identifier)) {
                document.getElementById("statusMsg").innerText = "✅ Xác thực thành công! Key hợp lệ.";
                alert("Thành công! Key của bạn chính xác.");
            } else {
                document.getElementById("statusMsg").innerText = "❌ Sai key hoặc key không hợp lệ!";
                alert("Thất bại! Key bạn nhập không đúng.");
            }
        }

        function handleAction() {
            let currentKeyData = JSON.parse(localStorage.getItem("vnhub_key_v12"));
            let now = new Date().getTime();

            if (!currentKeyData) return;

            if (!currentKeyData.destroyAt) {
                let keyText = currentKeyData.key;
                navigator.clipboard.writeText(keyText).then(() => {
                    currentKeyData.destroyAt = now + DESTROY_TIME; // Kích hoạt đếm ngược 5 phút
                    localStorage.setItem("vnhub_key_v12", JSON.stringify(currentKeyData));
                    document.getElementById("statusMsg").innerText = "📋 Đã sao chép! Trang web sẽ đóng sau 5 phút.";
                });
            }
        }

        window.onload = initKeySystem;
        setInterval(initKeySystem, 1000);
    </script>
</body>
</html>

