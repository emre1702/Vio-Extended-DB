taxijobicon = createPickup ( -2543.2326660156, 1228.1779785156, 37.116344451904, 3, 1239, 1000, 0 )

taxiblip = createBlip ( -2543.2326660156, 1228.1779785156, 37.116344451904, 52, 1, 255, 0, 0, 255, 0, 99999 )
setElementVisibleTo ( taxiblip, getRootElement(), false )

taxi1 = createVehicle ( 420, -2512.2512207031, 1209.8507080078, 37.271873474121, 0, 0, 270, "SF-CX 03" )
setVehicleRespawnPosition ( taxi1, getElementPosition ( taxi1 ) )
toggleVehicleRespawn ( taxi1, true )
setVehicleRespawnDelay ( taxi1, 1000*10 )
setVehicleIdleRespawnDelay ( taxi1, 1000*60 )

taxi2 = createVehicle ( 420, -2512.0871582031, 1205.3233642578, 37.271873474121, 0, 0, 270, "SF-HP 25" )
setVehicleRespawnPosition ( taxi2, getElementPosition ( taxi2 ) )
toggleVehicleRespawn ( taxi2, true )
setVehicleRespawnDelay ( taxi2, 1000*10 )
setVehicleIdleRespawnDelay ( taxi2, 1000*60 )

taxi3 = createVehicle ( 420, -2501.7060546875, 1222.2401123047, 37.278327941895, 0, 0, 145, "SF-KK 34" )
setVehicleRespawnPosition ( taxi3, getElementPosition ( taxi3 ) )
toggleVehicleRespawn ( taxi3, true )
setVehicleRespawnDelay ( taxi3, 1000*10 )
setVehicleIdleRespawnDelay ( taxi3, 1000*60 )

taxi4 = createVehicle ( 420, -2494.7189941406, 1217.1856689453, 37.278327941895, 0, 0, 145, "SF-CX 03" )
setVehicleRespawnPosition ( taxi4, getElementPosition ( taxi4 ) )
toggleVehicleRespawn ( taxi4, true )
setVehicleRespawnDelay ( taxi4, 1000*10 )
setVehicleIdleRespawnDelay ( taxi4, 1000*60 )

taxi5 = createVehicle ( 420, -2517.0568847656, 1229.1000976563, 37.278327941895, 0, 0, 210, "SF-HK 04" )
setVehicleRespawnPosition ( taxi5, getElementPosition ( taxi5 ) )
toggleVehicleRespawn ( taxi5, true )
setVehicleRespawnDelay ( taxi5, 1000*10 )
setVehicleIdleRespawnDelay ( taxi5, 1000*60 )

taxi6 = createVehicle ( 420, -2530.0539550781, 1229.2932128906, 37.278327941895, 0, 0, 210, "SF-TX 35" )
setVehicleRespawnPosition ( taxi6, getElementPosition ( taxi6 ) )
toggleVehicleRespawn ( taxi6, true )
setVehicleRespawnDelay ( taxi6, 1000*10 )
setVehicleIdleRespawnDelay ( taxi6, 1000*60 )

taxi7 = createVehicle ( 420, -2539.0537109375, 1229.4775390625, 37.278327941895, 0, 0, 210, "SF-BB 89" )
setVehicleRespawnPosition ( taxi7, getElementPosition ( taxi7 ) )
toggleVehicleRespawn ( taxi7, true )
setVehicleRespawnDelay ( taxi7, 1000*10 )
setVehicleIdleRespawnDelay ( taxi7, 1000*60 )

function jobicon_taxi ( player )
	
	triggerClientEvent ( player, "infobox_start", getRootElement(), "Tippe /job, um\nTaxifahrer zu werden -\n dazu brauchst du\neinen Fuehrer-\nschein!", 1000, 200, 200, 0 )
end
addEventHandler ( "onPickupHit", taxijobicon, jobicon_taxi )

function taxilight (player,key,state)

	if state == "down" then
		if getPedOccupiedVehicleSeat ( player ) == 0 then
			for i = 1, 7 do
				if _G["taxi"..i]  then
					if not isVehicleTaxiLightOn ( getPedOccupiedVehicle ( player ) ) then
						setVehicleTaxiLightOn ( getPedOccupiedVehicle ( player ), true )
					else
						setVehicleTaxiLightOn ( getPedOccupiedVehicle ( player ), false )
					end
				end
			end
			if getElementModel ( getPedOccupiedVehicle ( player ) ) == 420 or getElementModel ( getPedOccupiedVehicle ( player ) ) == 438 then
				if isVehicleTaxiLightOn ( getPedOccupiedVehicle ( player ) ) == false then
					setVehicleTaxiLightOn ( getPedOccupiedVehicle ( player ), true )
				else
					setVehicleTaxiLightOn ( getPedOccupiedVehicle ( player ), false )
				end
			end
		end
	end
end

function VehicleTaxiEnter ( veh, seat )

	if (getElementModel ( veh ) == 420 or getElementModel ( veh ) == 438) and vioGetElementData ( source, "job" ) == "taxifahrer" and seat == 0 then
		bindKey ( source, "sub_mission", "down", taxilight )
	elseif (getElementModel ( veh ) == 420 or getElementModel ( veh ) == 438) and vioGetElementData ( source, "job" ) ~= "taxifahrer" and seat == 0 then
		for i = 1, 7 do
			if _G["taxi"..i] == veh then
				opticExitVehicle ( source )
				triggerClientEvent ( source, "infobox_start", getRootElement(), "\n\nDu bist\nkein Taxifahrer!", 5000, 125, 0, 0 )
			end
		end
	elseif (getElementModel ( veh ) == 420 or getElementModel ( veh ) == 438) and seat ~= 0 then
		if isVehicleTaxiLightOn ( veh ) then
			local driver = getVehicleOccupant ( veh, 0 )
			local passenger = source
			if driver ~= false and driver ~= nil then
				triggerClientEvent ( driver, "infobox_start", getRootElement(), "\nEin Kunde ist\nin dein Taxi\ngestiegen!", 5000, 125, 0, 0 )
				triggerClientEvent ( passenger, "infobox_start", getRootElement(), "Du zahlst dem\nTaxifahrer "..taxipreis.." $\npro 5 Sekunden", 5000, 125, 0, 0 )
				setTimer ( paycheckTaxi, 5000, 1, passenger, driver )
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), VehicleTaxiEnter )

function paycheckTaxi ( passenger, driver )

	if getPedOccupiedVehicleSeat ( driver ) == 0 and getPedOccupiedVehicleSeat ( passenger ) then
		if vioGetElementData ( passenger, "money" ) >= taxipreis then
			takePlayerMoney ( passenger, taxipreis )
			givePlayerMoney ( driver, taxipreis )
			triggerClientEvent ( passenger, "HudEinblendenMoney", getRootElement() )
			triggerClientEvent ( driver, "HudEinblendenMoney", getRootElement() )
			vioSetElementData ( passenger, "money", vioGetElementData ( passenger, "money" ) - taxipreis )
			vioSetElementData ( driver, vioGetElementData ( driver, "money" ) + taxipreis )
			setTimer ( paycheckTaxi, 5000, 1, passenger, driver )
		else
			triggerClientEvent ( passenger, "infobox_start", getRootElement(), "\nDu hast nicht\n mehr genug\nGeld!", 5000, 125, 0, 0 )
			triggerClientEvent ( driver, "infobox_start", getRootElement(), "\nDu hast nicht\n mehr genug\nGeld!", 5000, 125, 0, 0 )
		end
	end
end