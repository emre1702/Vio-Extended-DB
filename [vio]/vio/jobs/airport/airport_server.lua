﻿airportjobicon = createPickup ( -1414.8072509766, -299.4963684082, 5.8523507118225, 3, 1239, 1, 99 )

flughafenModels = { 
[592]=true,
[577]=true,
[511]=true,
[512]=true,
[593]=true,
[553]=true,
[519]=true,
[485]=true
 }

function cancelAirportMission ( veh )

	if vioGetElementData ( source, "isinairportmission" ) then
		if flughafenModels [ getElementModel ( veh ) ] then
			destroyElement ( veh )
			killTrailer_func ( source, 1 )
			killTrailer_func ( source, 2 )
			killTrailer_func ( source, 3 )
			setElementDimension ( source, 0 )
			toggleControl ( source, "sub_mission", true )
			vioSetElementData ( source, "isinairportmission", false )
			infobox ( source, "Auftrag gescheitert -\nDu hast das Fahrzeug\nverlassen!", 5000, 125, 0, 0 )
			setElementPosition ( source, -1417.6236572266, -302.36517333984, 5.8523507118225 )
			removeEventHandler ( "onPlayerVehicleExit", source, cancelAirportMission )
			
			local pname = getPlayerName ( player )
			for i = 1, 3 do
				if isElement ( _G["BaggageTrailer"..i..pname] ) then
					destroyElement ( _G["BaggageTrailer"..i..pname] )
				end
			end
		end
	end
end

function airportjobiconHit ( player )
	
	if vioGetElementData ( player, "job" ) == "airport" and not getPedOccupiedVehicle ( player ) then
		local dim = getFreeDimension ()
		vioSetElementData ( player, "jobDimension", dim )
		showCursor ( player, true )
		vioSetElementData ( player, "ElementClicked", true )
		triggerClientEvent ( player, "showAirportJobGui", getRootElement() )
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Tippe /job, um\nam Fluhafen zu\narbeiten -\n dazu brauchst du\neinen Fuehrerschein.", 5000, 200, 200, 0 )
	end
end
addEventHandler ( "onPickupHit", airportjobicon, airportjobiconHit )

function airportjobDimFix_func ( player )

	player = client
	local t = getRealTime()
	local minutes = t.minute 
	local hour = t.hour
	vioSetElementData ( player, "jobStartedM", minutes )
	vioSetElementData ( player, "jobStartedH", hour )
	
	vioSetElementData ( player, "isinairportmission", true )
	local pname = getPlayerName ( player )
	local dim = vioGetElementData ( player, "jobDimension" )
	_G["Baggage"..pname] = createVehicle ( 485, -1264.0727539063, 34.647338867188, 13.841641426086, 0, 0, 135 )
	_G["BaggageTrailer1"..pname] = createVehicle ( 606, -1260.7633056641, 31.612400054932, 13.841641426086, 0, 0, 135 )
	_G["BaggageTrailer2"..pname] = createVehicle ( 606, -1258.3664550781, 29.416164398193, 13.841641426086, 0, 0, 135 )
	_G["BaggageTrailer3"..pname] = createVehicle ( 607, -1255.9699707031, 27.217338867188, 13.841641426086, 0, 0, 135 )
	setElementDimension ( _G["Baggage"..pname], dim )
	setElementDimension ( _G["BaggageTrailer1"..pname], dim )
	setElementDimension ( _G["BaggageTrailer2"..pname], dim )
	setElementDimension ( _G["BaggageTrailer3"..pname], dim )
	setElementDimension ( player, dim )
	warpPedIntoVehicle ( player, _G["Baggage"..pname] )
	addEventHandler ( "onPlayerVehicleExit", player, cancelAirportMission )
	infobox ( player, "Bring das Gepaeck\nzu den Flugzeugen!", 5000, 200, 200, 10 )
end
addEvent ( "airportjobDimFix", true )
addEventHandler ( "airportjobDimFix", getRootElement(), airportjobDimFix_func )

function killTrailer_func ( player, trailer )

	local pname = getPlayerName ( player )
	if player == client then
		if isElement ( trailer ) then
			destroyElement ( trailer )
		end
	end
end
addEvent ( "killTrailer", true )
addEventHandler ( "killTrailer", getRootElement(), killTrailer_func )

