-- Banana Cat Hub (UI ONLY) - FULL MERGED CONFIG
-- Safe UI practice | No exploit | No autofarm

print("Banana Cat Hub loading...")

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BananaCatHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.6)
main.Position = UDim2.fromScale(0.22,0.2)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.1)
title.BackgroundTransparency = 1
title.Text = "Banana Cat Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255,200,0)

-- SIDEBAR
local side = Instance.new("Frame", main)
side.Size = UDim2.fromScale(0.25,0.9)
side.Position = UDim2.fromScale(0,0.1)
side.BackgroundColor3 = Color3.fromRGB(15,15,15)
side.BorderSizePixel = 0
side.ClipsDescendants = true
Instance.new("UICorner", side).CornerRadius = UDim.new(0,12)

local sideLayout = Instance.new("UIListLayout", side)
sideLayout.Padding = UDim.new(0,6)

-- SIDEBAR TOGGLE BUTTON
local toggleSide = Instance.new("TextButton", main)
toggleSide.Size = UDim2.fromScale(0.04,0.06)
toggleSide.Position = UDim2.fromScale(0.005,0.02)
toggleSide.Text = "≡"
toggleSide.Font = Enum.Font.GothamBold
toggleSide.TextSize = 18
toggleSide.BackgroundColor3 = Color3.fromRGB(255,200,0)
toggleSide.TextColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", toggleSide).CornerRadius = UDim.new(1,0)

local sideOpen = true
toggleSide.MouseButton1Click:Connect(function()
	sideOpen = not sideOpen
	TweenService:Create(side, TweenInfo.new(0.25), {
		Size = sideOpen and UDim2.fromScale(0.25,0.9) or UDim2.fromScale(0,0.9)
	}):Play()
end)

-- CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.fromScale(0.72,0.9)
content.Position = UDim2.fromScale(0.27,0.1)
content.BackgroundColor3 = Color3.fromRGB(25,25,25)
content.BorderSizePixel = 0
Instance.new("UICorner", content).CornerRadius = UDim.new(0,12)

local contentLayout = Instance.new("UIListLayout", content)
contentLayout.Padding = UDim.new(0,10)

-- SIDEBAR SECTIONS + ICONS (A12)
local sections = {
	{icon="🛒", name="Shop"},
	{icon="📊", name="Status And Server"},
	{icon="👤", name="LocalPlayer"},
	{icon="⚙️", name="Setting Farm"},
	{icon="🎯", name="Hold And Select Skill"},
	{icon="⚔️", name="Farming"},
	{icon="📦", name="Stack Farming"},
	{icon="🧩", name="Farming Other"},
	{icon="🍎", name="Fruit and Raid, Dungeon"},
	{icon="🌊", name="Sea Event"}
}

local selectedButton = nil

for _,data in ipairs(sections) do
	local btn = Instance.new("TextButton", side)
	btn.Size = UDim2.fromScale(1,0.08)
	btn.Text = "  "..data.icon.."  "..data.name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
	btn.TextColor3 = Color3.fromRGB(200,200,200)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

	btn.MouseButton1Click:Connect(function()
		if selectedButton then
			selectedButton.BackgroundColor3 = Color3.fromRGB(20,20,20)
			selectedButton.TextColor3 = Color3.fromRGB(200,200,200)
		end
		btn.BackgroundColor3 = Color3.fromRGB(255,200,0)
		btn.TextColor3 = Color3.fromRGB(30,30,30)
		selectedButton = btn
	end)
end

-- ===== FARMING SECTION =====
local farmingSection = Instance.new("Frame", content)
farmingSection.Size = UDim2.fromScale(1,1)
farmingSection.BackgroundTransparency = 1
Instance.new("UIListLayout", farmingSection).Padding = UDim.new(0,8)

-- TOGGLE ROW (ANIMATED)
local function toggleRow(text)
	local row = Instance.new("Frame", farmingSection)
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
	toggleBg.Size = UDim2.fromScale(0.1,0.5)
	toggleBg.Position = UDim2.fromScale(0.85,0.25)
	toggleBg.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1,0)

	local knob = Instance.new("Frame", toggleBg)
	knob.Size = UDim2.fromScale(0.45,0.9)
	knob.Position = UDim2.fromScale(0.05,0.05)
	knob.BackgroundColor3 = Color3.fromRGB(200,200,200)
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

	local btn = Instance.new("TextButton", toggleBg)
	btn.Size = UDim2.fromScale(1,1)
	btn.BackgroundTransparency = 1
	btn.Text = ""

	local on = false
	btn.MouseButton1Click:Connect(function()
		on = not on
		TweenService:Create(toggleBg, TweenInfo.new(0.2), {
			BackgroundColor3 = on and Color3.fromRGB(255,200,0) or Color3.fromRGB(40,40,40)
		}):Play()
		TweenService:Create(knob, TweenInfo.new(0.2), {
			Position = on and UDim2.fromScale(0.5,0.05) or UDim2.fromScale(0.05,0.05)
		}):Play()
	end)
end

toggleRow("Ignore Attack Katakuri")
toggleRow("Hop Find Katakuri")
toggleRow("Auto Quest [Katakuri/Bone/Tyrant]")
toggleRow("Start Farm")

print("Banana Cat Hub UI LOADED SUCCESSFULLY")
