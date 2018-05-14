function banVioPlayer ( player, reason )

	if client then
		if player == client then
			if reason ~= "Event-Faking" and reason ~= "EventFaking" and reason ~= "Event Faking" then
				local pname = getPlayerName(player)
				outputChatBox ( pname.." wurde vom Anticheatsystem gebannt.", getRootElement(), 255, 0, 0 )
				local ip = getPlayerIP ( player )
				local serial = getPlayerSerial ( player )
				dbExec ( handler, "INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES (?, 'Anticheat', ?, '"..timestamp().."', ?, ?)", pname, reason, ip, serial)
				kickPlayer ( player, "Vom Anticheat gebannt!" )
			end
		end
	end
end

function banVioShieldPlayer ( player, reason )

	local pname = getPlayerName ( player )
	outputChatBox ( "Spieler "..pname.." wurde vom Anticheatsystem gebannt! ( Grund: "..reason.." )", getRootElement(), 255, 0, 0 )
	
	local ip = getPlayerIP ( player )
	local serial = getPlayerSerial ( player )
	
	dbExec ( handler, "INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES (?, 'Vio Shield', ?, '"..timestamp().."', ?, ?)", pname, reason, ip, serial )
	kickPlayer ( player, "Von: Anticheat, Grund: "..reason.." (Gebannt!)" )
end

function banVioPlayerServer ( player, reason )
	
	if reason ~= "Event Faking" then
		local pname = getPlayerName(player)
		outputChatBox ( pname.." wurde vom Anticheatsystem gebannt.", getRootElement(), 255, 0, 0 )
		local ip = getPlayerIP ( player )
		local serial = getPlayerSerial ( player )
		dbExec ( handler, "INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES (?, 'Anticheat', ?, '"..timestamp().."', ?, ?)", pname, reason, ip, serial )
		kickPlayer ( player, "Vom Anticheat gebannt!" )
	end
end


function timebanPlayer ( pname, time, admin, reason )

	local player = getPlayerFromName ( pname )

	local result = dbPoll( dbQuery ( handler, "SELECT Serial from players WHERE Name LIKE ?", pname ) )
	
	if result and result[1] then
	
		local sec = getTBanSecTime ( time )
		local serial = result[1]["Serial"]
		dbExec ( handler, "INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial, STime) VALUES (?, ?, ?, '"..timestamp().."', '0.0.0.0', ?, ?)", pname, admin, reason, serial, sec )
		outputChatBox ("Spieler "..pname.." wurde von "..admin.." fuer "..time.." Stunden gebannt! (Grund: "..tostring(reason)..")",getRootElement(),255,0,0)
		
		if isElement(player) then

			kickPlayer ( player, "Du wurdest fuer "..time.." Stunden von "..admin.." gebannt! ( "..reason..")" )
		
		end
		return true
		
	end	
	
	return false
	
end

function getTBanSecTime ( duration )

	return getSecTime ( duration )
end