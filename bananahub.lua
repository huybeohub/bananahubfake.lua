--// HUY BÉO HUB - OPTIMIZED SINGLE FILE
--// Sửa lỗi UI, Tối ưu vòng lặp Farm và Fix Lag

repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local plr = Players.LocalPlayer

----------------------------------------------------
-- GLOBAL FLAGS
----------------------------------------------------
getgenv().AutoFarm = false
getgenv().FixLag = false

-- Hàm tắt va chạm (Noclip) để không bị văng khi farm
RunService.Stepped:Connect(function()
    if getgenv().AutoFarm then
        if plr.Character then
            for _, v in pairs(plr.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end
end)

----------------------------------------------------
-- AUTO CLICK
----------------------------------------------------
task.spawn(function()
    while true do
        task.wait(0.1)
        if getgenv().AutoFarm then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:Button1Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
                task.wait(0.01)
                VirtualUser:Button1Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            end)
        end
    end
end)

----------------------------------------------------
-- AUTO FARM (FIXED LOGIC)
----------------------------------------------------
task.spawn(function()
    while task.wait(0.5) do
        if not getgenv().AutoFarm then continue end

        pcall(function()
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            -- Tìm quái gần nhất hoặc quái bất kỳ trong Workspace.Enemies
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
                    
                    local targetName = mob.Name
                    
                    repeat
                        if not getgenv().AutoFarm or not mob.Parent or mob.Humanoid.Health <= 0 then break end
                        
                        -- Di chuyển đến phía trên quái 12 studs
                        hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                        
                        -- Gom quái (Bring Mob) - Chỉ chạy mỗi 1 giây để tránh lag
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
-- FIX LAG (CLEANED)
----------------------------------------------------
local function ApplyFixLag()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    if setfpscap then setfpscap(60) end
    
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        elseif v:IsA("PostProcessEffect") then
            v.Enabled = false
        end
    end
end

----------------------------------------------------
-- UI TOGGLE (FIXED CALLBACK)
----------------------------------------------------
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "HuyBeoHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.25, 0.35)
frame.Position = UDim2.fromScale(0.35, 0.3)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true -- Lưu ý: Draggable đã cũ nhưng vẫn chạy được

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1, 0.2)
title.Text = "HUY BÉO HUB"
title.TextColor3 = Color3.new(1, 1, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local function makeBtn(text, y, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.fromScale(0.9, 0.2)
    b.Position = UDim2.fromScale(0.05, y)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    
    b.MouseButton1Click:Connect(function()
        callback(b) -- Truyền chính button vào để đổi text
    end)
end

makeBtn("Auto Farm: OFF", 0.25, function(btn)
    getgenv().AutoFarm = not getgenv().AutoFarm
    btn.Text = "Auto Farm: " .. (getgenv().AutoFarm and "ON" or "OFF")
    btn.BackgroundColor3 = getgenv().AutoFarm and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
end)

makeBtn("Fix Lag (Run Once)", 0.5, function(btn)
    ApplyFixLag()
    btn.Text = "Lag Fixed!"
    btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
end)

makeBtn("Close UI", 0.75, function()
    gui:Destroy()
end)
