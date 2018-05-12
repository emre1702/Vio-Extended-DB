jobicons = {}

function isHitman ( player )
	if vioGetElementData ( player, "job" ) == "hitman" then return true else return false end
end

function ad_func ( player, cmd, ... )
	
	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	local length = #stringWithAllParameters
	local costs = length*adcosts+adbasiscosts
	if vioGetElementData ( player, "money" ) >= costs then
		if #stringWithAllParameters <= 70 then
			if vioGetElementData ( player, "playingtime" ) >= 180 then
				local time = getRealTime()
				local curtime = time.second+time.minute*60+time.hour*60*60
				if lastadtime-curtime < -30 or lastadtime > curtime then
					lastadtime = curtime
					outputChatBox ( "Werbung von "..getPlayerName ( player ).." [Handy: "..vioGetElementData(player,"telenr").."]: "..stringWithAllParameters, getRootElement(), 0, 200, 50 )
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - costs )
					takePlayerMoney ( player, costs )
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
					playSoundFrontEnd ( player, 40 )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nEs kann nur\nalle 30 Sekunden\neine Werbung\ngeschaltet werden!", 7500, 125, 0, 0 )
				end	
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu musst min-\ndestens schon\n180 Minuten gespielt\nhaben!", 7500, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDeine Werbung darf\nMaximal 70\nZeichen beinhalten!", 7500, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast zu wenig\nGeld! Werbung\nkostet "..adcosts.." $ pro\nZeichen und "..adbasiscosts.." $ \nGrundkosten", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "ad", ad_func )

function getElementJobPosition ( element )

	local x, y, z = 0, 0, 0
	if isElement ( element ) then
		x, y, z = getElementPosition ( element )
	end
	return x, y, z
end

function job_func ( player )

	triggerClientEvent ( player, "killcityhallmarker", getRootElement() )
	local x1, y1, z1 = getElementJobPosition ( player )
	local x2, y2, z2 = getElementJobPosition ( fischerjobicon )
	local x3, y3, z3 = getElementJobPosition ( taxijobicon )
	local x4, y4, z4 = getElementJobPosition ( drugjobicon )
	local x5, y5, z5 = getElementJobPosition ( mechanikerjobicon )
	local x6, y6, z6 = getElementJobPosition ( wdealerjobicon )
	local x7, y7, z7 = getElementJobPosition ( jobicons["trucker"] )
	local x8, y8, z8 = getElementJobPosition ( airportjobicon )
	local x9, y9, z9 = getElementJobPosition ( hitmanjobicon )
	local x10, y10, z10 = getElementJobPosition ( hotdogjobicon )
	local x11, y11, z11 = getElementJobPosition ( jobicons["trash"] )
	local x12, y12, z12 = getElementJobPosition ( jobicons["farmer"] )
	if tonumber ( vioGetElementData ( player, "jobtime" ) ) == 0 then
		if vioGetElementData ( player, "job" ) == "none" then
			if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) < 5 then
				if vioGetElementData ( player, "fishinglicense" ) == 1 and vioGetElementData ( player, "motorbootlicense" ) == 1 then
					vioSetElementData ( player, "job", "fischer" )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nFischer! Oeffne das\nHilfemenue fuer\nmehr Informationen!", 7500, 0, 125, 0 )
					setElementVisibleTo ( fischerblip, player, true )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du brauchst\neinen Angel- und\neinen Boots-\nschein!", 5000, 125, 0, 0 )
				end
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x3, y3, z3 ) < 5 then
				if vioGetElementData ( player, "carlicense" ) == 1 then
					vioSetElementData ( player, "job", "taxifahrer" )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nTaxifahrer! Oeffne\ndas Hilfemenue fuer\nmehr Informationen!", 7500, 0, 125, 0 )
					setElementVisibleTo ( taxiblip, player, true )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu brauchst\neinen Fuehrer-\nschein!", 5000, 125, 0, 0 )
				end
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x4, y4, z4 ) < 5 then
				vioSetElementData ( player, "job", "dealer" )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nDealer! Oeffne\ndas Hilfemenue fuer\nmehr Informationen!", 7500, 0, 125, 0 )
				setElementVisibleTo ( drugsjobiconblip, player, true )
				triggerClientEvent ( player, "createDrugJobMarker", getRootElement() )
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x5, y5, z5 ) < 5 then
				vioSetElementData ( player, "job", "mechaniker" )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nMechaniker! Oeffne\ndas Hilfemenue fuer\nmehr Informationen!", 7500, 0, 125, 0 )
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x6, y6, z6 ) < 5 then
				vioSetElementData ( player, "job", "wdealer" )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nWaffendealer! Oeffne\ndas Hilfemenue fuer\nmehr Informationen!", 7500, 0, 125, 0 )
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x7, y7, z7 ) < 5 then
				vioSetElementData ( player, "job", "transporteur" )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nTransporteur! Oeffne\ndas Hilfemenue fuer\nmehr Informationen!", 7500, 0, 125, 0 )
				setElementVisibleTo ( truckericonblip, player, true )
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x8, y8, z8 ) < 5 then
				vioSetElementData ( player, "job", "airport" )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nFlughafenmitarbeiter!\nOeffne das\nHilfemenue fuer\nmehr Informationen!", 7500, 0, 125, 0 )
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x9, y9, z9 ) < 5 then
				--[[if vioGetElementData ( player, "silentassasin_achiev" ) == "done" then
					vioSetElementData ( player, "job", "hitman" )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nHitman!\nOeffne das\nHilfemenue fuer\nmehr Informationen!", 7500, 0, 125, 0 )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du musst erst\ndie Mission \"The\nTruth is out\nthere\" ohne\nAlarm schaffen!", 5000, 125, 0, 0 )
				end]]
				outputChatBox ( "Vorruebergehend deaktiviert!", player, 125, 0, 0 )
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x10, y10, z10 ) < 5 then
				vioSetElementData ( player, "job", "hotdog" )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nHotdogverkaeufer!\nOeffne das\nHilfemenue fuer\nmehr Informationen!", 7500, 0, 125, 0 )
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x11, y11, z11 ) < 5 then
				vioSetElementData ( player, "job", "streetclean" )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nStrassenreiniger!\nOeffne das\nHilfemenue fuer\nmehr Informationen!", 7500, 0, 125, 0 )
			elseif getDistanceBetweenPoints3D ( x1, y1, z1, x12, y12, z12 ) < 5 then
				vioSetElementData ( player, "job", "farmer" )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nFarmer!\nOeffne das\nHilfemenue fuer\nmehr Informationen!", 7500, 0, 125, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bei\nkeinem Arbeitgeber!", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits\neinen Job! Tippe\n/quitjob, um zu\nkuendigen.", 5000, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du musst noch\n"..vioGetElementData ( player, "jobtime" ).." Minuten\nwarten, bis du\neinen Job\nannehmen kannst.", 5000, 125, 0, 0 )
	end
	showFittingBlipForPlayer ( player )
