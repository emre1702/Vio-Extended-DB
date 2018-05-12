vehBlipColor = {}
	vehBlipColor["r"] = {}
	vehBlipColor["g"] = {}
	vehBlipColor["b"] = {}
		color = 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 125
		vehBlipColor["g"][color] = 125
		vehBlipColor["b"][color] = 125
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 150
		vehBlipColor["b"][color] = 0
		color = color + 1
		color = nil

function towveh_func ( player, command, towcar )

	if towcar == nil then
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nGebrauch:\n/towveh\n[Fahrzeugnummer]", 5000, 125, 0, 0 )
	else
		if tonumber(vioGetElementData ( player, "carslot"..towcar )) >= 1 then
			local pname = MySQL_Save ( getPlayerName ( player ) )
			if vioGetElementData ( player, "money" ) >= 35 then
				if respawnPrivVeh ( towcar, pname ) then
					vioSetElementData ( player, "money", tonumber(vioGetElementData ( player, "money" )) - 35 )
					takePlayerMoney ( player, 35 )
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast dein\nFahrzeug respawnt!", 5000, 0, 255, 0 )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDas Fahrzeug ist\nnicht leer!", 5000, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast kein\nFahrzeug mit\ndieser Nummer!", 5000, 125, 0, 0 )
		end
	end
end
addEvent ( "respawnPrivVehClick", true )
addEventHandler ( "respawnPrivVehClick", getRootElement(), towveh_func )
addCommandHandler ( "towveh", towveh_func )

