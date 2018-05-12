-- Table

adminsIngame = {}
local player_admin = {}
local frozen_players = {}
local veh_frozen_players = {}
local veh_frozen_vehs = {}
local muted_players = {}

-- Funktionen 

local pack_cmds = {}
pack_cmds["msg"] = true
pack_cmds["pm"] = true

function blockParticularCmds ( cmd )
	
	if pack_cmds[cmd] then
		cancelEvent()
		outputChatBox ( "Benutzung von /msg und /pm ist verboten", source, 255, 0, 0 )
	end
	
end

--

function blockParticularCmdsJoin ( )
	
	addEventHandler( "onPlayerCommand", source, blockParticularCmds )
	
end

addEventHandler ( "onPlayerJoin", getRootElement(), blockParticularCmdsJoin )

--

function executeAdminServerCMD_func ( cmd, arguments )

	executeCommandHandler ( cmd, client, arguments )
	
end

function doesAnyPlayerOccupieTheVeh ( car )

	local bool = false

	for i = 0, 5, 1 do
	
		local test = getVehicleOccupant ( car, i )
		
		if test ~= false then
			bool = true
		end
	
	end
	
	if bool == false then
		return false
	else
		return true
	end

end

function getAdminLevel ( player )

	local plevel = vioGetElementData ( player, "adminlvl" )
	
	if not plevel or plevel == nil then
		return 0
	end
	
	return tonumber(plevel)

end

function isAdminLevel ( player, level )

	local plevel = vioGetElementData ( player, "adminlvl" )
	
	if not plevel or plevel == nil then
		return false
	end
	
	if plevel >= level then
		return true
	else
		return false
	end

end

function adminMenueTrigger_func ( )

	if source == client then
		if vioGetElementData ( source, "adminlvl" ) >= 1 then
			triggerClientEvent ( source, "PListFill", getRootElement() )
		else
			triggerClientEvent ( source, "infobox_start", getRootElement(), "\nDu bist kein\nAdmin!", 5000, 255, 0, 0 )
		end
	end
end

-- command-Funktionen

function help_func ( player )

	outputChatBox ( "Wichtige Befehle: /admins = Admins anzeigen, /report [Text] bei Problemen, /rebind bei Problemen mit dem Clicksystem.", player, 125, 0, 0 )
	
end

function nickchange_func ( player, cmd, alterName, neuerName )

	local alterName = MySQL_Save ( alterName )
	local neuerName = MySQL_Save ( neuerName )
	
	if isAdminLevel ( player, 2 ) then
	
		if not findPlayerByName ( alterName ) then
		
			if MySQL_DatasetExist ( "players", "Name LIKE '"..alterName.."'") then
			
				if not MySQL_DatasetExist ( "players", "Name LIKE '"..neuerName.."'") and not MySQL_DatasetOldExist ( "players", "Name LIKE '"..neuerName.."'") then
				
					-- Data --
					MySQL_SetString ( "achievments", "Name", neuerName, "Name LIKE '"..alterName.."'")
					MySQL_SetString ( "biz", "Inhaber", neuerName, "Inhaber LIKE '"..alterName.."'")
					MySQL_SetString ( "bonustable", "Name", neuerName, "Name LIKE '"..alterName.."'")
					MySQL_SetString ( "houses", "Besitzer", neuerName, "Besitzer LIKE '"..alterName.."'")
					MySQL_SetString ( "inventar", "Name", neuerName, "Name LIKE '"..alterName.."'")
					MySQL_SetString ( "logout", "Name", neuerName, "Name LIKE '"..alterName.."'")
					MySQL_SetString ( "packages", "Name", neuerName, "Name LIKE '"..alterName.."'")
					MySQL_SetString ( "players", "Name", neuerName, "Name LIKE '"..alterName.."'")
					MySQL_SetString ( "prestige", "Besitzer", neuerName, "Besitzer LIKE '"..alterName.."'")
					MySQL_SetString ( "userdata", "Name", neuerName, "Name LIKE '"..alterName.."'")
					MySQL_SetString ( "vehicles", "Besitzer", neuerName, "Besitzer LIKE '"..alterName.."'")
					MySQL_SetString ( "skills", "Name", neuerName, "Name LIKE '"..alterName.."'")
					
					outputAdminLog ( getPlayerName ( player ).." hat "..alterName.." in "..neuerName.." umbenannt." )
					
					outputChatBox ( "Du hast den Spieler "..alterName.." in "..neuerName.." umbenannt!", player, 0, 125, 0 )
					
				else
				
					outputChatBox ( "Der neue Name ist bereits vergeben!", player, 125, 0, 0 )
					
				end
				
			else
			
				outputChatBox ( "Der Spieler existiert nicht!", player, 125, 0, 0 )
				
			end
			
		else
		
			outputChatBox ( "Der Spieler ist noch eingeloggt!", player, 125, 0, 0 )
			
		end
		
	else
	
		outputChatBox ( "Du bist kein Admin!", player, 125, 0, 0 )
		
	end
	
end

function move_func ( player, cmd, direction )

	if ( not client or client == player ) then
	
		if isAdminLevel ( player, 1 ) then
		
			local veh = getPedOccupiedVehicle ( player )
			local element = player
			
			if isElement ( veh ) then
			
				element = veh
				
			end
			
			local x, y, z = getElementPosition ( element )
			
			if direction == "up" then
				y = y + 1
			elseif direction == "down" then
				y = y - 1
			elseif direction == "left" then
				x = x - 1
			elseif direction == "right" then
				x = x + 1
			elseif direction == "higher" then
				z = z + 1
			elseif direction == "lower" then
				z = z - 1
			end
			
			setElementPosition ( element, x, y, z )
			
		else
		
			infobox ( player, "Du bist kein Admin", 5000, 125, 0, 0 )
			
		end
		
	end
	
end

function moveVehicleAway_func ( veh )

	if isAdminLevel ( client, 1 ) then
	
		setElementPosition ( veh, 999999, 999999, 999999 )
		setElementInterior ( veh, 999999 )
		setElementDimension ( veh, 999999 )
		
	end
	
end

function pwchange_func ( player, cmd, target, newPW )

	if isAdminLevel ( player, 2 ) then
	
		if newPW and target then
		
			local target = MySQL_Save ( target )
			local newPW = MySQL_Save ( newPW )
			local empty = ""
			MySQL_SetString ( "players", "Passwort", md5(newPW), "Name LIKE '" ..target.."'" )
			MySQL_SetString ( "players", "Salt", empty, "Name LIKE '" ..target.."'" )
			outputChatBox ( "Passwort geaendert!", player, 0, 125, 0 )
			
			outputAdminLog ( getPlayerName ( player ).." hat das Passwort von "..target.." geaendert!" )
			
		else
		
			outputChatBox ( "Gebrauch: /pwchange [Name] [Neues Passwort]", player, 125, 0, 0 )
			
		end
		
	else
	
		outputChatBox ( "Du benoetigst Adminlvl 2!", player, 125, 0, 0 )
		
	end
	
end

function query_func ( player, cmd, ... )

	local parametersTable = {...}
	local query = table.concat( parametersTable, " " )
	
	if isAdminLevel ( player, 4 ) then
	
		local result = mysql_vio_query ( query )
		outputChatBox ( "Query: "..tostring ( result ), player, 0, 125, 0 )
		
	end
	
end

function shut_func ( player, cmd, test )

	if isAdminLevel ( player, 1 ) then
	
		outputAdminLog ( getPlayerName ( player ).." hat die Notabschaltung benutzt." )
		shutdown ( "Abgeschaltet von: "..getPlayerName ( player ) )
		
		setServerPassword ( "fdgdfgfdzTDEd" )
		
		for id, playeritem in ipairs(getElementsByType("player")) do 
			kickPlayer ( playeritem )
		end
		
	end
	
