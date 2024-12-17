
getgenv().hbar = {
    enabled = false,            
    barThickness = 3,         
    greenThickness = 1.5,      
    barColor = Color3.fromRGB(0, 0, 0),
    greenColor = Color3.fromRGB(0, 255, 0), 
    updateInterval = 0.1       
}



local player = game:GetService("Players").LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local runService = game:GetService("RunService")


local function NewLine(thickness, color)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color
    line.Thickness = thickness
    line.Transparency = 1
    return line
end


local function UpdateHealthBar(plr)
    local library = {
        healthbar = NewLine(getgenv().hbar.barThickness, getgenv().hbar.barColor),
        greenhealth = NewLine(getgenv().hbar.greenThickness, getgenv().hbar.greenColor)
    }

    
    local function Updater()
        local connection
        connection = runService.RenderStepped:Connect(function()
       
            if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") then
                local HumPos, OnScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local head = camera:WorldToViewportPoint(plr.Character.Head.Position)
                    local DistanceY = math.clamp((Vector2.new(head.X, head.Y) - Vector2.new(HumPos.X, HumPos.Y)).magnitude, 2, math.huge)

          
                    local d = (Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2) - Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)).magnitude 
                    local healthoffset = plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth * d

             
                    library.greenhealth.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2)
                    library.greenhealth.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2 - healthoffset)

                    library.healthbar.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2)
                    library.healthbar.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y - DistanceY*2)


                    local green = getgenv().hbar.greenColor
                    local red = Color3.fromRGB(255, 0, 0)
                    library.greenhealth.Color = red:lerp(green, plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth)

  
                    library.greenhealth.Visible = getgenv().hbar.enabled
                    library.healthbar.Visible = getgenv().hbar.enabled
                else

                    library.greenhealth.Visible = false
                    library.healthbar.Visible = false
                end
            else

                library.greenhealth.Visible = false
                library.healthbar.Visible = false
            end
        end)
    end
    coroutine.wrap(Updater)()
end


for i, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v.Name ~= player.Name then
        UpdateHealthBar(v)
    end
end


game.Players.PlayerAdded:Connect(function(newplr)
    if newplr.Name ~= player.Name then
        UpdateHealthBar(newplr)
    end
end)


game:GetService("RunService").Heartbeat:Connect(function()

    if getgenv().hbar.enabled == false then
 
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("Humanoid") then
                local library = v:FindFirstChild("DrawingHealthBar")
                if library then
                    library.greenhealth.Visible = false
                    library.healthbar.Visible = false
                end
            end
        end
    end
end)
