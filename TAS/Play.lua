local Play = {MoveData = {}}
Play.__index = Play
Play.__metatable = nil

local Twait = task.wait

local function TAS_Move(self, Attr, i, Callback)
	local Root = Attr[1]
	local Humanoid = Attr[2]
	
	while true do
		local Move = self.MoveData[i]
		local M = (Root.Position - Move[2]).Magnitude
		if math.floor(M) <= self.MinMagnitude then
			if Move[1] ~= nil then
				-- Custom actions wooo
				if Move[1] == 'Jump' then
					Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					Humanoid.Jump = true
				end
			end
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
			TAS_Move(self, Attr, i, function()
				for i2 = 1, 10 do
					Root.Position = Root.Position:Lerp(MoveData[i][2], i2/10)
					Twait(PauseTime)
				end
			end)
		end
		if Freezing then
			Root.Anchored = false
		end
	else
		for i = 1, #MoveData do
			TAS_Move(self, Attr, i, function()
				Humanoid:MoveTo(MoveData[i][2])
			end)
		end
	end
	print ("Run attempt completed. Time: " .. (tick() - Start))
end

return Play
