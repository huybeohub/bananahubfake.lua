repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer
--------------------------------------------------
-- HUY BÉO HUB | BANANA FUNCTION PACK (99.99%)
-- KEYLESS | ALL IN ONE
--------------------------------------------------

-- SERVICES
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TP = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local plr = Players.LocalPlayer

--------------------------------------------------
-- GLOBAL FLAGS
--------------------------------------------------
getgenv().AutoFarm = true
getgenv().AutoBoss = true
getgenv().AutoBone = true
getgenv().AutoRaid = true
getgenv().AutoFruit = true
getgenv().AutoSea2 = true
getgenv().AutoSea3 = true
getgenv().AutoGodhuman = true
getgenv().BringMob = true
getgenv().SafeFarm = true
getgenv().FixLag = true
getgenv().ServerHop = true

--------------------------------------------------
-- ANTI AFK
--------------------------------------------------
plr.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

--------------------------------------------------
-- AUTO HAKI
--------------------------------------------------
task.spawn(function()
    while task.wait(2) do
        pcall(function()
            if plr.Character and not plr.Character:FindFirstChild("HasBuso") then
                RS.Remotes.CommF_:InvokeServer("Buso")
            end
        end)
    end
end)

--------------------------------------------------
-- AUTO CLICK (FIX XA)
--------------------------------------------------
local function Click()
    VirtualUser:Button1Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait()
    VirtualUser:Button1Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end

--------------------------------------------------
-- SAFE FARM + ANTI DIE
--------------------------------------------------
RunService.Heartbeat:Connect(function()
    if getgenv().SafeFarm and plr.Character then
        local hum = plr.Character:FindFirstChild("Humanoid")
        if hum and hum.Health < hum.MaxHealth*0.3 then
            plr.Character.HumanoidRootPart.CFrame *= CFrame.new(0,40,0)
        end
    end
end)

--------------------------------------------------
-- AUTO SELECT MELEE LOWEST MASTERY
--------------------------------------------------
task.spawn(function()
    while task.wait(5) do
        local char = plr.Character
        if not char then continue end
        local lowest, pick = math.huge,nil
        for _,t in pairs(plr.Backpack:GetChildren()) do
            if t:IsA("Tool") and t.ToolTip=="Melee" and t:FindFirstChild("Level") then
                if t.Level.Value < lowest then
                    lowest=t.Level.Value
                    pick=t
                end
            end
        end
        if pick then pick.Parent=char end
    end
end)

--------------------------------------------------
-- BRING MOB + FARM CORE
--------------------------------------------------
local function FarmMob(name)
    for _,mob in pairs(WS.Enemies:GetChildren()) do
        if mob.Name==name and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health>0 then
            local hrp = plr.Character.HumanoidRootPart
            hrp.Anchored=true
            repeat
                hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,12,0)
                if getgenv().BringMob then
                    for _,v in pairs(WS.Enemies:GetChildren()) do
                        if v.Name==name and v:FindFirstChild("HumanoidRootPart") then
                            v.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame
                            v.Humanoid.WalkSpeed=0
                            v.Humanoid.JumpPower=0
                        end
                    end
                end
                Click()
                task.wait(0.12)
            until mob.Humanoid.Health<=0
            hrp.Anchored=false
        end
    end
end

--------------------------------------------------
-- AUTO FARM / BOSS / BONE / RAID
--------------------------------------------------
task.spawn(function()
    while task.wait(0.3) do
        if getgenv().AutoFarm then FarmMob("Bandit") end
        if getgenv().AutoBone then FarmMob("Reborn Skeleton") end
        if getgenv().AutoBoss then FarmMob("Tide Keeper") end
        if getgenv().AutoRaid then
            RS.Remotes.CommF_:InvokeServer("RaidsNpc","Select","Flame")
        end
    end
end)

--------------------------------------------------
-- AUTO FRUIT (NHẶT + CẤT)
--------------------------------------------------
task.spawn(function()
    while task.wait(5) do
        if not getgenv().AutoFruit then continue end
        for _,v in pairs(WS:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                firetouchinterest(plr.Character.HumanoidRootPart,v.Handle,0)
                task.wait()
                RS.Remotes.CommF_:InvokeServer("StoreFruit",v.Name)
            end
        end
    end
end)

--------------------------------------------------
-- SERVER HOP FIX (ANTI LOOP / ANTI KICK)
--------------------------------------------------
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local hopping = false
local lastHop = 0

local function GetLowServer()
    local url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
    local body = HttpService:JSONDecode(game:HttpGet(url))

    for _,server in pairs(body.data) do
        if server.playing < server.maxPlayers - 2
        and server.id ~= game.JobId then
            return server.id
        end
    end
end

local function NeedHop()
    -- không còn quái sống
    for _,v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return false
        end
    end
    return true
end

task.spawn(function()
    while task.wait(10) do
        if not getgenv().ServerHop then continue end
        if hopping then continue end
        if tick() - lastHop < 60 then continue end -- cooldown 60s
        if not NeedHop() then continue end

        hopping = true
        lastHop = tick()

        local serverId = GetLowServer()
        if serverId then
            pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, plr)
            end)
        end

        task.wait(5)
        hopping = false
    end
end)

--------------------------------------------------
-- FIX LAG
--------------------------------------------------
if getgenv().FixLag then
    task.spawn(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _,v in pairs(WS:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material=Enum.Material.SmoothPlastic
                v.Reflectance=0
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled=false
            end
        end
        pcall(function() setfpscap(120) end)
    end)
end
