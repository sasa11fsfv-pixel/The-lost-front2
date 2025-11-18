local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local DISCORD_LINK = "https://discord.gg/fxPe9TZYM7"
local KEY = "NewLokivichPirdkey"

local mainCheatGui, mainCheatFrame

local function tweenFrameColors(frame, bg_from, bg_to, duration)
    frame.BackgroundColor3 = bg_from
    TweenService:Create(frame, TweenInfo.new(duration, Enum.EasingStyle.Sine), {BackgroundColor3 = bg_to}):Play()
end

local function createDiscordMenu(callbackNext)
    local gui = Instance.new("ScreenGui")
    gui.Name = "FrontDiscordMenu"
    gui.Parent = player:WaitForChild("PlayerGui")
    gui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(42, 43, 45)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 18)
    corner.Parent = frame
    
    local function createLabel(text, y, props)
        local lbl = Instance.new("TextLabel")
        lbl.Text = text
        lbl.TextColor3 = props and props.color or Color3.fromRGB(26, 27, 30)
        lbl.TextScaled = true
        lbl.BackgroundTransparency = 1
        lbl.Size = UDim2.new(1, -36, 0, 38)
        lbl.Position = UDim2.new(0, 18, 0, y)
        lbl.Font = Enum.Font.GothamBlack
        lbl.Parent = frame
        return lbl
    end
    
    createLabel("Welcome!", 14, {color=Color3.fromRGB(255,255,255)})
    createLabel("Copy our Discord for access and news.", 60, {color=Color3.fromRGB(180,200,220)})
    
    local discordBtn = Instance.new("TextButton")
    discordBtn.Text = "Copy Discord"
    discordBtn.Size = UDim2.new(1, -40, 0, 38)
    discordBtn.Position = UDim2.new(0, 20, 0, 108)
    discordBtn.BackgroundColor3 = Color3.fromRGB(56, 81, 160)
    discordBtn.TextColor3 = Color3.fromRGB(255,255,255)
    discordBtn.Font = Enum.Font.GothamBold
    discordBtn.TextScaled = true
    discordBtn.Parent = frame
    Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0, 9)

    local nextBtn = Instance.new("TextButton")
    nextBtn.Text = "Next"
    nextBtn.Size = UDim2.new(1, -140, 0, 34)
    nextBtn.Position = UDim2.new(0, 70, 0, 160)
    nextBtn.BackgroundColor3 = Color3.fromRGB(124, 134, 164)
    nextBtn.TextColor3 = Color3.fromRGB(30, 35, 48)
    nextBtn.Font = Enum.Font.GothamBold
    nextBtn.TextScaled = true
    nextBtn.Parent = frame
    Instance.new("UICorner", nextBtn).CornerRadius = UDim.new(0, 7)

    frame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size=UDim2.new(0, 370, 0, 225)}):Play()
    
    discordBtn.MouseButton1Click:Connect(function()
        setclipboard(DISCORD_LINK)
        StarterGui:SetCore("SendNotification", { Title = "Done!", Text = "Link copied", Duration = 2 })
    end)
    nextBtn.MouseButton1Click:Connect(function()
        TweenService:Create(frame, TweenInfo.new(0.44, Enum.EasingStyle.Quad), {BackgroundTransparency=1, Size=UDim2.new(0,0,0,0)}):Play()
        wait(0.44)
        gui:Destroy()
        callbackNext()
    end)
end

