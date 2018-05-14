local usedCarStrings = {}
debug.sethook()
carsSpawned = false


function privVeh_spawning()

	caramount = 0
	deletedcars = 0
	result, errorcode, errormsg = dbPoll( dbQuery(handler, "SELECT * FROM vehicles"), -1 )
	if( not result) then
		 outputDebugString("Error executing the query: (" .. errorcode .. ") " .. errormsg)
	else
		if #result > 0 then
			carsData = table.remove( result, 1 )
			mySQLCarCreate()
		else
			outputServerLog("Es wurden keine Autos gefunden")
		end
	end
end

function mySQLCarCreate ()

	if not carsSpawned then
		caramount = caramount + 1
		local Besitzer = carsData["Besitzer"]
		local valid = true
		if carsData["AuktionsID"] then
			carsData["AuktionsID"] = tonumber ( carsData["AuktionsID"] )
			if carsData["AuktionsID"] then
				if carsData["AuktionsID"] > 0 then
					valid = false
				end
			end
		end
		if valid then
			if isOwnerActive ( Besitzer ) then
				local Typ = carsData["Typ"]
				local Tuning = carsData["Tuning"]
				local Spawnpos_X = tonumber(carsData["Spawnpos_X"])
				local Spawnpos_Y = tonumber(carsData["Spawnpos_Y"])
				local Slot = carsData["Slot"]
				local tmp = getPrivVehString ( Besitzer, Slot )
				if not badMySQLCarHouseXSpawns[math.floor ( Spawnpos_X )] and not badMySQLCarHouseYSpawns[math.floor ( Spawnpos_Y )] and not usedCarStrings[tmp] then
					usedCarStrings[tmp] = true
					local Spawnpos_Z = tonumber(carsData["Spawnpos_Z"])
					local Spawnrot_X = tonumber(carsData["Spawnrot_X"])
					local Spawnrot_Y = tonumber(carsData["Spawnrot_Y"])
					local Spawnrot_Z = tonumber(carsData["Spawnrot_Z"])
					local Special = tonumber(carsData["Special"]) 
					local Farbe = carsData["Farbe"]
					if #( tostring ( Farbe ) )<= 3 then
						Farbe = "0|0|0|0"
						dbExec( handler, "UPDATE vehicles SET Farbe = ? WHERE Besitzer LIKE ? AND Slot LIKE ?", Farbe, Besitzer, tonumber(Slot) )
					end
					local Paintjob = carsData["Paintjob"]
					local Benzin = carsData["Benzin"]
					_G[getPrivVehString ( Besitzer, Slot )] = createVehicle ( Typ, Spawnpos_X, Spawnpos_Y, Spawnpos_Z, 0, 0, 0, Besitzer )
					if Special == 2 then
						local vx, vy, vz = Spawnpos_X, Spawnpos_Y-2, 1.55
						both = Besitzer..Slot
						_G["ObjYacht"..both] = createObject ( 1337, vx, vy, vz )
						attachElements ( _G["ObjYacht"..both], _G[getPrivVehString ( Besitzer, Slot )], 0, 2, 1.55 )
						setElementDimension ( _G["ObjYacht"..both], 1 )
					end
					local veh = _G[getPrivVehString ( Besitzer, Slot )]
					local STuning = carsData["STuning"]
					vioSetElementData ( veh, "stuning", STuning )
					setVehicleAsMagnetHelicopter ( veh )
					setVehicleRotation ( veh, Spawnrot_X, Spawnrot_Y, Spawnrot_Z )
					vioSetElementData ( veh, "owner", Besitzer )
					vioSetElementData ( veh, "name", veh )
					vioSetElementData ( veh, "carslotnr_owner", Slot )
					vioSetElementData ( veh, "locked", true )
					vioSetElementData ( veh, "color", Farbe )
					vioSetElementData ( veh, "spawnpos_x", Spawnpos_X )
					vioSetElementData ( veh, "spawnpos_y", Spawnpos_Y )
					vioSetElementData ( veh, "spawnpos_z", Spawnpos_Z )
					vioSetElementData ( veh, "spawnrot_x", Spawnrot_X )
					vioSetElementData ( veh, "spawnrot_y", Spawnrot_Y )
					vioSetElementData ( veh, "spawnrot_z", Spawnrot_Z )
					vioSetElementData ( veh, "special", Special )
					vioSetElementData ( veh, "lcolor", carsData["Lights"] )
					vioSetElementData ( veh, "distance", tonumber ( carsData["Distance"] ) )
					setPrivVehCorrectLightColor ( veh )
					setVehicleLocked ( veh, true )
					vioSetElementData ( veh, "fuelstate", tonumber ( Benzin ) )
					setPrivVehCorrectColor ( veh )
					setVehiclePaintjob ( veh, Paintjob )
					if tonumber(Tuning) == 1 then
						dbExec( handler, "UPDATE vehicles SET Tuning = '|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|' WHERE Besitzer LIKE ? AND Slot LIKE ?", Besitzer, tonumber(Slot) )
					else
						pimpVeh ( veh, Tuning )
					end
					
					vioSetElementData ( veh, "rcVehicle", tonumber ( carsData["rc"] ) )
				end
			else
				local Besitzer = carsData["Besitzer"]
				-- Deaktiviert by Bonus, da eh nicht benutzt wird 
				--local banresult = dbPoll( dbQuery( handler, "SELECT STime FROM ban WHERE Name LIKE ?", Besitzer ), -1 )
				--local bantime =  tonumber ( banresult and banresult[1] and banresult[1]["STime"] or 0 )
				--local diff = math.floor ( ( ( bantime - getTBanSecTime ( 0 ) ) / 60 ) * 100 ) / 100
				--[[if diff < 0 then
					deletedcars = deletedcars + 1
					local Slot = carsData["Slot"]
					MySQL_DelRow("vehicles", "Besitzer LIKE '"..Besitzer.."' AND Slot LIKE '"..Slot.."'")
					MySQL_SetString("userdata", "Carslot"..Slot, 0, "Name LIKE '"..Besitzer.."'")
					MySQL_SetString("userdata", "CurrentCars", tonumber(MySQL_GetString("userdata", "CurrentCars", "Name LIKE '"..Besitzer.."'"))-1, "Name LIKE '"..Besitzer.."'")
					offlinemsg ( "Dein Fahrzeug in Slot Nr. "..Slot.." wurde entfernt, da du mehr als 30 Tage inaktiv warst!", "Server", Besitzer )
				end]]
			end
		end
		carsData = table.remove( result, 1 )
		if carsData then
			mySQLCarCreate()
		else
			carsSpawned = true
			outputServerLog("Es wurden "..caramount.." Fahrzeuge gefunden und "..deletedcars.." Fahrzeuge von inaktiven Benutzern entfernt.")
		end
	end
