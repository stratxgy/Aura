
getgenv().pname = getgenv().pname or {
    Color = Color3.fromRGB(255, 255, 255), 
    Enabled = true, 
    Position = "Below",
    Size = 13,
}

if not getgenv().pname.Enabled then return end 
local function createNameBillboard(player)
    if player == game.Players.LocalPlayer then return end
    local function adornCharacter(character)
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
        character.AncestryChanged:Connect(function()
            if not character:IsDescendantOf(game) then
                billboard:Destroy()
            end
        end)
    end
    if player.Character then
        adornCharacter(player.Character)
    end
    player.CharacterAdded:Connect(adornCharacter)
end
for _, player in ipairs(game.Players:GetPlayers()) do
    createNameBillboard(player)
end
game.Players.PlayerAdded:Connect(createNameBillboard) -- yes i combined it all to make it shorter lol
