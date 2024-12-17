

if getgenv()._ptoolLoaded then return end
getgenv()._ptoolLoaded = true

getgenv().ptool = getgenv().ptool or {
    Color = Color3.fromRGB(255, 255, 255), 
    Enabled = false, -- Above or Below (hi I was here, yes I know so cool)
    Position = "Above", 
    Size = 10,
}

local billboards = {} 


local function createToolBillboard(player)
    if player == game.Players.LocalPlayer then return end 
    if not getgenv().ptool.Enabled then return end

    local function adornCharacter(character)
        if not getgenv().ptool.Enabled then return end
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

   
        local billboard = Instance.new("BillboardGui")
        billboard.Adornee = humanoidRootPart
        billboard.Size = UDim2.new(4, 0, 1, 0)
        billboard.StudsOffset = getgenv().ptool.Position == "Below" 
            and Vector3.new(0, -4, 0) 
            or Vector3.new(0, 4, 0)
        billboard.AlwaysOnTop = true


        local textLabel = Instance.new("TextLabel")
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = getgenv().ptool.Color
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextScaled = false
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.TextTransparency = getgenv().ptool.Size < 5 and 1 or 0
        textLabel.TextSize = math.clamp((getgenv().ptool.Size - 5) * 2 + 14, 14, 40)
        textLabel.Text = "None"
        textLabel.Parent = billboard
        billboard.Parent = humanoidRootPart
        billboards[player] = billboard

  
        local function updateTool()
            local tool = character:FindFirstChildOfClass("Tool")
            textLabel.Text = tool and tool.Name or "None"
        end

        character.ChildAdded:Connect(updateTool)
        character.ChildRemoved:Connect(updateTool)
        updateTool()
    end

    if player.Character then
        adornCharacter(player.Character)
    end

    player.CharacterAdded:Connect(function()
        if getgenv().ptool.Enabled then
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
        if getgenv().ptool.Enabled then
            for _, player in ipairs(game.Players:GetPlayers()) do
                if not billboards[player] then
                    createToolBillboard(player)
                end
            end
        else
            removeAllBillboards()
        end
    end
end)


if getgenv().ptool.Enabled then
    for _, player in ipairs(game.Players:GetPlayers()) do
        createToolBillboard(player)
    end

    game.Players.PlayerAdded:Connect(function(player)
        createToolBillboard(player)
    end)
end

