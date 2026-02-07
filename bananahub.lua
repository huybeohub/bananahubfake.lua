-- Banana Cat Hub (UI ONLY) - Safe Roblox UI Practice

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "BananaCatHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.6)
main.Position = UDim2.fromScale(0.22,0.2)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.1)
title.BackgroundTransparency = 1
title.Text = "Banana Cat Hub - UI"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255,200,0)

local content = Instance.new("Frame", main)
content.Size = UDim2.fromScale(0.72,0.9)
content.Position = UDim2.fromScale(0.27,0.1)
content.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", content).CornerRadius = UDim.new(0,12)

Instance.new("UIListLayout", content).Padding = UDim.new(0,10)

-- ===== FARMING UI =====
local farmingSection = Instance.new("Frame", content)
farmingSection.Size = UDim2.fromScale(1,1)
farmingSection.BackgroundTransparency = 1

Instance.new("UIListLayout", farmingSection).Padding = UDim.new(0,8)

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

print("Banana Cat Hub UI LOADED OK")
