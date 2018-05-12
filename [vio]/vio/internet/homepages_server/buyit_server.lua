usedAuktionIDs = {}
local validAuktionTypes = {
["Drug"]=true, 
["Mats"]=true, 
["Veh"]=true, 
["Houses"]=true, 
["Prestige"]=true, 
["Garages"]=true, 
["Special"]=true }

function loadOffers ()

	curDrugOffers = 0
	curMatsOffers = 0
	curVehOffers = 0
	curHousesOffers = 0
	curPrestigeOffers = 0
	curGaragesOffers = 0
	curSpecialOffers = 0
	
	DrugOffers = {}
	MatsOffers = {}
	VehOffers = {}
	HousesOffers = {}
	PrestigeOffers = {}
	GaragesOffers = {}
	SpecialOffers = {}
	
	result = mysql_query ( handler, "SELECT * FROM buyit" )
	
	offers = mysql_fetch_assoc ( result )
	while offers do
		local ID = tonumber ( offers["ID"] )
		usedAuktionIDs[ID] = true
		local Typ = offers["Typ"]
		_G["cur"..Typ.."Offers"] = _G["cur"..Typ.."Offers"] + 1
		local Anbieter = offers["Anbieter"]
		local Hoechstbietender = offers["Hoechstbietender"]
		local Hoechstgebot = offers["Hoechstgebot"]
		local LaeuftBis = offers["LaeuftBis"]
		local Beschreibung = offers["Beschreibung"]
		local OptischesDatum = offers["OptischesDatum"]
		local Anzahl = offers["Anzahl"]
		
		_G[Typ.."Offers"][ID] = ID
		_G[Typ.."Offers"][ID] = {}
			_G[Typ.."Offers"][ID]["Typ"] = Typ
			_G[Typ.."Offers"][ID]["Anbieter"] = Anbieter
			_G[Typ.."Offers"][ID]["Hoechstbietender"] = Hoechstbietender
			_G[Typ.."Offers"][ID]["Hoechstgebot"] = Hoechstgebot
			_G[Typ.."Offers"][ID]["LaeuftBis"] = LaeuftBis
			_G[Typ.."Offers"][ID]["Beschreibung"] = Beschreibung
			_G[Typ.."Offers"][ID]["OptischesDatum"] = OptischesDatum
			_G[Typ.."Offers"][ID]["Anzahl"] = Anzahl
		
		offers = mysql_fetch_assoc(result)
	end
	mysql_free_result(result)
	globalBuyItCheck ()
end
setTimer ( loadOffers, 500, 1 )

function globalBuyItCheck ()

	local time = getRealTime()
	local minute = time.minute
	local hour = time.hour
	local yearday = time.yearday
	local year = time.year + 1900
	
	curtime = formatDateToInteger ( minute, hour, yearday, year )
	
	for typ, indexOut in pairs ( validAuktionTypes ) do
		for key, index in pairs ( _G[typ.."Offers"] ) do
			local diff = _G[typ.."Offers"][key]["LaeuftBis"] - curtime
			if diff <= 0 then
				endAuktion ( key, typ )
			elseif diff <= 20 then
				setTimer ( endAuktion, diff*60000, 1, key, typ )
			end
		end
	end
	setTimer ( globalBuyItCheck, 1200000, 1 )
end

function endAuktion ( id, typ )

	anbieter = _G[typ.."Offers"][id]["Anbieter"]
	hoechstbietender = _G[typ.."Offers"][id]["Hoechstbietender"]
	hoechstgebot = _G[typ.."Offers"][id]["Hoechstgebot"]
	anzahl = _G[typ.."Offers"][id]["Anzahl"]
	
	outputServerLog ( "BuyIt-Log: Ende der Auktion: ID: "..id..", Von "..anbieter..", An: "..hoechstbietender..", Anzahl: "..anzahl..", Gebot: "..hoechstgebot )
	
	if not hoechstbietender == "" and not hoechstbietender == "-" then
		buyItMoneyChange ( anbieter, hoechstgebot )
		sendBuyItMessage ( anbieter, "Dein Angebot bei BuyIt.com wurde erfolgreich versteigert! Du erhaelst "..hoechstgebot.." $!" )
		sendBuyItMessage ( hoechstbietender, "Du hast bei BuyIt.com ein Objekt ersteigert!" )
		buyItGiveItem ( typ, hoechstbietender, anzahl, id, anbieter )
	else
		sendBuyItMessage ( anbieter, "Dein Angebot bei BuyIt.com wurde leider nicht ersteigert." )
		buyItGiveItem ( typ, anbieter, anzahl, id, anbieter )
	end
	
	_G["cur"..typ.."Offers"] = _G["cur"..typ.."Offers"] - 1
	
	--[[
	curDrugOffers = 0
	curMatsOffers = 0
	curVehOffers = 0
	curHousesOffers = 0
	curPrestigeOffers = 0
	curGaragesOffers = 0
	curSpecialOffers = 0	
	]]
	
	MySQL_DelRow ( "buyit", "ID LIKE '"..id.."'" )
	
	_G[typ.."Offers"][id] = nil
	usedAuktionIDs[id] = nil
