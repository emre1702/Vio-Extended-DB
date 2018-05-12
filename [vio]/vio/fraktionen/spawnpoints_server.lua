function spawnchange_func ( player, cmd, place, sType )

	local pname = getPlayerName ( player )
	if place == "house" then
		if vioGetElementData ( player, "housekey" ) ~= 0 then
			local dim = math.abs ( tonumber ( vioGetElementData ( player, "housekey" ) ) )
			local hint = vioGetElementData ( houses["pickup"][dim], "curint" )
			local int, intx, inty, intz = getInteriorData ( hint )
			
			if hint == 0 then
				int = 0
				dim = 0
				intx, inty, intz = getElementPosition ( houses["pickup"][dim] )
			end
			
			vioSetElementData ( player, "spawndim", dim )
			vioSetElementData ( player, "spawnint", int )
			vioSetElementData ( player, "spawnpos_x", intx )
			vioSetElementData ( player, "spawnpos_y", inty )
			vioSetElementData ( player, "spawnpos_z", intz )
			
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
			OwnFootCheck ( player )
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist Obdachlos!", 5000, 0, 125, 0 )
		end
	elseif place == "faction" then
		local faction = vioGetElementData ( player, "fraktion" )
		if faction > 0 then
			if vioGetElementData ( player, "rang" ) >= 5 or faction == 9 then
				OwnFootCheck ( player )
				if faction == 1 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", 228.71 )
						vioSetElementData ( player, "spawnpos_y", 126.83 )
						vioSetElementData ( player, "spawnpos_z", 1009.85 )
						vioSetElementData ( player, "spawnrot_x", 180 )
						vioSetElementData ( player, "spawnint", 10 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 210.94281005859, 150.44526672363, 1002.672668457, -90, 3, 0 )
					end
				end
				if faction == 2 then
					if sType == "sf" then
						setPlayerNewSpawnpoint ( player, -684.36, 939.62, 13.63, 90, 0, 0 )
					else
						setPlayerNewSpawnpoint ( player, 2170.59, 1601.95, 999.61895751953, 0, 1, 0 )
					end
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
				end
				if faction == 3 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", -2160.2456054688 )
						vioSetElementData ( player, "spawnpos_y", 642.27325439453 )
						vioSetElementData ( player, "spawnpos_z", 1057.2429199219 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 1 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 1927.07, 1017.93, 994.11, 90, 10, 0 )
					end
				end
				if faction == 4 then
					vioSetElementData ( player, "spawnpos_x", -1998.9085693359 )
					vioSetElementData ( player, "spawnpos_y", -1563.2896728516 )
					vioSetElementData ( player, "spawnpos_z", 85.435836791992 )
					vioSetElementData ( player, "spawnrot_x", 0 )
					vioSetElementData ( player, "spawnint", 0 )
					vioSetElementData ( player, "spawndim", 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
				end
				if faction == 5 then
					setPlayerNewSpawnpoint ( player, -2520.77, -623.44, 132.77, 0, 0, 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
				end
				if faction == 6 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", -2453.8784179688 )
						vioSetElementData ( player, "spawnpos_y", 503.82363891602 )
						vioSetElementData ( player, "spawnpos_z", 29.728803634644 )
						vioSetElementData ( player, "spawnrot_x", 0 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 221.1217956543, 150.03002929688, 1002.672668457, -90, 3, 0 )
					end
				end
				if faction == 7 then
					if sType == "strip" then
						setPlayerNewSpawnpoint ( player, 1200.94, 11.89, 1000.57, 0, 2, 0 )
					else
						setPlayerNewSpawnpoint ( player, -797.27, 2439.11, 157.66, 184, 0, 0 )
					end
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
				end
				if faction == 8 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", -1346.1706542969 )
						vioSetElementData ( player, "spawnpos_y", 492.36785888672 )
						vioSetElementData ( player, "spawnpos_z", 10.851915359497 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					elseif sType == "lv" then
						vioSetElementData ( player, "spawnpos_x", 247.46310424805 )
						vioSetElementData ( player, "spawnpos_y", 1859.85546875 )
						vioSetElementData ( player, "spawnpos_z", 13.733238220215 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					end
				end
				if faction == 9 then
				
					if sType == "sf" then
						setPlayerNewSpawnpoint ( player, 508.35272216797, -84.92643737793, 998.61016845703, 0, 11, 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					elseif sType == "lv" then
						setPlayerNewSpawnpoint ( player, 1126.712890625, -12.259765625, 1002.0859375, 0, 12, 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					end
				
				end
			else
				if faction == 1 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", 246.3 )
						vioSetElementData ( player, "spawnpos_y", 125.05 )
						vioSetElementData ( player, "spawnpos_z", 1003 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 10 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 216.72428894043, 168.78742980957, 1002.672668457, 90, 3, 0 )
					end
				end
				if faction == 2 then
					if sType == "sf" then
						setPlayerNewSpawnpoint ( player, -660.83, 1025.09, 12.78, 90, 0, 0 )
					else
						setPlayerNewSpawnpoint ( player, 2170.59, 1601.95, 999.61895751953, 0, 1, 0 )
					end
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
				end
				if faction == 3 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", -2160.2456054688 )
						vioSetElementData ( player, "spawnpos_y", 642.27325439453 )
						vioSetElementData ( player, "spawnpos_z", 1057.2429199219 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 1 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 1927.07, 1017.93, 994.11, 90, 10, 0 )
					end
				end
				if faction == 4 then
					vioSetElementData ( player, "spawnpos_x", -1998.9085693359 )
					vioSetElementData ( player, "spawnpos_y", -1563.2896728516 )
					vioSetElementData ( player, "spawnpos_z", 85.435836791992 )
					vioSetElementData ( player, "spawnrot_x", 0 )
					vioSetElementData ( player, "spawnint", 0 )
					vioSetElementData ( player, "spawndim", 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
				end
				if faction == 5 then
					setPlayerNewSpawnpoint ( player, -2520.77, -623.44, 132.77, 0, 0, 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
				end
				if faction == 6 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", -2453.8784179688 )
						vioSetElementData ( player, "spawnpos_y", 503.82363891602 )
						vioSetElementData ( player, "spawnpos_z", 29.728803634644 )
						vioSetElementData ( player, "spawnrot_x", 0 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 216.72428894043, 168.78742980957, 1002.672668457, 90, 3, 0 )
					end
				end
				if faction == 7 then
					if sType == "strip" then
						setPlayerNewSpawnpoint ( player, 1200.94, 11.89, 1000.57, 0, 2, 0 )
					else
						setPlayerNewSpawnpoint ( player, -797.27, 2439.11, 157.66, 184, 0, 0 )
					end
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
				end
				if faction == 8 then
					if sType == "ls" then
						vioSetElementData ( player, "spawnpos_x", -1346.1706542969 )
						vioSetElementData ( player, "spawnpos_y", 492.36785888672 )
						vioSetElementData ( player, "spawnpos_z", 10.851915359497 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					elseif sType == "lv" then
						vioSetElementData ( player, "spawnpos_x", 247.46310424805 )
						vioSetElementData ( player, "spawnpos_y", 1859.85546875 )
						vioSetElementData ( player, "spawnpos_z", 13.733238220215 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
					end
				end
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist in\nkeiner Fraktion!", 5000, 125, 0, 0 )
		end
	elseif place == "street" then
		vioSetElementData ( player, "spawnpos_x", -2458.288085 )
		vioSetElementData ( player, "spawnpos_y", 774.354492 )
		vioSetElementData ( player, "spawnpos_z", 35.171875 )
		vioSetElementData ( player, "spawnrot_x", 52 )
		vioSetElementData ( player, "spawnint", 0 )
		vioSetElementData ( player, "spawndim", 0 )
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
	elseif place == "hotel" then
		if vioGetElementData ( player, "money" ) >= 100 then
			takePlayerSaveMoney ( player, 100 )
			if sType == "sf" then
				vioSetElementData ( player, "spawnpos_x", 2230.5236816406 )
				vioSetElementData ( player, "spawnpos_y", -1107.6160888672 )
				vioSetElementData ( player, "spawnpos_z", 1050.5319824219 )
				vioSetElementData ( player, "spawnrot_x", 0 )
				vioSetElementData ( player, "spawnint", 5 )
				vioSetElementData ( player, "spawndim", 0 )
			else
				vioSetElementData ( player, "spawnpos_x", 2230.5236816407 )
				vioSetElementData ( player, "spawnpos_y", -1107.6160888672 )
				vioSetElementData ( player, "spawnpos_z", 1050.5319824219 )
				vioSetElementData ( player, "spawnrot_x", 0 )
				vioSetElementData ( player, "spawnint", 5 )
				vioSetElementData ( player, "spawndim", 0 )
			end
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nDu musst mind.\n100 $ besitzen!", 5000, 0, 125, 0 )
		end
	elseif place == "hier" then
		if vioGetElementData ( player, "adminlvl" ) >= 1 then
			local x, y, z = getElementPosition ( player )
			vioSetElementData ( player, "spawnpos_x", x )
			vioSetElementData ( player, "spawnpos_y", y )
			vioSetElementData ( player, "spawnpos_z", z )
			vioSetElementData ( player, "spawnrot_x", getPedRotation ( player ) )
			vioSetElementData ( player, "spawnint", getElementInterior ( player ) )
			vioSetElementData ( player, "spawndim", getElementDimension ( player ) )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
		end
	elseif place == "bar" then
		if vioGetElementData ( player, "club" ) == "biker" then
			vioSetElementData ( player, "spawnpos_x", -2244.6462402344 )
			vioSetElementData ( player, "spawnpos_y", -88.103973388672 )
			vioSetElementData ( player, "spawnpos_z", 34.96 )
			vioSetElementData ( player, "spawnrot_x", 180 )
			vioSetElementData ( player, "spawnint", 0 )
			vioSetElementData ( player, "spawndim", 0 )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
		else
			outputChatBox ( "Du bist kein Biker!", player, 125, 0, 0 )
		end
	elseif place == "boat" then
		OwnFootCheck ( player )
		local pname = getPlayerName ( player )
		local model = false
		local veh
		for i = 1, 10 do
			veh = _G[getPrivVehString ( pname, i )]
			if isElement ( veh ) then
				veh = getElementModel ( veh )
				if veh == 454 or veh == 484 then
					if veh == 484 then
						model = "marquis"
					elseif veh == 454 then
						model = "tropic"
					end
					nexti = i
					break
				end
			end
		end
		if not model then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast keine\nYacht!", 5000, 125, 0, 0 )
		else
			vioSetElementData ( player, "spawnpos_x", model )
			vioSetElementData ( player, "spawnpos_y", getPrivVehString ( pname, nexti ) )
			vioSetElementData ( player, "spawnpos_z", 0 )
			vioSetElementData ( player, "spawnrot_x", 0 )
			vioSetElementData ( player, "spawnint", 0 )
			vioSetElementData ( player, "spawndim", 0 )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
		end
	elseif place == "wohnmobil" then
		local wohnmobil = false
		
		for i = 1, 10 do
			veh = _G[getPrivVehString ( pname, i )]
			if isElement ( veh ) then
				if camper [ getElementModel ( veh ) ] then
					wohnmobil = true
				end
			end
		end
		
		if wohnmobil then
			vioSetElementData ( player, "spawnpos_x", "wohnmobil" )
			vioSetElementData ( player, "spawnpos_y", 0 )
			vioSetElementData ( player, "spawnpos_z", 0 )
			vioSetElementData ( player, "spawnrot_x", 0 )
			vioSetElementData ( player, "spawnint", 0 )
			vioSetElementData ( player, "spawndim", 0 )
			
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nDu hast kein\nWohnmobil!", 5000, 0, 125, 0 )
		end
	else
		outputChatBox ( "Ungueltige Eingabe! Bitte entweder \"house\", \"faction\", \"boat\", \"wohnmobil\" oder \"street\" eingeben!", player, 125, 0, 0 )
	end
	MySQL_SetString("userdata", "Spawnpos_X", vioGetElementData ( player, "spawnpos_x" ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "Spawnpos_Y", vioGetElementData ( player, "spawnpos_y" ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "Spawnpos_Z", vioGetElementData ( player, "spawnpos_z" ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "Spawnrot_X", vioGetElementData ( player, "spawnrot_x" ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "SpawnInterior", vioGetElementData ( player, "spawnint" ), "Name LIKE '"..pname.."'")
	MySQL_SetString("userdata", "SpawnDimension", vioGetElementData ( player, "spawndim" ), "Name LIKE '"..pname.."'")
end
addCommandHandler ( "spawnchange", 
	function ( player )
		outputChatBox ( "Bitte nutze das Optionsmenue!", player, 125, 0, 0 )
	end
)

function changeSpawnPosition_func ( arg1, arg2 )

	spawnchange_func ( client, "", arg1, arg2 )
end
addEvent ( "changeSpawnPosition", true )
addEventHandler ( "changeSpawnPosition", getRootElement(), changeSpawnPosition_func )

function setPlayerNewSpawnpoint ( player, x, y, z, rot, int, dim )

	vioSetElementData ( player, "spawnpos_x", x )
	vioSetElementData ( player, "spawnpos_y", y )
	vioSetElementData ( player, "spawnpos_z", z )
	vioSetElementData ( player, "spawnrot_x", rot )
	vioSetElementData ( player, "spawnint", int )
	vioSetElementData ( player, "spawndim", dim )
end