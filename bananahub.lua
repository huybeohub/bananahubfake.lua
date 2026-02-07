--// HUY BÉO HUB V4 - FIXED ATTACK & NEW UI DESIGN
--// UI style inspired by Banana Hub

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local plr = Players.LocalPlayer

----------------------------------------------------
-- CÀI ĐẶT CHUNG (GLOBAL SETTINGS)
----------------------------------------------------
getgenv().AutoFarm = false
getgenv().KillAura = false
getgenv().AutoBuso = false
getgenv().WeaponType = "Melee" -- Chọn "Melee" hoặc "Sword"

----------------------------------------------------
-- CÁC CHỨC NĂNG CHÍNH (CORE FUNCTIONS)
----------------------------------------------------

-- 1. Auto Equip (Tự động cầm vũ khí) - QUAN TRỌNG ĐỂ ĐÁNH ĐƯỢC
task.spawn(function()
    while task.wait(0.5) do
        if getgenv().AutoFarm or getgenv().KillAura then
            local char = plr.Character
            if char and not char:FindFirstChildOfClass("Tool") then
                local backpack = plr.Backpack
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        if getgenv().WeaponType == "Melee" and tool.ToolTip == "Melee" then
                            char.Humanoid:EquipTool(tool)
                            break
                        elseif getgenv().WeaponType == "Sword" and tool.ToolTip == "Sword" then
                            char.Humanoid:EquipTool(tool)
                            break
                        end
                    end
                end
            end
        end
    end
end)

-- 2. Auto Buso (Tự động bật Haki)
task.spawn(function()
    while task.wait(1) do
        if getgenv().AutoBuso then
            local char = plr.Character
            if char and not char:FindFirstChild("HasBuso") then
                local remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
                if remote then remote:InvokeServer("Buso") end
            end
        end
    end
end)

-- 3. Kill Aura (Đánh nhanh xung quanh)
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().KillAura then
            pcall(function()
                local char = plr.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    local mobHrp = mob:FindFirstChild("HumanoidRootPart")
                    if mobHrp and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        if (mobHrp.Position - hrp.Position).Magnitude <= 40 then -- Phạm vi 40 studs
                            VirtualUser:CaptureController()
                            VirtualUser:Button1Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
                        end
                    end
                end
            end)
        end
    end
end)

-- 4. Auto Farm (Gom quái và đánh - ĐÃ FIX)
task.spawn(function()
    while task.wait() do
        if getgenv().AutoFarm then
            pcall(function()
                local char = plr.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                local target = nil
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
                        target = mob
                        break
                    end
                end

                if target then
                    local targetName = target.Name
                    repeat
                        if not getgenv().AutoFarm or not target.Parent or target.Humanoid.Health <= 0 then break end
                        
                        -- FIX: Đứng thẳng trên đầu quái 7 studs
                        hrp.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)
                        hrp.Velocity = Vector3.zero -- Khóa vận tốc để không bị văng

                        -- GOM QUÁI (Bring Mobs)
                        for _, v in pairs(Workspace.Enemies:GetChildren()) do
                            if v.Name == targetName and v ~= target and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                v.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame
                                v.HumanoidRootPart.CanCollide = false
                                if v:FindFirstChild("Humanoid") then v.Humanoid.WalkSpeed = 0 end
                            end
                        end

                        -- CLICK ĐÁNH
                        VirtualUser:CaptureController()
                        VirtualUser:Button1Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
                        
                        task.wait()
                    until not getgenv().AutoFarm or target.Humanoid.Health <= 0
                end
            end)
        end
    end
end)

-- 5. Noclip Bypass (Đi xuyên tường)
RunService.Stepped:Connect(function()
    if getgenv().AutoFarm and plr.Character then
        for _, v in pairs(plr.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end
end)

----------------------------------------------------
-- GIAO DIỆN MỚI (NEW UI)
----------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner_Main = Instance.new("UICorner")
local Sidebar = Instance.new("Frame")
local UICorner_Sidebar = Instance.new("UICorner")
local SidebarLayout = Instance.new("UIListLayout")
local ContentFrame = Instance.new("Frame")
local UICorner_Content = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local UICorner_Close = Instance.new("UICorner")

ScreenGui.Name = "HuyBeoHubV4"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner_Main.CornerRadius = UDim.new(0, 10)
UICorner_Main.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Size = UDim2.new(0, 200, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "HUY BÉO HUB V4"
Title.TextColor3 = Color3.fromRGB(255, 170, 0)
Title.TextSize = 18.000
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.92, 0, 0.02, 0)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14.000
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

UICorner_Close.CornerRadius = UDim.new(0, 6)
UICorner_Close.Parent = CloseBtn

-- Sidebar (Thanh điều hướng)
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Sidebar.Position = UDim2.new(0, 0, 0.114, 0)
Sidebar.Size = UDim2.new(0, 130, 0, 310)

UICorner_Sidebar.CornerRadius = UDim.new(0, 10)
UICorner_Sidebar.Parent = Sidebar

SidebarLayout.Parent = Sidebar
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 5)