function baggageMissionComplete_func ( player )

	if player == client then
		local t = getRealTime()
		local minutes = t.minute 
		local hour = t.hour
		local dist = getDistanceBetweenMinutes ( vioGetElementData ( player, "jobStartedM" ), vioGetElementData ( player, "jobStartedH" ), minutes, hour )
		if dist >= 1 then
			local veh = getPedOccupiedVehicle ( player )
			local trailer = getVehicleTowedByVehicle ( veh )
			vioSetElementData ( player, "isinairportmission", false )
			local pname = getPlayerName ( player )
			removePedFromVehicle ( player )
			setElementDimension ( player, 0 )
			infobox ( player, "Auftrag abgeschlossen!\nDu erhaelst 75 $!", 5000, 0, 125, 0 )
			increaseAirportLevel ( player, 1 )
			local pmoney = vioGetElementData ( player, "money" )
			vioSetElementData ( player, "money", pmoney + 75 )
			givePlayerMoney ( player, 75 )
			triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )	
			setElementPosition ( player, -1417.6236572266, -302.36517333984, 5.8523507118225 )
			destroyElement ( veh )
			destroyElement ( trailer )
		end
	end
end
addEvent ( "baggageMissionComplete", true )
addEventHandler ( "baggageMissionComplete", getRootElement(), baggageMissionComplete_func )

function airportJobInsektenvernichter_func ( player )

	if player == client then
		local t = getRealTime()
		local t = getRealTime()
		local minutes = t.minute 
		local hour = t.hour
		vioSetElementData ( player, "jobStartedM", minutes )
		vioSetElementData ( player, "jobStartedH", hour )
		
		vioSetElementData ( player, "isinairportmission", true )
		local pname = getPlayerName ( player )
		local dim = vioGetElementData ( player, "jobDimension" )
		vioSetElementData ( player, "jobDimension", dim )
		_G["Cropduster"..pname] = createVehicle ( 512, -1432.7407226563, -953.34649658203, 201.60592651367, 0, 0, 270 )
		setTimer ( warpPedIntoVehicle, 300, 1, player, _G["Cropduster"..pname] )
		setControlState ( player, "sub_mission", true )
		setTimer ( setControlState, 200, 1, player, "sub_mission", false )
		toggleControl ( player, "sub_mission", false )
		setElementDimension ( _G["Cropduster"..pname], dim )
		setElementDimension ( player, dim )
		
		vioSetElementData ( player, "airportMissionVeh", _G["Cropduster"..pname] )
		addEventHandler ( "onPlayerQuit", player, airportMissionCrash )
	end
end
addEvent ( "airportJobInsektenvernichter", true )
addEventHandler ( "airportJobInsektenvernichter", getRootElement(), airportJobInsektenvernichter_func )

function airportMissionCrash ()

	local veh = vioGetElementData ( source, "airportMissionVeh" )
	if veh then
		if isElement ( veh ) then
			destroyElement ( veh )
		end
	end
end

function cropdusterMissionComplete_func ( player )

	if player == client then
		removeEventHandler ( "onPlayerQuit", player, airportMissionCrash )
		
		local t = getRealTime()
		local minutes = t.minute 
		local hour = t.hour
		local dist = getDistanceBetweenMinutes ( vioGetElementData ( player, "jobStartedM" ), vioGetElementData ( player, "jobStartedH" ), minutes, hour )
		if dist >= 1 then
			if vioGetElementData ( player, "isinairportmission" ) then	
				local t = getRealTime()
				local minutes = t.minute 
				local hour = t.hour
				vioSetElementData ( player, "jobStartedM", minutes )
				vioSetElementData ( player, "jobStartedH", hour )
			
				toggleControl ( player, "sub_mission", true )
				vioSetElementData ( player, "isinairportmission", false )
				local pname = getPlayerName ( player )
				local veh = getPedOccupiedVehicle ( player )
				removePedFromVehicle ( player )
				if getElementModel ( veh ) == 512 then
					destroyElement ( veh )
				end
				setElementDimension ( player, 0 )
				infobox ( player, "Auftrag abgeschlossen!\nDu erhaelst 125 $!", 5000, 0, 125, 0 )
				increaseAirportLevel ( player, 2 )
				local pmoney = vioGetElementData ( player, "money" )
				vioSetElementData ( player, "money", pmoney + 125 )
				givePlayerMoney ( player, 125 )
				triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )	
				setElementPosition ( player, -1417.6236572266, -302.36517333984, 5.8523507118225 )
			end
		end
	end
end
addEvent ( "cropdusterMissionComplete", true )
addEventHandler ( "cropdusterMissionComplete", getRootElement(), cropdusterMissionComplete_func )

