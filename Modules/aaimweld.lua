
getgenv().aaimweld = {
    enabled = false,          
    keybind = Enum.KeyCode.P,  
    toggle = false,            
    spinspeed = 500,           
    offset = false,            
    persist = true,        
}

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")


local isSpinning = false
local togglePressed = false
local active = false
local spinWeld


local function setupCharacter(character)
    if not active then return end 

    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local torso = character:FindFirstChild("UpperTorso") or character:WaitForChild("Torso")


    spinWeld = Instance.new("Weld")
    spinWeld.Part0 = humanoidRootPart
    spinWeld.Part1 = torso


    if getgenv().aaimweld.offset then
        spinWeld.C0 = CFrame.new(0, 1, 0) 
    else
        spinWeld.C0 = CFrame.new()
    end

    spinWeld.Parent = humanoidRootPart
end


local function updateOffset()
    if spinWeld then
        if getgenv().aaimweld.offset then
            spinWeld.C0 = CFrame.new(0, 1, 0)
        else
            spinWeld.C0 = CFrame.new()
        end
    end
end


local function spinCharacter(deltaTime)
    if spinWeld then
        local rotationSpeed = getgenv().aaimweld.spinspeed
        local rotationAngle = math.rad(rotationSpeed * deltaTime)
        spinWeld.C0 = spinWeld.C0 * CFrame.Angles(0, rotationAngle, 0)
    end
end


local function handleKeybindInput()
    userInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed or not active then return end
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == getgenv().aaimweld.keybind then
            if getgenv().aaimweld.toggle then
                togglePressed = not togglePressed
                isSpinning = togglePressed
            else
                isSpinning = true
            end
        end
    end)

    userInputService.InputEnded:Connect(function(input)
        if not active then return end
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == getgenv().aaimweld.keybind and not getgenv().aaimweld.toggle then
            isSpinning = false
        end
    end)
end


runService.RenderStepped:Connect(function(deltaTime)
    if active and isSpinning then
        spinCharacter(deltaTime)
    end
end)


task.spawn(function()
    while true do
        if getgenv().aaimweld.enabled and not active then
            active = true
            if player.Character then
                setupCharacter(player.Character)
            end
        elseif not getgenv().aaimweld.enabled and active then
            active = false
            isSpinning = false 
            spinWeld = nil 
        end
        task.wait(0.5)
    end
end)


task.spawn(function()
    local lastOffset = getgenv().aaimweld.offset
    while true do
        if getgenv().aaimweld.offset ~= lastOffset then
            lastOffset = getgenv().aaimweld.offset
            updateOffset()
        end
        task.wait(0.5)
    end
end)


player.CharacterAdded:Connect(function(character)
    if getgenv().aaimweld.persist and active then
        setupCharacter(character)
    end
end)


if player.Character and getgenv().aaimweld.enabled then
    setupCharacter(player.Character)
end


handleKeybindInput()