end

function buyItGiveItem ( typ, pname, anzahl, id, offerer )

	outputDebugString ( tostring (typ).."|"..tostring(pname).."|"..tostring(anzahl).."|"..tostring(id) )
	local ingame = getPlayerFromName ( pname )
	if typ == "Drug" then
		if isElement ( ingame ) and vioGetElementData ( ingame, "loggedin" ) and vioGetElementData ( ingame, "loggedin" ) == 1 then
			vioSetElementData ( ingame, "drugs", vioGetElementData ( ingame, "drugs" ) + anzahl )
		else
			local drugs = MySQL_GetString ( "userdata", "Drogen", "Name LIKE '" ..pname.."'" )
			MySQL_SetString ( "userdata", "Drogen", drugs + anzahl, "Name LIKE '" ..pname.."'" )
		end
	elseif typ == "Mats" then
		if isElement ( ingame ) and vioGetElementData ( ingame, "loggedin" ) and vioGetElementData ( ingame, "loggedin" ) == 1 then
			vioSetElementData ( ingame, "mats", vioGetElementData ( ingame, "mats" ) + anzahl )
		else
			local mats = MySQL_GetString ( "userdata", "Drogen", "Name LIKE '" ..pname.."'" )
			MySQL_SetString ( "userdata", "Drogen", mats + anzahl, "Name LIKE '" ..pname.."'" )
		end
	elseif typ == "Veh" then
		MySQL_SetString("vehicles", "Besitzer", pname, "AuktionsID LIKE '"..id.."'")
	elseif typ == "Prestige" then
		MySQL_SetString ( "prestige", "Besitzer", pname, "Besitzer LIKE '" ..offerer.."'" )
	elseif typ == "Houses" then
		MySQL_SetString ( "houses", "Besitzer", pname, "Besitzer LIKE '" ..offerer.."'" )
		local key = MySQL_GetString ( "houses", "ID", "Besitzer LIKE '" ..pname.."'" )
		if isElement ( getPlayerFromName ( pname ) ) then
			vioSetElementData ( getPlayerFromName ( pname ), "housekey", key )
		end
		if isElement ( getPlayerFromName ( offerer ) ) then
			vioSetElementData ( getPlayerFromName ( offerer ), "housekey", 0 )
		end
	elseif typ == "Special" then
		sendBuyItMessage ( pname, "Du hast etwas besonderes ersteigert - ein Administrator wird sich in kuerze bei dir melden!" )
		sendBuyItMessage ( "[Vio]Zipper", pname.." hat eine Sonderauktion gewonnen." )
	end
end

function getDataForObjectList_func ( typ )

	local player = client
	local i = 0
	local dataString = ""
	
	local time = getRealTime()
	local year = time.year + 1900
	
	for key, index in pairs ( _G[typ.."Offers"] ) do
		i = i + 1
		local date = calcTimeToRunOptical ( _G[typ.."Offers"][key]["LaeuftBis"], 0, 0, year )
		dataString = dataString..key.."|".._G[typ.."Offers"][key]["Anbieter"].."|".._G[typ.."Offers"][key]["Hoechstgebot"].."|"..date.."|".._G[typ.."Offers"][key]["Anzahl"].."|".._G[typ.."Offers"][key]["Hoechstbietender"].."|~"
	end
	triggerClientEvent ( player, "recieveDataForObjectList", getRootElement(), i, dataString )
end
addEvent ( "getDataForObjectList", true )
addEventHandler ( "getDataForObjectList", getRootElement(), getDataForObjectList_func )

function getDescriptionForObject_func ( typ, id )

	triggerClientEvent ( client, "recieveDescriptionForObject", getRootElement(), _G[typ.."Offers"][id]["Beschreibung"], id )
end
addEvent ( "getDescriptionForObject", true )
addEventHandler ( "getDescriptionForObject", getRootElement(), getDescriptionForObject_func )

