createBlip ( -2111, -444.266, 37.661, 33, 2, 255, 0, 0, 255, 0, 200 )

hotringcount = 1

HotringRacer1 = "-1001.029296875|596.88629150391|1195.75512695313"
HotringRacer2 = "-986.48138427734|588.41064453125|1195.75512695313"
HotringRacer3 = "-1001.276550293|580.8125|1195.75512695313"
HotringRacer4 = "-986.40545654297|572.40386962891|1195.75512695313"
HotringRacer5 = "-1001.5704345703|564.15411376953|1195.75512695313"
HotringRacer6 = "-986.712890625|555.291015625|1195.75512695313"
HotringRacer7 = "-1001.6979980469|547.89617919922|1195.75512695313"
HotringRacer8 = "-986.75274658203|538.53460693359|1195.75512695313"
HotringRacer9 = "-1001.3354492188|531.17028808594|1195.75512695313"
HotringRacer10 = "-986.81774902344|521.90045166016|1195.75512695313"
HotringRacer11 = "-1000.8764038086|512.39947509766|1195.75512695313"
HotringRacer12 = "-986.73956298828|504.44668579102|1195.75512695313"

stadionRaceEntrance = createMarker ( -2111, -444.266, 38.5, "corona", 1.2, 0, 125, 0, 225 )


local function highscore_func_DB ( qh, player )
	local result = dbPoll( qh, 0 )
	if result then
		p1name = result[1] and result[1]["Name"] or nil
		p1ms = result[1] and result[1]["MilliSekunden"] or nil
		p1s = result[1] and result[1]["Sekunden"] or nil
		p1m = result[1] and result[1]["Minuten"] or nil
		p2name = result[2] and result[2]["Name"] or nil
		p2ms = result[2] and result[2]["MilliSekunden"] or nil
		p2s = result[2] and result[2]["Sekunden"] or nil
		p2m = result[2] and result[2]["Minuten"] or nil
		p3name = result[3] and result[3]["Name"] or nil
		p3ms = result[3] and result[3]["MilliSekunden"] or nil
		p3s = result[3] and result[3]["Sekunden"] or nil
		p3m = result[3] and result[3]["Minuten"] or nil
		if p1name then
			outputChatBox ( "Platz 1: "..p1name.." mit "..p1m..":"..p1s..":"..p1ms, player, 200, 200, 0 )
		end
		if p2name then
			outputChatBox ( "Platz 2: "..p2name.." mit "..p2m..":"..p2s..":"..p2ms, player, 200, 200, 0 )
		end
		if p3name then
			outputChatBox ( "Platz 3: "..p3name.." mit "..p3m..":"..p3s..":"..p3ms, player, 200, 200, 0 )
		end
	end
end

function highscore_func ( player )
	outputChatBox ( "___Highscore (Canyon)___", player, 200, 200, 0 )
	dbQuery( highscore_func_DB, { player }, handler, "SELECT Name, MilliSekunden, Sekunden, Minuten FROM racing WHERE Platz BETWEEN 1 AND 3 ORDER BY Platz")
end
addCommandHandler ( "highscore", highscore_func )

function stadionRaceEntrance_func ( player )

	triggerClientEvent ( player, "showRaceGui", getRootElement() )
	showCursor ( player, true )
	vioSetElementData ( player, "ElementClicked", true )
end
addEventHandler ( "onMarkerHit", stadionRaceEntrance, stadionRaceEntrance_func )

function startFirstRace_func ( player )

	if player == client then
		if getPedOccupiedVehicle ( player ) == false then
			suc = false
			setElementDimension ( player, 1 )
			vioSetElementData ( player, "isInRace", true )
			vioSetElementData ( player,"nodmzone", 1 )
			
			local sx = tonumber( gettok ( _G["HotringRacer"..hotringcount], 1, string.byte('|') ) )
			local sy = tonumber( gettok ( _G["HotringRacer"..hotringcount], 2, string.byte('|') ) )
			hotringcount = hotringcount + 1
			if hotringcount >= 13 then
				hotringcount = 1
			end
			local sz = 1195.75512695313
			local veh = createVehicle ( 502, sx, sy, sz, 0, 0, 0, "Hotring" )
			vioSetElementData ( veh, "slot", i )
			setElementHealth ( veh, 1000000 )
			triggerClientEvent ( player, "startRaceRoundTime", player, sx, sy, sz )
			setElementDimension ( veh, 1 )
			setElementDimension ( player, 1 )
			warpPedIntoVehicle ( player, veh )
			setElementFrozen ( veh, true )
			setTimer ( defreezeRace, 4000, 1, veh )
			outputChatBox ( "Verlasse das Fahrzeug, um das Rennen zu beenden!", player, 200, 200, 0 )
			suc = true
		end
	end
end
addEvent ( "startFirstRace", true )
addEventHandler ( "startFirstRace", getRootElement(), startFirstRace_func )

function defreezeRace ( veh )

	setElementFrozen ( veh, false )
end

function stopArenaSettings ( player )

	toggleControl ( player, "fire", true )
	toggleControl ( player, "enter_exit", true )
	vioSetElementData( player, "nodmzone", 0 )
	vioSetElementData ( player, "isInRace", false )
end

function funexit_func ( player, veh )

	if vioGetElementData ( player, "isInRace" ) == true then
		if veh then
			destroyElement ( veh )
		end
		removePedFromVehicle ( player )
		setElementPosition ( player, -2130, -444.266, 36 )
		setElementDimension ( player, 0 )
		stopArenaSettings ( player )
		triggerClientEvent ( player, "killRaceClient", getRootElement() )
		vioSetElementData ( player, "isInRace", false )
	end
