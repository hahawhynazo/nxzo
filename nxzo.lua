-- Nxzo's Script
-- Roblox Studio LocalScript
-- Place in StarterPlayer > StarterPlayerScripts.
-- This is a UI-only RageMode toggle; it does not automate attacks or damage players.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("NxzosScriptGui")
if oldGui then oldGui:Destroy() end

local ACCESS_KEY = "NXZO-2026" -- Change this placeholder to your preferred display key.
local rageEnabled = false

local gui = Instance.new("ScreenGui")
gui.Name = "NxzosScriptGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 340, 0, 300)
main.Position = UDim2.new(0.5, -170, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(145, 75, 220)
stroke.Thickness = 1.5
stroke.Parent = main

local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 42)
top.BackgroundColor3 = Color3.fromRGB(43, 27, 61)
top.BorderSizePixel = 0
top.Parent = main
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -52, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Nxzo's Script"
title.TextColor3 = Color3.fromRGB(245, 235, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -36, 0, 6)
close.BackgroundColor3 = Color3.fromRGB(92, 48, 119)
close.Text = "×"
close.TextColor3 = Color3.new(1, 1, 1)
close.TextSize = 22
close.Font = Enum.Font.GothamBold
close.BorderSizePixel = 0
close.Parent = top
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

local function makeLabel(name, text, size, position, textSize, color)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(230, 220, 242)
    label.TextSize = textSize
    label.Font = Enum.Font.Gotham
    label.TextWrapped = true
    label.Parent = main
    return label
end

local discordLabel = makeLabel(
    "DiscordLabel", "dc: gothangelz",
    UDim2.new(1, -24, 0, 25), UDim2.new(0, 12, 0, 52), 16,
    Color3.fromRGB(205, 160, 255)
)
discordLabel.Font = Enum.Font.GothamBold

makeLabel(
    "FriendRequestNote",
    "before sending friend request explain why you wanna add so i will add you",
    UDim2.new(1, -28, 0, 48), UDim2.new(0, 14, 0, 79), 12
)

local keyBox = Instance.new("TextBox")
keyBox.Name = "KeyInput"
keyBox.Size = UDim2.new(1, -28, 0, 40)
keyBox.Position = UDim2.new(0, 14, 0, 137)
keyBox.BackgroundColor3 = Color3.fromRGB(38, 30, 50)
keyBox.BorderSizePixel = 0
keyBox.PlaceholderText = "Enter key..."
keyBox.Text = ""
keyBox.ClearTextOnFocus = false
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.PlaceholderColor3 = Color3.fromRGB(170, 155, 185)
keyBox.TextSize = 14
keyBox.Font = Enum.Font.Gotham
keyBox.Parent = main
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

local function makeButton(name, text, y)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -28, 0, 40)
    button.Position = UDim2.new(0, 14, 0, y)
    button.BackgroundColor3 = Color3.fromRGB(100, 52, 145)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 14
    button.Font = Enum.Font.GothamSemibold
    button.Parent = main
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
    return button
end

local status = makeLabel(
    "Status", "Enter the key to unlock the panel.",
    UDim2.new(1, -28, 0, 25), UDim2.new(0, 14, 0, 184), 12,
    Color3.fromRGB(200, 185, 215)
)

local unlockButton = makeButton("UnlockButton", "Unlock", 213)
local rageButton = makeButton("RageModeToggle", "RageMode: OFF", 213)
rageButton.Visible = false

unlockButton.MouseButton1Click:Connect(function()
    if keyBox.Text == ACCESS_KEY then
        keyBox.Visible = false
        unlockButton.Visible = false
        status.Position = UDim2.new(0, 14, 0, 184)
        status.Text = "Panel unlocked. Toggle is UI-only."
        rageButton.Visible = true
    else
        status.Text = "Incorrect key. Try again."
    end
end)

rageButton.MouseButton1Click:Connect(function()
    rageEnabled = not rageEnabled
    if rageEnabled then
        rageButton.Text = "RageMode: ON"
        rageButton.BackgroundColor3 = Color3.fromRGB(155, 48, 90)
        status.Text = "RageMode is ON (visual toggle only)."
    else
        rageButton.Text = "RageMode: OFF"
        rageButton.BackgroundColor3 = Color3.fromRGB(100, 52, 145)
        status.Text = "RageMode is OFF."
    end
end)

-- Draggable on desktop and touch devices.
local dragging = false
local dragInput
local dragStart
local startPosition

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

top.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)