function makeOffer_func ( typ, startGebot, description, timeToRun, count )

	startGebot = math.floor ( math.abs ( startGebot ) )
	count = math.floor ( math.abs ( count ) )
	typ = MySQL_Save ( typ )
	description = MySQL_Save ( description )
	local player = client
	local pname = getPlayerName ( player )
	if typ and description and startGebot and tonumber ( timeToRun ) and ( tonumber ( count ) or count == nil ) then
		local validValues = true
		local auktionID = getFreeAuktionID ()
		ID = auktionID
		if typ == "Veh" then
			--[[local veh = _G["privVeh"..pname..count]
			if isElement ( veh ) then
				MySQL_SetString("vehicles", "AuktionsID", ID, "Besitzer LIKE '"..pname.."' AND Slot LIKE '"..tonumber(count).."'")
				destroyElement ( _G["privVeh"..pname..count] )
				outputChatBox ( "Du hast dein Fahrzeug in Slot Nr. "..count.." zur Auktion gestellt!", player, 0, 125, 0 )
				count = getElementModel ( _G["privVeh"..pname..count] )
			else
				validValues = false
				outputChatBox ( "Du hast kein Fahrzeug in diesem Slot / Du musst dein Fahrzeug zuerst respawnen!", player, 125, 0, 0 )
			end]]
			outputChatBox ( "Vorruebergehend deaktiviert.", player, 125, 0, 0 )
			return true
		elseif typ == "Mats" then
			local mats = vioGetElementData ( player, "mats" )
			if mats >= count then
				vioSetElementData ( player, "mats", mats - count )
				outputChatBox ( "Gebot eingestellt!", player, 0, 125, 0 )
			else
				validValues = false
				outputChatBox ( "Du hast nicht genug Materialien dafuer!", player, 125, 0, 0 )
			end
		elseif typ == "Drug" then
			local drugs = vioGetElementData ( player, "drugs" )
			if drugs >= count then
				vioSetElementData ( player, "drugs", drugs - count )
				outputChatBox ( "Gebot eingestellt!", player, 0, 125, 0 )
			else
				validValues = false
				outputChatBox ( "Du hast nicht genug Drogen dafuer!", player, 125, 0, 0 )
			end
		elseif typ == "Houses" then
			if vioGetElementData ( lp, "housekey" ) > 0 then
				outputChatBox ( "Du hast dein Haus erfolgreich zum Verkauf angeboten!", player, 0, 125, 0 )
			else
				validValues = false
				outputChatBox ( "Du besitzt kein Haus!", player, 125, 0, 0 )
			end
		elseif typ == "Prestige" then
			if MySQL_DatasetExist ( "prestige", "Besitzer LIKE '"..MySQL_Save( getPlayerName ( player ) ).."'" ) then
				outputChatBox ( "Du hast dein Prestige-Objekt erfolgreich zum Verkauf angeboten!", player, 0, 125, 0 )
			else
				validValues = false
				outputChatBox ( "Du besitzt kein Prestige-Objekt!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Nicht verfuegbar.", player, 125, 0, 0 )
			count = 0
		end
		if validValues then
			_G["cur"..typ.."Offers"] = _G["cur"..typ.."Offers"] + 1
			_G[typ.."Offers"][ID] = ID
			_G[typ.."Offers"][ID] = {}
				_G[typ.."Offers"][ID]["typ"] = typ
				_G[typ.."Offers"][ID]["Anbieter"] = pname
				_G[typ.."Offers"][ID]["Hoechstbietender"] = "-"
				_G[typ.."Offers"][ID]["Hoechstgebot"] = startGebot
				
				_G[typ.."Offers"][ID]["Beschreibung"] = description
			_G[typ.."Offers"][ID]["Anzahl"] = count
			
			outputServerLog ( "BuyIt-Log: Offer: ID: "..ID..", Von "..pname..", Anzahl: "..count..", Startgebot: "..startGebot )
			
			local time = getRealTime()
			local minute = time.minute
			local hour = time.hour
			local yearday = time.yearday
			local year = time.year + 1900
			
			timeToRunOptical = calcTimeToRunOptical ( minute + timeToRun, hour, yearday, year )
			timeToRun = formatDateToInteger ( minute + timeToRun, hour, yearday, year )
			local result = mysql_query(handler, "INSERT INTO buyit (ID, typ, Anbieter, Hoechstbietender, Hoechstgebot, LaeuftBis, Beschreibung, OptischesDatum, Anzahl) VALUES ('"..auktionID.."', '"..typ.."', '"..pname.."', '-', '"..startGebot.."', '"..timeToRun.."', '"..description.."', '"..timeToRunOptical.."', '"..count.."')")
			if( not result) then
				outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
			else
				mysql_free_result(result)
			end
			_G[typ.."Offers"][ID]["LaeuftBis"] = timeToRun
			_G[typ.."Offers"][ID]["OptischesDatum"] = timeToRunOptical
		end
	end
