
getgenv().tp = {
    player = "",  -- Replace with the target player's username
    tp = true  -- Set to true to trigger teleportation, false to disable it
}

-- Function to teleport the local player to the specified player
local function teleportToPlayerWithOffset()
    -- Check if teleportation is enabled
    if not getgenv().tp.tp then
        return
    end

    local username = getgenv().tp.player  -- Get the username from the settings
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


-- Call the teleport function if the toggle is enabled
teleportToPlayerWithOffset()