function sellcarto_func ( player, cmd, target, price, pSlot )

	if target and pSlot and getPlayerFromName ( target ) and tonumber ( pSlot ) then
		pSlot = MySQL_Save ( pSlot )
		tSlot = getFreeCarSlot ( getPlayerFromName ( target ) )
		local pname = getPlayerName ( player )
		local target = getPlayerFromName ( target )
		if tonumber ( MySQL_GetString("vehicles", "AuktionsID", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..tonumber(pSlot).."'") ) == 0 then
			if tSlot and vioGetElementData ( target, "carslot"..tSlot ) == 0 and vioGetElementData ( player, "carslot"..pSlot ) > 0 then
				local veh = _G[getPrivVehString ( pname, pSlot )]
				if tonumber ( price ) then
					price = math.abs ( math.floor ( tonumber ( price ) ) )
					if isElement ( veh ) then
						if ( premiumBuyCars[getElementModel(veh)] and vioGetElementData ( target, "premium" ) ) or not premiumBuyCars[getElementModel(veh)] then
							if vioGetElementData ( target, "curcars" ) < vioGetElementData ( target, "maxcars" ) then
								local model = getElementModel ( veh )
								outputChatBox ( getPlayerName ( player ).." bietet dir folgendes Fahrzeug für "..price.." $ an: "..getVehicleName ( veh ), target, 0, 125, 0 )
								outputChatBox ( "Tippe /buy car, um das Fahrzeug zu kaufen.", target, 0, 125, 0 )
								outputChatBox ( "Du hast "..getPlayerName ( target ).." dein Fahrzeug aus Slot Nr. "..pSlot.." angeboten.", player, 200, 200, 0 )
								
								vioSetElementData ( target, "carToBuyFrom", player )
								vioSetElementData ( target, "carToBuySlot", tonumber ( pSlot ) )
								vioSetElementData ( target, "carToBuyPrice", price )
								vioSetElementData ( target, "carToBuyModel", getElementModel ( veh ) )
							else
								outputChatBox ( "Der Spieler hat keinen freien Fahrzeugslot mehr!", player, 125, 0, 0 )
							end
						else
							outputChatBox ( "Du kannst keine Premium Fahrzeuge an nicht Premiumnutzer weitergeben!", player, 125, 0, 0 )
						end
					else
						outputChatBox ( "Ungueltiges Fahrzeug! Gebrauch: /sellcarto [Name] [Preis] [Eigener Slot]", player, 125, 0, 0 )
					end
				else
					outputChatBox ( "Ungueltiger Preis! Gebrauch: /sellcarto [Name] [Preis] [Eigener Slot]", player, 125, 0, 0 )
				end
			else
				outputChatBox ( "Ungueltiger Fahrzeugslot! Gebrauch: /sellcarto [Name] [Preis] [Eigener Slot]", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Dieses Fahrzeuge wird momentan versteigert!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Gebrauch: /sellcarto [Name] [Preis] [Eigener Slot]", player, 125, 0, 0 )
	end
end
addCommandHandler ( "sellcarto", sellcarto_func )

function respawnPrivVeh ( carslot, pname )

	if not isElement ( _G[getPrivVehString ( pname, carslot )] ) or ( not getVehicleOccupant ( _G[getPrivVehString ( pname, carslot )] ) and not getVehicleOccupant ( _G[getPrivVehString ( pname, carslot )], 1 ) and not getVehicleOccupant ( _G[getPrivVehString ( pname, carslot )], 2 ) and not getVehicleOccupant ( _G[getPrivVehString ( pname, carslot )], 3 ) ) then
		if tonumber ( MySQL_GetString("vehicles", "AuktionsID", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..carslot.."'") ) == 0 then
			local dsatz
			local result = mysql_query ( handler, "SELECT * from vehicles WHERE Besitzer LIKE '"..pname.."' AND Slot LIKE '"..carslot.."'" )
			if result then
				if ( mysql_num_rows ( result ) > 0 ) then
					dsatz = mysql_fetch_assoc ( result )
				end
				mysql_free_result ( result )
			end
			
			destroyMagnet ( _G[getPrivVehString ( pname, carslot )] )
			local Besitzer = pname
			local Slot = carslot
			MySQL_SetString("vehicles", "Benzin", vioGetElementData(_G[getPrivVehString ( pname, carslot )],"fuelstate"), "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..carslot.."'")
			if vioGetElementData ( _G[getPrivVehString ( pname, carslot )], "special" ) == 2 then 
				detachElements ( _G["ObjYacht"..Besitzer..Slot], _G[getPrivVehString ( pname, carslot )] )
				destroyElement ( _G["ObjYacht"..Besitzer..Slot] )
				special = 2
			end
			destroyElement ( _G[getPrivVehString ( pname, carslot )] )
			local Typ = dsatz["Typ"]
			local Last_Login_Besitzer_Tag = MySQL_GetString("players", "Last_login", "Name LIKE '" ..pname.."'")
			local Tuning = dsatz["Tuning"]
			local Spawnpos_X = dsatz["Spawnpos_X"]
			local Spawnpos_Y = dsatz["Spawnpos_Y"]
			local Spawnpos_Z = dsatz["Spawnpos_Z"]
			local Spawnrot_X = dsatz["Spawnrot_X"]
			local Spawnrot_Y = dsatz["Spawnrot_Y"]
			local Spawnrot_Z = dsatz["Spawnrot_Z"]
			local Farbe = dsatz["Farbe"]
			local LFarbe = dsatz["Lights"]
			local Paintjob = dsatz["Paintjob"]
			local Benzin = dsatz["Benzin"]
			local Distanz = dsatz["Distance"]
			local STuning = dsatz["STuning"]
			_G[getPrivVehString ( pname, carslot )] = createVehicle ( Typ, Spawnpos_X, Spawnpos_Y, Spawnpos_Z, 0, 0, 0, Besitzer )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "owner", Besitzer )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "name", _G[getPrivVehString ( pname, carslot )] )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "carslotnr_owner", Slot )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "locked", true )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "color", Farbe )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "lcolor", LFarbe )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnpos_x", Spawnpos_X )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnpos_y", Spawnpos_Y )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnpos_z", Spawnpos_Z )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnrot_x", Spawnrot_X )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnrot_y", Spawnrot_Y )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "spawnrot_z", Spawnrot_Z )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "distance", Distanz )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "stuning", STuning )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "rcVehicle", tonumber ( dsatz["rc"] ) )
			setVehicleLocked ( _G[getPrivVehString ( pname, carslot )], true )
			vioSetElementData ( _G[getPrivVehString ( pname, carslot )], "fuelstate", Benzin )
			setPrivVehCorrectColor ( _G[getPrivVehString ( pname, carslot )] )
			setPrivVehCorrectLightColor ( _G[getPrivVehString ( pname, carslot )] )
			setVehiclePaintjob ( _G[getPrivVehString ( pname, carslot )], Paintjob )
			if special == 2 then
				local both = Besitzer..Slot
				_G["ObjYacht"..both] = createObject ( 1337, 0, 0, 0 )
				attachElements ( _G["ObjYacht"..Besitzer..Slot], _G[getPrivVehString ( pname, carslot )], 0, 2, 1.55 )
				setElementDimension ( _G["ObjYacht"..both], 1 )
			end
			setVehicleRotation ( _G[getPrivVehString ( pname, carslot )], Spawnrot_X, Spawnrot_Y, Spawnrot_Z )
			pimpVeh ( _G[getPrivVehString ( pname, carslot )], Tuning )
			setVehicleAsMagnetHelicopter ( _G[getPrivVehString ( pname, carslot )] )
			return true
		end
	end
	return false
