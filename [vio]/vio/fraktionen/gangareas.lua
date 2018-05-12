gangColor = {}
	gangColor[0] = {}
		gangColor[0][1] = 200
		gangColor[0][2] = 200
		gangColor[0][3] = 200
	gangColor[2] = {}
		gangColor[2][1] = 10
		gangColor[2][2] = 10
		gangColor[2][3] = 10
	gangColor[3] = {}
		gangColor[3][1] = 0
		gangColor[3][2] = 50
		gangColor[3][3] = 200
	gangColor[7] = {}
		gangColor[7][1] = 150
		gangColor[7][2] = 150
		gangColor[7][3] = 10
	gangColor[9] = {}
		gangColor[9][1] = 100
		gangColor[9][2] = 50
		gangColor[9][3] = 100
		
gangName = { 
 [0]="Niemandem",
 [2]="Mafia",
 [3]="Triaden",
 [7]="Aztecas",
 [9]="Angels of Death"
 }

validGangs = { 
 [2]=true,
 [3]=true,
 [7]=true,
 [9]=true
 }

areaTexts = {
 [3]="Gramm Drogen",
 [6]="Material",
 [8]="Material",
 [7]="Material"
 }
 
gangAreaUnderAttack = false
gangAreaAttackers = false
gangAreaDefenders = false
gangCount = 13
gangAreaConquerEach = 500

sec = 1000

function createGangAreas ( )

	local result = mysql_query( handler, "SELECT * FROM gangs" )
	
	if ( not result) then
		outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
		return
	end
	
	local dsatz = mysql_fetch_assoc( result )
		
	while ( dsatz ) do
	
		local ID = dsatz["Nummer"]
		local XS = math.abs( dsatz["X1"] - dsatz["X2"] )
		local YS = math.abs( dsatz["Y1"] - dsatz["Y2"] )
		local Besitzer = tonumber(dsatz["BesitzerFraktion"])
		local r, g, b = gangColor[Besitzer][1], gangColor[Besitzer][2], gangColor[Besitzer][3]
	
		_G["gangArea"..ID] = createRadarArea ( dsatz["X1"], dsatz["Y1"], XS, YS, r, g, b, 200, getRootElement() )
		_G["gangPickup"..ID] = createPickup ( dsatz["X3"], dsatz["Y3"], dsatz["Z3"], 3, 1313, 1, 9999 )
		
		vioSetElementData ( _G["gangPickup"..ID], "gang", Besitzer )
		vioSetElementData ( _G["gangPickup"..ID], "id", ID )
		vioSetElementData ( _G["gangPickup"..ID], "einnahmen", dsatz["Einnahmen"] )
		vioSetElementData ( _G["gangPickup"..ID], "isUnderAttack", false )
		vioSetElementData ( _G["gangPickup"..ID], "lastAttacked", dsatz["LastAttacked"] )
		
		addEventHandler ( "onPickupHit", _G["gangPickup"..ID], 
			function ( hit )
			
				if getElementType(hit) ~= "player" then
					return
				end
			
				outputChatBox ( "Dieses Ganggebiet gehoert: "..gangName[vioGetElementData( source, "gang" )], hit, 125, 125, 200 )
				
				if areaTexts[vioGetElementData( source, "id" )] then
					bonus = "1 "..areaTexts [vioGetElementData( source, "id" )].." / 20 Minuten"
				else
					bonus = "-"
				end
				
				outputChatBox ( "Einnahmen/Stunde: "..( vioGetElementData ( source, "einnahmen" ) * 12 )..", Sonstige Boni: "..bonus, hit, 125, 125, 200 )
				
				local fraktion = vioGetElementData ( hit, "fraktion" )
				
				local time = getRealTime( tonumber( vioGetElementData( source, "lastAttacked" ) ) )
				local str = time.monthday.."."..( tonumber(time.month) + 1 ).."."..(tonumber(time.year)+1900).." um "..time.hour..":"..time.minute..":"..time.second.." Uhr"
				
				outputChatBox ( "Naechster Attack moeglich am "..str.."!", hit, 125, 0, 0 )
				
				if vioGetElementData ( hit, "rang" ) >= 3 and validGangs[fraktion] then
					outputChatBox ( "Tippe /attack, um einen Angriff zu starten!", hit, 125, 0, 0 )
				end	
			
			end )
			
		dsatz = mysql_fetch_assoc ( result )
			
	end
	
	mysql_free_result ( result )