end
addCommandHandler ( "job", job_func )

function quitjob_func ( player )

	if not vioSetElementData ( player, "isWorking" ) then
		if vioGetElementData ( player, "job" ) == "none" or getElementModel ( getPedOccupiedVehicle ( player ) ) == 453 then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nDu hast keinen\nJob!", 5000, 125, 0, 0 )
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nDu bist nun\narbeitslos!", 7500, 0, 125, 0 )
			setElementVisibleTo ( fischerblip, player, false )
			vioSetElementData ( player, "job", "none" )
			hideblips ( player )
			triggerClientEvent ( player, "destroyDrugJobMarker", player )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nDu arbeitest gerade!", 5000, 125, 0, 0 )
	end
end
addCommandHandler ( "quitjob", quitjob_func )

function hideblips ( player )

	setElementVisibleTo ( fischerblip, player, false )
	setElementVisibleTo ( taxiblip, player, false )
	setElementVisibleTo ( drugsjobiconblip, player, false )
	setElementVisibleTo ( hitmanblip, player, false )
	setElementVisibleTo ( hotdogblip, player, false )
end

function showFittingBlipForPlayer ( player )

	local job = vioGetElementData ( player, "job" )
	if job == "fischer" then
		setElementVisibleTo ( fischerblip, player, true )
	elseif job == "taxifahrer" then
		setElementVisibleTo ( taxiblip, player, true )
	elseif job == "dealer" then
		setElementVisibleTo ( drugsjobiconblip, player, true )
		triggerClientEvent ( player, "createDrugjobMarker", getRootElement() )
	elseif job == "hitman" then
		setElementVisibleTo ( hitmanblip, player, true )
	elseif job == "hotdog" then
		setElementVisibleTo ( hotdogblip, player, true )
	else
		hideblips ( player )
	end
end

function eject_func ( player, cmd, nick )

	if getPedOccupiedVehicleSeat ( player ) == 0 then
		local target = getPlayerFromName ( nick )
		local veh = getPedOccupiedVehicle ( player )
		if target and target ~= player then
			if getPedOccupiedVehicle ( target ) == veh then
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\n"..nick.."\naus deinem Fahrzeug\ngeworfen!", 7500, 0, 125, 0 )
				triggerClientEvent ( target, "infobox_start", getRootElement(), "\nDu wurdest aus\ndem Fahrzeug\ngeworfen!", 7500, 0, 125, 0 )
				opticExitVehicle ( target )
				--setPedAnimation ( target, "ped", "CAR_fallout_LHS", -1, false, true, false )
				--setTimer ( carEject, 1000, 1, player )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDer Spieler sitzt\nicht in deinem\Fahrzeug!", 7500, 0, 125, 0 )
			end
		elseif nick == "all" then
			for i = 1, 4 do
				_G["seat"..i] = getVehicleOccupant ( veh, i )
				if _G["seat"..i] then 
					opticExitVehicle ( _G["seat"..i] )
					--setPedAnimation ( _G["seat"..i], "ped", "CAR_fallout_LHS", -1, false, true, false )
					--setTimer ( carEject, 1000, 1, _G["seat"..i] )
				end
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nUngueltiger Name!", 7500, 0, 125, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist kein\nFahrer!", 7500, 0, 125, 0 )
	end
end
addCommandHandler ( "eject", eject_func )

function carEject ( player )

	setPedAnimation ( player )
end