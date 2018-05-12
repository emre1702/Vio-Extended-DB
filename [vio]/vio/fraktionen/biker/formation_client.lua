local formationTimer

function formationFound ()

	setTimer ( formationSpeedUp, 50, 1 )
	setPedCanBeKnockedOffBike ( lp, true )
end
addEvent ( "formationFound", true )
addEventHandler ( "formationFound", getRootElement(), formationFound )

function formationSpeedUp ()

	local veh = getPedOccupiedVehicle ( lp )
	if veh then
		if vioGetElementData ( veh, "formationMarker" ) then
			if getPedControlState ( lp, "accelerate" ) then
				local veh = getPedOccupiedVehicle ( lp )
				local vx, vy, vz = getElementVelocity ( veh )
				local speed = math.sqrt ( vx ^ 2 + vy ^ 2 + vz ^ 2 ) / 0.00464
				if speed <= 100 then
					setElementVelocity ( veh, vx * 1.005 * 1.005, vy * 1.005 * 1.005, vz * 1.005 * 1.005 )
				elseif speed <= 150 then
					setElementVelocity ( veh, vx * 1.006 * 1.006, vy * 1.006 * 1.006, vz * 1.006 * 1.006 )
				elseif speed <= 220 then
					setElementVelocity ( veh, vx * 1.007 * 1.007, vy * 1.007 * 1.007, vz * 1.007 * 1.007 )
				end
			end
			setTimer ( formationSpeedUp, 50, 1 )
			return true
		end
	end
	infobox ( "Deine Formation\nwurde aufgelöst!", 5000, 125, 0, 0 )
end
function formationSpeedUpMember ( leaderVeh )

	if not getPedControlState ( lp, "accelerate" ) then
		local veh = getPedOccupiedVehicle ( lp )
		local vx, vy, vz = getElementVelocity ( leaderVeh )
		setElementVelocity ( veh, vx, vy, vz )
		local x1, y1, z1 = getElementPosition ( veh )
		local x2, y2, z2 = getElementPosition ( leaderVeh )
		local speed = math.sqrt ( vx ^ 2 + vy ^ 2 + vz ^ 2 ) / 0.00464
		--if speed > 10 then
			local r1X, r1Y, r1Z = getElementRotation ( leaderVeh )
			local r2X, r2Y, r2Z = getElementRotation ( veh )
			setElementRotation ( veh, r2X, r2Y, r1Z )
			
			--setPedControlState ( lp, "vehicle_right", getPedControlState ( getVehicleOccupant ( leaderVeh ), "vehicle_right" ) )
			--setPedControlState ( lp, "vehicle_left", getPedControlState ( getVehicleOccupant ( leaderVeh ), "vehicle_left" ) )
			
			if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) >= 15 then
				leavaeFormation ()
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) >= 10 then
				setElementVelocity ( veh, vx * 1.05, vy * 1.05, vz * 1.05 )
				setElementPosition ( veh, x1 - ( x1 - x2 ) * 0.01, y1 - ( y1 - y2 ) * 0.01, z1 )
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) >= 5 then
				setElementVelocity ( veh, vx * 1.03, vy * 1.03, vz * 1.03 )
				setElementPosition ( veh, x1 - ( x1 - x2 ) * 0.01, y1 - ( y1 - y2 ) * 0.01, z1 )
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 5 then
				--setElementVelocity ( veh, vx * 1.03, vy * 1.03, vz * 1.03 )
				--setElementPosition ( veh, x1 + ( x1 - x2 ) * 0.05, y1 + ( y1 - y2 ) * 0.05, z1 )
			end
		--end
	end
end

function joinFormation ()

	local playerVeh = getPedOccupiedVehicle ( lp )
	setPedCanBeKnockedOffBike ( lp, false )
	local marker = vioGetElementData ( playerVeh, "formationMarker" )
	local veh = vioGetElementData ( marker, "formationVeh" )
	formationTimer = setTimer ( formationSpeedUpMember, 50, -1, veh )
	addEventHandler ( "onClientMarkerLeave", marker,
		function ( player )
			if player == lp then
				killTimer ( formationTimer )
				formationTimer = nil
			end
		end
	)
end
addEvent ( "joinFormation", true )
addEventHandler ( "joinFormation", getRootElement(), joinFormation )

function leavaeFormation ()

	killTimer ( formationTimer )
	formationTimer = nil
	setPedCanBeKnockedOffBike ( lp, true )
	infobox ( "Deine Formation\nwurde aufgelöst!", 5000, 125, 0, 0 )
end
addEvent ( "leavaeFormation", true )
addEventHandler ( "leavaeFormation", getRootElement(), leavaeFormation )