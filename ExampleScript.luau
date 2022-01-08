local TAS = require(script.TAS)
local Player = game:GetService("Players").interpreterK

local Ways = {}
for i,v in next, workspace:GetChildren() do
	if v.Name == "Button" then
		table.insert(Ways, v.Head.Position)
	end
end

local Run = TAS.new(Player, Ways)
Run.Freezing = false
Run.UseRawMovement = true
Run:Play()