-- Nxzo's Script
-- Roblox Studio LocalScript
-- Place in StarterPlayer > StarterPlayerScripts.
-- This GUI is for testing your own experience; it does not log into or control alternate accounts.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("NxzosScriptGui")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "NxzosScriptGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 320, 0, 225)
main.Position = UDim2.new(0.5, -160, 0.5, -112)
main.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

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

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 12)
topCorner.Parent = top

local title = Instance.new("TextLabel")
title.Name = "Title"
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
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextSize = 22
close.Font = Enum.Font.GothamBold
close.BorderSizePixel = 0
close.Parent = top
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local status = Instance.new("TextLabel")
status.Name = "Status"
status.Size = UDim2.new(1, -28, 0, 42)
status.Position = UDim2.new(0, 14, 0, 52)
status.BackgroundTransparency = 1
status.Text = "Players in this server: " .. #Players:GetPlayers()
status.TextColor3 = Color3.fromRGB(220, 210, 235)
status.TextSize = 14
status.Font = Enum.Font.Gotham
status.TextWrapped = true
status.Parent = main

local function makeButton(name, text, y)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -28, 0, 42)
    button.Position = UDim2.new(0, 14, 0, y)
    button.BackgroundColor3 = Color3.fromRGB(100, 52, 145)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.GothamSemibold
    button.AutoButtonColor = true
    button.Parent = main
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
    return button
end

local refreshButton = makeButton("RefreshPlayerCount", "Refresh Player Count", 98)
refreshButton.MouseButton1Click:Connect(function()
    status.Text = "Players in this server: " .. #Players:GetPlayers()
end)

local helpButton = makeButton("MultiplayerTestHelp", "Multiplayer Test Help", 148)
helpButton.MouseButton1Click:Connect(function()
    status.Text = "Studio: Test tab → Start a Server, then choose the number of Players to test multiplayer."
end)

-- Make the window draggable on desktop and mobile.
local UserInputService = game:GetService("UserInputService")
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
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
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
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

Players.PlayerAdded:Connect(function()
    if status and status.Parent and not status.Text:find("Studio:") then
        status.Text = "Players in this server: " .. #Players:GetPlayers()
    end
end)

Players.PlayerRemoving:Connect(function()
    task.defer(function()
        if status and status.Parent and not status.Text:find("Studio:") then
            status.Text = "Players in this server: " .. #Players:GetPlayers()
        end
    end)
end)
