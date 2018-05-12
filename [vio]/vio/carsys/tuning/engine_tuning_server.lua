function vtuning ( player, cmd, todo )

	local veh = getPedOccupiedVehicle ( player )
	local model = getElementModel ( veh )
	if todo == "basic" then
		setVehicleHandling ( veh, "mass", defaultVehicleHandlingData[model]["mass"] )
		setVehicleHandling ( veh, "maxVelocity", defaultVehicleHandlingData[model]["maxVelocity"] )
		setVehicleHandling ( veh, "brakeDeceleration", defaultVehicleHandlingData[model]["maxVelocity"] )
		setVehicleHandling ( veh, "turnMass", defaultVehicleHandlingData[model]["turnMass"] )
		setVehicleHandling ( veh, "engineAcceleration", defaultVehicleHandlingData[model]["engineAcceleration"] )
		outputChatBox ( "bas" )
	elseif todo == "velocity" then
		setVehicleHandling ( veh, "maxVelocity", defaultVehicleHandlingData[model]["maxVelocity"] * 3 )
		outputChatBox ( "vel" )
	elseif todo == "breaks" then
		setVehicleHandling ( veh, "brakeBias", defaultVehicleHandlingData[model]["brakeBias"] * 10 )
		outputChatBox ( "bre" )
	elseif todo == "turn" then
		setVehicleHandling ( veh, "turnMass", defaultVehicleHandlingData[model]["turnMass"] * 3 )
		outputChatBox ( "tur" )
	elseif todo == "mass" then
		setVehicleHandling ( veh, "mass", defaultVehicleHandlingData[model]["mass"] * 3 )
		outputChatBox ( "mas" )
	elseif todo == "acceleration" then
		setVehicleHandling ( veh, "engineAcceleration", defaultVehicleHandlingData[model]["engineAcceleration"] * 3 )
		outputChatBox ( "acc" )
	end
end
--addCommandHandler ( "vtuning", vtuning )