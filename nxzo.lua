-- Nxzo's Script
-- Roblox Studio LocalScript
-- Place in StarterPlayer > StarterPlayerScripts.
-- Rage tab contains a visual ON/OFF toggle only; it does not automate attacks.

local UserInputService = game:GetService("UserInputService")
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("NxzosScriptGui")
if oldGui then oldGui:Destroy() end

local ACCESS_KEY = "NXZO-2026" -- Replace with your desired key.
local unlocked = false
local rageEnabled = false
local activeCategory = "Rage"

local gui = Instance.new("ScreenGui")
gui.Name = "NxzosScriptGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 500, 0, 390)
main.Position = UDim2.new(0.5, -250, 0.5, -195)
main.BackgroundColor3 = Color3.fromRGB(19, 17, 27)
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(139, 75, 204)
outline.Thickness = 1.5
outline.Parent = main

local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 42)
top.BackgroundColor3 = Color3.fromRGB(38, 27, 52)
top.BorderSizePixel = 0
top.Parent = main
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
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

local function label(parent, name, text, size, position, textSize, color)
    local item = Instance.new("TextLabel")
    item.Name = name
    item.Size = size
    item.Position = position
    item.BackgroundTransparency = 1
    item.Text = text
    item.TextColor3 = color or Color3.fromRGB(225, 215, 238)
    item.TextSize = textSize
    item.Font = Enum.Font.Gotham
    item.TextWrapped = true
    item.Parent = parent
    return item
end

local function button(parent, name, text, size, position)
    local item = Instance.new("TextButton")
    item.Name = name
    item.Size = size
    item.Position = position
    item.BackgroundColor3 = Color3.fromRGB(75, 49, 99)
    item.BorderSizePixel = 0
    item.Text = text
    item.TextColor3 = Color3.fromRGB(245, 238, 255)
    item.TextSize = 14
    item.Font = Enum.Font.GothamSemibold
    item.Parent = parent
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 8)
    return item
end

local sidebar = Instance.new("Frame")
sidebar.Name = "Categories"
sidebar.Size = UDim2.new(0, 132, 1, -54)
sidebar.Position = UDim2.new(0, 10, 0, 49)
sidebar.BackgroundColor3 = Color3.fromRGB(27, 23, 37)
sidebar.BorderSizePixel = 0
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 9)

label(sidebar, "CategoryTitle", "CATEGORIES", UDim2.new(1, -16, 0, 25),
    UDim2.new(0, 8, 0, 8), 11, Color3.fromRGB(167, 137, 192))

local rageCategory = button(sidebar, "RageCategory", "Rage", UDim2.new(1, -16, 0, 38),
    UDim2.new(0, 8, 0, 40))
rageCategory.BackgroundColor3 = Color3.fromRGB(105, 58, 142)

local antiAfkCategory = button(sidebar, "AntiAFKCategory", "ANTI-AFK",
    UDim2.new(1, -16, 0, 38), UDim2.new(0, 8, 0, 84))

local testCategory = button(sidebar, "TestCategory", "10/10",
    UDim2.new(1, -16, 0, 38), UDim2.new(0, 8, 0, 128))

local content = Instance.new("Frame")
content.Name = "CategoryContent"
content.Size = UDim2.new(1, -160, 1, -54)
content.Position = UDim2.new(0, 150, 0, 49)
content.BackgroundColor3 = Color3.fromRGB(27, 23, 37)
content.BorderSizePixel = 0
content.Parent = main
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 9)

local discord = label(content, "DiscordLabel", "dc: gothangelz",
    UDim2.new(1, -24, 0, 24), UDim2.new(0, 12, 0, 10), 15,
    Color3.fromRGB(205, 160, 255))
discord.Font = Enum.Font.GothamBold

label(content, "FriendRequestNote",
    "before sending friend request explain why you wanna add so i will add you",
    UDim2.new(1, -24, 0, 42), UDim2.new(0, 12, 0, 35), 11)

local keyBox = Instance.new("TextBox")
keyBox.Name = "KeyInput"
keyBox.Size = UDim2.new(1, -24, 0, 36)
keyBox.Position = UDim2.new(0, 12, 0, 86)
keyBox.BackgroundColor3 = Color3.fromRGB(39, 32, 49)
keyBox.BorderSizePixel = 0
keyBox.PlaceholderText = "Enter key..."
keyBox.Text = ""
keyBox.ClearTextOnFocus = false
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.PlaceholderColor3 = Color3.fromRGB(165, 151, 181)
keyBox.TextSize = 13
keyBox.Font = Enum.Font.Gotham
keyBox.Parent = content
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 7)

