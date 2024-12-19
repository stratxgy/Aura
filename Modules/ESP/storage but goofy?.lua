

local FrameTimer = tick()
local FrameCounter = 0
local FPS = 60

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter
        FrameTimer = tick()
        FrameCounter = 0
    end


    Library:SetWatermark(('Aura - Da Hood | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ))
end)


Library.KeybindFrame.Visible = false

Library:OnUnload(function()
    WatermarkConnection:Disconnect()
    print('Unloaded!')
    Library.Unloaded = true
end)


toggleWatermark()