local function createKeyMenu(callbackNext)
    local gui = Instance.new("ScreenGui")
    gui.Name = "FrontKeyMenu"
    gui.Parent = player:WaitForChild("PlayerGui")
    gui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(27, 37, 66)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 18)
    corner.Parent = frame

    
    frame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(frame, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {Size=UDim2.new(0, 370, 0, 190)}):Play()
    tweenFrameColors(frame, Color3.fromRGB(25,32,48), Color3.fromRGB(27, 37, 66), 0.38)

    local label = Instance.new("TextLabel")
    label.Text = "Enter your key for access"
    label.TextColor3 = Color3.fromRGB(140, 180, 255)
    label.TextScaled = true
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0,18,0,20)
    label.Size = UDim2.new(1, -36, 0, 36)
    label.Font = Enum.Font.GothamBold
    label.Parent = frame
    
    local keyBox = Instance.new("TextBox")
    keyBox.PlaceholderText = "Key..."
    keyBox.Size = UDim2.new(1, -40, 0, 36)
    keyBox.Position = UDim2.new(0, 20, 0, 70)
    keyBox.BackgroundColor3 = Color3.fromRGB(20, 30, 55)
    keyBox.TextColor3 = Color3.fromRGB(200,210,255)
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextScaled = true
    keyBox.Parent = frame
    Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 7)

    local confirmBtn = Instance.new("TextButton")
    confirmBtn.Text = "Check key"
    confirmBtn.Size = UDim2.new(0.67, 0, 0, 36)
    confirmBtn.Position = UDim2.new(0.165, 0, 1, -46)
    confirmBtn.AnchorPoint = Vector2.new(0, 0)
    confirmBtn.BackgroundColor3 = Color3.fromRGB(80, 135, 235)
    confirmBtn.TextColor3 = Color3.fromRGB(230, 245, 255)
    confirmBtn.Font = Enum.Font.GothamBold
    confirmBtn.TextScaled = true
    confirmBtn.Parent = frame
    Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0, 7)

    local info = Instance.new("TextLabel")
    info.Text = ""
    info.Size = UDim2.new(1, -36, 0, 26)
    info.Position = UDim2.new(0, 18, 1, -28)
    info.BackgroundTransparency = 1
    info.TextScaled = true
    info.Font = Enum.Font.Gotham
    info.TextColor3 = Color3.fromRGB(255, 130, 130)
    info.Parent = frame

    confirmBtn.MouseButton1Click:Connect(function()
        if keyBox.Text == KEY then
            StarterGui:SetCore("SendNotification", { Title = "Key accepted", Text = "Success!", Duration = 2 })
            gui:Destroy()
            callbackNext()
        else
            info.Text = "Wrong key."
        end
    end)
end

local function createMainMenu()
    mainCheatGui = Instance.new("ScreenGui")
    mainCheatGui.Name = "FrontCheatGui_MainMenu"
    mainCheatGui.Parent = player:WaitForChild("PlayerGui")
    mainCheatGui.ResetOnSpawn = false
    mainCheatFrame = Instance.new("Frame")
    mainCheatFrame.Size = UDim2.new(0, 420, 0, 280)
    mainCheatFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainCheatFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainCheatFrame.BackgroundColor3 = Color3.fromRGB(33,42,65)
    mainCheatFrame.BorderSizePixel = 0
    mainCheatFrame.Active = true
    mainCheatFrame.Draggable = true
    mainCheatFrame.Visible = true
    mainCheatFrame.Parent = mainCheatGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 17)
    corner.Parent = mainCheatFrame

    local label = Instance.new("TextLabel")
    label.Text = "The Lost Front | Cheat Menu"
    label.TextColor3 = Color3.fromRGB(180, 220, 255)
    label.TextScaled = true
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 18)
    label.Size = UDim2.new(1, -20, 0, 34)
    label.Font = Enum.Font.GothamBold
    label.Parent = mainCheatFrame

    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(1, -24, 0, 2)
    sep.Position = UDim2.new(0, 12, 0, 62)
    sep.BackgroundColor3 = Color3.fromRGB(67,90,140)
    sep.BorderSizePixel = 0
    sep.Parent = mainCheatFrame
    Instance.new("UICorner", sep).CornerRadius = UDim.new(0, 1)

    local content = Instance.new("TextLabel")
    content.Text = "ESP, Aimbot, and Misc tabs here."
    content.TextColor3 = Color3.fromRGB(220, 225, 235)
    content.TextScaled = true
    content.BackgroundTransparency = 1
    content.Position = UDim2.new(0, 18, 0, 80)
    content.Size = UDim2.new(1, -36, 1, -96)
    content.Font = Enum.Font.Gotham
    content.Parent = mainCheatFrame
end


UserInputService.InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.RightShift and not processed then
        if mainCheatFrame and mainCheatFrame.Parent then
            mainCheatFrame.Visible = not mainCheatFrame.Visible
        end
    end
end)


createDiscordMenu(function()
    createKeyMenu(function()
        createMainMenu()
    end)
end)


