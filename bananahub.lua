--// WAIT GAME LOAD
repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

--// CLEAN UI
pcall(function()
    CoreGui:FindFirstChild("HuyBeoHub_UI"):Destroy()
end)

--// GLOBAL FLAGS
getgenv().AutoFarm   = false
getgenv().AutoBoss   = false
getgenv().AutoRaid   = false
getgenv().AutoBone   = false
getgenv().SafeFarm   = false
getgenv().ServerHop  = false
getgenv().FixLag     = false

--// UI
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "HuyBeoHub_UI"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromScale(0.38, 0.45)
Main.Position = UDim2.fromScale(0.31, 0.25)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.fromScale(1,0.12)
Title.Text = "🍌 HUY BÉO HUB"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255,210,90)
Title.BackgroundTransparency = 1

local Holder = Instance.new("Frame", Main)
Holder.Position = UDim2.fromScale(0.05,0.15)
Holder.Size = UDim2.fromScale(0.9,0.8)
Holder.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Holder)
UIList.Padding = UDim.new(0,8)

--// TOGGLE FUNC
local function CreateToggle(text, flag)
    local Btn = Instance.new("TextButton", Holder)
    Btn.Size = UDim2.fromScale(1,0.12)
    Btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Btn.Text = text.." : OFF"
    Btn.Font = Enum.Font.GothamBold
    Btn.TextScaled = true
    Btn.TextColor3 = Color3.fromRGB(230,230,230)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

    Btn.MouseButton1Click:Connect(function()
        getgenv()[flag] = not getgenv()[flag]
        Btn.Text = text.." : "..(getgenv()[flag] and "ON" or "OFF")
        Btn.BackgroundColor3 = getgenv()[flag]
            and Color3.fromRGB(60,120,60)
            or Color3.fromRGB(35,35,35)
    end)
end

--// TOGGLES
CreateToggle("Auto Farm Level", "AutoFarm")
CreateToggle("Auto Boss", "AutoBoss")
CreateToggle("Auto Raid", "AutoRaid")
CreateToggle("Auto Bone", "AutoBone")
CreateToggle("Safe Farm / Anti Die", "SafeFarm")
CreateToggle("Server Hop", "ServerHop")
CreateToggle("Fix Lag / FPS Boost", "FixLag")

--// CLOSE
local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.fromScale(0.12,0.08)
Close.Position = UDim2.fromScale(0.88,0)
Close.Text = "X"
Close.Font = Enum.Font.GothamBlack
Close.TextScaled = true
Close.TextColor3 = Color3.fromRGB(255,80,80)
Close.BackgroundTransparency = 1
Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

--------------------------------------------------
--=============== MAIN LOGIC LOOP ===============--
--------------------------------------------------

task.spawn(function()
    while task.wait(0.3) do

        if getgenv().FixLag then
            settings().Rendering.QualityLevel = 1
        end

        if getgenv().SafeFarm and Player.Character then
            local hum = Player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health < hum.MaxHealth * 0.4 then
                hum.Health = hum.MaxHealth
            end
        end

        if getgenv().AutoFarm then
            -- 🔧 GẮN LOGIC AUTO FARM CỦA BẠN Ở ĐÂY
            -- Ví dụ:
            -- Attack Mob
            -- Tween tới quái
        end

        if getgenv().AutoBoss then
            -- 🔧 LOGIC AUTO BOSS
        end

        if getgenv().AutoRaid then
            -- 🔧 LOGIC AUTO RAID
        end

        if getgenv().AutoBone then
            -- 🔧 LOGIC FARM BONE
        end

        if getgenv().ServerHop then
            -- 🔧 LOGIC HOP SERVER
        end

    end
end)