end

function rebind_func ( player )

	if isKeyBound ( player, "ralt", "down", showcurser ) then
		unbindKey ( player, "ralt", "down", showcurser )
	end
	
	if isKeyBound ( player, "m", "down", showcurser ) then
		unbindKey ( player, "m", "down", showcurser )
	end
	
	if isKeyBound ( player, "f1", "down", showhmenue ) then
		unbindKey ( player, "f1", "down", showhmenue )
	end
	
	if isKeyBound ( player, "r", "down", reload ) then
		unbindKey ( player, "r", "down", reload )
	end
	
	bindKey ( player, "ralt", "down", showcurser, player )
	bindKey ( player, "m", "down", showcurser, player )
	bindKey ( player, "f1", "down", showhmenue, player )
	bindKey ( player, "r", "down", reload )
	
	outputChatBox ( "Hotkeys wurden neu gelegt!", player, 0, 125, 0 )
	
end

function adminlist ( player )

	outputChatBox ( "Momentan online:", player, 0, 100, 255 )
	
	for key, index in pairs(adminsIngame) do
	
		if index == 1 then
			outputChatBox ( getPlayerName(key)..", Moderator", player, 0, 0, 200 )
		elseif index == 2 then
			outputChatBox ( getPlayerName(key)..", Administrator", player, 0, 0, 200 )
		elseif index == 3 then
			outputChatBox ( getPlayerName(key)..", Administrator mit Vollzugriff", player, 0, 0, 200 )
		elseif index == 4 then
			if getPlayerName ( key ) == "[Vio]Zipper" or getPlayerName ( key ) == "[Vio]Michael" then
				lvl = "Scripter & Inhaber"
			else
				lvl = "Inhaber"
			end
			outputChatBox ( getPlayerName(key)..", "..lvl, player, 0, 0, 200 )
		end
		
	end
	
end

