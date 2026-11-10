local a,b,c,d,e=game:GetService("CoreGui"),game:GetService("Players").LocalPlayer,game:GetService("TweenService"),"https://link4m.net/WMuZuX",24*3600 
getgenv().LimboData=getgenv().LimboData or{SavedKey="",TimeLeft=0,IsRunning=false}
local function f() 
    if a:FindFirstChild("LimboHubKeySystem") then a.LimboHubKeySystem:Destroy() end 
    local g=Instance.new("ScreenGui",a) g.Name="LimboHubKeySystem" g.ResetOnSpawn=false 
    local h=Instance.new("Frame",g) h.BackgroundColor3=Color3.fromRGB(18,18,22) h.BorderColor3=Color3.fromRGB(180,30,30) h.BorderSizePixel=2 h.AnchorPoint=Vector2.new(0.5,0.5) h.Position=UDim2.new(0.5,0,0.5,0) h.Size=UDim2.new(0,0,0,0) h.BackgroundTransparency=1 
    Instance.new("UICorner",h).CornerRadius=UDim.new(0,12) 
    local i=Instance.new("TextLabel",h) i.BackgroundTransparency=1 i.Position=UDim2.new(0,0,0,35) i.Size=UDim2.new(1,0,0,35) i.Font=Enum.Font.GothamBold i.Text="NHẬP KEY" i.TextColor3=Color3.fromRGB(255,255,255) i.TextSize=22 i.TextTransparency=1 
    local j=Instance.new("TextLabel",h) j.BackgroundTransparency=1 j.Position=UDim2.new(0,0,0,75) j.Size=UDim2.new(1,0,0,20) j.Font=Enum.Font.Gotham j.Text="Vui lòng nhập Key hôm nay để tiếp tục." j.TextColor3=Color3.fromRGB(160,160,160) j.TextSize=13 j.TextTransparency=1 
    local k=Instance.new("TextBox",h) k.BackgroundColor3=Color3.fromRGB(28,25,30) k.BorderColor3=Color3.fromRGB(220,50,50) k.BorderSizePixel=1 k.Position=UDim2.new(0.1,0,0.42,0) k.Size=UDim2.new(0.8,0,0,45) k.Font=Enum.Font.Gotham k.PlaceholderText="Nhập Key hôm nay tại đây..." k.Text="" k.TextColor3=Color3.fromRGB(255,255,255) k.PlaceholderColor3=Color3.fromRGB(120,120,120) k.TextSize=14 k.BackgroundTransparency=1 k.TextTransparency=1 
    Instance.new("UICorner",k).CornerRadius=UDim.new(0,8) 
    local l=Instance.new("TextButton",h) l.BackgroundColor3=Color3.fromRGB(35,30,35) l.BorderColor3=Color3.fromRGB(200,50,50) l.BorderSizePixel=1 l.Position=UDim2.new(0.1,0,0.70,0) l.Size=UDim2.new(0.42,0,0,40) l.Font=Enum.Font.GothamBold l.Text="Xác nhận ✓" l.TextColor3=Color3.fromRGB(255,255,255) l.TextSize=14 l.BackgroundTransparency=1 l.TextTransparency=1 
    Instance.new("UICorner",l).CornerRadius=UDim.new(0,8) 
    local m=Instance.new("TextButton",h) m.BackgroundColor3=Color3.fromRGB(35,35,40) m.BorderColor3=Color3.fromRGB(80,80,90) m.BorderSizePixel=1 m.Position=UDim2.new(0.55,0,0.70,0) m.Size=UDim2.new(0.35,0,0,40) m.Font=Enum.Font.GothamBold m.Text="Lấy Key" m.TextColor3=Color3.fromRGB(255,255,255) m.TextSize=14 m.BackgroundTransparency=1 m.TextTransparency=1 
    Instance.new("UICorner",m).CornerRadius=UDim.new(0,8) 
    task.spawn(function() 
        task.wait(0.05) 
        c:Create(h,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(0,420,0,240),BackgroundTransparency=0.05}):Play() 
        c:Create(i,TweenInfo.new(0.4),{TextTransparency=0}):Play() 
        c:Create(j,TweenInfo.new(0.4),{TextTransparency=0}):Play() 
        c:Create(k,TweenInfo.new(0.4),{BackgroundTransparency=0,TextTransparency=0}):Play() 
        c:Create(l,TweenInfo.new(0.4),{BackgroundTransparency=0,TextTransparency=0}):Play() 
        c:Create(m,TweenInfo.new(0.4),{BackgroundTransparency=0,TextTransparency=0}):Play() 
    end) 
    m.MouseButton1Click:Connect(function() 
        if setclipboard then setclipboard(d) m.Text="Đã copy link!" task.wait(1.5) m.Text="Lấy Key" end 
    end) 
    l.MouseButton1Click:Connect(function() 
        local t=k.Text local u=false 
        if string.match(t,"^LIMBOHUB%-.+%-([0-9]+)$") then 
            local v=tonumber(string.match(t,"%-([0-9]+)$")) 
            if v==71 or v==92 or v==13 then u=true end 
        end 
        if u then 
            l.Text="Thành công!" 
            getgenv().LimboData.SavedKey=t 
            getgenv().LimboData.TimeLeft=e 
            c:Create(h,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(0,0,0,0),BackgroundTransparency=1}):Play() 
            c:Create(i,TweenInfo.new(0.4),{TextTransparency=1}):Play() 
            c:Create(j,TweenInfo.new(0.4),{TextTransparency=1}):Play() 
            c:Create(k,TweenInfo.new(0.4),{BackgroundTransparency=1,TextTransparency=1}):Play() 
            c:Create(l,TweenInfo.new(0.4),{BackgroundTransparency=1,TextTransparency=1}):Play() 
            c:Create(m,TweenInfo.new(0.4),{BackgroundTransparency=1,TextTransparency=1}):Play() 
            task.wait(0.4) g:Destroy() n() 
        else 
            l.Text="Key Sai!" task.wait(1.5) l.Text="Xác nhận ✓" 
        end 
    end) 
