
getgenv().pname = getgenv().pname or {
    Color = Color3.fromRGB(255, 255, 255),
    Enabled = false,
    Position = "Above",  -- hi future me the options are "Above" or "Below" remember that ok? ok good.
    Size = 10, 
}

local billboards = {} 


local function createNameBillboard(player)
    if player == game.Players.LocalPlayer then return end 
    if not getgenv().pname.Enabled then return end 

    local function adornCharacter(character)
        if not getgenv().pname.Enabled then return end
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")


        local billboard = Instance.new("BillboardGui")
        billboard.Adornee = humanoidRootPart
        billboard.Size = UDim2.new(4, 0, 1, 0)
        billboard.StudsOffset = getgenv().pname.Position == "Below" 
            and Vector3.new(0, -3, 0) 
            or Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true


        local textLabel = Instance.new("TextLabel")
        textLabel.Text = player.Name
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = getgenv().pname.Color
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextScaled = false
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.TextTransparency = getgenv().pname.Size < 5 and 1 or 0
        textLabel.TextSize = math.clamp((getgenv().pname.Size - 5) * 2 + 14, 14, 40)
        textLabel.Parent = billboard

        billboard.Parent = humanoidRootPart
        billboards[player] = billboard 

      
        character.AncestryChanged:Connect(function()
            if not character:IsDescendantOf(game) then
                billboard:Destroy()
                billboards[player] = nil
            end
        end)
    end

    if player.Character then
        adornCharacter(player.Character)
    end

    player.CharacterAdded:Connect(function()
        if getgenv().pname.Enabled then
            adornCharacter(player.Character)
        end
    end)
end


local function removeAllBillboards()
    for _, billboard in pairs(billboards) do
        if billboard then
            billboard:Destroy()
        end
    end
    table.clear(billboards)
end


task.spawn(function()
    while task.wait(0.2) do
        if getgenv().pname.Enabled then
            for _, player in ipairs(game.Players:GetPlayers()) do
                if not billboards[player] then
                    createNameBillboard(player)
                end
            end
        else
            removeAllBillboards()
        end
    end
end)


if getgenv().pname.Enabled then
    for _, player in ipairs(game.Players:GetPlayers()) do
        createNameBillboard(player)
    end

    game.Players.PlayerAdded:Connect(function(player)
        createNameBillboard(player)
    end)
end
