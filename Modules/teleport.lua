-- Initialize teleport settings with the default value of `tp = true` for immediate teleportation
getgenv().tp = {
    player = "",  -- Replace with the target player's username
    tp = true  -- Set to true to trigger teleportation immediately, false will not teleport
}

-- Function to teleport the local player to the specified player
local function teleportToPlayerWithOffset()
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

        -- Once the teleportation is done, set getgenv().tp.tp to false to prevent it from happening again
        getgenv().tp.tp = false
    end
end


-- Call the teleport function to teleport immediately
teleportToPlayerWithOffset()
