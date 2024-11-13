-- Create a global settings table using getgenv()
getgenv().headless = {
    enabled = false,  -- Set to true to activate headless mode
    size = Vector3.new(0.1, 0.1, 0.1),  -- Size of the head when shrunk
    positionOffset = Vector3.new(0, 0, 0),  -- Offset from the HumanoidRootPart to position the head
}

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Function to shrink the head and move it inside the torso
local function shrinkHeadAndMove()
    -- Check if headless is enabled in the settings
    if getgenv().headless.enabled then
        local head = character:WaitForChild("Head")
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
        
        -- Shrink the head to the specified size in the settings
        head.Size = getgenv().headless.size
        head.Position = humanoidRootPart.Position + getgenv().headless.positionOffset

        -- Move the head into the torso (adjust position if needed)
        head.CFrame = torso.CFrame * CFrame.new(getgenv().headless.positionOffset)

        -- Optionally, hide the head so it doesn't render while inside the torso
        head.Transparency = 1
        head.CanCollide = false
    end
end

-- Call the function to shrink and move the head if headless is enabled
shrinkHeadAndMove()
