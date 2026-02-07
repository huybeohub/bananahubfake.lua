-- Banana Cat Hub (UI ONLY) - Safe Roblox UI Practice
-- No exploit, no autofarm, no game injection

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "BananaCatHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.6)
main.Position = UDim2.fromScale(0.22,0.2)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Name = "Main"

Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.1)
title.BackgroundTransparency = 1
title.Text = "Banana Cat Hub - UI"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255,200,0)

-- Sidebar
local side = Instance.new("Frame", main)
side.Size = UDim2.fromScale(0.25,0.9)
side.Position = UDim2.fromScale(0,0.1)
side.BackgroundColor3 = Color3.fromRGB(15,15,15)
side.BorderSizePixel = 0
Instance.new("UICorner", side).CornerRadius = UDim.new(0,12)

local sections = {
	"Shop",
	"Status And Server",
	"LocalPlayer",
	"Setting Farm",
	"Hold And Select Skill",
	"Farming",
	"Stack Farming",
	"Farming Other",
	"Fruit and Raid, Dungeon",
	"Sea Event"
}

local layout = Instance.new("UIListLayout", side)
layout.Padding = UDim.new(0,6)

for _,name in ipairs(sections) do
	local btn = Instance.new("TextButton", side)
	btn.Size = UDim2.fromScale(1,0.08)
	btn.Text = name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	btn.TextColor3 = Color3.fromRGB(220,220,220)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
end

-- Content Frame
local content = Instance.new("Frame", main)
content.Size = UDim2.fromScale(0.72,0.9)
content.Position = UDim2.fromScale(0.27,0.1)
content.BackgroundColor3 = Color3.fromRGB(25,25,25)
content.BorderSizePixel = 0
Instance.new("UICorner", content).CornerRadius = UDim.new(0,12)

local list = Instance.new("UIListLayout", content)
list.Padding = UDim.new(0,10)

local items = {
	"Redeem Code",
	"Teleport Old World",
	"Teleport New World",
	"Teleport Third Sea",
	"Buy Dual Flintlock",
	"Reroll Race"
}

for _,text in ipairs(items) do
	local row = Instance.new("Frame", content)
	row.Size = UDim2.fromScale(1,0.12)
	row.BackgroundTransparency = 1

	local label = Instance.new("TextLabel", row)
	label.Size = UDim2.fromScale(0.7,1)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.Gotham
	label.TextSize = 16
	label.TextXAlignment = Left
	label.TextColor3 = Color3.fromRGB(230,230,230)

	local click = Instance.new("TextButton", row)
	click.Size = UDim2.fromScale(0.25,0.6)
	click.Position = UDim2.fromScale(0.73,0.2)
	click.Text = "Click"
	click.Font = Enum.Font.GothamBold
	click.TextSize = 14
	click.BackgroundColor3 = Color3.fromRGB(255,190,60)
	click.TextColor3 = Color3.fromRGB(30,30,30)
	Instance.new("UICorner", click).CornerRadius = UDim.new(0,10)

	click.MouseButton1Click:Connect(function()
		print("[UI ONLY] Clicked:", text)
	end)
end

-- ===== Farming (UI ONLY) =====
local farmingSection = Instance.new("Frame", content)
farmingSection.Size = UDim2.fromScale(1,0.9)
farmingSection.BackgroundTransparency = 1

local header = Instance.new("TextLabel", farmingSection)
header.Size = UDim2.fromScale(1,0.08)
header.BackgroundTransparency = 1
header.Text = "Setting Farm"
header.Font = Enum.Font.GothamBold
header.TextSize = 18
header.TextColor3 = Color3.fromRGB(255,200,0)

local farmList = Instance.new("UIListLayout", farmingSection)
farmList.Padding = UDim.new(0,8)

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
	label.TextXAlignment = Left
	label.TextColor3 = Color3.fromRGB(230,230,230)

	local toggle = Instance.new("TextButton", row)
	toggle.Size = UDim2.fromScale(0.08,0.6)
	oggle.Position = UDim2.fromScale(0.9,0.2)
	toggle.Text = ""
	toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,6)

	local on = false
	toggle.MouseButton1Click:Connect(function()
		on = not on
		toggle.BackgroundColor3 = on and Color3.fromRGB(255,200,0) or Color3.fromRGB(40,40,40)
		print("[UI ONLY] Toggle", text, on)
	end)
end

-- Select Method Farms (placeholder button)
toggleRow("Select Method Farms")

-- Distance Farm Aura (display only)
local dist = Instance.new("Frame", farmingSection)
dist.Size = UDim2.fromScale(1,0.1)
dist.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", dist).CornerRadius = UDim.new(0,10)

local dLabel = Instance.new("TextLabel", dist)
dLabel.Size = UDim2.fromScale(0.7,1)
dLabel.BackgroundTransparency = 1
dLabel.Text = "Distance Farm Aura"
dLabel.Font = Enum.Font.Gotham
dLabel.TextSize = 14
dLabel.TextXAlignment = Left
dLabel.TextColor3 = Color3.fromRGB(230,230,230)

local dValue = Instance.new("TextLabel", dist)
dValue.Size = UDim2.fromScale(0.2,1)
dValue.Position = UDim2.fromScale(0.75,0)
dValue.BackgroundTransparency = 1
dValue.Text = "300"
dValue.Font = Enum.Font.GothamBold
dValue.TextSize = 14
dValue.TextColor3 = Color3.fromRGB(255,200,0)

-- Toggles like the screenshot
toggleRow("Ignore Attack Katakuri")
toggleRow("Hop Find Katakuri")
toggleRow("Auto Quest [Katakuri/Bone/Tyrant]")
toggleRow("Start Farm")

print("Banana Cat Hub UI loaded (SAFE MODE) + Farming UI")
