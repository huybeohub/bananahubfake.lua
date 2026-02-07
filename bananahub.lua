-- Banana Cat Hub | FULL MERGED A12 + A13 + FARM METHODS
-- UI + CONFIG + FARMING SYSTEM

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ================= CONFIG =================
local CONFIG_FILE = "BananaCatHub_Config.json"

local Config = {
	UIOpen = true,

	FarmLevel = false,
	FarmBones = false,
	FarmKatakuri = false,
	FarmAura = false,
}

if readfile and isfile and isfile(CONFIG_FILE) then
	local data = HttpService:JSONDecode(readfile(CONFIG_FILE))
	for k,v in pairs(data) do
		Config[k] = v
	end
end

local function SaveConfig()
	if writefile then
		writefile(CONFIG_FILE, HttpService:JSONEncode(Config))
	end
end

-- ================= UI ROOT =================
local gui = Instance.new("ScreenGui")
gui.Name = "BananaCatHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ================= TOGGLE UI BUTTON =================
local uiBtn = Instance.new("TextButton", gui)
uiBtn.Size = UDim2.fromScale(0.06,0.08)
uiBtn.Position = UDim2.fromScale(0.01,0.45)
uiBtn.Text = "🍌"
uiBtn.Font = Enum.Font.GothamBold
uiBtn.TextSize = 22
uiBtn.BackgroundColor3 = Color3.fromRGB(255,200,0)
uiBtn.TextColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", uiBtn).CornerRadius = UDim.new(1,0)

-- ================= MAIN =================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.6)
main.Position = UDim2.fromScale(0.22,0.2)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Visible = Config.UIOpen
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

uiBtn.MouseButton1Click:Connect(function()
	Config.UIOpen = not Config.UIOpen
	main.Visible = Config.UIOpen
	SaveConfig()
end)

-- ================= TITLE =================
local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.1)
title.BackgroundTransparency = 1
title.Text = "Banana Cat Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255,200,0)

-- ================= CONTENT : FARMING =================
local farming = Instance.new("Frame", main)
farming.Size = UDim2.fromScale(0.95,0.85)
farming.Position = UDim2.fromScale(0.025,0.12)
farming.BackgroundColor3 = Color3.fromRGB(25,25,25)
farming.BorderSizePixel = 0
farming.Visible = true
Instance.new("UICorner", farming).CornerRadius = UDim.new(0,12)

local layout = Instance.new("UIListLayout", farming)
layout.Padding = UDim.new(0,10)

-- ================= TOGGLE CREATOR =================
local function createToggle(text,key)
	local row = Instance.new("Frame", farming)
	row.Size = UDim2.fromScale(1,0.1)
	row.BackgroundColor3 = Color3.fromRGB(30,30,30)
	Instance.new("UICorner", row).CornerRadius = UDim.new(0,10)

	local label = Instance.new("TextLabel", row)
	label.Size = UDim2.fromScale(0.7,1)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextColor3 = Color3.fromRGB(230,230,230)

	local toggleBg = Instance.new("Frame", row)
	toggleBg.Size = UDim2.fromScale(0.18,0.45)
	toggleBg.Position = UDim2.fromScale(0.78,0.275)
	toggleBg.BackgroundColor3 = Color3.fromRGB(60,60,60)
	Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1,0)

	local knob = Instance.new("Frame", toggleBg)
	knob.Size = UDim2.fromScale(0.45,0.85)
	knob.Position = UDim2.fromScale(0.05,0.075)
	knob.BackgroundColor3 = Color3.fromRGB(220,220,220)
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

	local btn = Instance.new("TextButton", toggleBg)
	btn.Size = UDim2.fromScale(1,1)
	btn.BackgroundTransparency = 1
	btn.Text = ""

	local on = Config[key]
	if on then
		toggleBg.BackgroundColor3 = Color3.fromRGB(255,200,0)
		knob.Position = UDim2.fromScale(0.5,0.075)
	end

	btn.MouseButton1Click:Connect(function()
		on = not on
		Config[key] = on
		SaveConfig()

		TweenService:Create(toggleBg,TweenInfo.new(0.2),{
			BackgroundColor3 = on and Color3.fromRGB(255,200,0) or Color3.fromRGB(60,60,60)
		}):Play()

		TweenService:Create(knob,TweenInfo.new(0.2),{
			Position = on and UDim2.fromScale(0.5,0.075) or UDim2.fromScale(0.05,0.075)
		}):Play()
	end)
end

-- ================= FARMING TOGGLES =================
createToggle("Farm Level","FarmLevel")
createToggle("Farm Bones","FarmBones")
createToggle("Farm Katakuri","FarmKatakuri")
createToggle("Farm Aura","FarmAura")

-- ================= FARM METHODS (HOOK) =================
RunService.Heartbeat:Connect(function()
	if Config.FarmLevel then
		-- farm level logic
	end
	if Config.FarmBones then
		-- farm bones logic
	end
	if Config.FarmKatakuri then
		-- farm katakuri logic
	end
	if Config.FarmAura then
		-- farm aura logic
	end
end)

print("✅ Banana Cat Hub | UI + FARM SYSTEM LOADED")
