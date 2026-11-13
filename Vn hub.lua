local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LinkKey = "https://link4m.net/WMuZuX"
local CountdownTime = 24 * 3600

getgenv().LimboData = getgenv().LimboData or { SavedKey = "", TimeLeft = 0, IsRunning = false }

-- HÀM LOAD VÀ HIỂN THỊ MENU CHÍNH QUA AURADT.SITE
local function LaunchMainHub()
    if getgenv().LimboData.IsRunning then return end
    getgenv().LimboData.IsRunning = true

    -- Tải sẵn code từ auradt.site qua mạng
    local success, mainScript = pcall(function()
        return game:HttpGet("https://auradt.site/script=vnhub.lua")
    end)

    if success and mainScript then
        task.spawn(function()
            local runSuccess, err = pcall(function()
                loadstring(mainScript)()
            end)
            if not runSuccess then
                warn("[VNHub Error]: Lỗi chạy menu chính: " .. tostring(err))
            end
        end)
    else
        warn("[VNHub Error]: Không thể tải được script từ auradt.site!")
        getgenv().LimboData.IsRunning = false
    end
end

-- HIỂN THỊ GIAO DIỆN NHẬP KEY (VN HUB)
local function ShowKeyUI()
    if CoreGui:FindFirstChild("VNHubKeySystem") then 
        CoreGui.VNHubKeySystem:Destroy() 
    end 
    
    local screenGui = Instance.new("ScreenGui", CoreGui)
    screenGui.Name = "VNHubKeySystem"
    screenGui.ResetOnSpawn = false 
    
    local frame = Instance.new("Frame", screenGui)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    frame.BorderColor3 = Color3.fromRGB(180, 30, 30)
    frame.BorderSizePixel = 2
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.BackgroundTransparency = 1 
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
    
    local title = Instance.new("TextLabel", frame)
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 0, 0, 35)
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Font = Enum.Font.GothamBold
    title.Text = "VN HUB - NHẬP KEY"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 22
    title.TextTransparency = 1
    
    local desc = Instance.new("TextLabel", frame)
    desc.BackgroundTransparency = 1
    desc.Position = UDim2.new(0, 0, 0, 75)
    desc.Size = UDim2.new(1, 0, 0, 20)
    desc.Font = Enum.Font.Gotham
    desc.Text = "Vui lòng nhập Key định dạng VN_HUB-... để tiếp tục."
    desc.TextColor3 = Color3.fromRGB(160, 160, 160)
    desc.TextSize = 13
    desc.TextTransparency = 1
    
    local textBox = Instance.new("TextBox", frame)
    textBox.BackgroundColor3 = Color3.fromRGB(28, 25, 30)
    textBox.BorderColor3 = Color3.fromRGB(220, 50, 50)
    textBox.BorderSizePixel = 1
    textBox.Position = UDim2.new(0.1, 0, 0.42, 0)
    textBox.Size = UDim2.new(0.8, 0, 0, 45)
    textBox.Font = Enum.Font.Gotham
    textBox.PlaceholderText = "Nhập Key tại đây (VN_HUB-...)..."
    textBox.Text = ""
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    textBox.TextSize = 14
    textBox.BackgroundTransparency = 1
    textBox.TextTransparency = 1
    Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 8)
    
    local btnVerify = Instance.new("TextButton", frame)
    btnVerify.BackgroundColor3 = Color3.fromRGB(35, 30, 35)
    btnVerify.BorderColor3 = Color3.fromRGB(200, 50, 50)
    btnVerify.BorderSizePixel = 1
    btnVerify.Position = UDim2.new(0.1, 0, 0.70, 0)
    btnVerify.Size = UDim2.new(0.42, 0, 0, 40)
    btnVerify.Font = Enum.Font.GothamBold
    btnVerify.Text = "Xác nhận ✓"
    btnVerify.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnVerify.TextSize = 14
    btnVerify.BackgroundTransparency = 1
    btnVerify.TextTransparency = 1
    Instance.new("UICorner", btnVerify).CornerRadius = UDim.new(0, 8)
    
    local btnGet = Instance.new("TextButton", frame)
    btnGet.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    btnGet.BorderColor3 = Color3.fromRGB(80, 80, 90)
    btnGet.BorderSizePixel = 1
    btnGet.Position = UDim2.new(0.55, 0, 0.70, 0)
    btnGet.Size = UDim2.new(0.35, 0, 0, 40)
    btnGet.Font = Enum.Font.GothamBold
    btnGet.Text = "Lấy Key"
    btnGet.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnGet.TextSize = 14
    btnGet.BackgroundTransparency = 1
    btnGet.TextTransparency = 1
    Instance.new("UICorner", btnGet).CornerRadius = UDim.new(0, 8)
    
    -- Hiệu ứng hiện bảng Key nhanh gọn
    task.spawn(function() 
        TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 420, 0, 240), BackgroundTransparency = 0.05}):Play() 
        TweenService:Create(title, TweenInfo.new(0.3), {TextTransparency = 0}):Play() 
        TweenService:Create(desc, TweenInfo.new(0.3), {TextTransparency = 0}):Play() 
        TweenService:Create(textBox, TweenInfo.new(0.3), {BackgroundTransparency = 0, TextTransparency = 0}):Play() 
        TweenService:Create(btnVerify, TweenInfo.new(0.3), {BackgroundTransparency = 0, TextTransparency = 0}):Play() 
        TweenService:Create(btnGet, TweenInfo.new(0.3), {BackgroundTransparency = 0, TextTransparency = 0}):Play() 
    end) 
    
    btnGet.MouseButton1Click:Connect(function() 
        if setclipboard then 
            setclipboard(LinkKey) 
            btnGet.Text = "Đã copy link!" 
            task.wait(1.5) 
            btnGet.Text = "Lấy Key" 
        end 
    end) 
    
    btnVerify.MouseButton1Click:Connect(function() 
        local userKey = textBox.Text 
        local isValid = false 
        -- Kiểm tra key định dạng: VN_HUB-[ngẫu nhiên]-[71 hoặc 92 hoặc 13]
        if string.match(userKey, "^VN_HUB%-.+%-([0-9]+)$") then 
            local num = tonumber(string.match(userKey, "%-([0-9]+)$")) 
            if num == 71 or num == 92 or num == 13 then isValid = true end 
        end 
        
        if isValid then 
            btnVerify.Text = "Thành công!" 
            getgenv().LimboData.SavedKey = userKey 
            getgenv().LimboData.TimeLeft = CountdownTime 
            
            -- Xóa nhanh bảng Key ngay lập tức
            screenGui:Destroy() 
            StartTimerAndHub() 
        else 
            btnVerify.Text = "Key Sai!" 
            task.wait(1.2) 
            btnVerify.Text = "Xác nhận ✓" 
        end 
    end) 
