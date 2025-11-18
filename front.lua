local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local DISCORD_LINK = "https://discord.gg/fxPe9TZYM7"
local KEY = "NewLokivichPirdkey"

local mainCheatGui, mainCheatFrame, tabHighlight, tabButtons, contentFrames
local BLOOD = Color3.fromRGB(140,20,34)
local BLOOD_DARK = Color3.fromRGB(56,22,38)
local SIDE_BG = Color3.fromRGB(33,18,25)

-- ESP STATE
local espEnabled = false
local enemyColor = Color3.fromRGB(120,120,255)  -- синий по дефолту
local allyColor = Color3.fromRGB(48,210,108)
local espBoxes = {}
local espUpdateConnection = nil

local function tweenFrameColors(frame, bg_from, bg_to, duration)
    frame.BackgroundColor3 = bg_from
    TweenService:Create(frame, TweenInfo.new(duration, Enum.EasingStyle.Sine), {BackgroundColor3 = bg_to}):Play()
end

local function createDiscordMenu(callbackNext)
    local gui = Instance.new("ScreenGui")
    gui.Name = "ZenwareDiscord"
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
    gui.Name = "ZenwareKey"
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

-- Исправленный ESP с кэшем
local function clearESP()
    for _,v in ipairs(espBoxes) do if v then v:Destroy() end end
    espBoxes = {}
end

local function updateESP()
    clearESP()
    for _,pl in ipairs(Players:GetPlayers()) do
        if pl ~= player and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and pl.Team ~= nil then
            local isEnemy = player.Team and (pl.Team ~= player.Team)
            local color = isEnemy and enemyColor or allyColor
            local box = Instance.new("BoxHandleAdornment")
            box.Adornee = pl.Character.HumanoidRootPart
            box.Size = Vector3.new(4, 7, 3)
            box.AlwaysOnTop = true
            box.ZIndex = 15
            box.Transparency = 0.08
            box.Color3 = color
            box.Parent = workspace.CurrentCamera
            table.insert(espBoxes, box)
        end
    end
end

local function startESP()
    clearESP()
    espEnabled = true
    if espUpdateConnection then espUpdateConnection:Disconnect() end
    espUpdateConnection = RunService.RenderStepped:Connect(updateESP)
end

local function stopESP()
    espEnabled = false
    clearESP()
    if espUpdateConnection then espUpdateConnection:Disconnect() espUpdateConnection = nil end
end

local function toggleESP(btn)
    if not espEnabled then
        btn.Text = "Disable ESP"
        startESP()
    else
        btn.Text = "Enable ESP"
        stopESP()
    end
end

local function colorToString(c)
    return string.format("R:%d G:%d B:%d", math.floor(c.r*255), math.floor(c.g*255), math.floor(c.b*255))
end

