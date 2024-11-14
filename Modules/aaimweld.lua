-- Settings
getgenv().aaimweld = {
    enabled = false,           -- Whether the feature is enabled
    keybind = Enum.KeyCode.P,  -- Keybind to activate/deactivate spinning
    toggle = false,            -- True for toggle, false for hold
    spinspeed = 500,           -- Speed of the spin (degrees per second)
    offset = false,            -- Whether to apply the offset (true for offset, false for normal)
    persist = false,           -- Persist across death and teleportation
}

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

-- Variables
local isSpinning = false
local togglePressed = false
local active = false
local spinWeld

-- Function to handle character setup
local function setupCharacter(character)
    if not active then return end -- Ensure feature is inactive until enabled

    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local torso = character:FindFirstChild("UpperTorso") or character:WaitForChild("Torso")

    -- Create or update the custom weld to handle spinning
    spinWeld = Instance.new("Weld")
    spinWeld.Part0 = humanoidRootPart
    spinWeld.Part1 = torso

    -- Apply the offset if enabled
    if getgenv().aaimweld.offset then
        spinWeld.C0 = CFrame.new(0, 1, 0) -- Adjusted offset
    else
        spinWeld.C0 = CFrame.new()
    end

    spinWeld.Parent = humanoidRootPart
end

-- Spin the character using the weld
local function spinCharacter(deltaTime)
    if spinWeld then
        local rotationSpeed = getgenv().aaimweld.spinspeed
        local rotationAngle = math.rad(rotationSpeed * deltaTime)

        -- Update C0 to apply rotation while maintaining the offset
        spinWeld.C0 = spinWeld.C0 * CFrame.Angles(0, rotationAngle, 0)
    end
end

-- Handle toggle or hold for keybind
local function handleKeybindInput()
    userInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed or not active then return end
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == getgenv().aaimweld.keybind then
            if getgenv().aaimweld.toggle then
                togglePressed = not togglePressed
                isSpinning = togglePressed
            else
                isSpinning = true
            end
        end
    end)

    userInputService.InputEnded:Connect(function(input)
        if not active then return end
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == getgenv().aaimweld.keybind and not getgenv().aaimweld.toggle then
            isSpinning = false
        end
    end)
end

-- Main loop to handle the spinning
runService.RenderStepped:Connect(function(deltaTime)
    if active and isSpinning then
        spinCharacter(deltaTime)
    end
end)

-- Monitor for changes to getgenv().aaimweld.enabled
task.spawn(function()
    while true do
        if getgenv().aaimweld.enabled and not active then
            active = true
            if player.Character then
                setupCharacter(player.Character)
            end
        elseif not getgenv().aaimweld.enabled and active then
            active = false
            isSpinning = false -- Stop spinning when disabled
            spinWeld = nil -- Remove the weld
        end
        task.wait(0.1)
    end
end)

-- When the player respawns or teleports, re-setup the character if persist is enabled
player.CharacterAdded:Connect(function(character)
    if getgenv().aaimweld.persist and active then
        setupCharacter(character)
    end
end)

-- Ensure the character is properly set up if the player is already alive when the script starts
if player.Character and getgenv().aaimweld.enabled then
    setupCharacter(player.Character)
end

-- Initialize keybind input handling
handleKeybindInput()
