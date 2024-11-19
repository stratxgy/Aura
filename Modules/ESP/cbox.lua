
getgenv().cbox = {
    Enabled = false, 
    Box_Color = Color3.fromRGB(255, 255, 255), 
    Box_Thickness = 2,
    Team_Check = false,
    Team_Color = false,
    Autothickness = true
}


local Space = game:GetService("Workspace")
local Player = game:GetService("Players").LocalPlayer
local Camera = Space.CurrentCamera

local activeConnections = {} 


local function NewLine(color, thickness)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color
    line.Thickness = thickness
    line.Transparency = 1
    return line
end

local function Vis(lib, state)
    for _, v in pairs(lib) do
        v.Visible = state
    end
end

local function Colorize(lib, color)
    for _, v in pairs(lib) do
        v.Color = color
    end
end

local function CleanupConnections()
    for _, conn in pairs(activeConnections) do
        conn:Disconnect()
    end
    activeConnections = {}
end

local function Main(plr)
    repeat task.wait() until plr.Character and plr.Character:FindFirstChild("Humanoid")
    local Library = {
        TL1 = NewLine(getgenv().cbox.Box_Color, getgenv().cbox.Box_Thickness),
        TL2 = NewLine(getgenv().cbox.Box_Color, getgenv().cbox.Box_Thickness),
        TR1 = NewLine(getgenv().cbox.Box_Color, getgenv().cbox.Box_Thickness),
        TR2 = NewLine(getgenv().cbox.Box_Color, getgenv().cbox.Box_Thickness),
        BL1 = NewLine(getgenv().cbox.Box_Color, getgenv().cbox.Box_Thickness),
        BL2 = NewLine(getgenv().cbox.Box_Color, getgenv().cbox.Box_Thickness),
        BR1 = NewLine(getgenv().cbox.Box_Color, getgenv().cbox.Box_Thickness),
        BR2 = NewLine(getgenv().cbox.Box_Color, getgenv().cbox.Box_Thickness)
    }

    local oripart = Instance.new("Part")
    oripart.Parent = Space
    oripart.Transparency = 1
    oripart.CanCollide = false
    oripart.Size = Vector3.new(1, 1, 1)
    oripart.Position = Vector3.new(0, 0, 0)

    -- Updater Loop
    local function Updater()
        local c
        c = game:GetService("RunService").RenderStepped:Connect(function()
            if not getgenv().cbox.Enabled then
                Vis(Library, false)
                return
            end

            if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") then
                local Hum = plr.Character
                local HumPos, vis = Camera:WorldToViewportPoint(Hum.HumanoidRootPart.Position)
                if vis then
                    oripart.Size = Vector3.new(Hum.HumanoidRootPart.Size.X, Hum.HumanoidRootPart.Size.Y * 1.5, Hum.HumanoidRootPart.Size.Z)
                    oripart.CFrame = CFrame.new(Hum.HumanoidRootPart.CFrame.Position, Camera.CFrame.Position)
                    local SizeX = oripart.Size.X
                    local SizeY = oripart.Size.Y
                    local TL = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(SizeX, SizeY, 0)).p)
                    local TR = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(-SizeX, SizeY, 0)).p)
                    local BL = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(SizeX, -SizeY, 0)).p)
                    local BR = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(-SizeX, -SizeY, 0)).p)

                    -- Update color and thickness based on settings
                    if getgenv().cbox.Team_Check then
                        if plr.TeamColor == Player.TeamColor then
                            Colorize(Library, Color3.fromRGB(0, 255, 0)) -- Green for teammates
                        else
                            Colorize(Library, Color3.fromRGB(255, 0, 0)) -- Red for enemies
                        end
                    elseif getgenv().cbox.Team_Color then
                        Colorize(Library, plr.TeamColor.Color) -- Use team color
                    else
                        Colorize(Library, getgenv().cbox.Box_Color) -- Use custom color
                    end

                    local ratio = (Camera.CFrame.Position - Hum.HumanoidRootPart.Position).Magnitude
                    local offset = math.clamp(1 / ratio * 750, 2, 300)

                    Library.TL1.From = Vector2.new(TL.X, TL.Y)
                    Library.TL1.To = Vector2.new(TL.X + offset, TL.Y)
                    Library.TL2.From = Vector2.new(TL.X, TL.Y)
                    Library.TL2.To = Vector2.new(TL.X, TL.Y + offset)

                    Library.TR1.From = Vector2.new(TR.X, TR.Y)
                    Library.TR1.To = Vector2.new(TR.X - offset, TR.Y)
                    Library.TR2.From = Vector2.new(TR.X, TR.Y)
                    Library.TR2.To = Vector2.new(TR.X, TR.Y + offset)

                    Library.BL1.From = Vector2.new(BL.X, BL.Y)
                    Library.BL1.To = Vector2.new(BL.X + offset, BL.Y)
                    Library.BL2.From = Vector2.new(BL.X, BL.Y)
                    Library.BL2.To = Vector2.new(BL.X, BL.Y - offset)

                    Library.BR1.From = Vector2.new(BR.X, BR.Y)
                    Library.BR1.To = Vector2.new(BR.X - offset, BR.Y)
                    Library.BR2.From = Vector2.new(BR.X, BR.Y)
                    Library.BR2.To = Vector2.new(BR.X, BR.Y - offset)

                    Vis(Library, true)

                    if getgenv().cbox.Autothickness then
                        local distance = (Player.Character.HumanoidRootPart.Position - oripart.Position).Magnitude
                        local value = math.clamp(1 / distance * 100, 1, 4) -- Min thickness 1, max 4
                        for _, x in pairs(Library) do
                            x.Thickness = value
                        end
                    else
                        for _, x in pairs(Library) do
                            x.Thickness = getgenv().cbox.Box_Thickness
                        end
                    end
                else
                    Vis(Library, false)
                end
            else
                Vis(Library, false)
                if not game:GetService("Players"):FindFirstChild(plr.Name) then
                    for _, v in pairs(Library) do
                        v:Remove()
                    end
                    oripart:Destroy()
                    c:Disconnect()
                end
            end
        end)
        table.insert(activeConnections, c)
    end
    coroutine.wrap(Updater)()
end

-- Monitor Enabled State
coroutine.wrap(function()
    while true do
        task.wait(0.5)
        if getgenv().cbox.Enabled then
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v.Name ~= Player.Name then
                    coroutine.wrap(Main)(v)
                end
            end

            game:GetService("Players").PlayerAdded:Connect(function(newplr)
                coroutine.wrap(Main)(newplr)
            end)
        else
            CleanupConnections()
        end
    end
end)()
