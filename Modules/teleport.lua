
getgenv().tp = {
    player = "",  -- Replace with the initial target player's username
    tp = true  -- Set to true to trigger teleportation immediately, false will not teleport
}

-- Function to teleport the local player to the specified player
local function teleportToPlayerWithOffset()
    -- Check if teleportation is triggered (getgenv().tp.tp == true)
    if getgenv().tp.tp then
        -- Get the username from the settings
        local username = getgenv().tp.player  
        local targetPlayer = game.Players:FindFirstChild(username)

        if not targetPlayer then

            return
        end

        -- Get the local player's character and the target player's character
        local localPlayer = game.Players.LocalPlayer
        local localCharacter = localPlayer.Character
        local targetCharacter = targetPlayer.Character

        if localCharacter and targetCharacter then
            local PlayerHumanoid = localCharacter:WaitForChild("Humanoid")
            local TargetHumanoid = targetCharacter:WaitForChild("Humanoid")
            
            -- Method 1: Teleport the local player 5 studs in front of the target
            local newPosition = TargetHumanoid.RootPart.CFrame + TargetHumanoid.RootPart.CFrame.LookVector * 5
            PlayerHumanoid.RootPart.CFrame = newPosition

            
            -- Method 2: Align the local player's position with the target, keeping the Y-axis fixed
            local newPositionAligned = CFrame.new(
                PlayerHumanoid.RootPart.Position.X,
                PlayerHumanoid.RootPart.Position.Y,
                TargetHumanoid.RootPart.Position.Z
            )
            PlayerHumanoid.RootPart.CFrame = newPositionAligned
        end
    end
end

-- Monitor changes to `getgenv().tp.player` and execute teleportation when it changes
local lastPlayer = getgenv().tp.player  -- Store the initial value of the player

while true do
    -- Check if the player has changed
    if getgenv().tp.player ~= lastPlayer then
        lastPlayer = getgenv().tp.player  -- Update the lastPlayer value

        teleportToPlayerWithOffset()
    end
    
    -- Wait briefly before checking again (to prevent high CPU usage)
    wait(0.1)
end
