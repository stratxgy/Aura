local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Aura | Da Hood                                         by Stratxgy',
    Center = true, -- Set Center to true if you want the menu to appear in the center
    AutoShow = true, -- Set AutoShow to true if you want the menu to appear when it is created
    TabPadding = 8,
    MenuFadeTime = 0.2
    --Position = float (optional)
    --Size = float (optional)
})


loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Aura/refs/heads/main/Modules/alltheloadstrings.lua"))() -- it really is all the loadstrings
print("hi, it's stratxgy. If it sent an error like: attempt to index nil with 'visible' it's okay and it worked fine. Thanks for using my script.")


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
        getgenv().dhlock.enabled = Value
    end
})


LeftGroupBox:AddToggle('FOV Visible', {
    Text = 'FOV Visible',
    Default = false, -- Default value (true / false)
    Tooltip = 'turns on aimbot i think', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().dhlock.showfov = Value
    end
})

LeftGroupBox:AddToggle('Toggle Aimbot (hold / toggle)', {
    Text = 'Aimbot Toggle (hold / toggle)',
    Default = false, -- Default value (true / false)
    Tooltip = 'if its false that means you have to hold the button if true its toggle', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().dhlock.toggle = Value
    end
})


LeftGroupBox:AddLabel('Lock Button'):AddKeyPicker('Lock Button', {
    Default = 'MB2', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    Text = 'Lock Button Keybind', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu
    ChangedCallback = function(New)
        getgenv().dhlock.keybind = New
    end
})




