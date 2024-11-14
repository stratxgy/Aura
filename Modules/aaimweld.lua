-- Settings
getgenv().aaimweld = {
    enabled = false,           -- Whether the feature is enabled
    keybind = Enum.KeyCode.P,  -- Keybind to activate/deactivate spinning
    toggle = false,            -- True for toggle, false for hold
    spinspeed = 500,           -- Speed of the spin (degrees per second)
    offset = false,            -- Whether to apply the offset (true for offset, false for normal)
}

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

-- Variables
local rotationSpeed = getgenv().aaimweld.spinspeed
local isSpinning = false
local togglePressed = false
local active = false

-- Function to handle character setup after respawn
local function setupCharacter(character)
    if not active then return end  -- Ensure feature is inactive until enabled

    local humanoid = character:WaitForChild("Humanoid")
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local torso = character:FindFirstChild("UpperTorso") or character:WaitForChild("Torso")
    local head = character:WaitForChild("Head", 10) -- Wait up to 10 seconds for Head

    -- Default spin part: HumanoidRootPart
    local spinPartObject = humanoidRootPart

    -- Create a custom weld to handle spinning
    local spinWeld = Instance.new("Weld")
    spinWeld.Part0 = spinPartObject
    spinWeld.Part1 = torso

    -- Apply the offset if enabled
    if getgenv().aaimweld.offset then
        spinWeld.C0 = CFrame.new(0, 1, 0) -- Adjusted offset (feel free to modify the 1)
    else
        spinWeld.C0 = CFrame.new()
    end

    spinWeld.Parent = spinPartObject

    -- Disable the walking animation
    local function disableWalkingAnimation()
        local animator = humanoid:FindFirstChild("Animator")
        if animator then
            for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end
    end

    -- Spin the character using the weld
    local function spinCharacter(deltaTime)
        local rotationAngle = math.rad(rotationSpeed * deltaTime)
        spinWeld.C0 = spinWeld.C0 * CFrame.Angles(0, rotationAngle, 0)
    end

    -- Handle toggle or hold for keybind
    local function handleKeybindInput()
        userInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
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

    disableWalkingAnimation()
    handleKeybindInput()
end

-- Monitor for changes to getgenv().aaimweld.enabled
task.spawn(function()
    while true do
        if getgenv().aaimweld.enabled and not active then
            active = true
            if player.Character then
                setupCharacter(player.Character)
            end
        end
        task.wait(0.1)
    end
end)

-- Ensure the character is properly set up if the player is already alive when the script starts
player.CharacterAdded:Connect(function(character)
    if active then
        setupCharacter(character)
    end
end)