end
addEvent ( "makeOffer", true )
addEventHandler ( "makeOffer", getRootElement(), makeOffer_func )

function betForObject_func ( typ, id, gebot )

	local player = client
	local gebot = math.abs ( math.floor ( gebot ) )
	local typ = MySQL_Save ( typ )
	local id = tonumber ( MySQL_Save ( id ) )
	if _G[typ.."Offers"][id]["LaeuftBis"] then
		local curGebot = tonumber ( _G[typ.."Offers"][id]["Hoechstgebot"] )
		local hoechstbietender = _G[typ.."Offers"][id]["Hoechstbietender"]
		local pname = getPlayerName ( player )
		if curGebot < gebot then
			if not MySQL_DatasetExist("buyit", "Hoechstbietender LIKE '"..pname.."' AND Typ LIKE '"..typ.."'") then
				if vioGetElementData ( player, "bankmoney" ) >= gebot then
					local betOK = true
					if typ == "Veh" then
						local carslot = buyItGetFreeCarslot ( pname )
						if carslot then
							vioSetElementData ( player, "carslot"..carslot, 3 )
						else
							betOK = false
							reason = "Du hast keinen freien Fahrzeugslot!"
						end
					elseif typ == "House" then
						if vioGetElementData ( player, "housekey" ) > 0 then
							betOK = false
							reason = "Du hast bereits ein Haus!"
						end
					elseif typ == "Prestige" then
						if MySQL_DatasetExist("prestige", "Besitzer LIKE '"..pname.."'") then
							betOK = false
							reason = "Du hast bereits ein Prestige-Objekt!"
						end
					end
					if betOK then
						-- Ehemaliger Hoechstbietender --
						outputServerLog ( "BuyIt-Log: Bet: Von "..pname..", Typ: "..typ..", Gebot: "..gebot..", ID: "..id )
						local target = getPlayerFromName ( hoechstbietender )
						if target then
							if typ == "Veh" then
								for i = 1, 10 do
									if vioGetElementData ( target, "carslot"..i ) == 3 then
										vioSetElementData ( target, "carslot"..i, 0 )
										break
									end
								end
							end
							outputChatBox ( "Du wurdest soeben von "..pname.." ueberboten!", target, 125, 0, 0 )
							vioSetElementData ( target, "bankmoney", vioGetElementData ( target, "bankmoney" ) + curGebot )
						elseif hoechstbietender ~= "-" then
							local money = MySQL_GetString("userdata", "Bankgeld", "Name LIKE '"..hoechstbietender.."'")
							MySQL_SetString("userdata", "Bankgeld", money + curGebot, "Name LIKE '"..hoechstbietender.."'")
							buyItSendMail ( hoechstbietender.."@FORUMADRESSE", "Du wurdest bei einer Auktion von "..pname.." ueberboten!" )
						end
						-- Aktueller Hoechstbietender --
						vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) - gebot )
						outputChatBox ( "Du hast dein Gebot erfolgreich abgegeben und bist nun Hoechstbietender!", player, 0, 125, 0 )
						outputChatBox ( "Wir werden dich ueber den weiteren Verlauf der Auktion informieren!", player, 0, 125, 0 )
						-- Auktionsdatei (InGame) --
						_G[typ.."Offers"][id]["Hoechstbietender"] = pname
						_G[typ.."Offers"][id]["Hoechstgebot"] = gebot
						-- Auktionsdatei (MySQL) --
						MySQL_SetString("buyit", "Hoechstbietender", pname, "ID LIKE '"..id.."'")
						MySQL_SetString("buyit", "Hoechstgebot", gebot, "ID LIKE '"..id.."'")
					else
						outputChatBox ( reason, player, 125, 0, 0 )
					end
				end
			else
				outputChatBox ( "Du kannst nur auf einen Artikel der selben Kathegorie zur gleichen Zeit bieten.", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Dein aktuelles Gebot ist zu niedrig! Bitte aktualisiere deine Seite!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Die Auktion ist beendet. Bitte aktualisiere deine Seite!", player, 125, 0, 0 )
	end
end
addEvent ( "betForObject", true )
addEventHandler ( "betForObject", getRootElement(), betForObject_func )

function getMarketValues_func ()

	if source == client then
		triggerClientEvent ( source, "refreshMarketValues", source, curDrugOffers, curMatsOffers, curVehOffers, curHousesOffers, curPrestigeOffers, curGaragesOffers, curSpecialOffers )
	end
end
addEvent ( "getMarketValues", true )
addEventHandler ( "getMarketValues", getRootElement(), getMarketValues_func )