local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
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
                showMainESP()
            end)
        else
            Library:Notify("Wrong Key, try again!")
        end
    end)
end

function showMainESP()
    local MainWindow = Library.CreateLib("The Lost Front | ESP ONLY", "BloodTheme")
    local ESP = MainWindow:NewTab("ESP")
    ESP:NewLabel("ESP options coming soon!")
end

local menuOpen = false

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightShift then
        menuOpen = not menuOpen
        if menuOpen then
            showMainESP()
        else
            Library:Notify("Menu closed. Press Right Shift again to reopen.")
        end
    end
end)

showKeyMenu()