end

function respawnVeh_func ( towcar, pname, veh )
	
	if towcar then
		respawnPrivVeh ( towcar, pname )
	else
		if not getVehicleOccupant ( veh ) then
			respawnVehicle ( veh )
			setElementDimension ( veh, 0 )
			setElementInterior ( veh, 0 )
		end
	end
end
addEvent ( "respawnVeh", true )
addEventHandler ( "respawnVeh", getRootElement(), respawnVeh_func )

function deleteVeh_func ( towcar, pname, veh, reason )

	local admin = getPlayerName ( source )
	if vioGetElementData ( source, "adminlvl" ) >= 1 then
		local player = getPlayerFromName ( pname )
		if player then
			outputChatBox ( "Dein Fahrzeug in Slot Nr. "..towcar.." wurde von "..admin.." geloescht ("..reason..")!", player, 125, 0, 0 )
			vioSetElementData ( player, "carslot"..towcar, 0 )
		else
			offlinemsg ( "Dein Fahrzeug in Slot Nr. "..towcar.." wurde von "..admin.." geloescht("..reason..")!", "Server", pname )
		end
		outputLog ( "Fahrzeug von "..pname.." ( "..towcar.." ) wurde von "..admin.." geloescht. | Modell: "..getElementModel(veh).." |", "autodelete" )
		destroyElement ( veh )
		MySQL_DelRow("vehicles", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..towcar.."'")
	end
end
addEvent ( "deleteVeh", true )
addEventHandler ( "deleteVeh", getRootElement(), deleteVeh_func )