local function createMainMenu()
    mainCheatGui = Instance.new("ScreenGui")
    mainCheatGui.Name = "ZenwareMainMenu"
    mainCheatGui.Parent = player:WaitForChild("PlayerGui")
    mainCheatGui.ResetOnSpawn = false
    mainCheatFrame = Instance.new("Frame")
    mainCheatFrame.Size = UDim2.new(0, 800, 0, 500)
    mainCheatFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainCheatFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainCheatFrame.BackgroundColor3 = BLOOD_DARK
    mainCheatFrame.BorderSizePixel = 0
    mainCheatFrame.Active = true
    mainCheatFrame.Draggable = true
    mainCheatFrame.Visible = true
    mainCheatFrame.Parent = mainCheatGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = mainCheatFrame

    local side = Instance.new("Frame")
    side.Size = UDim2.new(0, 180, 1, 0)
    side.Position = UDim2.new(0, 0, 0, 0)
    side.BackgroundColor3 = Color3.fromRGB(47,55,105) -- синийфон
    side.BorderSizePixel = 0
    side.Parent = mainCheatFrame
    Instance.new("UICorner", side).CornerRadius = UDim.new(0, 14)
    local logo = Instance.new("TextLabel")
    logo.Text = "Zenware\nMenu"
    logo.TextColor3 = BLOOD
    logo.TextScaled = true
    logo.BackgroundTransparency = 1
    logo.Position = UDim2.new(0, 0, 0, 20)
    logo.Size = UDim2.new(1, 0, 0, 58)
    logo.Font = Enum.Font.GothamBlack
    logo.Parent = side
    tabHighlight = Instance.new("Frame")
    tabHighlight.Size = UDim2.new(1, -8, 0, 56)
    tabHighlight.Position = UDim2.new(0, 4, 0, 32)
    tabHighlight.BackgroundColor3 = BLOOD
    tabHighlight.BackgroundTransparency = 0.18
    tabHighlight.BorderSizePixel = 0
    tabHighlight.Parent = side
    Instance.new("UICorner", tabHighlight).CornerRadius = UDim.new(0, 12)
    local tabNames = {"ESP", "AIMBOT", "MISC"}
    tabButtons = {}
    for i, name in ipairs(tabNames) do
        local btn = Instance.new("TextButton")
        btn.Text = name
        btn.Size = UDim2.new(1, -16, 0, 56)
        btn.Position = UDim2.new(0, 8, 0, 32 + (i - 1) * 70)
        btn.BackgroundTransparency = 0.18
        btn.BackgroundColor3 = Color3.fromRGB(34,50,120)
        btn.TextColor3 = i==1 and Color3.fromRGB(255,255,255) or Color3.fromRGB(222,230,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextStrokeTransparency = .7
        btn.TextScaled = true
        btn.Name = "Tab"..i
        btn.ZIndex = 11
        btn.Parent = side
        table.insert(tabButtons, btn)
        btn.MouseButton1Click:Connect(function()
            for n, tbtn in ipairs(tabButtons) do
              tbtn.TextColor3 = n == i and Color3.fromRGB(255,255,255) or Color3.fromRGB(222,230,255)
              tbtn.Font = Enum.Font.GothamBold
            end
            switchTab(i)
        end)
    end
    contentFrames = {}
    for i, name in ipairs(tabNames) do
        local cf = Instance.new("Frame")
        cf.BackgroundTransparency = 1
        cf.Size = UDim2.new(1, -180, 1, 0)
        cf.Position = UDim2.new(0, 180, 0, 0)
        cf.Visible = false
        cf.Parent = mainCheatFrame
        table.insert(contentFrames, cf)
        local title = Instance.new("TextLabel")
        title.Text = "Zenware | " .. name .. " Options"
        title.TextColor3 = Color3.fromRGB(255, 51 + (i-1)*60, 60 + (i-1)*60)
        title.TextScaled = true
        title.BackgroundTransparency = 1
        title.Position = UDim2.new(0, 0, 0, 22)
        title.Size = UDim2.new(1, 0, 0, 48)
        title.Font = Enum.Font.GothamBold
        title.Parent = cf
        if name == "ESP" then
            local mainBox = Instance.new("Frame")
            mainBox.AnchorPoint = Vector2.new(0.5,0)
            mainBox.Position = UDim2.new(0.5,0, 0,84)
            mainBox.Size = UDim2.new(0,400,0,292)
            mainBox.BackgroundColor3 = Color3.fromRGB(23,30,61)
            mainBox.BackgroundTransparency = .15
            mainBox.Parent = cf
            Instance.new("UICorner", mainBox).CornerRadius = UDim.new(0,17)
            
            local titleESPLbl = Instance.new("TextLabel")
            titleESPLbl.Text = "ESP Controls"
            titleESPLbl.Size = UDim2.new(1,0,0,38)
            titleESPLbl.Position = UDim2.new(0,0,0,16)
            titleESPLbl.BackgroundTransparency = 1
            titleESPLbl.TextColor3 = Color3.fromRGB(210,220,255)
            titleESPLbl.Font = Enum.Font.GothamBlack
            titleESPLbl.TextScaled = true
            titleESPLbl.Parent = mainBox

            local btnToggle = Instance.new("TextButton")
            btnToggle.Text = "Enable ESP"
            btnToggle.Size = UDim2.new(1, -40, 0, 54)
            btnToggle.Position = UDim2.new(0, 20, 0, 72)
            btnToggle.BackgroundColor3 = Color3.fromRGB(36,48,120)
            btnToggle.TextColor3 = Color3.fromRGB(255,255,255)
            btnToggle.Font = Enum.Font.GothamBold
            btnToggle.TextScaled = true
            btnToggle.Parent = mainBox
            Instance.new("UICorner", btnToggle).CornerRadius = UDim.new(0,12)
            btnToggle.MouseButton1Click:Connect(function() toggleESP(btnToggle) end)

            local colorBtn = Instance.new("TextButton")
            colorBtn.Text = "Enemy Colour"
            colorBtn.Size = UDim2.new(1, -40, 0, 54)
            colorBtn.Position = UDim2.new(0, 20, 0, 140)
            colorBtn.BackgroundColor3 = enemyColor
            colorBtn.TextColor3 = Color3.fromRGB(26,22,32)
            colorBtn.Font = Enum.Font.GothamBold
            colorBtn.TextScaled = true
            colorBtn.Parent = mainBox
            Instance.new("UICorner", colorBtn).CornerRadius = UDim.new(0,12)
            colorBtn.MouseButton1Click:Connect(function()
                local preset = {
                    Color3.fromRGB(120,120,255), Color3.fromRGB(210,80,210), Color3.fromRGB(180,255,60), Color3.fromRGB(60,160,255), Color3.fromRGB(255,176,30)
                }
                local idx = 1
                for i, c in ipairs(preset) do
                    if c == enemyColor then idx = i; break end
                end
                idx = idx % #preset + 1
                enemyColor = preset[idx]
                colorBtn.BackgroundColor3 = enemyColor
                if espEnabled then updateESP() end
            end)

            local allyLbl = Instance.new("TextLabel")
            allyLbl.Text = "Ally color: R:48 G:210 B:108"
            allyLbl.Size = UDim2.new(1, -22, 0, 32)
            allyLbl.Position = UDim2.new(0, 12, 0, 210)
            allyLbl.BackgroundTransparency = 1
            allyLbl.TextColor3 = allyColor
            allyLbl.Font = Enum.Font.Gotham
            allyLbl.TextScaled = true
            allyLbl.Parent = mainBox

        elseif name == "AIMBOT" or name=="MISC" then
            local mainBox = Instance.new("Frame")
            mainBox.AnchorPoint = Vector2.new(0.5,0)
            mainBox.Position = UDim2.new(0.5,0, 0,84)
            mainBox.Size = UDim2.new(0,400,0,190)
            mainBox.BackgroundColor3 = Color3.fromRGB(23,30,61)
            mainBox.BackgroundTransparency = .15
            mainBox.Parent = cf
            Instance.new("UICorner", mainBox).CornerRadius = UDim.new(0,17)

            local infoLbl = Instance.new("TextLabel")
            infoLbl.Text = name .. " features coming soon!"
            infoLbl.Size = UDim2.new(1,0,0,54)
            infoLbl.Position = UDim2.new(0,0,0,30)
            infoLbl.BackgroundTransparency = 1
            infoLbl.TextColor3 = Color3.fromRGB(220,220,255)
            infoLbl.Font = Enum.Font.GothamBlack
            infoLbl.TextScaled = true
            infoLbl.Parent = mainBox

            local stubBtn = Instance.new("TextButton")
            stubBtn.Text = "Soon available"
            stubBtn.Size = UDim2.new(1, -40, 0, 54)
            stubBtn.Position = UDim2.new(0,20,0,104)
            stubBtn.BackgroundColor3 = Color3.fromRGB(36,48,120)
            stubBtn.TextColor3 = Color3.fromRGB(255,255,255)
            stubBtn.Font = Enum.Font.GothamBold
            stubBtn.TextScaled = true
            stubBtn.Parent = mainBox
            Instance.new("UICorner", stubBtn).CornerRadius = UDim.new(0,12)
        end
    end
    contentFrames[1].Visible = true
end

function switchTab(idx)
    for i, frame in ipairs(contentFrames) do
        frame.Visible = (i == idx)
    end
    if tabHighlight and tabButtons[idx] then
        TweenService:Create(tabHighlight, TweenInfo.new(0.22, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0, 4, 0, 32 + (idx - 1) * 70),
        }):Play()
    end
end

UserInputService.InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.RightShift and not processed then
        if mainCheatFrame and mainCheatFrame.Parent then
            mainCheatFrame.Visible = not mainCheatFrame.Visible
        end
    end
end)

Players.PlayerAdded:Connect(function()
    if espEnabled then updateESP() end
end)
Players.PlayerRemoving:Connect(function()
    if espEnabled then updateESP() end
end)

createDiscordMenu(function()
    createKeyMenu(function()
        createMainMenu()
    end)
end)
