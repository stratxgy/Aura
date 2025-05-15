local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Aura | Universal                                        by Stratxgy',
    Center = true, -- Set Center to true if you want the menu to appear in the center
    AutoShow = true, -- Set AutoShow to true if you want the menu to appear when it is created
    TabPadding = 8,
    MenuFadeTime = 0.2
    --Position = float (optional)
    --Size = float (optional)
})

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Aura/refs/heads/main/Modules/ESP/ESP.lua"))()
local hbar = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Aura/refs/heads/main/Modules/ESP/hbar.lua"))()
local viewtracer = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Aura/refs/heads/main/Modules/ESP/ViewTracerESP.lua"))()
local pname = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Aura/refs/heads/main/Modules/ESP/pname.lua"))()
local ptool = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Aura/refs/heads/main/Modules/ESP/ptool.lua"))()
local chams = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Roblox-Chams-Highlight/refs/heads/main/Highlight.lua"))()
local targethud = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Lua-TargetHud/refs/heads/main/targethud.lua"))()

local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/esp-aimbot/refs/heads/main/Aimbot/aimbot.lua"))()
local triggerbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Roblox-Lua-Triggerbot/refs/heads/main/Triggerbot.lua"))()

local speed = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Lua-Speed/refs/heads/main/speed.lua"))()
local spin = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Aura/refs/heads/main/Modules/spinlock.lua"))()
local aaimweld = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Aura/refs/heads/main/Modules/aaimweld.lua"))()



local Tabs = {
    aimbot = Window:AddTab('Aimbot'),
    visuals = Window:AddTab('Visuals'),
    player = Window:AddTab('Player'),
    ['UI Settings'] = Window:AddTab('UI Settings')
}

local LeftGroupBox = Tabs.aimbot:AddLeftGroupbox('Aimbot')

LeftGroupBox:AddToggle('Aimbot', {
    Text = 'Aimbot',
    Default = false, -- Default value (true / false)
    Tooltip = 'turns on aimbot i think', -- Information shown when you hover over the toggle
    Callback = function(Value)
        Aimbot.Load()
    end
})

LeftGroupBox:AddDropdown('Lock Part', {
    Values = { 'Head', 'HumanoidRootPart', 'UpperTorso', 'LowerTorso' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    Text = 'Lock Part',
    Tooltip = 'lockpart changer', -- Information shown when you hover over the dropdown
    Callback = function(Value)
        getgenv().Aimbot.Settings.LockPart = Value
    end
})



LeftGroupBox:AddLabel('Lock Button'):AddKeyPicker('Lock Button', {
    Default = 'MB2', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    Text = 'Lock Button Keybind', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu
    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        getgenv().Aimbot.Settings.TriggerKey = New
    end
})


LeftGroupBox:AddSlider('FOV', {
    Text = 'FOV Circle',
    Default = 35,
    Min = 0,
    Max = 500,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().Aimbot.FOVSettings.Radius = Value
    end
})

LeftGroupBox:AddLabel('FOVColor'):AddColorPicker('FOV Color', {
    Default = Color3.new(1, 1, 1),
    Title = 'FOV Colorpicker', -- Optional. Allows you to have a custom color picker title (when you open it)
    Callback = function(Value)
        getgenv().Aimbot.FOVSettings.Color = Value
    end
})

LeftGroupBox:AddLabel('FOV Color when Locked'):AddColorPicker('FOV Color when Locked', {
    Default = Color3.new(1, 0, 0), 
    Title = 'FOV Colorpicker when locked', -- Optional. Allows you to have a custom color picker title (when you open it)
    Callback = function(Value)
        getgenv().Aimbot.FOVSettings.LockedColor = Value
    end
})

LeftGroupBox:AddSlider('Smoothness (lower = faster)', {
    Text = 'Smoothness (lower = faster)',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().Aimbot.Settings.Sensitivity = Value
    end
})



local LeftGroupBox = Tabs.aimbot:AddLeftGroupbox('Triggerbot')


local tbot = LeftGroupBox:AddButton({
    Text = 'TriggerBot',
    Func = function()
        getgenv().triggerbot.load()
    end,
    DoubleClick = false,
    Tooltip = 'probably turns on a triggerbot' -- When you hover over the button this appears
})


LeftGroupBox:AddLabel('TriggerBot Toggle Key'):AddKeyPicker('TriggerBot Toggle Key', {

    Default = 'T', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,

    Text = 'TriggerBot Toggle Key', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        getgenv().triggerbot.Settings.toggleKey = New
    end
})

LeftGroupBox:AddSlider('Click Delay (Seconds)', {
    Text = 'Click Delay (Seconds)',
    Default = 0,
    Min = 0,
    Max = 2,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().triggerbot.Settings.clickDelay = Value
    end
})




local RightGroupBox = Tabs.aimbot:AddRightGroupbox('Checks')

RightGroupBox:AddToggle('TeamCheck', {
    Text = 'Team Check',
    Default = false, -- Default value (true / false)
    Tooltip = 'checks if a player is on your team', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().Aimbot.Settings.TeamCheck = Value
    end
})

RightGroupBox:AddToggle('Wall Check', {
    Text = 'Wall Check',
    Default = false, -- Default value (true / false)
    Tooltip = 'checks if a player is behind a wall', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().Aimbot.Settings.WallCheck = Value
    end
})

RightGroupBox:AddToggle('AliveCheck', {
    Text = 'Alive Check',
    Default = false, -- Default value (true / false)
    Tooltip = 'checks if a player is alive', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().Aimbot.Settings.AliveCheck = Value
    end
})

RightGroupBox:AddToggle('Aimbot Toggle (hold / toggle)', {
    Text = 'Aimbot Toggle (hold / toggle)',
    Default = false, -- Default value (true / false)
    Tooltip = 'if its false that means you have to hold the button if true its toggle', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().Aimbot.Settings.Toggle = Value
    end
})


--// ////// \\\\\\ //////// \\\\\\\\ //////// \\\\\\\ /////// \\\\\\\ /////// \\\\\\\           | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | 


local LeftGroupBox = Tabs.visuals:AddLeftGroupbox('Healthbar')

LeftGroupBox:AddToggle('Health Bar', {
    Text = 'Health Bar',
    Default = false, -- Default value (true / false)
    Tooltip = 'hopefully toggles health bar', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().hbar.enabled = Value
    end
})

local LeftGroupBox = Tabs.visuals:AddLeftGroupbox('Target Hud')

LeftGroupBox:AddToggle('Target Hud', {
    Text = 'Target Hud',
    Default = false, -- Default value (true / false)
    Tooltip = 'turns on a box displaying information when you hover over people', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().targethud.enabled = Value
    end
})

local LeftGroupBox = Tabs.visuals:AddLeftGroupbox('Menu Settings')

LeftGroupBox:AddToggle('Aura Watermark', { 
    Text = 'Aura Watermark', 
    Default = false, 
    Tooltip = 'Aura watermark', 
    Callback = function(Value)
        if Value then
            Library:SetWatermarkVisibility(true)
            if not _G.WatermarkConnection then
                local FrameTimer = tick()
                local FrameCounter = 0
                local FPS = 60
                _G.WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
                    FrameCounter += 1
                    if (tick() - FrameTimer) >= 1 then
                        FPS = FrameCounter
                        FrameTimer = tick()
                        FrameCounter = 0
                    end
                    Library:SetWatermark(('Aura - Universal | %s fps | %s ms'):format(
                        math.floor(FPS),
                        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
                    ))
                end)
            end
        else
            Library:SetWatermarkVisibility(false)
            if _G.WatermarkConnection then
                _G.WatermarkConnection:Disconnect()
                _G.WatermarkConnection = nil
            end
        end
    end
})
-- wow that was confusing


