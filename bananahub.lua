repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer

----------------------------------------------------
-- GLOBAL FLAGS
----------------------------------------------------
getgenv().AutoFarm = false
getgenv().KillAura = false
getgenv().AutoBuso = false
getgenv().FixLag = false

----------------------------------------------------
-- AUTO BUSO (HAKI) - Tự động bật giáp
----------------------------------------------------
task.spawn(function()
    while task.wait(2) do
        if getgenv().AutoBuso or getgenv().AutoFarm then
            if not plr.Character:FindFirstChild("HasBuso") then -- Kiểm tra nếu chưa bật
                local r = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
                if r then r:InvokeServer("Buso") end
            end
        end
    end
end)

----------------------------------------------------
-- KILL AURA (FAST ATTACK) 
-- Quét quái xung quanh và gây sát thương liên tục
----------------------------------------------------
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().KillAura or getgenv().AutoFarm then
            pcall(function()
                local enemies = Workspace:FindFirstChild("Enemies")
                if not enemies then return end
                
                for _, mob in pairs(enemies:GetChildren()) do
                    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                    local mobHrp = mob:FindFirstChild("HumanoidRootPart")
                    
                    if hrp and mobHrp and (mobHrp.Position - hrp.Position).Magnitude < 50 then
                        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            -- Giả lập click cực nhanh
                            VirtualUser:CaptureController()
                            VirtualUser:Button1Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
                        end
                    end
                end
            end)
        end
    end
end)

----------------------------------------------------
-- AUTO FARM + GOM QUÁI (SMOOTH)
----------------------------------------------------
task.spawn(function()
    while task.wait(0.5) do
        if not getgenv().AutoFarm then continue end

        pcall(function()
            local char = plr.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
                    
                    local targetName = mob.Name
                    repeat
                        if not getgenv().AutoFarm or not mob.Parent or mob.Humanoid.Health <= 0 then break end
                        
                        -- Vị trí farm: Đứng trên đầu quái 10 units
                        hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                        
                        -- GOM QUÁI (Mang quái về một điểm để Kill Aura dọn sạch)
                        for _, v in pairs(Workspace.Enemies:GetChildren()) do
                            if v.Name == targetName and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                v.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame
                                v.HumanoidRootPart.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                            end
                        end
                        task.wait()
                    until not getgenv().AutoFarm or mob.Humanoid.Health <= 0
                end
            end
        end)
    end
end)

----------------------------------------------------
-- UI - THÊM CÁC NÚT MỚI
----------------------------------------------------
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "HuyBeoHub_V2"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.25, 0.45)
frame.Position = UDim2.fromScale(0.35, 0.25)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local function makeBtn(text, y, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.fromScale(0.9, 0.15)
    b.Position = UDim2.fromScale(0.05, y)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    
    b.MouseButton1Click:Connect(function() callback(b) end)
end

-- Tiêu đề
local t = Instance.new("TextLabel", frame)
t.Size = UDim2.fromScale(1, 0.15)
t.Text = "HUY BÉO HUB V2"
t.TextColor3 = Color3.fromRGB(255, 200, 0)
t.BackgroundTransparency = 1
t.Font = Enum.Font.GothamBold

-- Các nút chức năng
makeBtn("Auto Farm: OFF", 0.18, function(btn)
    getgenv().AutoFarm = not getgenv().AutoFarm
    btn.Text = "Auto Farm: " .. (getgenv().AutoFarm and "ON" or "OFF")
    btn.BackgroundColor3 = getgenv().AutoFarm and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(45, 45, 45)
end)

makeBtn("Kill Aura: OFF", 0.35, function(btn)
    getgenv().KillAura = not getgenv().KillAura
    btn.Text = "Kill Aura: " .. (getgenv().KillAura and "ON" or "OFF")
    btn.BackgroundColor3 = getgenv().KillAura and Color3.fromRGB(120, 0, 0) or Color3.fromRGB(45, 45, 45)
end)

makeBtn("Auto Buso: OFF", 0.52, function(btn)
    getgenv().AutoBuso = not getgenv().AutoBuso
    btn.Text = "Auto Buso: " .. (getgenv().AutoBuso and "ON" or "OFF")
    btn.BackgroundColor3 = getgenv().AutoBuso and Color3.fromRGB(0, 80, 150) or Color3.fromRGB(45, 45, 45)
end)

makeBtn("Fix Lag", 0.69, function(btn)
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = "SmoothPlastic" end
    end
    btn.Text = "Lag Fixed!"
end)

makeBtn("Close UI", 0.86, function() gui:Destroy() end)

-- Noclip (Luôn bật khi Farm)
RunService.Stepped:Connect(function()
    if getgenv().AutoFarm and plr.Character then
        for _, v in pairs(plr.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)
