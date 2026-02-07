-- Banana Cat Hub | UI ONLY
-- A12: Toggle UI
-- A13: Save Toggle Config

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- ================= CONFIG SAVE =================
local CONFIG_FILE = "BananaCatHub_Config.json"

local Config = {
	UIOpen = true,
	IgnoreKatakuri = false,
	HopKatakuri = false,
	AutoQuest = false,
	StartFarm = false
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
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "BananaCatHub"
gui.ResetOnSpawn = false

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

-- ================= SIDEBAR =================
local side = Instance.new("Frame", main)
side.Size = UDim2.fromScale(0.25,0.9)
side.Position = UDim2.fromScale(0,0.1)
side.BackgroundColor3 = Color3.fromRGB(15,15,15)
side.BorderSizePixel = 0
Instance.new("UICorner", side).CornerRadius = UDim.new(0,12)

local sideLayout = Instance.new("UIListLayout", side)
sideLayout.Padding = UDim.new(0,6)

local sections = {
	"Shop","Status And Server","LocalPlayer",
	"Setting Farm","Hold And Select Skill",
	"Farming","Stack Farming","Farming Other",
	"Fruit and Raid, Dungeon","Sea Event"
}

local currentTab
for _,name in ipairs(sections) do
	local b = Instance.new("TextButton", side)
	b.Size = UDim2.fromScale(1,0.08)
	b.Text = name
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.BackgroundColor3 = Color3.fromRGB(25,25,25)
	b.TextColor3 = Color3.fromRGB(220,220,220)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

	b.MouseButton1Click:Connect(function()
		if currentTab then currentTab.Visible = false end
		if name == "Farming" then
			currentTab = farming
			farming.Visible = true
		end
	end)
end

-- ================= CONTENT =================
local farming = Instance.new("Frame", main)
farming.Size = UDim2.fromScale(0.72,0.9)
farming.Position = UDim2.fromScale(0.27,0.1)
farming.BackgroundColor3 = Color3.fromRGB(25,25,25)
farming.BorderSizePixel = 0
farming.Visible = false
Instance.new("UICorner", farming).CornerRadius = UDim.new(0,12)

local fLayout = Instance.new("UIListLayout", farming)
fLayout.Padding = UDim.new(0,10)

local header = Instance.new("TextLabel", farming)
header.Size = UDim2.fromScale(1,0.08)
header.BackgroundTransparency = 1
header.Text = "Setting Farm"
header.Font = Enum.Font.GothamBold
header.TextSize = 18
header.TextColor3 = Color3.fromRGB(255,200,0)

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

	local toggle = Instance.new("TextButton", row)
	toggle.Size = UDim2.fromScale(0.18,0.6)
	toggle.Position = UDim2.fromScale(0.78,0.2)
	toggle.Text = ""
	Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

	local on = Config[key]
	toggle.BackgroundColor3 = on and Color3.fromRGB(255,200,0) or Color3.fromRGB(60,60,60)

	toggle.MouseButton1Click:Connect(function()
		on = not on
		Config[key] = on
		toggle.BackgroundColor3 = on and Color3.fromRGB(255,200,0) or Color3.fromRGB(60,60,60)
		SaveConfig()
	end)
end
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

	-- Toggle background
	local toggleBg = Instance.new("Frame", row)
	toggleBg.Size = UDim2.fromScale(0.18,0.45)
	toggleBg.Position = UDim2.fromScale(0.78,0.275)
	toggleBg.BackgroundColor3 = Color3.fromRGB(60,60,60)
	Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1,0)

	-- Knob
	local knob = Instance.new("Frame", toggleBg)
	knob.Size = UDim2.fromScale(0.45,0.85)
	knob.Position = UDim2.fromScale(0.05,0.075)
	knob.BackgroundColor3 = Color3.fromRGB(220,220,220)
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

	-- Button layer
	local btn = Instance.new("TextButton", toggleBg)
	btn.Size = UDim2.fromScale(1,1)
	btn.BackgroundTransparency = 1
	btn.Text = ""

	-- Load state
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
createToggle("Ignore Attack Katakuri","IgnoreKatakuri")
createToggle("Hop Find Katakuri","HopKatakuri")
createToggle("Auto Quest [Katakuri/Bone/Tyrant]","AutoQuest")
createToggle("Start Farm","StartFarm")

print("✅ Banana Cat Hub | A12 + A13 Loaded")
