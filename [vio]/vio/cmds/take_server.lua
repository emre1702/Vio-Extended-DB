local takeStrings = {}
	takeStrings["gunlicense"] = "takegunlicense"
	takeStrings["illegal"] = "takeillegal"
	takeStrings["weapons"] = "takeweapons"
	takeStrings["drugs"] = "takedrugs"

function take_func ( player, _, cmd, arg1, arg2 )

	local string = takeStrings[cmd]
	if string then
		executeCommandHandler ( takeStrings[cmd], player, arg1, arg2 )
	end
end
addCommandHandler ( "take", take_func )