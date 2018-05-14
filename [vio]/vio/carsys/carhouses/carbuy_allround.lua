function carbuy ( player, carprice, vehid, spawnx, spawny, spawnz, rx, ry, rz, c1, c2, c3, c4, p, ec, Tuning )

	vehid = tonumber ( vehid )
	local pname = getPlayerName ( player )
	local differenz
	
	if not carprices[vehid] then
		if aiCarPrices[vehid] then
			table.insert ( carprices, vehid, aiCarPrices[vehid] )
		end
	end
	local hasCamper = false
	local id
	local result = dbPoll( dbQuery ( handler, "SELECT Typ FROM vehicles WHERE Besitzer LIKE ? AND Slot LIKE ?", pname, i ), -1 )
	if result and result[1] then
		for i=1, #result do
			id = tonumber( result[i]["Typ"] )
			if id then
				if camper[id] then
					hasCamper = true
					break
				end
			end
		end
	end
	if camper[vehid] and hasCamper then
		outputChatBox ( "Du kannst nur einen Wohnwagen haben!", player, 125, 0, 0 )
	else
		if carprices[vehid] or vioGetElementData ( player, "everyCarBuyableForFree" ) then
			if vioGetElementData ( player, "maxcars" ) > vioGetElementData ( player, "curcars" ) then
				local i = true
				vioSetElementData ( player, "carbuyslot", 0 )
				carslotnr = 1
				sucesfull = false
				for i = 1, tonumber(vioGetElementData ( player, "maxcars" )) do
					carslotzahl = "carslot"..carslotnr
					if tonumber(vioGetElementData ( player, carslotzahl )) == 0 then
						vioSetElementData ( player, "carbuyslot", carslotnr )
						sucesfull = true
						break
					else
						y = carslotnr
						carslotnr = ( y + 1 )
					end
				end
				if not sucesfull then
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits zuviele\nFahrzeuge, zerstoere oder\nverkaufe eines deiner\nalten!", 5000, 255, 0, 0 )
				else
					if not vioGetElementData ( player, "everyCarBuyableForFree" ) then
						if carprices[tonumber(vehid)] then
							carprice = carprices[tonumber(vehid)]
						end
						if ec then
							differenz = vioGetElementData ( player, "bankmoney" ) - carprice
						else
							differenz = vioGetElementData ( player, "money" ) - carprice
						end
					end
					if vioGetElementData ( player, "everyCarBuyableForFree" ) or differenz >= 0 then
						if hasPlayerLicense ( player, tonumber(vehid) ) then
							setElementDimension ( player, 0 )
							setElementInterior ( player, 0 )
							fadeCamera( player, true)
							setCameraTarget( player, player )
							
							local x = getPlayerName ( player )
							local y = vioGetElementData ( player, "carbuyslot" )
							xy = x..y
							
							spawnX = tonumber ( spawnx )
							spawnY = tonumber ( spawny )
							spawnZ = tonumber ( spawnz )
							
							_G[getPrivVehString ( x, y )] = createVehicle ( vehid, spawnX, spawnY, spawnZ, 0, 0, 0, getPlayerName ( player ) )
							vioSetElementData ( _G[getPrivVehString ( x, y )], "owner", pname )
							vioSetElementData ( _G[getPrivVehString ( x, y )], "name", "privVeh"..x..y )
							vioSetElementData ( _G[getPrivVehString ( x, y )], "carslotnr_owner", y )
							vioSetElementData ( _G[getPrivVehString ( x, y )], "locked", true )
							vioSetElementData ( _G[getPrivVehString ( x, y )], "fuelstate", 100 )
							
							setVehicleLocked ( _G[getPrivVehString ( x, y )], true )
							local z = vioGetElementData ( player, "carbuyslot" )
							vioSetElementData ( player, "carslot"..z, 1 )
							vioSetElementData ( player, "curcars", vioGetElementData ( player, "curcars" )+1 )
							
							local Besitzer = vioGetElementData ( _G[getPrivVehString ( x, y )], "owner" )
							if not Tuning then
								Tuning = "|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|"
							end
							local Spawnpos_X, Spawnpos_Y, Spawnpos_Z = getElementPosition ( _G[getPrivVehString ( x, y )] )
							local Slot = vioGetElementData ( _G[getPrivVehString ( x, y )], "carslotnr_owner" )
							setVehicleRotation ( _G[getPrivVehString ( x, y )], rx, ry, rz )
							local Spawnrot_X, Spawnrot_Y, Spawnrot_Z = getVehicleRotation ( _G[getPrivVehString ( x, y )] )
							
							local Farbe1, Farbe2, Farbe3, Farbe4
							local Paintjob
							
							if not c1 or not c2 or not c3 or not c4 then
								Farbe1, Farbe2, Farbe3, Farbe4 = getVehicleColor ( _G[getPrivVehString ( x, y )] )
							else
								Farbe1, Farbe2, Farbe3, Farbe4 = c1, c2, c3, c4
								setVehicleColor ( _G[getPrivVehString ( x, y )], c1, c2, c3, c4 )
							end
							if not p then
								Paintjob = getVehiclePaintjob ( _G[getPrivVehString ( x, y )] )
							else
								Paintjob = p
								setVehiclePaintjob ( _G[getPrivVehString ( x, y )], p )
							end
							local Benzin = vioGetElementData ( _G[getPrivVehString ( x, y )], "fuelstate" )
							vioSetElementData ( _G[getPrivVehString ( x, y )], "stuning", "0|0|0|0|0|0|" )
							
							local color = "|"..Farbe1.."|"..Farbe2.."|"..Farbe3.."|"..Farbe4.."|"
							vioSetElementData ( _G[getPrivVehString ( x, y )], "color", color )
							vioSetElementData ( _G[getPrivVehString ( x, y )], "lcolor", "|255|255|255|" )
							setPrivVehCorrectLightColor ( _G[getPrivVehString ( x, y )] )
							
							specPimpVeh ( _G[getPrivVehString ( x, y )] )
							SaveCarData ( player )
							
							outputChatBox ( "Glueckwunsch, du hast das Fahrzeug gekauft! Tippe /vehhelp für mehr Infomationen oder rufe das Hilfemenue auf!", player, 0, 255, 0 )
							
							checkCarWahnAchiev( player )
							
							if not vioGetElementData ( player, "everyCarBuyableForFree" ) then
								if ec then
									vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) - carprice )
									triggerClientEvent ( player, "createNewStatementEntry", player, "Fahrzeugkauf\n", carprice * -1, getVehicleNameFromModel ( vehid ).."\n" )
								else
									vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - carprice )
									takePlayerMoney ( player, carprice )
									triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								end
							end
							warpPedIntoVehicle ( player, _G[getPrivVehString ( x, y )], 0 )
							
							if vioGetElementData ( player, "playingtime" ) <= 300 then
								local text = "Du hast soeben ein Fahrzeug erworben!\nHier einige kurze Hinweise:\n\n1. Du kannst dein Fahrzeug mit /park an einem neuen\nOrt abstellen - dort wird es nach einem Server-\nrestart oder wenn du /towveh eintippst, erscheinen.\n\n2. Den Motor schaltest du mit \"X\" ein und aus.\n\n3. Mit /lock kannst du dein Fahrzeug abschliessen.\n\n4. Parke dein Fahrzeug nur an angemessenen Stellen,\nsonst wird es moeglicherweise geloescht.\nNicht angemessene Stellen sind z.b. auf der Strasse oder\nan wichtigen Stellen ( z.b. dem Eingang der Stadthalle ).\n\nFuer mehr: /vehinfos"
								prompt ( player, text, 30 )
							end
							
							local result = dbExec(handler, "INSERT INTO vehicles (Besitzer, Typ, Tuning, Spawnpos_X, Spawnpos_Y, Spawnpos_Z, Spawnrot_X, Spawnrot_Y, Spawnrot_Z, Farbe, Paintjob, Benzin, Slot) VALUES (?, "..vehid..", '"..Tuning.."', '"..Spawnpos_X.."', '"..Spawnpos_Y.."', '"..Spawnpos_Z.."', '"..Spawnrot_X.."', '"..Spawnrot_Y.."', '"..Spawnrot_Z.."', '"..color.."', '"..Paintjob.."', '"..Benzin.."', '"..Slot.."')", Besitzer )
							if ( not result ) then
								outputDebugString("Error executing the query in carbuy" )
								destroyElement ( _G[getPrivVehString ( x, y )] )
							end
							activeCarGhostMode ( player, 10000 )
							
							setElementPosition ( _G[getPrivVehString ( x, y )], spawnx, spawny, spawnz )
							vioSetElementData ( player, "everyCarBuyableForFree", false )
							return true
						else
							outputChatBox ( "Du hast nicht die erforderlichen Scheine / Boni!", player, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Das\nFahrzeug kostet\n"..carprice.." $!", 5000, 125, 0, 0 )
					end
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast keinen\nfreien Fahrzeugslot!\nTippe /sellcar, um\neines deiner Fahr-\nzeuge zu ver-\nkaufen.", 5000, 125, 0, 0 )
			end
		end
	end
	return false
end

function getFreeCarSlot ( player )

	if vioGetElementData ( player, "maxcars" ) > vioGetElementData ( player, "curcars" ) then
		local cars = 0
		for i = 1, 10 do
			if vioGetElementData ( player, "carslot"..i ) == 0 then
				return i
			end
		end
	else
		return false
	end
end