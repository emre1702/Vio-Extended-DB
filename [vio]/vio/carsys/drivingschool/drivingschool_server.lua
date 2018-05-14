drivingSchoolMarkers = {
 ["x"] = {
  [1]=-2001.8179931641,
  [2]=-1712.5074462891,
  [3]=-1560.3911132813,
  [4]=-1747.5130615234,
  [5]=-1990.8626708984
 },
 ["y"] = {
  [1]=603.61480712891,
  [2]=731.6,
  [3]=731.6,
  [4]=307.04,
  [5]=137.94
 },
 ["z"] = {
  [1]=35.00,
  [2]=25,
  [3]=7,
  [4]=7,
  [5]=33
 }
}

function startDrivingSchoolTheory_func ()

	local player = client
	setElementDimension ( player, tonumber ( vioGetElementData ( player, "playerid" ) ) )
	setElementPosition ( player, 361.36, 171.82, 1025.44 )
	setPedRotation ( player, 180 )
	triggerClientEvent ( player, "startDrivingLicenseTheory", player )
	showCursor ( player, true )
	setElementData ( player, "ElementClicked", true )
end

function showNextDrivingSchoolMarker ( player )

	if vioGetElementData ( player, "drivingSchoolPractise" ) then
		local old = vioGetElementData ( player, "drivingSchoolMarker" )
		if old then
			if isElement ( old ) then
				destroyElement ( old )
				destroyElement ( vioGetElementData ( player, "drivingSchoolBlip" ) )
			end
		end
		local new = vioGetElementData ( player, "drivingSchoolCur" ) + 1
		vioSetElementData ( player, "drivingSchoolCur", new )
		if new <= table.size ( drivingSchoolMarkers["x"] ) then
			local x, y, z = drivingSchoolMarkers["x"][new], drivingSchoolMarkers["y"][new], drivingSchoolMarkers["z"][new]
			local marker = createMarker ( x, y, z, "checkpoint", 10, 200,0,0, 255, player )
			local blip = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999.0, player )
			local dim = getElementDimension ( player )
			vioSetElementData ( player, "drivingSchoolMarker", marker )
			vioSetElementData ( player, "drivingSchoolBlip", blip )
			setElementDimension ( marker, dim )
			setElementDimension ( blip, dim )
			infobox ( player, "Checkpoint erreicht -\nnun zum naechsten!", 5000, 125, 0, 0 )
			addEventHandler ( "onMarkerHit", marker, showNextDrivingSchoolMarker )
		else
			triggerClientEvent ( player, "drivingSchoolFinished", player )
			spawnAfterDrivingSchool ( player )
			infobox ( player, "Herzlichen\nGlueckwunsch,du hast\ndie Fahrpruefung\nbestanden!", 5000, 125, 0, 0 )
			vioSetElementData ( player, "carlicense", 1 )
			playSoundFrontEnd ( player, 40 )
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - vioGetElementData ( player, "drivingLicensePrice" ) )
			dbExec( handler, "UPDATE userdata SET Autofuehrerschein = ? WHERE Name LIKE ?", vioGetElementData ( player, "carlicense" ), getPlayerName ( player ) )
		end
	end
end

function drivingSchoolTheoryComplete_func ( correct )

	local player = client
	if correct >= 6 then
		-- Practise
		showCursor ( player, false )
		vioSetElementData ( player, "ElementClicked", false )
		
		setElementInterior ( player, 0 )
		local dim = getElementDimension ( player )
		local veh = createVehicle ( 421, -1995.3588867188, 171.2080078125, 27.6875 )
		local ped = createPed ( 17, 0, 0, 0 )
		warpPedIntoVehicle ( player, veh, 0 )
		warpPedIntoVehicle ( ped, veh, 1 )
		setVehicleDamageProof ( veh, true )
		setElementDimension ( veh, dim )
		setElementDimension ( ped, dim )
		
		vioSetElementData ( player, "drivingSchoolVeh", veh )
		vioSetElementData ( player, "drivingSchoolPed", ped )
		vioSetElementData ( player, "drivingSchoolCur", 0 )
		vioSetElementData ( player, "drivingSchoolPractise", true )
		
		toggleControl ( player, "enter_exit", false )
		
		outputChatBox ( "Um die praktische Pruefung abzuschliesen, musst die die vorgegebene Strecke abfahren.", player, 200, 200, 0 )
		outputChatBox ( "Beachte dabei jedoch, dass du nicht schneller als 80 km/h fahren darfst - sonst ist die Pruefung gelaufen!", player, 200, 200, 0 )
		outputChatBox ( "Druecke X und L, um Licht oder Motor ein- oder aus zu schalten!", player, 200, 200, 0 )
		
		setTimer ( triggerClientEvent, 1000, 1, player, "checkDrivingSchoolSpeed", player )
		
		showNextDrivingSchoolMarker ( player )
		
		addEventHandler ( "onVehicleExit", veh,
			function ( player )
				infobox ( player, "Du hast das Fahrzeug verlassen!", 5000, 125, 0, 0 )
				spawnAfterDrivingSchool ( player )
			end
		)
		addEventHandler ( "onPlayerQuit", player, drivingSchoolQuit )
	else
		infobox ( player, "Du bist durchgefallen!\nDu hast nur "..correct.." / 7\n Fragen richtig be-\nantwortet.", 5000, 125, 0, 0 )
		spawnAfterDrivingSchool ( player )
	end
end
addEvent ( "drivingSchoolTheoryComplete", true )
addEventHandler ( "drivingSchoolTheoryComplete", getRootElement(), drivingSchoolTheoryComplete_func )

function drivingSchoolQuit ()

	local player = source
	if vioGetElementData ( player, "drivingSchoolPractise" ) then
		spawnAfterDrivingSchool ( player )
	end
end

function drivingSchoolToFast_func ()

	local client = player
	if vioGetElementData ( player, "drivingSchoolPractise" ) then
		spawnAfterDrivingSchool ( player )
		infobox ( player, "Du bist zu\nschnell gefahren!", 5000, 125, 0, 0 )
	end
end
addEvent ( "drivingSchoolToFast", true )
addEventHandler ( "drivingSchoolToFast", getRootElement(), drivingSchoolToFast_func )

function spawnAfterDrivingSchool ( player )

	if vioGetElementData ( player, "drivingSchoolPractise" ) then
		vioSetElementData ( player, "drivingSchoolPractise", false )
		local veh = vioGetElementData ( player, "drivingSchoolVeh" )
		if veh then
			if isElement ( veh ) then
				removePedFromVehicle ( player )
				destroyElement ( veh )
			end
		end
		local ped = vioGetElementData ( player, "drivingSchoolPed" )
		if ped then
			if isElement ( ped ) then
				destroyElement ( ped )
			end
		end
		local old = vioGetElementData ( player, "drivingSchoolMarker" )
		if old then
			if isElement ( old ) then
				destroyElement ( old )
				destroyElement ( vioGetElementData ( player, "drivingSchoolBlip" ) )
			end
		end
		
		if isElement ( player ) then
			setElementInterior ( player, 3 )
			toggleControl ( player, "enter_exit", true )
			setElementPosition ( player, 364.42 + 5, 173.81, 1008.039 )
			setPedRotation ( player, 90 )
			setCameraTarget ( player )
			setElementDimension ( player, 0 )
			showCursor ( player, false )
			setElementData ( player, "ElementClicked", false )
			triggerClientEvent ( player, "drivingSchoolFinished", player )
		end
	end
end