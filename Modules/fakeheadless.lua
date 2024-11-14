
getgenv().headless = {
    enabled = false,  -- Set to true to activate headless mode
    size = Vector3.new(0.1, 0.1, 0.1),  -- Size of the head when shrunk
    positionOffset = Vector3.new(0, -1, 0),  -- Offset relative to the torso when headless
}

local player = game.Players.LocalPlayer
local activeCharacter = nil  -- To keep track of the current character
local originalHeadProperties = {}  -- Table to store the original head properties

-- Function to store the original properties of the head
local function storeOriginalHeadProperties(head)
    originalHeadProperties = {
        Size = head.Size,
        CFrame = head.CFrame,
        Transparency = head.Transparency,
        CanCollide = head.CanCollide,
    }
end

-- Function to restore the original properties of the head
local function restoreOriginalHeadProperties(head)
    if originalHeadProperties.Size then
        head.Size = originalHeadProperties.Size
        head.CFrame = originalHeadProperties.CFrame
        head.Transparency = originalHeadProperties.Transparency
        head.CanCollide = originalHeadProperties.CanCollide
    else
        warn("Original head properties not found!")
    end
end

-- Function to shrink the head and move it inside the torso
local function shrinkHeadAndMove(character)
    -- Ensure the character is valid
    if not character then return end

    -- Wait for essential parts to load
    local head = character:FindFirstChild("Head") or character:WaitForChild("Head", 2)
    local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso") or character:WaitForChild("Torso", 2)

    -- Ensure all necessary parts exist
    if not head or not torso then
        warn("Essential parts are missing from the character.")
        return
    end

    if getgenv().headless.enabled then
        -- Store the original head properties once
        if not originalHeadProperties.Size then
            storeOriginalHeadProperties(head)
        end

        -- Shrink the head to the specified size
        head.Size = getgenv().headless.size

        -- Move the head inside the torso relative to its orientation
        local targetCFrame = torso.CFrame * CFrame.new(getgenv().headless.positionOffset)
        head.CFrame = targetCFrame

        -- Optionally, hide the head so it doesn't render
        head.Transparency = 1
        head.CanCollide = false
    else
        -- Restore the original head properties
        restoreOriginalHeadProperties(head)
    end
end

-- Function to handle when the character is added or respawned
local function onCharacterAdded(character)
    activeCharacter = character  -- Track the current character
    originalHeadProperties = {}  -- Reset stored properties for the new character

    -- Ensure all parts are loaded before applying the effect
    character:WaitForChild("Head", 2)
    character:WaitForChild("HumanoidRootPart", 2)

    -- Apply or restore the headless effect based on the current setting
    shrinkHeadAndMove(character)
end

-- Listen for the player's character being added (initial spawn, respawn, or teleport)
player.CharacterAdded:Connect(onCharacterAdded)

-- Ensure the headless effect is applied on initial load (if the character exists)
if player.Character then
    onCharacterAdded(player.Character)
end

-- Monitor `getgenv().headless.enabled` for real-time changes
task.spawn(function()
    local previousState = getgenv().headless.enabled
    while true do
        task.wait(0.1)  -- Check for updates every 0.1 seconds
        if getgenv().headless.enabled ~= previousState then
            previousState = getgenv().headless.enabled
            if activeCharacter then
                shrinkHeadAndMove(activeCharacter)
            end
        end
    end
end)