end

function leaveHotringRacer ( player )

	if getElementModel(source) == 502 then
		funexit_func ( player, source )
	end
end
addEventHandler ( "onVehicleExit", getRootElement(), leaveHotringRacer )


local function raceFinished_func_DB ( qh, player, ms, s, m, pct, pname )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		p1name = result[1] and result[1]["Name"] or nil
		p1ms = result[1] and tonumber( result[1]["MilliSekunden"] ) or nil
		p1s = result[1] and tonumber( result[1]["Sekunden"] ) or nil
		p1m = result[1] and tonumber( result[1]["Minuten"] ) or nil
		p2name = result[2] and result[2]["Name"] or nil
		p2ms = result[2] and tonumber( result[2]["MilliSekunden"] ) or nil
		p2s = result[2] and tonumber( result[2]["Sekunden"] ) or nil
		p2m = result[2] and tonumber( result[2]["Minuten"] ) or nil
		p3name = result[3] and result[3]["Name"] or nil
		p3ms = result[3] and tonumber( result[3]["MilliSekunden"] ) or nil
		p3s = result[3] and tonumber( result[3]["Sekunden"] ) or nil
		p3m = result[3] and tonumber( result[3]["Minuten"] ) or nil
		if p1s then
			p1t = p1ms+p1s*10+p1m*1000
		end
		if p2s then
			p2t = p2ms+p2s*10+p2m*1000
		end
		if p3s then
			p3t = p3ms+p3s*10+p3m*1000
		end
		if not p1name then
			dbExec( handler, "INSERT INTO racing (Name, MilliSekunden, Sekunden, Minuten, Platz) VALUES (?, ?, ?, ?, '1')", pname, ms, s, m )
		else
			if pct < p1t then
				if p2t then
					p3name = p2name
					p3ms = p2ms
					p3s = p2s
					p3m = p2m
				end
				p2ms = p1ms
				p2s = p1s
				p2m = p1m
				p2name = p1name
				p1ms = ms
				p1s = s
				p1m = m
				p1name = pname
			elseif not p2name then
				dbExec( handler, "INSERT INTO racing (Name, MilliSekunden, Sekunden, Minuten, Platz) VALUES (?, ?, ?, ?, '2')", pname, ms, s, m )
			else
				if pct < p2t then
					p3ms = p2ms
					p3s = p2s
					p3m = p2m
					p3name = p2name
					p2ms = ms
					p2s = s
					p2m = m
					p2name = pname
				elseif not p3name then
					dbExec( handler, "INSERT INTO racing (Name, MilliSekunden, Sekunden, Minuten, Platz) VALUES (?, ?, ?, ?, '3')", pname, ms, s, m )
				elseif pct < p3t then
					p3ms = ms
					p3s = s
					p3m = m
					p3name = pname
				end
			end
		end
		if p1name then
			dbExec( handler, "UPDATE racing SET Name = ?, MilliSekunden = ?, Sekunden = ?, Minuten = ? WHERE Platz = 1", p1name, p1ms, p1s, p1m )
		end
		if p2name then
			dbExec( handler, "UPDATE racing SET Name = ?, MilliSekunden = ?, Sekunden = ?, Minuten = ? WHERE Platz = 2", p2name, p2ms, p2s, p2m )
		end
		if p3name then
			dbExec( handler, "UPDATE racing SET Name = ?, MilliSekunden = ?, Sekunden = ?, Minuten = ? WHERE Platz = 3", p3name, p3ms, p3s, p3m )
		end
		outputChatBox ( "___Highscore___", player, 200, 200, 0 )
		dbQuery( highscore_func_DB, { player }, handler, "SELECT Name, MilliSekunden, Sekunden, Minuten FROM racing WHERE Platz BETWEEN 1 AND 3 ORDER BY Platz" )
	end
end

function raceFinished_func ( player, ms, s, m )

	if player == client then
		ms, s, m = tonumber ( ms ), tonumber ( s ), tonumber ( m )
		if m < 2 or ( m == 2 and s < 10 ) then
			dbExec( handler, "INSERT INTO ban ( Name, Admin, Grund, Datum, IP, Serial ) VALUES ( ?, 'Anticheat', 'Speedhack', '"..timestamp().."', ?, ? )", getPlayerName ( player ), getPlayerIP ( player ), getPlayerSerial( player ) )
			kickPlayer ( player, "Von: Anticheat, Grund: Speedhack (Gebannt!)" )
			return false
		end
		pct = ms+s*10+m*1000
		datatime = ms+s*10+m*1000
		pname = getPlayerName ( player )
		outputChatBox ( "Deine Zeit: "..m..":"..s..":"..ms.."!", player, 200, 200, 0 )
		if datatime <= 3000 then
			pricemoney = 50 + math.floor ( ( 3000 - datatime ) * 0.2 )
			outputChatBox ( "Deine Zeit war besser, als der Durchschnitt - Du erhaelst "..pricemoney.." $ Preisgeld!", player, 0, 125, 0 )
			vioSetElementData ( player, "money", tonumber(vioGetElementData ( player, "money" )) + pricemoney )
			givePlayerMoney ( player, pricemoney )
			triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
		end
		dbQuery( raceFinished_func_DB, { player, ms, s, m, pct, pname }, handler, "SELECT Name, MilliSekunden, Sekunden, Minuten FROM racing WHERE Platz BETWEEN 1 AND 3 ORDER BY Platz" )
	end
end
addEvent ( "raceFinished", true )
addEventHandler ( "raceFinished", getRootElement(), raceFinished_func )