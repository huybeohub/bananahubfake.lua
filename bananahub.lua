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

print("Banana Cat Hub UI loaded (SAFE MODE)")