function check_func ( admin, cmd, target )

	if isAdminLevel ( admin, 1 ) then
	
		local player = findPlayerByName( target )
		if player then
			local playtime = getElementData ( player, "playingtime" )
			local playtimehours = math.floor(playtime/60)
			local playtimeminutes = playtime-playtimehours*60
			local playtime = playtimehours..":"..playtimeminutes
			outputChatBox ( "Name: "..getPlayerName(player).." ( ID: "..vioGetElementData(player,"playerid").." ), Geld ( Bar/Bank ): "..getElementData ( player, "money" ).."/"..getElementData ( player, "bankmoney" )..", Spielzeit: "..playtime.." Minuten", admin, 200, 200, 0 )
			--local job = jobNames [ getElementData ( player, "job" ) ]
			outputChatBox ( --[["Job: "..job..",]]" Warns: "..getPlayerWarnCount ( getPlayerName ( player ) )..", Telefonnr: "..getElementData ( player, "telenr" ), admin, 200, 200, 0 )
			outputChatBox ( "Tode: "..getElementData ( player, "deaths" )..", Kills: "..getElementData ( player, "kills" )..", Drogen: "..getElementData ( player, "drugs" )..", Materials: "..getElementData ( player, "mats" ), admin, 200, 200, 0 )
			local fraktion = tonumber ( getElementData ( player, "fraktion" ) )
			if fraktion == 0 then
				local fraktion = "Zivilist"
			elseif fraktion == 1 then
				local fraktion = "Polizist"
			elseif fraktion == 2 then
				local fraktion = "Mafioso"
			elseif fraktion == 3 then
				local fraktion = "Triade"
			elseif fraktion == 4 then
				local fraktion = "Terrorist"
			elseif fraktion == 5 then
				local fraktion = "Reporter"
			elseif fraktion == 6 then
				local fraktion = "Federal"
			elseif fraktion == 7 then
				local fraktion = "Aztecas"
			elseif fraktion == 8 then
				local fraktion = "Army"
			end
			outputChatBox ( "Gefundene Paeckchen: "..getElementData ( player, "foundpackages" ).."/25", admin, 200, 200, 0 )
			outputChatBox ( "Fraktion: "..fraktion..", AdminLVL: "..getElementData ( player, "adminlvl" )..", Bonuspunkte: "..getElementData ( player, "bonuspoints" ), admin, 200, 200, 0 )
			local pname = getPlayerName ( player )
			local licenses = ""
			if getElementData ( player, "carlicense" ) == 1 then licenses = licenses.."Fuehrerschein " end
			if getElementData ( player, "bikelicense" ) == 1 then licenses = licenses.."Motorradschein " end
			if getElementData ( player, "fishinglicense" ) == 1 then licenses = licenses.."Angelschein " end
			if getElementData ( player, "lkwlicense" ) == 1 then licenses = licenses.."LKW-Fuehrerschein " end
			if getElementData ( player, "gunlicense" ) == 1 then licenses = licenses.."Waffenschein " end
			if getElementData ( player, "motorbootlicense" ) == 1 then licenses = licenses.."Bootsfuehrerschein " end
			if getElementData ( player, "segellicense" ) == 1 then licenses = licenses.."Segelschein " end
			if getElementData ( player, "planelicenseb" ) == 1 then licenses = licenses.."Flugschein A " end
			if getElementData ( player, "planelicensea" ) == 1 then licenses = licenses.."Flugschein B " end
			if getElementData ( player, "helilicense" ) == 1 then licenses = licenses.."Flugschein C " end
			outputChatBox ( "Vorhandene Lizensen: ", admin, 200, 0, 200 )
			outputChatBox ( licenses, admin, 200, 50, 200 )
			executeCommandHandler ( "getchangestate", admin, getPlayerName(player) )
			outputChatBox ( "IP: "..getPlayerIP(player), admin, 200, 200, 0 )
			outputChatBox ( "Aktuelle Waffe: "..getPedWeapon(player), admin, 125, 125, 125 )
		else
			triggerClientEvent ( admin, "infobox_start", getRootElement(), "\n\nUngueltiger Name!", 7500, 125, 0, 0 )
		end
		
	else
	
		triggerClientEvent ( admin, "infobox_start", getRootElement(), "\n\nDu bist kein\n Admin!", 7500, 125, 0, 0 )
		
	end
	
end

function mark_func ( player, cmd, count )

	if isAdminLevel ( player, 1 ) then
	
		if not count then
		
			count = 1
			
		end
	
		count = tonumber(count)
			
		if count ~= 1 and count ~= 2 and count ~= 3 then
			
			outputChatBox ( "Es sind nur Marker 1, 2 und 3 moeglich!", player, 0, 0, 0 )
			return		
		
		end
	
		local x, y, z = getElementPosition ( player )
		local int = getElementInterior ( player )
		local dim = getElementDimension ( player )

		setElementData ( player, "adminMarkerX"..count, x )
		setElementData ( player, "adminMarkerY"..count, y )
		setElementData ( player, "adminMarkerZ"..count, z )
		setElementData ( player, "adminMarkerDim"..count, dim )		
		setElementData ( player, "adminMarkerInt"..count, int )	
		
		outputChatBox ( "Koordinaten fuer Marker "..count.." gesetzt!", player, 0, 0, 0 )
				
	end
	
end

function gotomark_func ( player, cmd, count )


	if isAdminLevel ( player, 1 ) then

		if not count then
		
			count = 1
			
		end
	
		count = tonumber(count)
			
		if count ~= 1 and count ~= 2 and count ~= 3 then
			
			outputChatBox ( "Es sind nur Marker 1, 2 und 3 moeglich!", player, 0, 0, 0 )
			return		
		
		end
		
		local check = getElementData( player, "adminMarkerX"..count )
		
		if not check then
			outputChatBox ( "Marker existiert nicht!", player, 0, 0, 0 )
			return
		end
						
		local seat = getPedOccupiedVehicleSeat ( player )
		
		if seat then
		
			if seat == 0 then
			
				setElementPosition ( getPedOccupiedVehicle( player ), getElementData( player, "adminMarkerX"..count ), getElementData( player, "adminMarkerY"..count ), getElementData( player, "adminMarkerZ"..count ) )
				setElementDimension ( getPedOccupiedVehicle( player ), getElementData( player, "adminMarkerDim"..count ) )
				setElementInterior ( getPedOccupiedVehicle( player ), getElementData( player, "adminMarkerInt"..count ) )
				setElementDimension ( player, getElementData( player, "adminMarkerDim"..count ) )
				setElementInterior ( player, getElementData( player, "adminMarkerInt"..count ) )
				
				outputChatBox ( "Zum "..count..". Marker teleportiert!", player, 0, 0, 0 )
				return
			
			end
			
		end
		removePedFromVehicle ( player )
		setElementPosition ( player, getElementData( player, "adminMarkerX"..count ), getElementData( player, "adminMarkerY"..count ), getElementData( player, "adminMarkerZ"..count ) )
		setElementDimension ( player, getElementData( player, "adminMarkerDim"..count ) )
		setElementInterior ( player, getElementData( player, "adminMarkerInt"..count ) )

		outputChatBox ( "Zum "..count..". Marker teleportiert!", player, 0, 0, 0 )
		
	end
	
end

function report_func ( player, cmd, ... )	
	
	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	
	if stringWithAllParameters == nil then
	
		outputChatBox ("Bitte einen Text angeben!", player, 125, 0, 0 )
		
	elseif stringWithAllParameters == "" or stringWithAllParameters == " " or stringWithAllParameters == "  " then
	
		outputChatBox ("Bitte einen Text angeben!", player, 125, 0, 0 )
		
	else
	
		local counter
		
		for playeritem, index in pairs(adminsIngame) do
		
			outputChatBox ( "Report von "..getPlayerName(player).." (ID: "..getElementData(player,"playerid").."): ", playeritem, 200, 255, 0 )
			outputChatBox ( stringWithAllParameters, playeritem, 200, 200, 0 )
			counter = true
			
		end
		
		if counter then
		
			outputChatBox ( "Dein Report wurde gesendet!", player, 0, 125, 0 )
			player_admin[tonumber(getElementData(player,"playerid"))] = getPlayerName(player)
			
		else
		
			outputChatBox ( "Im Moment ist kein Admin online! Nutze /admins, um zu sehen, wer online ist!", player, 0, 125, 0 )
			
		end
		
	end
	
end

function whisper_func ( player, cmd, number, ... )
	
	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	local number = tonumber ( number )
	
	if isAdminLevel ( player, 1 ) then
	
		if stringWithAllParameters == nil then
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nBitte einen\nText eingeben!", 5000, 125, 0, 0 )
			
		else
		
			local target = getPlayerFromName(player_admin[number])
			
			if isElement( target ) then
			
				outputChatBox ( "Admin "..getPlayerName(player).." fluestert: "..stringWithAllParameters, target, 200, 200, 0 )
				outputChatBox ( "Tippe /reply, um zu antworten.", target, 200, 200, 0 )
				outputChatBox ( "Du hast "..player_admin[number].." gefluestert!", player, 0, 125, 0 )
				
				for playeritem, index in pairs(adminsIngame) do
				
					outputChatBox ( getPlayerName(player).." hat "..player_admin[number].." gefluestert!", playeritem, 200, 200, 0 )
					
				end
				
				vioSetElementData ( target, "supporter", player )
				vioSetElementData ( target, "isInSupport", true )
				
			else
			
				outputChatBox ( "Der Spieler ist offline!", player, 255, 0, 0 )
			
			end
					
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist kein\n Admin!", 5000, 125, 0, 0 )
		
	end
	
end

function reply_func ( player, cmd, ... )
	
	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	
	if vioGetElementData ( player, "isInSupport" ) then
	
		local supporter = vioGetElementData ( player, "supporter" )
		
		if isElement ( supporter ) then
		
			outputChatBox ( getPlayerName ( player ).." (ID: "..vioGetElementData(player,"playerid").."): "..stringWithAllParameters, supporter, 200, 200, 0 )
			outputChatBox ( "Du hast "..getPlayerName ( supporter ).." geantwortet!", player, 0, 125, 0 )
			
		else
		
			outputChatBox ( "Der Admin ist offline.", player, 125, 0, 0 )
			
		end
		
	end
	
end

function respawn_func ( player, cmd, respawn )

	local bool = false
	local boole = false

	if player == "none" then bool = true end
	
	if isElement(player) then
		if isAdminLevel ( player, 1 ) then
			bool = true
		end
	end

	if bool then
		if respawn == "faggio" then
			for i = 1, 20 do
				if getVehicleOccupant ( _G["noobfaggio"..i] ) == false then
					respawnVehicle ( _G["noobfaggio"..i] )
					setElementDimension ( _G["noobfaggio"..i], 0 )
					setElementInterior ( _G["noobfaggio"..i], 0 )
				end
			end
			for i = 1, 12 do
				if getVehicleOccupant ( _G["airportfaggio"..i] ) == false then
					respawnVehicle ( _G["airportfaggio"..i] )
					setElementDimension ( _G["airportfaggio"..i], 0 )
					setElementInterior ( _G["airportfaggio"..i], 0 )
				end
			end
		elseif respawn == "fishing" then
			for i = 1, 9 do
				if getVehicleOccupant ( _G["reefer"..i] ) == false then
					respawnVehicle ( _G["reefer"..i] )
					setElementDimension ( _G["reefer"..i], 0 )
					setElementInterior ( _G["reefer"..i], 0 )
				end
			end
		elseif respawn == "sfpd" then
			for veh, _ in pairs ( factionVehicles[1] ) do
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
		elseif respawn == "terror" then
			for veh, _ in pairs ( factionVehicles[4] ) do
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
		elseif respawn == "mafia" then
			for veh, _ in pairs ( factionVehicles[2] ) do
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
		elseif respawn == "triaden" then
			for veh, _ in pairs ( factionVehicles[3] ) do
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
		elseif respawn == "news" then
			for veh, _ in pairs ( factionVehicles[5] ) do
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
		elseif respawn == "fbi" then
			for veh, _ in pairs ( factionVehicles[6] ) do
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
		elseif respawn == "taxi" then
			for i = 1, 6 do
				local veh = _G["taxi"..i]
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
		elseif respawn == "hotdog" then
			for i = 1, 7 do
				local veh = _G["hotdog"..i]
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
		elseif respawn == "aztecas" then
			for veh, _ in pairs ( factionVehicles[7] ) do
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
		elseif respawn == "army" then
			for veh, _ in pairs ( factionVehicles[8] ) do
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
			if not getVehicleOccupant ( armyAC130 ) then
				destroyElement ( armyAC130 )
				ac130 ()
			end
		elseif respawn == "biker" then
			for veh, _ in pairs ( factionVehicles[9] ) do
				if not getVehicleOccupant ( veh ) then
					respawnVehicle ( veh )
				end
			end
		else
			if player ~= "none" then outputChatBox ( "/respawn [faggio|sfpd|mafia|triaden|news|terror|fbi|aztecas|army|biker|fishing|taxi|hotdog]", player, 125, 0, 0 ) end
			boole = true
		end
		if not boole then
			if player ~= "none" then outputChatBox ( "Fahrzeuge respawned!", player, 0, 125, 0 ) end
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nDu bist nicht\nauthorisiert!", 5000, 125, 0, 0 )
	end
	
end

function ServerRestartFactionRespawn ()

	respawn_func ( "none", "none", "sfpd" )
	respawn_func ( "none", "none", "mafia" )
	respawn_func ( "none", "none", "terror" )
	respawn_func ( "none", "none", "news" )
	respawn_func ( "none", "none", "fbi" )
	respawn_func ( "none", "none", "aztecas" )
	respawn_func ( "none", "none", "army" )
	respawn_func ( "none", "none", "biker" )
	respawn_func ( "none", "none", "triaden" )
	
	outputDebugString ( "Fraktionsfahrzeuge gepanzert" )
	
end

setTimer ( ServerRestartFactionRespawn, 30000, 1 )

function tunecar_func ( player, cmd, part )

	if isAdminLevel ( player, 4 ) then
	
		if tonumber ( part ) then
		
			succes = addVehicleUpgrade ( getPedOccupiedVehicle(player), tonumber ( part ) )
			
			if succes == false then
			
				outputChatBox ( "Ungueltige Eingabe/Fahrzeug!", player, 125, 0, 0 )
				
			end
			
		else
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nGebrauch:\n/tunecar [Part]", 7500, 125, 0, 0 )
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist nicht\nauthorisiert!", 5000, 125, 0, 0 )
		
	end
	
end

function freezeshit ( )

	setElementFrozen ( source, true )
	setElementFrozen ( veh_frozen_vehs[getPlayerName(source)], false )	

end

function cancelWeaponShit ()
	setPedWeaponSlot ( source, 0 )
end

function freeze_func ( player, cmd, target )

	local fix
	
	if isAdminLevel ( player, 1 ) then
	
		target = findPlayerByName( target )
		
		if target then
		
			if frozen_players[getPlayerName(target)] then
			
				setElementFrozen ( target, false )
				frozen_players[getPlayerName(target)] = false
				removeEventHandler ( "onPlayerWeaponSwitch", target, cancelWeaponShit )
				outputChatBox ( "Du hast "..getPlayerName(target).." entfreezed!", player, 0, 125, 0 )
				outputChatBox ( "Du wurdest von "..getPlayerName(player).." entfreezed!", target, 0, 125, 0 )
				
				return
			
			end
			
			if veh_frozen_players[getPlayerName(target)] then
			
				setElementFrozen ( target, false )
				veh_frozen_players[getPlayerName(target)] = false
				removeEventHandler ( "onPlayerWeaponSwitch", target, cancelWeaponShit )
				setElementFrozen ( veh_frozen_vehs[getPlayerName(target)], false )
				veh_frozen_vehs[getPlayerName(target)] = false	
				removeEventHandler ( "onPlayerVehicleExit", target, freezeshit )
					
				outputChatBox ( "Du hast "..getPlayerName(target).." entfreezed!", player, 0, 125, 0 )
				outputChatBox ( "Du wurdest von "..getPlayerName(player).." entfreezed!", target, 0, 125, 0 )
				
				return
			
			end
		
			local veh = getPedOccupiedVehicle ( target )		
			
			if veh then
			
				setElementFrozen ( veh, true )
				
				veh_frozen_players[getPlayerName(target)] = true
				veh_frozen_vehs[getPlayerName(target)] = veh
				addEventHandler ( "onPlayerWeaponSwitch", target, cancelWeaponShit )
				setPedWeaponSlot ( target, 0 )
				addEventHandler ( "onPlayerVehicleExit", target, freezeshit )
					
				addEventHandler ( "onPlayerQuit", target, 
					function ()
						setElementFrozen ( veh_frozen_vehs[getPlayerName(source)], false )
						veh_frozen_players[getPlayerName(source)] = false
						veh_frozen_vehs[getPlayerName(source)] = false
					end )
					
			else
			
				setElementFrozen ( target, true )
				frozen_players[getPlayerName(target)] = true
				addEventHandler ( "onPlayerWeaponSwitch", target, cancelWeaponShit )
				setPedWeaponSlot ( target, 0 )
				addEventHandler ( "onPlayerQuit", target, 
					function ()
						frozen_players[getPlayerName(source)] = false
					end )
									
			end
						
			outputChatBox ( "Du hast "..getPlayerName(target).." gefreezed!", player, 0, 125, 0 )
			outputChatBox ( "Du wurdest von "..getPlayerName(player).." gefreezed!", target, 0, 125, 0 )
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist nicht\nauthorisiert!", 5000, 125, 0, 0 )
		
	end
	
end

function intdim ( player, cmd, target, int, dim )

	if isAdminLevel ( player, 1 ) then
	
		local target = findPlayerByName( target )
		
		if not isElement(target) then
			outputChatBox ( "Der Spieler ist offline!", player, 125, 0, 0 )
			return
		end
		
		setElementInterior ( target, tonumber ( int ) )
		setElementDimension ( target, tonumber ( dim ) )
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist nicht\nauthorisiert!", 5000, 125, 0, 0 )
		
	end
		
end

function cleartext_func ( player )

	if vioGetElementData ( player, "adminlvl" ) == "console" then
	
		vioSetElementData( player, "adminlvl", 99 )
		
	end
	
	if isAdminLevel ( player, 1 ) then
	
		for i = 1, 50 do
			outputChatBox ( " " )
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist nicht\nauthorisiert!", 5000, 125, 0, 0 )
		
	end
	
end

function kickPlayerGMX ( player )

	kickPlayer ( player, "Serverrestart" )
	
end

function restartNow ()

	if not isThisTheBetaServer () then
		setServerPassword ( "" )
	end
	
	local resource = getResourceFromName ( "vio" )
	elementData = nil
	restartResource ( resource )
	
end

function restartServer()
	
	local btime = getRealTime()
	local bmonth = btime.month
	local bday = btime.monthday
	local bhour = btime.hour
	local bminute = btime.minute
	local bsecond = btime.second
	
	if isThisTheBetaServer () then
		setServerPassword ( betaServerPasswort )
	else
		setServerPassword ( "SDFSDFSDFFSD!" )
	end
	
	i = 0
	
	for id, playeritem in ipairs(getElementsByType("player")) do 
		i = i + 1
		setTimer ( kickPlayerGMX, 50+100*i, 1, playeritem )
	end
	
	setTimer ( restartNow, 100+200*i, 1 )
	
end

function gmx_func ( player, cmd, minutes )
	
	if getElementType(player) == "console" then
	
		vioSetElementData ( player, "adminlvl", 99 )
		
	end
	
	if isAdminLevel ( player, 3 ) then
	
		outputAdminLog ( getPlayerName ( player ).." hat den Server neu gestartet." )
		if not tonumber(minutes) then minutes = 1 end
		
		setTimer ( restartServer, minutes*60000, 1 )
		outputChatBox ( "Server wird in "..minutes.." Minuten neu gestartet.", getRootElement(), 125, 0, 0 )
		
		local btime = getRealTime()
		local bmonth = btime.month
		local bday = btime.monthday
		local bhour = btime.hour
		local bminute = btime.minute
		local bsecond = btime.second
		outputServerLog ( bday.."."..bmonth..", "..bhour..":"..bminute..":"..bsecond.." - "..getPlayerName ( player ).." hat den Server neu gestartet!")
		
	end
	
end

function ochat_func ( player, cmd, ... )
	
	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	
	if isAdminLevel ( player, 1 ) then
	
		if stringWithAllParameters == nil then
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nBitte einen\nText eingeben!", 5000, 125, 0, 0 )
			
		else
		
			local rang = tonumber(getElementData ( player, "adminlvl" ))
		
	
			if rang == 1 then
				rank = "Moderator"
			elseif rang == 2 then
				rank = "Admin"
			elseif rang == 3 then
				rank = "Admin m. V."
			elseif rang == 4 then
				if getPlayerName(player) == "[Vio]Zipper" or getPlayerName(player) == "[Vio]Michael" then
					rank = "Scripter & Inhaber"
				else
					rank = "Inhaber"
				end
			end
		
			outputChatBox ( "(( "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ))", getRootElement(), 255, 255, 255 )
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist kein\n Admin!", 5000, 125, 0, 0 )
		
	end
	
end

function achat_func ( player, cmd, ... )	
	
	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	
	if isAdminLevel ( player, 1 ) then
	
		if stringWithAllParameters == nil then
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nBitte einen\nText eingeben!", 5000, 125, 0, 0 )
			
		else
					
			local rang = tonumber(getElementData ( player, "adminlvl" ))
					
			if rang == 1 then
				rank = "Moderator"
			elseif rang == 2 then
				rank = "Admin"
			elseif rang == 3 then
				rank = "Admin m. V."
			elseif rang == 4 then
				if getPlayerName(player) == "[Vio]Zipper" or getPlayerName(player) == "[Vio]Michael" then
					rank = "Scripter & Inhaber"
				else
					rank = "Inhaber"
				end
			end
			
			for playeritem, index in pairs(adminsIngame) do 
			
				if vioGetElementData ( playeritem, "adminlvl" ) then
					if tonumber(vioGetElementData ( playeritem, "adminlvl" )) >= 1 then
						outputChatBox ( "[ "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ]", playeritem, 99, 184, 255 )
					end
				end
				
			end
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist in\nkein Admin!", 5000, 125, 0, 0 )
		
	end
	
end

function setrank_func ( player, cmd, target, rank )

	target = findPlayerByName( target )
	rank = math.floor ( math.abs ( tonumber ( rank ) ) )
	
	if isAdminLevel ( player, 2 ) then
	
		if isElement ( target ) then
		
			if rank <= 5 then
			
				vioSetElementData ( target, "rang", rank )
				outputChatBox ( "Admin "..getPlayerName ( player ).." hat deinen Rank auf "..rank.." gesetzt!", target, 200, 200, 0 )
				outputChatBox ( "Rang gesetzt!", player, 0, 125, 0 )
				
			else
			
				outputChatBox ( "Gebrauch: /setrank [Name] [Rang]", player, 125, 0, 0 )
				
			end
			
		else
		
			outputChatBox ( "Gebrauch: /setrank [Name] [Rang]", player, 125, 0, 0 )
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function makeleader_func ( player, cmd, target, fraktion )

	target = findPlayerByName( target )
	fraktion = math.floor ( math.abs ( tonumber ( fraktion ) ) )
	
	if isAdminLevel ( player, 2 ) then
	
		if getPlayerPing ( target ) == false then
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Gebrauch:\n/makeleader \n[Player] [Fraktion]", 5000, 0, 125, 125 )
			
		else
		
			if getElementData ( target, "loggedin" ) == 1 then
			
				if fraktion >= 0 then
				
					fraktionMembers[vioGetElementData ( target, "fraktion")][target] = nil
					
					if fraktion == 0 then
					
						vioSetElementData ( target, "rang", 0 )
						outputChatBox ( "Du wurdest soeben zum Zivilisten gemacht.", target, 0, 125, 0 )
						outputAdminLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Zivilisten gemacht." )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
						
					end
					
					if fraktion == 1 then
					
						vioSetElementData ( target, "rang", 5 )
						outputChatBox ( "Du wurdest soeben zum Polizeichief ernannt! Fuer mehr Infos oeffne das Hilfemenue!", target, 0, 125, 0 )
						outputAdminLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Polizeichief ernannt!" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
						
					end
					
					if fraktion == 2 then
					
						vioSetElementData ( target, "rang", 5 )
						outputChatBox ( "Du bist nun Don der Mafia - Fuer mehr Infos oeffne das Hilfemenue!", target, 0, 125, 0 )
						outputAdminLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Don ernannt!" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
						
					end
					
					if fraktion == 3 then
					
						vioSetElementData ( target, "rang", 5 )
						outputChatBox ( "Du bist nun das Oberhaupt der Triaden - Fuer mehr Infos oeffne das Hilfemenue!", target, 0, 125, 0 )
						outputAdminLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Triadenboss ernannt!" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
						
					end
					
					if fraktion == 4 then
					
						vioSetElementData ( target, "rang", 5 )
						outputChatBox ( "Du bist nun der Fuehrer der Terroristen - Fuer mehr Infos oeffne das Hilfemenue!", target, 0, 125, 0 )
						outputAdminLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Revolutionsführer ernannt!" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
						
					end
					
					if fraktion == 5 then
					
						vioSetElementData ( target, "rang", 5 )
						outputChatBox ( "Du bist nun der Chefredakteur der LTR - Fuer mehr Infos oeffne das Hilfemenue!", target, 0, 125, 0 )
						outputAdminLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Chefredakteur ernannt!" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
						
					end
					
					if fraktion == 6 then
					
						vioSetElementData ( target, "rang", 5 )
						outputChatBox ( "Du bist nun der Direktor des Federal Bureau of Investigation - Fuer mehr Infos oeffne das Hilfemenue!", target, 0, 125, 0 )
						outputAdminLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum FBI-Direktor ernannt!" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
						
					end
					
					if fraktion == 7 then
					
						vioSetElementData ( target, "rang", 5 )
						outputChatBox ( "Du bist nun der Boss der Los Aztecas - Fuer mehr Infos oeffne das Hilfemenue!", target, 0, 125, 0 )
						outputAdminLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Jefa ernannt!" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
						
					end
					
					if fraktion == 8 then
					
						vioSetElementData ( target, "rang", 5 )
						outputChatBox ( "Du bist nun der Commander der Army - Fuer mehr Infos oeffne das Hilfemenue!", target, 0, 125, 0 )
						outputAdminLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." zum Commander ernannt!" )
						MySQL_SetString ( "userdata", "LastFactionChange", timestampOptical (), "Name LIKE '"..getPlayerName ( target ).."'")
						
					end
					
					if fraktion ~= 0 then
					
						fraktionMembers[fraktion][target] = fraktion
						
					end
					
					vioSetElementData ( target, "fraktion", fraktion )
					
					for playeritem, key in pairs(adminsIngame) do 
					
						outputChatBox ( getPlayerName(player).." hat "..getPlayerName(target).." zum Leader von Fraktion "..fraktion.." gemacht!", playeritem, 255, 255, 0 )
						
					end
					
				else
				
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nUngueltige\nFraktions-ID!", 5000, 0, 125, 125 )
					
				end
				
			else
			
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nSpieler ist\nnicht eingeloggt!", 5000, 0, 125, 125 )
				
			end
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function spec_func ( player, command, spec )

	if isAdminLevel ( player, 1 ) then
	
		if not spec then
			spec = getPlayerName(player)
		end
	
		if findPlayerByName ( spec ) then
		
			if spec == getPlayerName(player) then
				setElementFrozen ( player, false )
			else
				setElementFrozen ( player, true )
			end
		
			fadeCamera( player, true )
			setCameraTarget( player, findPlayerByName ( spec ) )
			vioSetElementData ( player, "spectates", getPlayerFromName ( spec ) )
			
			if spec ~= getPlayerName ( player ) then
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Um den Spectate-Modus\nzu verlassen, tippe\nnur /spec", 5000, 0, 125, 125 )
			end
			
		else
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nGebrauch:\n/spec [Player]", 5000, 0, 125, 125 )
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function rkick_func ( player, command, kplayer, ... )
	
	if isElement(player) then
	
		if getElementType(player) == "console" then
		
			vioSetElementData(player, "adminlvl", 99 )
			
		end
	
	end
	
	if isAdminLevel ( player, 1 ) and ( not client or client == player ) then
	
		local reason = {...}
		reason = table.concat( reason, " " )
		
		local target = findPlayerByName(kplayer)
		
		if not isElement(target) then
			outputChatBox ( "Der Spieler ist offline!", player, 125, 0, 0 )
			return
		end
		
		if getAdminLevel ( player ) > getAdminLevel ( target ) then
		
			outputChatBox ("Spieler "..getPlayerName(target).." wurde von "..getPlayerName ( player ).." gekickt! (Grund: "..tostring ( reason )..")", getRootElement(), 255, 0, 0 )
			kickPlayer ( target, player, tostring(reason) )
			
		else
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler hat\neinen hoeheren \nAdminrang als du!", 5000, 255, 0, 0 )
			
		end
		
		outputAdminLog ( getPlayerName ( player ).." hat "..kplayer.." gekickt!" )
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function rban_func ( player, command, kplayer, ... )
		
	if getElementType(player) == "console" then
	
		vioSetElementData(player, "adminlvl", 99 )
		
	end
	
	if isAdminLevel ( player, 1 ) and ( not client or client == player ) then
	
		local reason = {...}
		reason = table.concat( reason, " " )
		local target = findPlayerByName ( kplayer )
		kplayer = MySQL_Save ( kplayer )
		
		if not target then
		
			if MySQL_DatasetExist("players", "Name LIKE '"..kplayer.."'") then
			
				local serial = MySQL_GetString( "players", "Serial", "Name LIKE '"..kplayer.."'" )
				outputChatBox ( "Der Spieler wurde (offline) gebannt!", player, 125, 0, 0 )
				mysql_vio_query("INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES ('"..kplayer.."', '"..getPlayerName(player).."', '"..reason.."', '"..timestamp().."', '0.0.0.0', '"..serial.."')")
				
			else
			
				outputChatBox ( "Der Spieler existiert nicht!", player, 125, 0, 0 )
				
			end
			
		else
		
			if getAdminLevel ( player ) < getAdminLevel ( target ) then
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler hat\neinen hoeheren \nAdminrang als du!", 5000, 255, 0, 0 )
				return
			end
		
			outputChatBox ("Spieler "..getPlayerName(target).." wurde von "..getPlayerName(player).." gebannt! (Grund: "..tostring(reason)..")",getRootElement(),255,0,0)
			
			local ip = getPlayerIP ( findPlayerByName(kplayer) )
			local serial = getPlayerSerial ( findPlayerByName(kplayer) )
			
			mysql_vio_query("INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES ('"..kplayer.."', '"..getPlayerName(player).."', '"..reason.."', '"..timestamp().."', '"..ip.."', '"..serial.."')")
			kickPlayer ( target, player, tostring(reason).." (gebannt!)" )
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function getip ( player, cmd, name )

	if not client or player == client then
	
		if isAdminLevel ( player, 1 ) then
		
			local target = findPlayerByName ( name )
			
			if isElement ( target ) then
			
				local ip = getPlayerIP ( target )
				outputChatBox ( "IP von "..name..": "..ip, player, 200, 200, 0 )
				
			else
			
				infobox ( player, "Gebrauch:\n/getip [Name]", 5000, 125, 0, 0 )
				
			end
			
		end
		
	end
	
end

function ipban ( player, cmd, ip )

	if isAdminLevel ( player, 2 ) then
	
		mysql_vio_query ( "INSERT INTO ban ( Name, Admin, Grund, Datum, IP, Serial ) VALUES ('IP-Ban', '"..getPlayerName ( player ).."', 'Unbekannt', '"..timestamp().."', '"..ip.."', '')" )
		outputChatBox ( "IP gesperrt.", player, 125, 0, 0 )
		
	end
	
end

function tban_func(player,command,kplayer,btime,...)
	
	if getElementType(player) == "console" then
	
		vioSetElementData(player, "adminlvl", 99 )
		
	end
		
	if isAdminLevel ( player, 1 ) and ( not client or client == player ) then
	
		local reason = {...}
		reason = table.concat( reason, " " )
		local target = findPlayerByName ( kplayer )
		
		if not isElement(target) then
			
			local success = timebanPlayer ( kplayer, tonumber(btime), getPlayerName( player ), reason )
			
			if success == false then
			
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Gebrauch:\n/tban [Player] [Grund]\n[Zeit],max. 3\nWoerter", 5000, 0, 125, 255 )
				
			end
			
			return
			
		end
		
		local name = getPlayerName( target )
		local savename = MySQL_Save ( name )
		
		local success = timebanPlayer ( savename, tonumber(btime), getPlayerName( player ), reason )
		
		if success == false then
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Gebrauch:\n/tban [Player] [Grund]\n[Zeit],max. 3\nWoerter", 5000, 0, 125, 255 )		
			
		end
						
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function slap_func(player,command,splayer,bslap)
	
	if getElementType(player) == "console" then
		vioSetElementData(player, "adminlvl", 3 )
	end
		
	if isAdminLevel ( player, 2 ) and ( not client or client == player ) then
	
		local target = findPlayerByName ( splayer )
		
		if not isElement(target) then
			outputChatBox ( "Der Spieler ist offline!", player, 125, 0, 0 )
			return
		end
		
		if not bslap then
			bslap = "nein"
		end
		
		if bslap == "nein" or bslap == "Nein" then
		
			local x,y,z = getElementPosition(target)
			setElementPosition ( target, x, y, z + 5, true )
			
			for playeritem, index in pairs(adminsIngame) do 
				outputChatBox ( getPlayerName(player).." hat "..getPlayerName(target).." geslapt!", playeritem, 255, 255, 0 )
			end
		
		elseif bslap == "ja" or bslap == "Ja" then
		
			local x, y, z = getElementPosition( target )
			setElementPosition ( target, x, y, z + 5, false )
			setPedOnFire ( target, true )
			
			for playeritem, key in pairs(adminsIngame) do
				outputChatBox ( getPlayerName(player).." hat "..getPlayerName(target).." geslapt und angezuendet!", playeritem, 255, 255, 0 )
			end
		
		else
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Gebrauch:\n/slap [Player] \n[Anzuenden]\nJa/Nein", 5000, 0, 125, 125 )
		
		end
			
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function goto_func(player,command,tplayer)

	if isAdminLevel ( player, 1 ) and ( not client or client == player ) then
	
		local target = findPlayerByName ( tplayer )
	
		if not isElement(target) then
			outputChatBox ( "Der Spieler ist offline!", player, 125, 0, 0 )
			return
		end
		
		local x, y, z = getElementPosition( target )
	
		if getPedOccupiedVehicleSeat ( player ) == 0 then
		
			setElementInterior ( player, getElementInterior(target) )
			setElementInterior ( getPedOccupiedVehicle(player), getElementInterior(target) )
			setElementPosition ( getPedOccupiedVehicle ( player ), x+3, y+3, z )
			setElementDimension ( getPedOccupiedVehicle ( player ), getElementDimension ( target ) )
			setElementDimension ( player, getElementDimension ( target ) )
			setElementVelocity(getPedOccupiedVehicle(player),0,0,0)
			setElementFrozen ( getPedOccupiedVehicle(player), true )
			setTimer ( setElementFrozen, 500, 1, getPedOccupiedVehicle(player), false )
			
		else
		
			removePedFromVehicle ( player )
			setElementPosition ( player, x, y + 1, z )
			setElementInterior ( player, getElementInterior(target) )
			setElementDimension ( player, getElementDimension ( target ) )
			
		end
		
		outputAdminLog ( getPlayerName ( player ).." hat sich zu "..getPlayerName ( target).." teleportiert!" )
			
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function gethere_func(player,command,tplayer)

	if isAdminLevel ( player, 1 ) and ( not client or client == player ) then
	
		local target = findPlayerByName ( tplayer )
		local x, y, z = getElementPosition ( player )
		if not isElement(target) then
			outputChatBox ( "Der Spieler ist offline!", player, 125, 0, 0 )
			return
		end
		
		if getPedOccupiedVehicleSeat ( target ) == 0 then
		
			setElementInterior ( target, getElementInterior(player) )
			setElementInterior ( getPedOccupiedVehicle(target), getElementInterior(player ) )
			setElementPosition ( getPedOccupiedVehicle(target), x+3, y+3, z )
			setElementDimension ( target, getElementDimension ( player ) )
			setElementDimension ( getPedOccupiedVehicle(target), getElementDimension ( player ) )
			setElementVelocity(getPedOccupiedVehicle(target),0,0,0)
			setElementFrozen ( getPedOccupiedVehicle(target), true )
			setTimer ( setElementFrozen, 500, 1, getPedOccupiedVehicle(target), false )
				
		else
			
			removePedFromVehicle ( target )
			setElementPosition ( target, x, y + 1, z )
			setElementInterior ( target, getElementInterior(player) )
			setElementDimension ( target, getElementDimension ( player ) )
			
		end
	
		outputAdminLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." zu sich teleportiert." )
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 7500, 255, 0, 0 )
		
	end
	
