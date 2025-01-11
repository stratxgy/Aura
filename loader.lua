--[[
 ________  ___  ___  ________  ________     
|\   __  \|\  \|\  \|\   __  \|\   __  \    
\ \  \|\  \ \  \\\  \ \  \|\  \ \  \|\  \   
 \ \   __  \ \  \\\  \ \   _  _\ \   __  \  
  \ \  \ \  \ \  \\\  \ \  \\  \\ \  \ \  \ 
   \ \__\ \__\ \_______\ \__\\ _\\ \__\ \__\
    \|__|\|__|\|_______|\|__|\|__|\|__|\|__|


hey look that ascii art is pretty cool :)

]]--

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UniversalButton = Instance.new("TextButton")
local HoodCustomsButton = Instance.new("TextButton")

ScreenGui.Name = "AuraLoader"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.Size = UDim2.new(0, 200, 0, 100)

UniversalButton.Name = "UniversalButton"
UniversalButton.Parent = Frame
UniversalButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
UniversalButton.Position = UDim2.new(0.1, 0, 0.2, 0)
UniversalButton.Size = UDim2.new(0.8, 0, 0.3, 0)
UniversalButton.Font = Enum.Font.SourceSans
UniversalButton.Text = "Universal"
UniversalButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UniversalButton.TextScaled = true


HoodCustomsButton.Name = "HoodCustomsButton"
HoodCustomsButton.Parent = Frame
HoodCustomsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
HoodCustomsButton.Position = UDim2.new(0.1, 0, 0.6, 0)
HoodCustomsButton.Size = UDim2.new(0.8, 0, 0.3, 0)
HoodCustomsButton.Font = Enum.Font.SourceSans
HoodCustomsButton.Text = "Hood/Customs"
HoodCustomsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HoodCustomsButton.TextScaled = true

UniversalButton.MouseButton1Click:Connect(function()
    print("Universal")
    ScreenGui:Destroy() 
end)

HoodCustomsButton.MouseButton1Click:Connect(function()
    print("Hood/Customs")
    ScreenGui:Destroy() 
end) 
-- ez 