LeftGroupBox:AddDropdown('Lock Part', {
    Values = { 'Head', 'HumanoidRootPart', 'UpperTorso', 'LowerTorso' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    Text = 'Lock Part',
    Tooltip = 'lockpart changer', -- Information shown when you hover over the dropdown
    Callback = function(Value)
        getgenv().dhlock.lockpart = Value
    end
})

LeftGroupBox:AddDropdown('Lock Part In Air', {
    Values = {  'Head', 'HumanoidRootPart', 'UpperTorso', 'LowerTorso' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    Text = 'Lock Part In Air',
    Tooltip = 'lockpart changer', -- Information shown when you hover over the dropdown
    Callback = function(Value)
        getgenv().dhlock.lockpartair = Value
    end
})





LeftGroupBox:AddInput('X Prediction', {
    Default = 'X Prediction',
    Numeric = true, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter
    Text = 'X Prediction',
    Tooltip = 'hi, stratxgy was here', -- Information shown when you hover over the textbox
    Placeholder = 'hi, stratxgy was here', -- placeholder text when the box is empty
    Callback = function(Value)
        getgenv().dhlock.predictionX = Value
    end
})

LeftGroupBox:AddInput('Y Prediction', {
    Default = 'Y Prediction',
    Numeric = true, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter
    Text = 'Y Prediction',
    Tooltip = 'hi, stratxgy was here', -- Information shown when you hover over the textbox
    Placeholder = 'hi, stratxgy was here', -- placeholder text when the box is empty
    Callback = function(Value)
        getgenv().dhlock.predictionY = Value
    end
})


LeftGroupBox:AddSlider('FOV', {
    Text = 'FOV Circle',
    Default = 50,
    Min = 0,
    Max = 500,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().dhlock.fov = Value
    end
})

LeftGroupBox:AddLabel('FOV Color'):AddColorPicker('FOV Color', {
    Default = Color3.new(1, 1, 1),
    Title = 'FOV Colorpicker', -- Optional. Allows you to have a custom color picker title (when you open it)
    Callback = function(Value)
        getgenv().dhlock.fovcolorunlocked = Value
    end
})

LeftGroupBox:AddLabel('FOV Color when Locked'):AddColorPicker('FOV Color when Locked', {
    Default = Color3.new(1, 0, 0), 
    Title = 'FOV Colorpicker when locked', -- Optional. Allows you to have a custom color picker title (when you open it)
    Callback = function(Value)
        getgenv().dhlock.fovcolorlocked = Value
    end
})

LeftGroupBox:AddSlider('Smoothness (lower = faster)', {
    Text = 'Smoothness (lower = faster)',
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().dhlock.smoothness = Value
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
        getgenv().dhlock.teamcheck = Value
    end
})

RightGroupBox:AddToggle('Wall Check', {
    Text = 'Wall Check',
    Default = false, -- Default value (true / false)
    Tooltip = 'checks if a player is behind a wall', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().dhlock.wallcheck = Value
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


local RightGroupBox = Tabs.aimbot:AddRightGroupbox('Spin Lock')

RightGroupBox:AddToggle('Spin Lock Master Toggle', {
    Text = 'Spin Lock Master Toggle',
    Default = false, -- Default value (true / false)
    Tooltip = 'When you click the keybind it makes you spin around your targeted player', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().spin.enabled = Value
    end
})

RightGroupBox:AddLabel('Spin Lock Toggle Key'):AddKeyPicker('Spin Lock Toggle Key', {

    Default = 'P', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,

    Text = 'Spinlock Toggle Key', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        getgenv().spin.keybind = New
    end
})

RightGroupBox:AddSlider('Spin Radius', {
    Text = 'Spin Radius',
    Default = 10,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().spin.straferadius = Value
    end
})

RightGroupBox:AddSlider('Rotation Strafe Speed', {
    Text = 'Rotation Strafe Speed',
    Default = 2,
    Min = 1,
    Max = 15,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().spin.strafespeed = Value
    end
})

RightGroupBox:AddSlider('Player Spin Speed', {
    Text = 'Player Spin Speed',
    Default = 5,
    Min = 1,
    Max = 50,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().spin.spinspeed = Value
    end
})


getgenv().ESP.Enabled = true

-- VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab VisualsTab 



local LeftGroupBox = Tabs.visuals:AddLeftGroupbox('Health Bar')

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

LeftGroupBox:AddSlider('Background Transparency', {
    Text = 'Background Transparency',
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().targethud.backgroundTransparency = Value
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
                    Library:SetWatermark(('Aura - Da Hood | %s fps | %s ms'):format(
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



local RightGroupBox = Tabs.visuals:AddRightGroupbox('Aim Viewer')

RightGroupBox:AddToggle('Aim Viewer', {
    Text = 'Aim Viewer',
    Default = false, -- Default value (true / false)
    Tooltip = 'imagine locking in a lego game', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().viewtracer.Enabled = Value
    end
})

RightGroupBox:AddSlider('Aim Viewer Length (studs)', {
    Text = 'Aim Viewer Length (studs)',
    Default = 15,
    Min = 1,
    Max = 50,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().viewtracer.Length = Value
    end
})

RightGroupBox:AddLabel('Aim Viewer Color'):AddColorPicker('Aim Viewer Color', {
    Default = Color3.new(1, 0.796078431372549, 0.5411764705882353),
    Title = 'Aim Viewer Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    Callback = function(Value)
        getgenv().viewtracer.Color = Value
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





local RightGroupBox = Tabs.player:AddRightGroupbox('Anti Aim')

RightGroupBox:AddToggle('Anti Aim Master Switch', {
    Text = 'Anti Aim Master Switch',
    Default = false, -- Default value (true / false)
    Tooltip = 'Cant hit me (probably)', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().aaimweld.enabled = Value
    end
})

RightGroupBox:AddLabel('Anti Aim Keybind'):AddKeyPicker('Anti Aim Keybind', {
    Default = 'P', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    Text = 'Anti Aim Keybind', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu
    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        getgenv().aaimweld.keybind = New
    end
})

RightGroupBox:AddToggle('Anti Aim Toggle (Toggle or Hold)', {
    Text = 'Anti Aim Toggle (Toggle or Hold)',
    Default = false, -- Default value (true / false)
    Tooltip = 'Cant hit me (probably)', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().aaimweld.toggle = Value
    end
})

RightGroupBox:AddSlider('Anti Aim Spin Speed', {
    Text = 'Anti Aim Spin Speed',
    Default = 500,
    Min = 300,
    Max = 4000,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().aaimweld.spinspeed = Value
    end
})

RightGroupBox:AddToggle('Anti Aim Offset', {
    Text = 'Anti Aim Offset',
    Default = false, -- Default value (true / false)
    Tooltip = 'It makes your chest go way off and it looks funny', -- Information shown when you hover over the toggle
    Callback = function(Value)
        getgenv().aaimweld.offset = Value
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