end

function skydive_func(player,command,tplayer)

	if isAdminLevel ( player, 2 ) and ( not client or client == player ) then
	
		local target = findPlayerByName ( tplayer )
	
		if not isElement(target) then
			outputChatBox ( "Der Spieler ist offline!", player, 125, 0, 0 )
			return
		end		
	
		giveWeapon ( target, 46, 1, true )
		triggerClientEvent ( target, "sec_gun_give", getRootElement(), 46, 1 )
		
		local x, y, z = getElementPosition(target)
		
		if getPedOccupiedVehicleSeat ( target ) == 0 then
		
			setElementPosition ( getPedOccupiedVehicle(target), x, y, z+2000 )
			
		else
				
			removePedFromVehicle ( target )
			setElementPosition ( target, x, y, z+2000 )
			
		end
		
		for playeritem, key in pairs(adminsIngame) do 
		
			outputChatBox ( getPlayerName(player).." hat "..getPlayerName(target).." geskydived!", playeritem, 255, 255, 0 )
			
		end
		
		outputAdminLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." geskydived!" )
				
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

local blocked_cms = {}
blocked_cms["say"] = true
blocked_cms["teamsay"] = true
blocked_cms["ad"] = true
blocked_cms["me"] = true
blocked_cms["t"] = true
blocked_cms["g"] = true
blocked_cms["s"] = true
blocked_cms["l"] = true
blocked_cms["m"] = true