local status = label(content, "Status", "Enter the key to unlock Rage controls.",
    UDim2.new(1, -24, 0, 30), UDim2.new(0, 12, 0, 130), 11,
    Color3.fromRGB(193, 178, 209))

local unlockButton = button(content, "UnlockButton", "Unlock",
    UDim2.new(1, -24, 0, 36), UDim2.new(0, 12, 0, 164))

local rageToggle = button(content, "RageModeToggle", "RageMode: OFF",
    UDim2.new(1, -24, 0, 40), UDim2.new(0, 12, 0, 164))
rageToggle.Visible = false

local antiAfkToggle = button(content, "AntiAFKToggle", "ANTI-AFK: OFF",
    UDim2.new(1, -24, 0, 40), UDim2.new(0, 12, 0, 164))
antiAfkToggle.Visible = false
local antiAfkInfo = label(content, "AntiAFKInfo",
    "This toggle is a UI setting only. It does not simulate clicks or prevent Roblox's idle kick.",
    UDim2.new(1, -24, 0, 54), UDim2.new(0, 12, 0, 210), 11,
    Color3.fromRGB(193, 178, 209))
antiAfkInfo.Visible = false
local antiAfkEnabled = false

-- Visual-only 10/10 panel. Do not enter real account tokens here.
local testInfo = label(content, "TestInfo",
    "UI MOCKUP ONLY. Do not paste real tokens; fields are not sent or saved.",
    UDim2.new(1, -24, 0, 32), UDim2.new(0, 12, 0, 8), 10,
    Color3.fromRGB(193, 178, 209))
testInfo.Visible = false

local tokenFields = {}
for i = 1, 10 do
    local col = (i - 1) % 2
    local row = math.floor((i - 1) / 2)
    local field = Instance.new("TextBox")
    field.Name = "DemoTokenField" .. i
    field.Size = UDim2.new(0.48, 0, 0, 26)
    field.Position = UDim2.new(col * 0.52, 0, 0, 44 + row * 30)
    field.BackgroundColor3 = Color3.fromRGB(39, 32, 49)
    field.BorderSizePixel = 0
    field.PlaceholderText = "Demo slot " .. i .. " (no real token)"
    field.Text = ""
    field.ClearTextOnFocus = false
    field.TextColor3 = Color3.new(1, 1, 1)
    field.PlaceholderColor3 = Color3.fromRGB(165, 151, 181)
    field.TextSize = 10
    field.Font = Enum.Font.Gotham
    field.Parent = content
    Instance.new("UICorner", field).CornerRadius = UDim.new(0, 6)
    field.Visible = false
    tokenFields[i] = field
end

local launchPreview = button(content, "LaunchPreviewButton", "Launch Preview (UI only)",
    UDim2.new(1, -24, 0, 32), UDim2.new(0, 12, 0, 202))
launchPreview.Visible = false
launchPreview.MouseButton1Click:Connect(function()
    status.Text = "Preview only — no accounts are connected or launched."
end)


local function showRageCategory()
    activeCategory = "Rage"
    rageCategory.BackgroundColor3 = Color3.fromRGB(105, 58, 142)
    antiAfkCategory.BackgroundColor3 = Color3.fromRGB(75, 49, 99)
    status.Visible = true
    keyBox.Visible = not unlocked
    unlockButton.Visible = not unlocked
    rageToggle.Visible = unlocked
    antiAfkToggle.Visible = false
    antiAfkInfo.Visible = false
    testInfo.Visible = false
    launchPreview.Visible = false
    for _, field in ipairs(tokenFields) do field.Visible = false end
    testCategory.BackgroundColor3 = Color3.fromRGB(75, 49, 99)
    if unlocked then
        status.Position = UDim2.new(0, 12, 0, 130)
        status.Text = "Rage tab selected. Toggle is visual-only."
    else
        status.Text = "Enter the key to unlock panel controls."
    end
end

