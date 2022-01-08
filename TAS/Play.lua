local Play = {MoveData = {}}
Play.__index = Play
Play.__metatable = nil

local Twait = task.wait

local function RootPlay(self, Root, i, Callback)
    while true do
        local M = (Root.Position - self.MoveData[i]).Magnitude
        if math.floor(M) <= self.MinMagnitude then
            break
        else
            Callback()
        end
        Twait()
    end
end

function Play : PlayAttempt(Attr)
    local Start = tick()

    local Root = Attr[1]
    local Humanoid = Attr[2]
    local MoveData = self.MoveData
    local Freezing = self.Freezing
    local PauseTime = self.PauseTime

    if self.UseRawMovement then
        if Freezing then
            Root.Anchored = true
        end
        for i = 1, #MoveData do
            RootPlay(self, Root, i, function()
                for i2 = 1, 10 do
                    Root.Position = Root.Position:Lerp(MoveData[i], i2/10)
                    Twait(PauseTime)
                end
            end)
        end
        if Freezing then
            Root.Anchored = false
        end
    else
        for i = 1, #MoveData do
            RootPlay(self, Root, i, function()
                Humanoid:MoveTo(MoveData[i])
            end)
        end
    end
    print ("Run attempt completed. Time: " .. (tick() - Start))
end

return Play