function vioMutePlayer ( cmd )

	if blocked_cms[cmd] then
		outputChatBox ( "Du bist gemuted, benutze /report fuer Fragen!", player, 125, 0, 0 )
		cancelEvent()
	end

end

function mute_func(player,command,tplayer)

	if isAdminLevel ( player, 1 ) and ( not client or client == player ) then
	
		local target = findPlayerByName ( tplayer )
	
		if not isElement(target) then
			outputChatBox ( "Der Spieler ist offline!", player, 125, 0, 0 )
			return
		end		
		
		if muted_players[target] then
		
			removeEventHandler ( "onPlayerCommand", target, vioMutePlayer )	
			
			muted_players[target] = false
			
			for playeritem, key in pairs(adminsIngame) do 
			
				outputChatBox ( getPlayerName(player).." hat "..getPlayerName(target).." entmuted!", playeritem, 255, 255, 0 )
				
			end
			
		else
		
			addEventHandler( "onPlayerCommand", target, vioMutePlayer )
			
			muted_players[target] = true
			
			for playeritem, key in pairs(adminsIngame) do 
			
				outputChatBox ( getPlayerName(player).." hat "..getPlayerName(target).." gemuted!", playeritem, 255, 255, 0 )
				
			end
					
		end	

				
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function unban_func ( player, cmd, nick )

	if getElementType ( player ) == "console" then
	
		vioSetElementData ( player, "adminlvl", 999 )
		
	end
	
	if isAdminLevel ( player, 2 ) then
	
		nick = MySQL_Save ( nick )
		local name = MySQL_GetString("ban", "Name", "Name LIKE '"..nick.."'")
		
		if name then
		
			MySQL_DelRow ( "ban", "Name LIKE '"..name.."'")
			outputChatBox ( getPlayerName(player).." hat "..nick.." entbannt!", getRootElement(), 125, 0, 0 )
			outputAdminLog ( getPlayerName(player).." hat "..nick.." entbannt." )
			
		else
		
			outputChatBox ( "Der Spieler existiert nicht!", player, 125, 0, 0 )
			
		end
		
	end
	