-- Content Frame (Khu vực nội dung)
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.Position = UDim2.new(0.25, 0, 0.114, 0)
ContentFrame.Size = UDim2.new(0, 400, 0, 310)

UICorner_Content.CornerRadius = UDim.new(0, 10)
UICorner_Content.Parent = ContentFrame

-- Hàm tạo nút trên Sidebar
local currentTab = nil
local function createTabBtn(text, container)
    local btn = Instance.new("TextButton")
    local corner = Instance.new("UICorner")
    btn.Name = text .. "Btn"
    btn.Parent = Sidebar
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 14.000
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if currentTab then
            currentTab.btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            currentTab.btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            currentTab.container.Visible = false
        end
        btn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
        btn.TextColor3 = Color3.fromRGB(25, 25, 25)
        container.Visible = true
        currentTab = {btn = btn, container = container}
    end)
    return btn
end

-- Hàm tạo nút chức năng (Toggle)
local function makeToggleBtn(parent, text, flagName, yPos)
    local btn = Instance.new("TextButton")
    local corner = Instance.new("UICorner")
    local status = Instance.new("Frame")
    local statusCorner = Instance.new("UICorner")

    btn.Name = text .. "Btn"
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Position = UDim2.new(0.05, 0, yPos, 0)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16.000
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextWrapped = true
    btn.PaddingLeft = UDim.new(0, 15)
    
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    status.Name = "Status"
    status.Parent = btn
    status.BackgroundColor3 = getgenv()[flagName] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    status.Position = UDim2.new(0.85, 0, 0.25, 0)
    status.Size = UDim2.new(0, 22, 0, 22)
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = status

    btn.MouseButton1Click:Connect(function()
        getgenv()[flagName] = not getgenv()[flagName]
        status.BackgroundColor3 = getgenv()[flagName] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    end)
end

-- Tạo các Container cho từng Tab
local MainContainer = Instance.new("Frame", ContentFrame)
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(1, 0, 1, 0)
MainContainer.BackgroundTransparency = 1
MainContainer.Visible = false

local StatsContainer = Instance.new("Frame", ContentFrame)
StatsContainer.Name = "StatsContainer"
StatsContainer.Size = UDim2.new(1, 0, 1, 0)
StatsContainer.BackgroundTransparency = 1
StatsContainer.Visible = false

local MiscContainer = Instance.new("Frame", ContentFrame)
MiscContainer.Name = "MiscContainer"
MiscContainer.Size = UDim2.new(1, 0, 1, 0)
MiscContainer.BackgroundTransparency = 1
MiscContainer.Visible = false

-- Tạo các nút trong từng Container
makeToggleBtn(MainContainer, "Auto Farm", "AutoFarm", 0.05)
makeToggleBtn(MainContainer, "Kill Aura", "KillAura", 0.2)
makeToggleBtn(MainContainer, "Auto Buso (Haki)", "AutoBuso", 0.35)

-- Ví dụ cho các tab khác (Bạn có thể thêm chức năng sau)
local label1 = Instance.new("TextLabel", StatsContainer)
label1.Text = "Coming Soon..."
label1.Size = UDim2.new(1,0,1,0)
label1.BackgroundTransparency = 1
label1.TextColor3 = Color3.new(1,1,1)
label1.Font = Enum.Font.GothamBold

local function FixLag()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
    end
end

local fixLagBtn = Instance.new("TextButton", MiscContainer)
fixLagBtn.Size = UDim2.new(0.9, 0, 0, 45)
fixLagBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
fixLagBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fixLagBtn.Font = Enum.Font.GothamBold
fixLagBtn.Text = "Fix Lag (FPS Boost)"
fixLagBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", fixLagBtn).CornerRadius = UDim.new(0, 8)
fixLagBtn.MouseButton1Click:Connect(function() FixLag() fixLagBtn.Text = "Lag Fixed!" task.wait(1) fixLagBtn.Text = "Fix Lag (FPS Boost)" end)

-- Tạo các nút Tab trên Sidebar
local mainTabBtn = createTabBtn("Main", MainContainer)
createTabBtn("Stats", StatsContainer)
createTabBtn("Misc", MiscContainer)

-- Mặc định chọn tab đầu tiên
mainTabBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
mainTabBtn.TextColor3 = Color3.fromRGB(25, 25, 25)
MainContainer.Visible = true
currentTab = {btn = mainTabBtn, container = MainContainer}
