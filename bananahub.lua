--// HUY BÉO HUB - FIXED ATTACK & EQUIP
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer

----------------------------------------------------
-- CÀI ĐẶT
----------------------------------------------------
getgenv().AutoFarm = false
getgenv().AutoBuso = false
getgenv().Weapon = "Melee" -- Có thể đổi thành "Sword" nếu muốn farm bằng kiếm

----------------------------------------------------
-- AUTO EQUIP (TỰ CẦM VŨ KHÍ)
----------------------------------------------------
task.spawn(function()
    while task.wait(0.5) do
        if getgenv().AutoFarm then
            local char = plr.Character
            if char and not char:FindFirstChildOfClass("Tool") then
                for _, v in pairs(plr.Backpack:GetChildren()) do
                    if v:IsA("Tool") and (v.ToolTip == getgenv().Weapon or getgenv().Weapon == "Melee") then
                        char.Humanoid:EquipTool(v)
                        break
                    end
                end
            end
        end
    end
end)

----------------------------------------------------
-- AUTO BUSO (HAKI)
----------------------------------------------------
task.spawn(function()
    while task.wait(1) do
        if getgenv().AutoBuso and not plr.Character:FindFirstChild("HasBuso") then
            local remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
            if remote then remote:InvokeServer("Buso") end
        end
    end
end)

----------------------------------------------------
-- AUTO FARM (FIXED POSITION & ATTACK)
----------------------------------------------------
task.spawn(function()
    while task.wait() do
        if getgenv().AutoFarm then
            pcall(function()
                local char = plr.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
                        
                        local targetName = mob.Name
                        repeat
                            if not getgenv().AutoFarm or not mob.Parent or mob.Humanoid.Health <= 0 then break end
                            
                            -- FIX: Đứng thẳng trên đầu quái 8-10 units để đánh trúng
                            hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                            
                            -- Khóa vận tốc để không bị văng
                            hrp.Velocity = Vector3.new(0,0,0)
                            
                            -- GOM QUÁI
                            for _, v in pairs(Workspace.Enemies:GetChildren()) do
                                if v.Name == targetName and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    v.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame
                                    v.HumanoidRootPart.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                end
                            end

                            -- TỰ ĐỘNG ĐÁNH (CLICK CHUỘT)
                            VirtualUser:CaptureController()
                            VirtualUser:Button1Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
                            
                            task.wait()
                        until not getgenv().AutoFarm or mob.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

----------------------------------------------------
-- UI (ĐÃ FIX CALLBACK)
----------------------------------------------------
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "HuyBeoHub_Fixed"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.22, 0.35)
frame.Position = UDim2.fromScale(0.05, 0.3) -- Đặt bên trái cho đỡ vướng
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local function makeBtn(text, y, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.fromScale(0.9, 0.2)
    b.Position = UDim2.fromScale(0.05, y)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() callback(b) end)
end

makeBtn("Auto Farm: OFF", 0.1, function(btn)
    getgenv().AutoFarm = not getgenv().AutoFarm
    btn.Text = "Auto Farm: " .. (getgenv().AutoFarm and "ON" or "OFF")
    btn.BackgroundColor3 = getgenv().AutoFarm and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
end)

makeBtn("Auto Buso: OFF", 0.35, function(btn)
    getgenv().AutoBuso = not getgenv().AutoBuso
    btn.Text = "Auto Buso: " .. (getgenv().AutoBuso and "ON" or "OFF")
    btn.BackgroundColor3 = getgenv().AutoBuso and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(50, 50, 50)
end)

makeBtn("Close UI", 0.7, function() gui:Destroy() end)

-- Noclip Bypass
RunService.Stepped:Connect(function()
    if getgenv().AutoFarm and plr.Character then
        for _, v in pairs(plr.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)