end

function askin_func ( player, cmd, skin )
	
	if isAdminLevel ( player, 4 ) and skin then
	
		setElementModel ( player, tonumber(skin) )
		vioSetElementData ( player, "skinid", tonumber(skin) )
		outputChatBox ( "Du hast den Skin "..skin.." angenommen!", player, 125, 0, 0 )
		
	end
	
end

function crespawn_func ( player, cmd, radius )
	
	if isAdminLevel ( player, 1 ) then
	
		if radius then
		
			radius = tonumber(radius)
			
			if radius <= 50 and radius > 0 then
			
				local x, y, z = getElementPosition ( player )
				local sphere_1 = createColSphere ( x, y, z, radius )
				
				local spehere_table = getElementsWithinColShape ( sphere_1, "vehicle" )
			
				for theKey,theVehicle in pairs(spehere_table) do
				
					if doesAnyPlayerOccupieTheVeh ( theVehicle ) then
						-- Nichts
					else
				
						if not getElementData ( theVehicle, "carslotnr_owner" ) then
					
							respawnVehicle ( theVehicle )
							
						else
						
							local towcar = getElementData ( theVehicle, "carslotnr_owner" )
							local pname = getElementData ( theVehicle, "owner" )
							respawnPrivVeh ( towcar, pname )
						end
					
					end
					
				end
				
				destroyElement(sphere_1)
			
			else
			
				outputChatBox ( "/crespawn [0 > Radius <= 50]!", player, 125, 0, 0 )
			
			end
			
		else
		
			outputChatBox ( "/crespawn [Radius]!", player, 125, 0, 0 )
			
		end
		
	end
	
