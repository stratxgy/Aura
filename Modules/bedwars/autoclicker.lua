
getgenv().autoclick = {
    enabled = false,
    bind = Enum.KeyCode.Q, 
    mode = "Hold",         
    cps = 15
}


local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")


local autoclicking = false


local function performClick()
    VirtualUser:Button1Down(Vector2.new())
    VirtualUser:Button1Up(Vector2.new())
end


local function clickLoop()
    while autoclicking and getgenv().autoclick.enabled do
        performClick()
        wait(1 / getgenv().autoclick.cps)
    end
end

local function isBindPressed(input)
    local bind = getgenv().autoclick.bind
  
    if input.KeyCode and input.KeyCode == bind then
        return true
    end

    if input.UserInputType == bind then
        return true
    end
    return false
end

local mode = string.lower(getgenv().autoclick.mode)

if mode == "toggle" then
    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end
        if isBindPressed(input) then
            autoclicking = not autoclicking
            if autoclicking then
                spawn(clickLoop)
            end
        end
    end)
elseif mode == "hold" then
    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end
        if isBindPressed(input) then
            autoclicking = true
            spawn(clickLoop)
        end
    end)

    UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end
        if isBindPressed(input) then
            autoclicking = false
        end
    end)