function park_func ( player, command )

	if getPedOccupiedVehicleSeat ( player ) == 0 then
		local veh = getPedOccupiedVehicle ( player )
		if vioGetElementData ( veh, "owner" ) == getPlayerName ( player ) then
			if isTrailerInParkingZone ( veh ) then
				local x, y, z = getElementPosition ( veh )
				local rx, ry, rz = getVehicleRotation ( veh )
				local c1, c2, c3, c4 = getVehicleColor ( veh )
				vioSetElementData ( veh, "spawnposx", x )
				vioSetElementData ( veh, "spawnposy", y )
				vioSetElementData ( veh, "spawnposz", z )
				vioSetElementData ( veh, "spawnrotx", rx )
				vioSetElementData ( veh, "spawnroty", ry )
				vioSetElementData ( veh, "spawnrotz", rz )
				vioSetElementData ( veh, "color1", c1 )
				vioSetElementData ( veh, "color2", c2 )
				vioSetElementData ( veh, "color3", c3 )
				vioSetElementData ( veh, "color4", c4 )
				outputChatBox ( "Fahrzeug geparkt!", player, 0, 255, 0 )
			
				local Spawnpos_X, Spawnpos_Y, Spawnpos_Z = getElementPosition ( veh )
				local Spawnrot_X, Spawnrot_Y, Spawnrot_Z = getVehicleRotation ( veh )
				local Farbe1, Farbe2, Farbe3, Farbe4 =  getVehicleColor ( veh )
				local color = "|"..Farbe1.."|"..Farbe2.."|"..Farbe3.."|"..Farbe4.."|"
				local Paintjob = getVehiclePaintjob ( veh )
				local Benzin = vioGetElementData ( veh, "fuelstate" )
				local pname = vioGetElementData ( veh, "owner" )
				local Distance = vioGetElementData ( veh, "distance" )
				local slot = vioGetElementData ( veh, "carslotnr_owner" )

				MySQL_SetString("vehicles", "Spawnpos_X", Spawnpos_X, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
				MySQL_SetString("vehicles", "Spawnpos_Y", Spawnpos_Y, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
				MySQL_SetString("vehicles", "Spawnpos_Z", Spawnpos_Z, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
				MySQL_SetString("vehicles", "Spawnrot_X", Spawnrot_X, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
				MySQL_SetString("vehicles", "Spawnrot_Y", Spawnrot_Y, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
				MySQL_SetString("vehicles", "Spawnrot_Z", Spawnrot_Z, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
				MySQL_SetString("vehicles", "Farbe", color, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
				MySQL_SetString("vehicles", "Paintjob", Paintjob, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
				MySQL_SetString("vehicles", "Benzin", Benzin, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
				MySQL_SetString("vehicles", "Distance", Distance, "Besitzer LIKE '" ..pname.."' AND Slot LIKE '" ..slot.. "' ")
			else
				outputChatBox ( "Dieses Fahrzeug kannst du nicht in der Stadt parken!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Dieses Fahrzeug gehoert dir nicht!", player, 255, 0, 0 )
		end
	else
		outputChatBox ( "Du musst in einem Fahrzeug sitzen!", player, 255, 0, 0 )
	end
end
addCommandHandler ( "park", park_func )

function lock_func ( player, command, locknr )

	if locknr == nil then
		outputChatBox ( "Gebrauch: /lock [Fahrzeugnummer]", player, 255, 0, 0 )
	else
		if tonumber(vioGetElementData ( player, "carslot"..locknr )) >= 1 then
			local pname = getPlayerName ( player )
			local veh = _G[getPrivVehString ( pname, locknr )]
			if isElement ( veh ) then
				if vioGetElementData ( veh, "locked" ) then
					vioSetElementData ( veh, "locked", false )
					setVehicleLocked ( veh, false )
					outputChatBox ( "Fahrzeug Aufgeschlossen!", player, 0, 0, 255 )
				elseif not vioGetElementData ( veh, "locked" ) then
					vioSetElementData ( veh, "locked", true )
					setVehicleLocked ( veh, true )
					outputChatBox ( "Fahrzeug Abgeschlossen!", player, 0, 0, 255 )
				end
			else
				outputChatBox ( "Bitte respawne dein Fahrzeug zuerst!", player, 255, 0, 0 )
			end
		else
			outputChatBox ( "Du hast kein Fahrzeug mit diesem Namen!", player, 255, 0, 0 )
		end
	end
end
addEvent ( "lockPrivVehClick", true )
addEventHandler ( "lockPrivVehClick", getRootElement(), lock_func )
addCommandHandler ( "lock", lock_func )

function vehinfos_func ( player )

	local curcars = vioGetElementData ( player, "curcars" )
	local maxcars = vioGetElementData ( player, "maxcars" )
	outputChatBox ( "Momentan im Besitz: "..curcars.." Fahrzeuge von maximal "..maxcars, player, 0, 0, 255  )
	local pname = getPlayerName ( player )
	color = 0
	for i = 1, 10 do
		carslotname = "carslot"..i
		if vioGetElementData ( player, carslotname ) ~= 0 then
			local veh = _G[getPrivVehString ( pname, i )]
			if isElement ( veh ) then
				local x, y, z = getElementPosition( veh )
				if vioGetElementData ( veh, "gps" ) then
					color = color + 1
					local blip = createBlip ( x, y, z, 0, 2, vehBlipColor["r"][color], vehBlipColor["g"][color], vehBlipColor["b"][color], 255, 0, 99999.0, player )
					setTimer ( destroyElement, 10000, 1, blip )
					outputChatBox ( "Slot NR "..i..": "..getVehicleName ( veh )..", steht momentan in "..getZoneName( x,y,z )..", "..getZoneName( x,y,z, true ), player, vehBlipColor["r"][color], vehBlipColor["g"][color], vehBlipColor["b"][color] )
				else
					outputChatBox ( "Slot NR "..i..": "..getVehicleName ( veh )..", steht momentan in "..getZoneName( x,y,z )..", "..getZoneName( x,y,z, true ), player, 0, 0, 200 )
				end
			else
				if tonumber ( MySQL_GetString("vehicles", "AuktionsID", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..i.."'") ) == 0 then
					outputChatBox ( "Dein Fahrzeug in Slot NR "..i.." muss zuerst mit /towveh "..i.." respawned werden!", player, 125, 0, 0 )
				else
					outputChatBox ( "Dein Fahrzeug in Slot NR "..i.." steht momentan zum Verkauf!", player, 125, 0, 0 )
				end
			end
		end
	end
end
addCommandHandler ( "vehinfos", vehinfos_func )

function vehhelp_func ( player )

	outputChatBox ( "--- Fahrzeughilfe ---", player, 0, 0, 255 )
	outputChatBox ( "/towveh [Nummer] zum Respawnen am Parkort", player, 255, 0, 255 )
	outputChatBox ( "/lock [Nummer] zum Oeffnen/Schliessen", player, 255, 0, 255 )
	outputChatBox ( "/park zum Parken", player, 255, 0, 255 )
	outputChatBox ( "/vehinfos zum Anzeigen aller Aktueller Fahrzeuge", player, 255, 0, 255 )
	outputChatBox ( "/sellcar [Nummer] zum verkaufen des Autos ( 75% der Kosten werden erstattet )", player, 255, 0, 255 )
	outputChatBox ( "/givecar [Spieler] [Eigener Slot] [Neuer Slot], um das Auto weiterzugeben", player, 255, 0, 255 )
end
addCommandHandler ( "vehhelp", vehhelp_func )

function sellcar_func ( player, cmd, slot )

	local slot = tonumber(slot)
	if vioGetElementData ( player, "carslot"..slot ) > 0 then
		local pname = MySQL_Save ( getPlayerName(player) )
		if tonumber ( MySQL_GetString("vehicles", "AuktionsID", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..slot.."'") ) == 0 then
			local veh = _G[getPrivVehString ( pname, slot )]
			if veh then
				destroyMagnet ( veh )
				local model = getElementModel ( veh )
				local price = carprices[model]
				if not price then
					price = 0
				end
				vioSetElementData ( player, "carslot"..slot, 0 )
				local spawnx = vioGetElementData ( player, "spawnpos_x" )
				if spawnx == "marquis" or spawnx == "tropic" then
					vioSetElementData ( player, "spawnpos_x", -2458.288085 )
					vioSetElementData ( player, "spawnpos_y", 774.354492 )
					vioSetElementData ( player, "spawnpos_z", 35.171875 )
					vioSetElementData ( player, "spawnrot_x", 52 )
					vioSetElementData ( player, "spawnint", 0 )
					vioSetElementData ( player, "spawndim", 0 )
				end
				MySQL_DelRow("vehicles", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..vioGetElementData(veh, "carslotnr_owner" ).."'")
				vioSetElementData(player,"curcars",tonumber(vioGetElementData ( player, "curcars" ))-1)
				destroyElement ( veh )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" )+price/100*75 )
				givePlayerMoney ( player, price/100*75 )
				triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				SaveCarData ( player )
			else
				outputChatBox ( "Bitte respawne dein Fahrzeug vorher!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Dieses Fahrzeug kannst du nicht respawnen, da es zum Verkauf steht.", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Ungueltiger Slot!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "sellcar", sellcar_func )

function accept_sellcarto ( accepter, _, cmd )
	if cmd == "car" then
		local target = accepter
		local pSlot = vioGetElementData ( accepter, "carToBuySlot" )
		player = vioGetElementData ( accepter, "carToBuyFrom" )
		price = vioGetElementData ( accepter, "carToBuyPrice" )
		model = vioGetElementData ( accepter, "carToBuyModel" )
		if isElement ( player ) then
			local money = vioGetElementData ( target, "bankmoney" )
			local tSlot = getFreeCarSlot ( target )
			if price <= money then
				if tonumber ( pSlot ) and tSlot then
					pSlot = tonumber ( pSlot )
					local pname = getPlayerName ( player )
					if tonumber ( MySQL_GetString("vehicles", "AuktionsID", "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..tonumber(pSlot).."'") ) == 0 then
						if vioGetElementData ( player, "carslot"..pSlot ) > 0 then
							local veh = _G[getPrivVehString ( pname, pSlot )]
							if isElement ( veh ) then
								if model == getElementModel ( veh ) then
									if ( premiumBuyCars[getElementModel(veh)] and vioGetElementData ( target, "premium" ) ) or not premiumBuyCars[getElementModel(veh)] then
										if vioGetElementData ( target, "curcars" ) < vioGetElementData ( target, "maxcars" ) then
											outputLog ( getPlayerName ( accepter ).." hat von "..getPlayerName ( player ).." ein Fahrzeug fuer "..price.." $ ( Model: "..model.." )", "sellcar" )
											
											local id = MySQL_GetString("vehicles", "ID", "Besitzer LIKE '"..getPlayerName(player).."' AND Slot LIKE '"..tonumber(pSlot).."'")
											
											outputChatBox ( "Du hast dein Fahrzeug in Slot Nr. "..pSlot.." an "..getPlayerName ( target ).." gegeben!", player, 0, 125, 0 )
											outputChatBox ( "Du hast ein Fahrzeug in Slot Nr. "..tSlot.." von "..getPlayerName ( player ).." erhalten!", target, 0, 125, 0 )
											
											MySQL_SetString("vehicles", "Besitzer", getPlayerName(target), "ID LIKE '"..id.."'")
											MySQL_SetString("vehicles", "Slot", tonumber ( tSlot ), "ID LIKE '"..id.."'")
										
											vioSetElementData ( target, "carslot"..tSlot, vioGetElementData ( player, "carslot"..pSlot ) )
											vioSetElementData ( player, "carslot"..pSlot, 0 )
											vioSetElementData ( target, "curcars", vioGetElementData ( target, "curcars" ) + 1 )
											vioSetElementData ( player, "curcars", vioGetElementData ( player, "curcars" ) - 1 )
											vioSetElementData ( veh, "lcolor", "|255|255|255|" )
											
											MySQL_SetString("vehicles", "Lights", "|255|255|255|", "ID LIKE '"..id.."'")
											setPrivVehCorrectLightColor ( veh )
											
											vioSetElementData ( veh, "owner", getPlayerName ( target ) )
											vioSetElementData ( veh, "name", "privVeh"..getPlayerName(target)..tSlot )
											vioSetElementData ( veh, "carslotnr_owner", tSlot )
											
											_G[getPrivVehString ( getPlayerName(target), tSlot )] = veh
											_G[getPrivVehString ( pname, pSlot )] = nil
											
											SaveCarData ( player )
											SaveCarData ( target )
											
											vioSetElementData ( target, "bankmoney", money - price )
											vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) + price )
											
											casinoMoneySave ( target )
											casinoMoneySave ( player )
										else
											infobox ( accepter, "Du hast keinen\nfreien Fahrzeugslot mehr!", 5000, 125, 0, 0 )
										end
									end
								else
									infobox ( accepter, "Ein Fehler\nist aufgetreten.\nBitte lass dir\ndas Angebot erneut\nschicken!", 5000, 125, 0, 0 )
								end
							else
								infobox ( accepter, "Ein Fehler\nist aufgetreten.\nBitte lass dir\ndas Angebot erneut\nschicken!", 5000, 125, 0, 0 )
							end
						else
							infobox ( accepter, "Der Verkaufer hat\ndas Fahrzeug nicht\nmehr!", 5000, 125, 0, 0 )
						end
					end
				else
					infobox ( accepter, "Ein Fehler\nist aufgetreten.\nBitte lass dir\ndas Angebot erneut\nschicken!", 5000, 125, 0, 0 )
				end
			else
				infobox ( accepter, "Du hast nicht\ngenug Geld auf\nder Bank!", 5000, 125, 0, 0 )
			end
		else
			infobox ( accepter, "Der Anbieter des\nFahrzeugs ist offline!", 5000, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "buy", accept_sellcarto )

function getPrivVehString ( pname, carslot )

	return string.lower ( "privVeh"..pname..carslot )
end

function handbremsen ( player )

	local vehicle = getPedOccupiedVehicle ( player )
	
	if vehicle then
	
		local sitz = getPedOccupiedVehicleSeat ( player )
		
		if sitz == 0 then
		
			local vx, vy, vz = getElementVelocity ( getPedOccupiedVehicle ( player ) )
			local speed = math.sqrt ( vx ^ 2 + vy ^ 2 + vz ^ 2 )
			
			if speed < 5 * 0.00464 then
			else
				return
			end
		
			if vioGetElementData ( vehicle, "owner" ) == getPlayerName ( player )  then
			
				if isElementFrozen ( vehicle ) then
			
					setElementFrozen ( vehicle, false )
					outputChatBox ( "Handbremse gelöst!", player, 0, 125, 0 )
				
				else
				
					setElementFrozen ( vehicle, true )
					outputChatBox ( "Handbremse angezogen!", player, 0, 125, 0 )
				
				end
			
			end
		
		end
	
	end
	
end

addCommandHandler ( "break", handbremsen )