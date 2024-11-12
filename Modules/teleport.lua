
getgenv().tp = {
    player = "", 
    enabled = false 
}

-- Function to teleport the local player to the specified player
local function teleportToPlayerWithOffset()
    -- Check if teleportation is enabled
    if not getgenv().tp.enabled then
        print("Teleportation is disabled.")
        return
    end

    local username = getgenv().tp.player  -- Get the username from the settings
    local targetPlayer = game.Players:FindFirstChild(username)

    if not targetPlayer then
        print("Player not found: " .. username)
        return
    end


    local localPlayer = game.Players.LocalPlayer
    local localCharacter = localPlayer.Character
    local targetCharacter = targetPlayer.Character

    if localCharacter and targetCharacter then
        local PlayerHumanoid = localCharacter:WaitForChild("Humanoid")
        local TargetHumanoid = targetCharacter:WaitForChild("Humanoid")
        

        local newPosition = TargetHumanoid.RootPart.CFrame + TargetHumanoid.RootPart.CFrame.LookVector * 5
        PlayerHumanoid.RootPart.CFrame = newPosition
     
        
        local newPositionAligned = CFrame.new(
            PlayerHumanoid.RootPart.Position.X,
            PlayerHumanoid.RootPart.Position.Y,
            TargetHumanoid.RootPart.Position.Z
        )
        PlayerHumanoid.RootPart.CFrame = newPositionAligned
     

    end
end

-- Toggle teleportation
local function toggleTeleport(enabled)
    getgenv().tp.enabled = enabled
end

-- Call the teleport function (this can be triggered manually or as needed)
teleportToPlayerWithOffset()
