--// HUY BÉO HUB - CLEAN SINGLE FILE
--// Made for learning & personal use

repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local plr = Players.LocalPlayer

----------------------------------------------------
-- GLOBAL FLAGS (CHỈ 1 LẦN)
----------------------------------------------------
getgenv().AutoFarm  = false
getgenv().AutoBoss  = false
getgenv().AutoRaid  = false
getgenv().AutoBone  = false
getgenv().SafeFarm  = true
getgenv().FixLag    = true

----------------------------------------------------
-- AUTO CLICK (FIX CHẾT CLICK)
----------------------------------------------------
task.spawn(function()
    while task.wait(0.12) do
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
-- AUTO FARM + BRING + ĐỨNG TRÊN KHÔNG
----------------------------------------------------
task.spawn(function()
    while task.wait(0.3) do
        if not getgenv().AutoFarm then continue end

        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end

        for _,mob in pairs(Workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("Humanoid")
            and mob:FindFirstChild("HumanoidRootPart")
            and mob.Humanoid.Health > 0 then

                -- SAFE FARM
                mob.HumanoidRootPart.CanCollide = false
                mob.Humanoid.WalkSpeed = 0
                mob.Humanoid.JumpPower = 0

                repeat
                    -- đứng trên không 12 stud
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
                until mob.Humanoid.Health <= 0
                   or not getgenv().AutoFarm
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
-- UI TOGGLE (GỌN – KHÔNG RỐI)
----------------------------------------------------
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HuyBeoHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.28,0.32)
frame.Position = UDim2.fromScale(0.36,0.15)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local function makeBtn(text,y,callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.fromScale(0.9,0.12)
    b.Position = UDim2.fromScale(0.05,y)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextScaled = true
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.MouseButton1Click:Connect(callback)
end

makeBtn("Auto Farm : OFF",0.1,function(btn)
    getgenv().AutoFarm = not getgenv().AutoFarm
    btn.Text = "Auto Farm : "..(getgenv().AutoFarm and "ON" or "OFF")
end)

makeBtn("Fix Lag : ON",0.25,function(btn)
    getgenv().FixLag = not getgenv().FixLag
    btn.Text = "Fix Lag : "..(getgenv().FixLag and "ON" or "OFF")
end)

makeBtn("Close UI",0.4,function()
    gui:Destroy()
end)
