
getgenv().viewtracer = {
    Enabled = false, 
    Color = Color3.fromRGB(255, 203, 138), -- Color of the line
    Thickness = 1, -- Thickness of the line (Overruled by AutoThickness if activated)
    Transparency = 1, -- 1 Visible - 0 Not Visible
    AutoThickness = true, -- Makes Thickness above futile, scales according to distance, good for less encumbered screen
    Length = 15, -- in studs
    Smoothness = 0.2 -- amount of updates, lower is less smooth
}

if not getgenv().viewtracer.Enabled then return end 

local toggle = true 

local player = game:GetService("Players").LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera

local function ESP(plr) 
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = getgenv().viewtracer.Color
    line.Thickness = getgenv().viewtracer.Thickness
    line.Transparency = getgenv().viewtracer.Transparency

    local function Updater() 
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
           
            if getgenv().viewtracer.Enabled and toggle and plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                local headpos, OnScreen = camera:WorldToViewportPoint(plr.Character.Head.Position)
                if OnScreen then 
                    local offsetCFrame = CFrame.new(0, 0, -getgenv().viewtracer.Length)
                    local check = false
                    line.From = Vector2.new(headpos.X, headpos.Y)
                    if getgenv().viewtracer.AutoThickness then
                        local distance = (player.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude 
                        local value = math.clamp(1/distance*100, 0.1, 3) 
                        line.Thickness = value
                    end
                    repeat
                        local dir = plr.Character.Head.CFrame:ToWorldSpace(offsetCFrame)
                        offsetCFrame = offsetCFrame * CFrame.new(0, 0, getgenv().viewtracer.Smoothness)
                        local dirpos, vis = camera:WorldToViewportPoint(Vector3.new(dir.X, dir.Y, dir.Z))
                        if vis then
                            check = true
                            line.To = Vector2.new(dirpos.X, dirpos.Y)
                            line.Visible = true
                            offsetCFrame = CFrame.new(0, 0, -getgenv().viewtracer.Length)
                        end
                    until check == true
                else 
                    line.Visible = false
                end
            else 
                line.Visible = false
                if game.Players:FindFirstChild(plr.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Updater)()
end

for i, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v.Name ~= player.Name then
        coroutine.wrap(ESP)(v)
    end
end

game.Players.PlayerAdded:Connect(function(newplr)
    if newplr.Name ~= player.Name then
        coroutine.wrap(ESP)(newplr)
    end
end)