end

function gotocar_func ( player, cmd, targetname, slot )
	
	if isAdminLevel ( player, 2 ) then
	
		if targetname and slot then
			slot = tonumber(slot)
			local target = findPlayerByName ( targetname )
			local newtargetname = MySQL_Save ( getPlayerName ( target ) )
			
			if isElement(target) then
			
				local carslot = vioGetElementData ( target, "carslot"..slot )
			
				if carslot then
				
					if carslot >= 1 then
					
						local veh = _G[getPrivVehString ( newtargetname, slot )]
						
						if isElement(veh) then
						
							local x, y, z = getElementPosition(veh)
							local inter = getElementInterior(veh)
							local dimension = getElementDimension(veh)
							
							setElementPosition ( player, x, y, z+1.5 )
							setElementInterior ( player, inter )
							setElementDimension ( player, dimension )
							
						else
						
							respawnPrivVeh ( slot, newtargetname )
							
							veh = _G[getPrivVehString ( newtargetname, slot )]
							
							local x, y, z = getElementPosition(veh)
							local inter = getElementInterior(veh)
							local dimension = getElementDimension(veh)
							
							setElementPosition ( player, x, y, z+1.5 )
							setElementInterior ( player, inter )
							setElementDimension ( player, dimension )
						
						end
					
					else
					
						outputChatBox ( "Der Spieler hat keinen Wagen mit dieser Nummer!", player, 125, 0, 0 )
					
					end
				
				else
				
					outputChatBox ( "Der Spieler hat keinen Wagen mit dieser Nummer!", player, 125, 0, 0 )
				
				end
			
			else
			
				outputChatBox ( "Spieler muss online sein!", player, 125, 0, 0 )
				
			end
		
		else
		
			outputChatBox ( "/gotocar [Spieler] [Slot]!", player, 125, 0, 0 )
			
		end
	
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function getcar_func ( player, cmd, targetname, slot )
	
	if isAdminLevel ( player, 4 ) then
	
		if targetname and slot then
			slot = tonumber(slot)
			local target = findPlayerByName ( targetname )
			local newtargetname = MySQL_Save ( getPlayerName ( target ) )
			
			if isElement(target) then
			
				local carslot = vioGetElementData ( target, "carslot"..slot )
			
				if carslot then
				
					if carslot >= 1 then
					
						local veh = _G[getPrivVehString ( newtargetname, slot )]
						
						if isElement(veh) then
						
							local x, y, z = getElementPosition(player)
							local inter = getElementInterior(player)
							local dimension = getElementDimension(player)
							
							setElementPosition ( veh, x, y, z+1.5 )
							setElementInterior ( veh, inter )
							setElementDimension ( veh, dimension )
							
						else
						
							respawnPrivVeh ( slot, newtargetname )
							
							veh = _G[getPrivVehString ( newtargetname, slot )]
							
							local x, y, z = getElementPosition(player)
							local inter = getElementInterior(player)
							local dimension = getElementDimension(player)
							
							setElementPosition ( veh, x, y, z+1.5 )
							setElementInterior ( veh, inter )
							setElementDimension ( veh, dimension )
						
						end
					
					else
					
						outputChatBox ( "Der Spieler hat keinen Wagen mit dieser Nummer!", player, 125, 0, 0 )
					
					end
				
				else
				
					outputChatBox ( "Der Spieler hat keinen Wagen mit dieser Nummer!", player, 125, 0, 0 )
				
				end
			
			else
			
				outputChatBox ( "Spieler muss online sein!", player, 125, 0, 0 )
				
			end
		
		else
		
			outputChatBox ( "/getcar [Spieler] [Slot]!", player, 125, 0, 0 )
			
		end
	
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function astart_func ( player, cmd )
	
	if isAdminLevel ( player, 4 ) then
	
		local veh = getPedOccupiedVehicle ( player )
		
		if not isElement ( veh ) then
			outputChatBox ( "Du musst in einem Wagen sitzen!", player, 125, 0, 0 )
			return
		end
		
		if getElementModel ( veh ) ~= 438 then
		
			if ( getPedOccupiedVehicleSeat ( player ) == 0 ) then
				
				vioSetElementData ( veh, "fuelstate", 100 )
				vioSetElementData ( veh, "engine", false )
				setVehicleOverrideLights ( veh, 1 )
				vioSetElementData ( veh, "light", false)
				setVehicleEngineState ( veh, false )
				
				if getVehicleEngineState ( veh ) then
					setVehicleEngineState ( veh, false )
					vioSetElementData ( veh, "engine", false )
					return		
				end
				
				if vioGetElementData ( veh, "fuelstate" ) >= 1 then
				
					setVehicleEngineState ( veh, true )
					vioSetElementData ( veh, "engine", true )
					if not vioGetElementData ( veh, "timerrunning" ) then
						setVehicleNewFuelState ( veh )
						vioSetElementData ( veh, "timerrunning", true )
					end
					
				else
				
					outputChatBox ( "Benzin leer!", player, 125, 0, 0 )
					
				end
					
			end
			
		end
	
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end

