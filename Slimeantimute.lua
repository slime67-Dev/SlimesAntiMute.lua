
-- SERVICES
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")

-- PLAYER
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- SETTINGS
local currentMode = "cuck"
local discordInvite = "https://discord.gg/Nts4v6PPT"

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "Slime anti mute"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- MAIN FRAME
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 225)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -112)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(35, 170, 90)
title.Text = "Slime anti mute"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = mainFrame

-- INPUT
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -20, 0, 35)
inputBox.Position = UDim2.new(0, 10, 0, 50)
inputBox.PlaceholderText = "Input message..."
inputBox.Text = ""
inputBox.TextSize = 14
inputBox.Font = Enum.Font.Gotham
inputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.Parent = mainFrame

-- MODE BUTTON
local modeButton = Instance.new("TextButton")
modeButton.Size = UDim2.new(1, -20, 0, 30)
modeButton.Position = UDim2.new(0, 10, 0, 95)
modeButton.Text = "Mode: " .. currentMode
modeButton.Font = Enum.Font.GothamBold
modeButton.TextSize = 13
modeButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
modeButton.TextColor3 = Color3.new(1, 1, 1)
modeButton.Parent = mainFrame

modeButton.MouseButton1Click:Connect(function()
    currentMode = currentMode == "cuck" and "fuck" or "cuck"
    modeButton.Text = "Mode: " .. currentMode
end)

-- EXECUTE BUTTON
local executeButton = Instance.new("TextButton")
executeButton.Size = UDim2.new(1, -20, 0, 35)
executeButton.Position = UDim2.new(0, 10, 0, 135)
executeButton.Text = "EXECUTE"
executeButton.Font = Enum.Font.GothamBold
executeButton.TextSize = 14
executeButton.BackgroundColor3 = Color3.fromRGB(35, 170, 90)
executeButton.TextColor3 = Color3.new(1, 1, 1)
executeButton.Parent = mainFrame

executeButton.MouseButton1Click:Connect(function()
    local message = inputBox.Text
    if message == "" then return end

    local formattedMessage =
        "🪟🪟🪟||| " .. message .. " |||🪟🪟🪟" .. currentMode

    local channel =
        TextChatService.TextChannels:FindFirstChild("RBXGeneral")

    if channel then
        channel:SendAsync(formattedMessage)
    end
end)

-- DISCORD INVITE
local inviteBox = Instance.new("TextBox")
inviteBox.Size = UDim2.new(0, 175, 0, 25)
inviteBox.Position = UDim2.new(0, 10, 0, 185)
inviteBox.Text = "discord.gg/Nts4v6PPT"
inviteBox.ClearTextOnFocus = false
inviteBox.TextEditable = false
inviteBox.TextSize = 11
inviteBox.Font = Enum.Font.Gotham
inviteBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
inviteBox.TextColor3 = Color3.new(1, 1, 1)
inviteBox.Parent = mainFrame

-- COPY BUTTON
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0, 75, 0, 25)
copyButton.Position = UDim2.new(1, -85, 0, 185)
copyButton.Text = "COPY"
copyButton.TextSize = 12
copyButton.Font = Enum.Font.GothamBold
copyButton.BackgroundColor3 = Color3.fromRGB(35, 170, 90)
copyButton.TextColor3 = Color3.new(1, 1, 1)
copyButton.Parent = mainFrame

copyButton.MouseButton1Click:Connect(function()
    if typeof(setclipboard) == "function" then
        setclipboard(discordInvite)
        copyButton.Text = "COPIED!"
    else
        copyButton.Text = "UNAVAILABLE"
    end
end)

-- OPEN / CLOSE TOGGLE
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 90, 0, 35)
toggleButton.Position = UDim2.new(0, 15, 0.5, 0)
toggleButton.Text = "CLOSE"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 14
toggleButton.BackgroundColor3 = Color3.fromRGB(35, 170, 90)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Parent = gui

toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    toggleButton.Text = mainFrame.Visible and "CLOSE" or "OPEN"
end)

-- DRAGGABLE WINDOW
local dragging = false
local dragStart
local startPosition

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        mainFrame.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