end

function pimpVeh ( veh, tuning )

	for i = 0, 16 do
		local x = i + 1
		_G["tunepart"..i] = tonumber(gettok ( tuning, x, string.byte('|') ))
	end
	for i = 0, 16 do
		if _G["tunepart"..i] > 0 then
			addVehicleUpgrade ( veh, _G["tunepart"..i] )
		end
	end
	specPimpVeh ( veh )
end

function setPrivVehCorrectColor ( veh )

	local colors = vioGetElementData ( veh, "color" )
	local c1 = tonumber ( gettok ( colors, 1, string.byte( '|' ) ))
	local c2 = tonumber ( gettok ( colors, 2, string.byte( '|' ) ))
	local c3 = tonumber ( gettok ( colors, 3, string.byte( '|' ) ))
	local c4 = tonumber ( gettok ( colors, 4, string.byte( '|' ) ))
	setVehicleColor ( veh, c1, c2, c3, c4 )
	setTimer ( setVehicleColor, 100, 1, veh, c1, c2, c3, c4 )
end

function setPrivVehCorrectLightColor ( veh )

	if veh then
		local colors = vioGetElementData ( veh, "lcolor" )
		if colors then
			local c1 = tonumber ( gettok ( colors, 1, string.byte( '|' ) ))
			local c2 = tonumber ( gettok ( colors, 2, string.byte( '|' ) ))
			local c3 = tonumber ( gettok ( colors, 3, string.byte( '|' ) ))
			vioSetElementData ( veh, "lc1", c1 )
			vioSetElementData ( veh, "lc2", c2 )
			vioSetElementData ( veh, "lc3", c3 )
			setVehicleHeadLightColor ( veh, c1, c2, c3 )
		end
	end
end

function isOwnerActive ( pname )

	return true
end