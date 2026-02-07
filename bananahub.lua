--// HUY BÉO HUB - BANANA STYLE
--// Single file | Clean | No key | Stable

repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local plr = Players.LocalPlayer

----------------------------------------------------
-- GLOBAL FLAGS
----------------------------------------------------
getgenv().AutoFarm   = false
getgenv().AutoBoss   = false
getgenv().AutoRaid   = false
getgenv().SafeFarm   = true
getgenv().FixLag     = true

----------------------------------------------------
-- AUTO CLICK (XA + ỔN ĐỊNH)
----------------------------------------------------
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().AutoFarm or getgenv().AutoBoss then
            pcall(function()
                VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(0.02)
                VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
end)

----------------------------------------------------
-- AUTO FARM + BRING + HOVER 12 STUD
----------------------------------------------------
task.spawn(function()
    while task.wait(0.25) do
        if not getgenv().AutoFarm then continue end

        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end

        for _,mob in pairs(Workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("Humanoid")
            and mob:FindFirstChild("HumanoidRootPart")
            and mob.Humanoid.Health > 0 then

                mob.HumanoidRootPart.CanCollide = false
                mob.Humanoid.WalkSpeed = 0
                mob.Humanoid.JumpPower = 0

                repeat
                    hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,12,0)

                    -- bring quái cùng loại
                    for _,v in pairs(Workspace.Enemies:GetChildren()) do
                        if v.Name == mob.Name
                        and v:FindFirstChild("HumanoidRootPart")
                        and v:FindFirstChild("Humanoid")
                        and v.Humanoid.Health > 0 then
                            v.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame
                            v.HumanoidRootPart.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.Humanoid.JumpPower = 0
                        end
                    end
                    task.wait()
                until mob.Humanoid.Health <= 0 or not getgenv().AutoFarm
            end
        end
    end
end)

----------------------------------------------------
-- FIX LAG / FPS BOOST
----------------------------------------------------
if getgenv().FixLag then
    task.spawn(function()
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            setfpscap(120)
        end)
        for _,v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
    end)
end

----------------------------------------------------
-- UI BANANA STYLE
----------------------------------------------------
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HuyBeoHub"

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.32,0.38)
main.Position = UDim2.fromScale(0.34,0.12)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.15)
title.Text = "🍌 HUY BÉO HUB"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,215,120)
title.BackgroundTransparency = 1

local function makeToggle(text,y,callback)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.fromScale(0.9,0.12)
    btn.Position = UDim2.fromScale(0.05,y)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    local state = false
    btn.Text = text.." : OFF"

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text.." : "..(state and "ON" or "OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(60,140,60) or Color3.fromRGB(55,55,55)
        callback(state)
    end)
end

makeToggle("Auto Farm Level",0.18,function(v)
    getgenv().AutoFarm = v
end)

makeToggle("Auto Boss",0.32,function(v)
    getgenv().AutoBoss = v
end)

makeToggle("Safe Farm / Anti Die",0.46,function(v)
    getgenv().SafeFarm = v
end)

makeToggle("Fix Lag / FPS Boost",0.60,function(v)
    getgenv().FixLag = v
end)

makeToggle("Close Hub",0.74,function()
    gui:Destroy()
end)