function increaseAirportLevel ( player, lvl )

	local airportlvl = tonumber ( vioGetElementData ( player, "airportlvl" ) )
	if airportlvl < 20 then
		if airportlvl + lvl >= 20 then
			vioSetElementData ( player, "airportlvl", 20 )
			infobox ( player, "Dein Flughafenlevel ist\nnun auf Maximum.", 5000, 125, 0, 0 )
			triggerClientEvent ( player, "showAchievmentBox", player, " From Zero\n to Hero", 25, 10000 )
			vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 25 )
		else
			vioSetElementData ( player, "airportlvl", airportlvl + lvl )
			infobox ( player, "Dein Flughafenlevel wurde\nerhoeht und liegt\njetzt bei "..airportlvl+lvl.."/20", 5000, 0, 150, 0 )
		end
	end
end

function airportJobFlight_func ( player, veh, x, y, z, rot )

	if player == client then
		local t = getRealTime()
		local minutes = t.minute 
		local hour = t.hour
		vioSetElementData ( player, "jobStartedM", minutes )
		vioSetElementData ( player, "jobStartedH", hour )
		
		vioSetElementData ( player, "isinairportmission", true )
		local pname = getPlayerName ( player )
		local dim = vioGetElementData ( player, "jobDimension" )
		vioSetElementData ( player, "jobDimension", dim )
		_G["Plane"..pname] = createVehicle ( veh, x, y, z, 0, 0, rot )
		setElementDimension ( _G["Plane"..pname], dim )
		setElementDimension ( player, dim )
		setTimer ( warpPedIntoVehicle, 300, 1, player, _G["Plane"..pname] )
		setTimer (
			function ( player )
				if isElement ( player ) then
					addEventHandler ( "onPlayerVehicleExit", player, cancelAirportMission )
				end
			end,
		500, 1, player )
		
		vioSetElementData ( player, "airportMissionVeh", _G["Plane"..pname] )
		addEventHandler ( "onPlayerQuit", player, airportMissionCrash )
	end
end
addEvent ( "airportJobFlight", true )
addEventHandler ( "airportJobFlight", getRootElement(), airportJobFlight_func )

function airportJobFreightFinished_func ( player, vehid )

	if player == client then
		removeEventHandler ( "onPlayerQuit", player, airportMissionCrash )
		
		if vioGetElementData ( player, "isinairportmission" ) then
			vioSetElementData ( player, "isinairportmission", false )
			local veh = getPedOccupiedVehicle ( player )
			removePedFromVehicle ( player )
			setElementDimension ( player, 0 )
			if vehid == 593 or vehid == 511 then
				local t = getRealTime()
				local minutes = t.minute 
				local hour = t.hour
				local dist = getDistanceBetweenMinutes ( vioGetElementData ( player, "jobStartedM" ), vioGetElementData ( player, "jobStartedH" ), minutes, hour )
				if dist >= 2 then
					destroyElement ( veh )
					earned = 225
				end
			elseif vehid == 553 or vehid == 519 then
			local t = getRealTime()
				local minutes = t.minute 
				local hour = t.hour
				local dist = getDistanceBetweenMinutes ( vioGetElementData ( player, "jobStartedM" ), vioGetElementData ( player, "jobStartedH" ), minutes, hour )
				if dist >= 1 then
					destroyElement ( veh )
					earned = 300
				end
			elseif vehid == 592 or vehid == 577 then
				local t = getRealTime()
				local minutes = t.minute 
				local hour = t.hour
				local dist = getDistanceBetweenMinutes ( vioGetElementData ( player, "jobStartedM" ), vioGetElementData ( player, "jobStartedH" ), minutes, hour )
				if dist >= 1 then
					destroyElement ( veh )
					earned = 450
				end
			end
			infobox ( player, "Auftrag abgeschlossen!\nDu erhaelst "..earned.." $!", 5000, 0, 125, 0 )
			increaseAirportLevel ( player, 2 )
			local pmoney = vioGetElementData ( player, "money" )
			vioSetElementData ( player, "money", pmoney + earned )
			givePlayerMoney ( player, earned )
			triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )	
			setElementPosition ( player, -1417.6236572266, -302.36517333984, 5.8523507118225 )
		end
	end
end
addEvent ( "airportJobFreightFinished", true )
addEventHandler ( "airportJobFreightFinished", getRootElement(), airportJobFreightFinished_func )