end 

local function n() 
    if a:FindFirstChild("LimboTimerGui") then a.LimboTimerGui:Destroy() end 
    local g=Instance.new("ScreenGui",a) g.Name="LimboTimerGui" g.ResetOnSpawn=false 
    local h=Instance.new("TextLabel",g) h.BackgroundColor3=Color3.fromRGB(20,20,25) h.BackgroundTransparency=0.2 h.BorderSizePixel=0 h.Position=UDim2.new(0.78,0,0.02,0) h.Size=UDim2.new(0,210,0,35) h.Font=Enum.Font.GothamBold h.TextColor3=Color3.fromRGB(0,255,128) h.TextSize=13 
    Instance.new("UICorner",h).CornerRadius=UDim.new(0,6) 
    if not getgenv().LimboData.IsRunning then 
        getgenv().LimboData.IsRunning=true 
        pcall(function() loadstring(game:HttpGet("https://limbohub.my.id/loader.lua"))() end) 
    end 
    task.spawn(function() 
        while getgenv().LimboData.TimeLeft>0 do 
            local o=getgenv().LimboData.TimeLeft 
            h.Text=string.format("Key còn lại: %02d:%02d:%02d",math.floor(o/3600),math.floor((o%3600)/60),o%60) 
            task.wait(1) 
            getgenv().LimboData.TimeLeft=getgenv().LimboData.TimeLeft-1 
        end 
        getgenv().LimboData.SavedKey="" 
        getgenv().LimboData.TimeLeft=0 
        getgenv().LimboData.IsRunning=false 
        g:Destroy() f() 
    end) 
end 

local w=getgenv().LimboData.SavedKey 
local x=getgenv().LimboData.TimeLeft 
local y=false 
if w~="" and string.match(w,"^LIMBOHUB%-.+%-([0-9]+)$") then 
    local z=tonumber(string.match(w,"%-([0-9]+)$")) 
    if z==71 or z==92 or z==13 then y=true end 
end 
if y and x>0 then 
    n() 
else 
    getgenv().LimboData.SavedKey="" 
    getgenv().LimboData.TimeLeft=0 
    getgenv().LimboData.IsRunning=false 
    f() 
end