function aenter_func ( player, cmd )
	
	if isAdminLevel ( player, 4 ) then
	
		setElementData ( player, "adminEnterVehicle", 1 )
		outputChatBox ( "Klicke auf einen Wagen!", player, 125, 0, 0 )
	
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
		
	end
	
end
--

-- Events

addEvent ( "executeAdminServerCMD", true )
addEvent ( "move", true )
addEvent ( "moveVehicleAway", true )
addEvent ( "adminMenueTrigger", true )
addEvent ( "rkick", true )
addEvent ( "rban", true )
addEvent ( "getip", true )
addEvent ( "tban", true )
addEvent ( "slap", true )
addEvent ( "goto", true )
addEvent ( "gethere", true )
addEvent ( "skydive", true )
addEvent ( "mute", true )

-- Event Handler

addEventHandler ( "executeAdminServerCMD", getRootElement(), executeAdminServerCMD_func )
addEventHandler ( "moveVehicleAway", getRootElement(), moveVehicleAway_func )
addEventHandler ( "move", getRootElement(), move_func )
addEventHandler ( "adminMenueTrigger", getRootElement(), adminMenueTrigger_func )
addEventHandler ( "mute", getRootElement(), mute_func )
addEventHandler ( "skydive", getRootElement(), skydive_func )
addEventHandler ( "gethere", getRootElement(), gethere_func )
addEventHandler ( "goto", getRootElement(), goto_func )
addEventHandler ( "slap", getRootElement(), slap_func )
addEventHandler ( "tban", getRootElement(), tban_func )
addEventHandler ( "getip", getRootElement(), getip )
addEventHandler ( "rban", getRootElement(), rban_func )
addEventHandler ( "rkick", getRootElement(), rkick_func )

-- Command Handler

addCommandHandler ( "hilfe", help_func )
addCommandHandler ( "nickchange", nickchange_func )
addCommandHandler ( "move", move_func )
addCommandHandler ( "pwchange", pwchange_func )
addCommandHandler ( "query", query_func )
addCommandHandler ( "shut", shut_func )
addCommandHandler ( "rebind", rebind_func )
addCommandHandler ( "admins", adminlist )
addCommandHandler ( "check", check_func )
addCommandHandler ( "mark", mark_func )
addCommandHandler ( "gotomark", gotomark_func )
addCommandHandler ( "w", whisper_func )
addCommandHandler ( "reply", reply_func )
addCommandHandler ( "respawn", respawn_func )
addCommandHandler ( "tunecar", tunecar_func )
addCommandHandler ( "freeze", freeze_func )
addCommandHandler ( "intdim", intdim )
addCommandHandler ( "cleartext", cleartext_func )
addCommandHandler ( "gmx", gmx_func )
addCommandHandler ( "report", report_func )
addCommandHandler ( "o", ochat_func )
addCommandHandler ( "a", achat_func )
addCommandHandler ( "setrank", setrank_func )
addCommandHandler ( "makeleader", makeleader_func )
addCommandHandler ( "spec", spec_func )
addCommandHandler ( "rkick", rkick_func )
addCommandHandler ( "rban", rban_func )
addCommandHandler ( "getip", getip )
addCommandHandler ( "ipban", ipban )
addCommandHandler ( "tban", tban_func )
addCommandHandler ( "slap", slap_func )
addCommandHandler ( "goto", goto_func )
addCommandHandler ( "gethere", gethere_func )
addCommandHandler ( "skydive", skydive_func )
addCommandHandler ( "rmute", mute_func )
addCommandHandler ( "unban", unban_func )
addCommandHandler ( "askin", askin_func )
addCommandHandler ( "crespawn", crespawn_func )
addCommandHandler ( "gotocar", gotocar_func )
addCommandHandler ( "getcar", getcar_func )
addCommandHandler ( "astart", astart_func )
addCommandHandler ( "aenter", aenter_func )