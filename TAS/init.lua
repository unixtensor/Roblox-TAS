--[[
    TAS api made by: interpreterK
    Repo link:

    Create TAS (Tool Assisted Speedrun) runs on roblox.
    [https://www.urbandictionary.com/define.php?term=tas]

    ! This module uses VECTOR based movement.
    ? CFraming variant

    Btw, I use
                   -`
                  .o+`
                 `ooo/
                `+oooo:
               `+oooooo:
               -+oooooo+:
             `/:-:++oooo+:
            `/++++/+++++++:
           `/++++++++++++++:
          `/+++ooooooooooooo/`
         ./ooosssso++osssssso+`
        .oossssso-````/ossssss+`
       -osssssso.      :ssssssso.
      :osssssss/        osssso+++.
     /ossssssss/        +ssssooo/-
   `/ossssso+/:-        -:/+osssso+-
  `+sso+:-`                 `.-/+oso:
 `++:.                           `-/+/
 .`   
]]

local TAS = {
	UseRawMovement = true,
	PauseTime = 1/100,
    Freezing = true,
    MinMagnitude = 3
}
TAS.__index = TAS
TAS.__metatable = nil

local Play = require(script.Play)

local function GetCharRequirements(Character)
	local Root = Character:FindFirstChild "HumanoidRootPart"
	local Humanoid = Character:FindFirstChildOfClass "Humanoid"
	if Root and Humanoid then
		return Root, Humanoid
	end
	warn "Could not get the required character parts."
	return nil
end

function TAS . new(Player, Waypoints)
	if Player and Player:IsA "Player" then
		print "Initialized a new TAS."
		if Waypoints then
			Play.MoveData = Waypoints
		end
		return setmetatable({
            Player = Player,
        }, TAS)
	else
		warn "Please specify a player 1st to create a new TAS."
	end
	return nil
end

function TAS : Play()
    if #Play.MoveData == 0 then
        warn "No waypoints specified for a run."
    else
        if self.Player then
            local Player = self.Player
            local Character = Player.Character
            local Root, Humanoid = GetCharRequirements(Character)
    
            if Root and Humanoid then
                print "Requirements reached, Playing run."
                
                Play.UseRawMovement = self.UseRawMovement
                Play.PauseTime = self.PauseTime
                Play.Freezing = self.Freezing
                Play.MinMagnitude = self.MinMagnitude

                Play : PlayAttempt({
                    [1] = Root,
                    [2] = Humanoid
                })
            else
                warn "Could not reach the requirements to play the run..."
            end
        else
            warn "Please specify a player 1st to play a TAS."
        end
    end
end

return TAS