end

addEventHandler ( "onResourceStart", resourceRoot, createGangAreas )

--[[function createGangAreas ()

	local gangCounter = 1
	local Besitzer = tonumber ( MySQL_GetString("gangs", "BesitzerFraktion", "Nummer LIKE '" ..gangCounter.."'") )
	while true do
		local Besitzer = tonumber ( MySQL_GetString("gangs", "BesitzerFraktion", "Nummer LIKE '" ..gangCounter.."'") )
		if Besitzer then
			local Einnahmen = MySQL_GetString("gangs", "Einnahmen", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local X1 = MySQL_GetString("gangs", "X1", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local Y1 = MySQL_GetString("gangs", "Y1", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local X2 = MySQL_GetString("gangs", "X2", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local Y2 = MySQL_GetString("gangs", "Y2", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			
			local XS = math.abs(X1-X2)
			local YS = math.abs(Y1-Y2)
			
			local X3 = MySQL_GetString("gangs", "X3", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local Y3 = MySQL_GetString("gangs", "Y3", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local Z3 = MySQL_GetString("gangs", "Z3", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local Einnahmen = MySQL_GetString("gangs", "Einnahmen", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			local r = gangColor[Besitzer][1]
			local g = gangColor[Besitzer][2]
			local b = gangColor[Besitzer][3]
			local lastAttacked = MySQL_GetString("gangs", "LastAttacked", "Nummer LIKE '" ..tonumber(gangCounter).."'")
			
			_G["gangArea"..gangCounter] = createRadarArea ( X1, Y1, XS, YS, r, g, b, 200, getRootElement() )
			
			_G["gangPickup"..gangCounter] = createPickup ( X3, Y3, Z3, 3, 1313, 1, 9999 )
			vioSetElementData ( _G["gangPickup"..gangCounter], "gang", Besitzer )
			vioSetElementData ( _G["gangPickup"..gangCounter], "id", gangCounter )
			vioSetElementData ( _G["gangPickup"..gangCounter], "einnahmen", Einnahmen )
			vioSetElementData ( _G["gangPickup"..gangCounter], "isUnderAttack", false )
			vioSetElementData ( _G["gangPickup"..gangCounter], "lastAttacked", lastAttacked )
			
			addEventHandler ( "onPickupHit", _G["gangPickup"..gangCounter], gangPickupHit )
			
			gangCounter = gangCounter + 1
		else
			break
		end
	end
	setTimer ( gangAreaBoni, 20*60*1000, -1 )
	setTimer ( gangAreaEinnahmen, 5*60*1000, -1 )
end]]

function gangAreaBoni ()

	for i = 1, gangCount do
		local pickup = _G["gangPickup"..i]
		local owner = vioGetElementData ( pickup, "gang" )
		if validGangs[owner] then
			local id = vioGetElementData ( pickup, "id" )
			if areaTexts[id] then
				if id == 3 then
					local gang = 0
					factionDepotData["drugs"][owner] = factionDepotData["drugs"][owner] + 5
					local drugs = factionDepotData["drugs"][owner]
					MySQL_SetString("fraktionen", "DepotDrogen", drugs, "id = '"..owner.."'")
				elseif id == 6 then
					factionDepotData["mats"][owner] = factionDepotData["mats"][owner] + 2
					local mats = factionDepotData["mats"][owner]
					MySQL_SetString("fraktionen", "DepotMaterials", mats, "id = '"..owner.."'")
				elseif id == 7 then
					local gang = 0
					if gang then
						factionDepotData["mats"][owner] = factionDepotData["mats"][owner] + 2
						local mats = factionDepotData["mats"][owner]
						MySQL_SetString("fraktionen", "DepotMaterials", mats, "id = '"..owner.."'")
					end
				elseif id == 8 then
					local gang = 0
					if gang then
						factionDepotData["mats"][owner] = factionDepotData["mats"][owner] + 2
						local mats = factionDepotData["mats"][owner]
						MySQL_SetString("fraktionen", "DepotMaterials", mats, "id = '"..owner.."'")
					end
				end
			end
		end
	end
end

function gangAreaEinnahmen ()

	for i = 1, gangCount do
		local pickup = _G["gangPickup"..i]
		local owner = vioGetElementData ( pickup, "gang" )
		if validGangs[owner] then
			local id = vioGetElementData ( pickup, "gang" )
			local gang = 0
			if gang then
				factionDepotData["money"][owner] = factionDepotData["money"][owner] + vioGetElementData ( pickup, "einnahmen" )
				local money = factionDepotData["money"][owner]
				MySQL_SetString ( "fraktionen", "DepotGeld", money, "id = '"..owner.."'" )
			end
		end
	end
end

--[[function gangPickupHit ( hit )

	outputChatBox ( "Dieses Ganggebiet gehoert: "..gangName[vioGetElementData( source, "gang" )], hit, 125, 125, 200 )
	if areaTexts [ vioGetElementData ( source, "id" ) ] then
		bonus = "1 "..areaTexts [ vioGetElementData ( source, "id" ) ].." / 20 Minuten"
	else
		bonus = "-"
	end
	outputChatBox ( "Einnahmen/Stunde: "..( vioGetElementData ( source, "einnahmen" ) * 12 )..", Sonstige Boni: "..bonus, hit, 125, 125, 200 )
	local fraktion = vioGetElementData ( hit, "fraktion" )
	if vioGetElementData ( hit, "rang" ) >= 3 and validGangs[fraktion] then
		outputChatBox ( "Tippe /attack, um einen Angriff zu starten!", hit, 125, 0, 0 )
	end
end]]

function attack_func ( player )
	
	if validGangs[vioGetElementData ( player, "fraktion" )] and vioGetElementData ( player, "rang" ) >= 3 then
		local x1, y1, z1 = getElementPosition ( player )
		sucess = false
		validID = nil
		for i = 1, gangCount do
			local x2, y2, z2 = getElementPosition ( _G["gangPickup"..i] )
			if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 3 then
				validID = i
				sucess = true
				break
			end
		end
		if sucess then
			local pickup = _G["gangPickup"..validID]
			local owner = tonumber ( vioGetElementData ( pickup, "gang" ) )
			if owner ~= vioGetElementData ( player, "fraktion" ) then
				if getFactionMembersOnline ( owner ) >= 3 then
					if not gangAreaUnderAttack then
						local lastAttacked = tonumber ( MySQL_GetString("gangs", "LastAttacked", "Nummer LIKE '" ..tonumber(validID).."'") )
						local time = getRealTime()
						if time.timestamp > lastAttacked then
							startGangAreaAttack ( player, pickup, owner, validID )
						end
					else
						outputChatBox ( "Es kann immer nur ein Angriff zur selben Zeit stattfinden!", player, 125, 0, 0 )
					end
				else
					outputChatBox ( "Es muessen mindestens 3 Mitglieder der verteidigenden Gang online sein!", player, 125, 0, 0 )
				end
			else
				outputChatBox ( "Du kannst nicht dein eigenes Gebiet angreifen!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Du bist bei keinem Ganggebiet!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Du bist nicht befugt!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "attack", attack_func )

function startGangAreaAttack ( player, pickup, owner, id )
	local time = getRealTime()
	local area = _G["gangArea"..id]
	MySQL_SetString("gangs", "LastAttacked", time.timestamp+86400, "Nummer LIKE '" ..id.."'")
	gangAreaUnderAttack = true
	setRadarAreaFlashing ( area, true )
	setRadarAreaColor ( area, 125, 0, 0, 200 )
	vioSetElementData ( pickup, "isUnderAttack", true )
	vioSetElementData ( pickup, "lastAttacked", time.timestamp+86400 )
	eroberungsTimer = setTimer ( areaEroberungsCheck, 30*sec, -1, area, vioGetElementData ( player, "fraktion" ), owner, pickup )
	victoryTimer = setTimer ( areaFinishCheck, 15*60*sec, -1, area, vioGetElementData ( player, "fraktion" ), owner, pickup, id )
	
	-----------
	
	local theattack = gangName[tonumber(vioGetElementData( player, "fraktion" ))]
	
	---------
	
	sendMSGForFaction ( "Eines eurer Gebiete wird angegriffen! Verteidigt es, oder ihr werdet es verlieren!", owner, 125, 0, 0 )
	sendMSGForFaction ( "Angreifer sind "..theattack.."!", owner, 125, 0, 0 )
	outputChatBox ( "Du hast einen Angriff gestartet! Halte das Gebiet 15 Minuten lang, um es zu erobern!", player, 125, 0, 0 )
end

function areaEroberungsCheck ( area, attackers, owner, pickup )

	suc = false
	gangAreaAttackers = attackers
	gangAreaDefenders = owner
	for id, playeritem in ipairs ( getElementsByType( "player" ) ) do
		if tonumber ( vioGetElementData ( playeritem, "fraktion" ) ) == tonumber ( attackers ) then
			local x1, y1, z1 = getElementPosition ( pickup )
			local x2, y2, z2 = getElementPosition ( playeritem )
			if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 50 and not isPedDead ( playeritem ) and z <= 100 then
				suc = true
				break
			end
		end
	end
	if not suc then
		setRadarAreaFlashing ( area, false )
		local r = gangColor[owner][1]
		local g = gangColor[owner][2]
		local b = gangColor[owner][3]
		setRadarAreaColor ( area, r, g, b, 200 )
		sendMSGForFaction ( "Angriff abgebrochen!", attackers, 125, 0, 0 )
		sendMSGForFaction ( "Gebiet erfolgreich verteidigt!", owner, 0, 125, 0 )
		vioSetElementData ( pickup, "isUnderAttack", false )
		gangAreaUnderAttack = false
		gangAreaDefenders = false
		gangAreaAttackers = false
		killTimer ( eroberungsTimer )
		killTimer ( victoryTimer )
	end
end

function areaFinishCheck ( area, attackers, owner, pickup, id )

	setRadarAreaFlashing ( area, false )
	sendMSGForFaction ( "Angriff erfolgreich!", attackers, 0, 125, 0 )
	sendMSGForFaction ( "Gebiet verloren!", owner, 125, 0, 0 )
	vioSetElementData ( pickup, "isUnderAttack", false )
	gangAreaUnderAttack = false
	gangAreaAttackers = false
	gangAreaDefenders = false
	vioSetElementData ( pickup, "gang", attackers )
	MySQL_SetString("gangs", "BesitzerFraktion", attackers, "Nummer LIKE '"..id.."'")
	
	local r = gangColor[attackers][1]
	local g = gangColor[attackers][2]
	local b = gangColor[attackers][3]
	setRadarAreaColor ( area, r, g, b, 200 )
	
	for id, playeritem in ipairs ( getElementsByType( "player" ) ) do
		if tonumber ( vioGetElementData ( playeritem, "fraktion" ) ) == tonumber ( attackers ) then
			givePlayerSaveMoney ( playeritem, gangAreaConquerEach )
			triggerClientEvent ( playeritem, "achievsound", getRootElement() )
		end
	end
	
	killTimer ( eroberungsTimer )
	killTimer ( victoryTimer )
end

function isReallyInsideRadarArea ( theArea, x, y )
    local posX, posY = getElementPosition ( theArea )
    local sizeX, sizeY = getRadarAreaSize ( theArea )
    if getDistanceBetweenPoints2D ( x, y, posX, posY ) <= 100 then
		return true
	else
		return false
	end
end
isInsideRadarArea = nil