local function showAntiAFKCategory()
    activeCategory = "ANTI-AFK"
    rageCategory.BackgroundColor3 = Color3.fromRGB(75, 49, 99)
    antiAfkCategory.BackgroundColor3 = Color3.fromRGB(105, 58, 142)
    status.Visible = true
    keyBox.Visible = not unlocked
    unlockButton.Visible = not unlocked
    rageToggle.Visible = false
    antiAfkToggle.Visible = unlocked
    antiAfkInfo.Visible = unlocked
    testInfo.Visible = false
    launchPreview.Visible = false
    for _, field in ipairs(tokenFields) do field.Visible = false end
    testCategory.BackgroundColor3 = Color3.fromRGB(75, 49, 99)
    status.Position = UDim2.new(0, 12, 0, 130)
    if unlocked then
        status.Text = "ANTI-AFK category selected."
    else
        status.Text = "Enter the key to unlock panel controls."
    end
end

local function showTestCategory()
    activeCategory = "10/10"
    rageCategory.BackgroundColor3 = Color3.fromRGB(75, 49, 99)
    antiAfkCategory.BackgroundColor3 = Color3.fromRGB(75, 49, 99)
    testCategory.BackgroundColor3 = Color3.fromRGB(105, 58, 142)
    status.Visible = true
    keyBox.Visible = not unlocked
    unlockButton.Visible = not unlocked
    rageToggle.Visible = false
    antiAfkToggle.Visible = false
    antiAfkInfo.Visible = false
    testInfo.Visible = unlocked
    launchPreview.Visible = unlocked
    for _, field in ipairs(tokenFields) do field.Visible = unlocked end
    status.Position = UDim2.new(0, 12, 0, 130)
    status.Text = unlocked and "10/10 preview selected. UI only." or "Enter the key to unlock panel controls."
end

rageCategory.MouseButton1Click:Connect(showRageCategory)
antiAfkCategory.MouseButton1Click:Connect(showAntiAFKCategory)
testCategory.MouseButton1Click:Connect(showTestCategory)

unlockButton.MouseButton1Click:Connect(function()
    if keyBox.Text == ACCESS_KEY then
        unlocked = true
        keyBox.Visible = false
        unlockButton.Visible = false
        if activeCategory == "10/10" then
            testInfo.Visible = true
            launchPreview.Visible = true
            for _, field in ipairs(tokenFields) do field.Visible = true end
            rageToggle.Visible = false
            antiAfkToggle.Visible = false
            antiAfkInfo.Visible = false
            status.Text = "10/10 preview unlocked. UI only; no accounts launched."
        elseif activeCategory == "ANTI-AFK" then
            antiAfkToggle.Visible = true
            antiAfkInfo.Visible = true
            rageToggle.Visible = false
            status.Text = "ANTI-AFK category unlocked. UI setting only."
        else
            rageToggle.Visible = true
            antiAfkToggle.Visible = false
            antiAfkInfo.Visible = false
            status.Text = "Rage category unlocked. Toggle is visual-only."
        end
    else
        status.Text = "Incorrect key. Try again."
    end
end)

rageToggle.MouseButton1Click:Connect(function()
    rageEnabled = not rageEnabled
    if rageEnabled then
        rageToggle.Text = "RageMode: ON"
        rageToggle.BackgroundColor3 = Color3.fromRGB(148, 47, 83)
        status.Text = "RageMode ON (visual toggle only)."
    else
        rageToggle.Text = "RageMode: OFF"
        rageToggle.BackgroundColor3 = Color3.fromRGB(75, 49, 99)
        status.Text = "RageMode OFF."
    end
end)

antiAfkToggle.MouseButton1Click:Connect(function()
    antiAfkEnabled = not antiAfkEnabled
    if antiAfkEnabled then
        antiAfkToggle.Text = "ANTI-AFK: ON"
        antiAfkToggle.BackgroundColor3 = Color3.fromRGB(148, 47, 83)
        status.Text = "ANTI-AFK UI setting ON; no automated input is sent."
    else
        antiAfkToggle.Text = "ANTI-AFK: OFF"
        antiAfkToggle.BackgroundColor3 = Color3.fromRGB(75, 49, 99)
        status.Text = "ANTI-AFK UI setting OFF."
    end
end)

-- Drag the window using the top bar on mouse or touch.
local dragging, dragInput, dragStart, startPosition
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
        main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
    end
end)

showRageCategory()
