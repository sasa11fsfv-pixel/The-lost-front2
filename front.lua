local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local http = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local function showKeyMenu()
    local Window = Library.CreateLib("The Lost Front | Access", "Ocean")
    local Home = Window:NewTab("Welcome")
    local Section = Home:NewSection("Copy Discord: https://discord.gg/fxPe9TZYM7")
    local keyInput

    Section:NewButton("Copy Discord", "Copy Link", function()
        setclipboard("https://discord.gg/fxPe9TZYM7")
    end)

    Section:NewTextBox("Enter Key", "Paste key then click Confirm", function(txt)
        keyInput = txt
    end)

    Section:NewButton("Confirm Key", "Confirm key for access", function()
        if keyInput == "NewLokivichPirdkey" then
            Library:Notify("Access Granted!", function()
                Window:Close()
                showMainCheat()
            end)
        else
            Library:Notify("Wrong Key, try again!")
        end
    end)
end

function showMainCheat()
    local MainWindow = Library.CreateLib("The Lost Front | Cheat", "BloodTheme")
    local ESP = MainWindow:NewTab("ESP")
    local Aimbot = MainWindow:NewTab("Aimbot")
    local Misc = MainWindow:NewTab("Misc")

    ESP:NewLabel("ESP options coming soon!")
    Aimbot:NewLabel("Aimbot options coming soon!")
    Misc:NewLabel("Misc options coming soon!")
end

local menuOpen = false

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightShift then
        menuOpen = not menuOpen
        if menuOpen then
            showMainCheat()
        else
            Library:Notify("Menu closed. Press Right Shift again to reopen.")
        end
    end
end)

showKeyMenu()