LeftGroupBox:AddToggle('Aura Keybind Window', {
    Text = 'Aura Keybind Window',
    Default = false, -- Default value (true / false)
    Tooltip = 'this probably works correctly', -- Information shown when you hover over the toggle
    Callback = function(Value)
        Library.KeybindFrame.Visible = Value;
    end
})



local RightGroupBox = Tabs.visuals:AddRightGroupbox('Chams')

RightGroupBox:AddToggle('Chams', {
    Text = 'Chams',
    Default = false, -- Default value (true / false)
    Tooltip = 'basically outline esp', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().chams.enabled = Value
    end
})

RightGroupBox:AddToggle('Chams Team Check', {
    Text = 'Chams Team Check',
    Default = false, -- Default value (true / false)
    Tooltip = 'checks if a player is on your team', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().chams.teamCheck = Value
    end
})

RightGroupBox:AddLabel('Chams Outline Color'):AddColorPicker('Chams Outline Color', {
    Default = Color3.new(1, 1, 1), 
    Title = 'Chams Outline Color Colorpicker', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    Callback = function(Value)
        getgenv().chams.outlineColor = Value
    end
})

RightGroupBox:AddSlider('Chams Outline Transparency', {
    Text = 'Chams Outline Transparency',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().chams.outlineTransparency = Value
    end
})


RightGroupBox:AddLabel('Chams Fill Color'):AddColorPicker('Chams Fill Color', {
    Default = Color3.new(1, 0, 0), 
    Title = 'Chams Fill Color Colorpicker', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    Callback = function(Value)
        getgenv().chams.fillColor = Value
    end
})


RightGroupBox:AddSlider('Chams Fill Transparency', {
    Text = 'Chams Fill Transparency',
    Default = 1,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().chams.fillTransparency = Value
    end
})


--// PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB PLAYERTAB 
local LeftGroupBox = Tabs.player:AddLeftGroupbox('Speed')

LeftGroupBox:AddToggle('Speed Master Switch', {
    Text = 'Speed Master Switch',
    Default = false, -- Default value (true / false)
    Tooltip = 'sped', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().speed.enabled = Value
    end
})

LeftGroupBox:AddLabel('Speed Toggle Button'):AddKeyPicker('Speed Toggle Button', {
    Default = 'KeypadDivide', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    Text = 'Lock Button Keybind', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu
    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        getgenv().speed.keybind = New
    end
})

LeftGroupBox:AddSlider('Speed Amount', {
    Text = 'Speed Amount',
    Default = 16,
    Min = 1,
    Max = 300,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().speed.speed = Value
    end
})

LeftGroupBox:AddToggle('Enhanced Control', {
    Text = 'Enhanced Control',
    Default = false, -- Default value (true / false)
    Tooltip = 'Usually you slide all around, but this makes you not do that', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().speed.control = Value
    end
})

LeftGroupBox:AddSlider('Control Amount (Friction)', {
    Text = 'Control Amount (Friction)',
    Default = 2.0,
    Min = 1,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().speed.friction = Value
    end
})



local function convertToKeyCode(input)
    local keyMappings = {
        LeftAlt = Enum.KeyCode.LeftAlt
    }
    return keyMappings[input] or input
end

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'LeftAlt', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('Aura')
SaveManager:SetFolder('Aura/Da Hood')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()