end 

-- HIỂN THỊ ĐỒNG HỒ ĐẾM NGƯỢC VÀ BẬT MENU CHÍNH NGAY LẬP TỨC
function StartTimerAndHub() 
    if CoreGui:FindFirstChild("VNHubTimerGui") then 
        CoreGui.VNHubTimerGui:Destroy() 
    end 
    
    local timerGui = Instance.new("ScreenGui", CoreGui)
    timerGui.Name = "VNHubTimerGui"
    timerGui.ResetOnSpawn = false 
    
    local timerLabel = Instance.new("TextLabel", timerGui)
    timerLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    timerLabel.BackgroundTransparency = 0.2
    timerLabel.BorderSizePixel = 0
    timerLabel.Position = UDim2.new(0.78, 0, 0.02, 0)
    timerLabel.Size = UDim2.new(0, 210, 0, 35)
    timerLabel.Font = Enum.Font.GothamBold
    timerLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
    timerLabel.TextSize = 13
    Instance.new("UICorner", timerLabel).CornerRadius = UDim.new(0, 6) 
    
    -- Gọi menu chính lên từ auradt.site cực nhanh không độ trễ
    LaunchMainHub()
    
    -- Vòng lặp đếm ngược thời gian
    task.spawn(function() 
        while getgenv().LimboData.TimeLeft > 0 do 
            local timeLeft = getgenv().LimboData.TimeLeft 
            timerLabel.Text = string.format("VN Hub còn: %02d:%02d:%02d", math.floor(timeLeft / 3600), math.floor((timeLeft % 3600) / 60), timeLeft % 60) 
            task.wait(1) 
            getgenv().LimboData.TimeLeft = getgenv().LimboData.TimeLeft - 1 
        end 
        
        getgenv().LimboData.SavedKey = "" 
        getgenv().LimboData.TimeLeft = 0 
        getgenv().LimboData.IsRunning = false 
        timerGui:Destroy() 
        ShowKeyUI() 
    end) 
end 

-- KIỂM TRA TRẠNG THÁI LƯU TRỮ BAN ĐẦU
local savedKey = getgenv().LimboData.SavedKey 
local timeLeft = getgenv().LimboData.TimeLeft 
local isKeyValid = false 

if savedKey ~= "" and string.match(savedKey, "^VN_HUB%-.+%-([0-9]+)$") then 
    local num = tonumber(string.match(savedKey, "%-([0-9]+)$")) 
    if num == 71 or num == 92 or num == 13 then isKeyValid = true end 
end 

if isKeyValid and timeLeft > 0 then 
    StartTimerAndHub() 
else 
    getgenv().LimboData.SavedKey = "" 
    getgenv().LimboData.TimeLeft = 0 
    getgenv().LimboData.IsRunning = false 
    ShowKeyUI() 
end
