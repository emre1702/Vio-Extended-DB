function banVioPlayer ( player, reason )

	reason = MySQL_Save ( reason )
	if client then
		if player == client then
			if reason ~= "Event-Faking" and reason ~= "EventFaking" and reason ~= "Event Faking" then
				local pname = MySQL_Save(getPlayerName(player))
				outputChatBox ( pname.." wurde vom Anticheatsystem gebannt.", getRootElement(), 255, 0, 0 )
				local ip = getPlayerIP ( player )
				local serial = getPlayerSerial ( player )
				mysql_vio_query ( "INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES ('"..pname.."', 'Anticheat', '"..reason.."', '"..timestamp().."', '"..ip.."', '"..serial.."')")
				kickPlayer ( player, "Vom Anticheat gebannt!" )
			end
		end
	end
end

function banVioShieldPlayer ( player, reason )

	local pname = getPlayerName ( player )
	reason = MySQL_Save ( reason )
	outputChatBox ( "Spieler "..pname.." wurde vom Anticheatsystem gebannt! ( Grund: "..reason.." )", getRootElement(), 255, 0, 0 )
	
	local ip = getPlayerIP ( player )
	local serial = getPlayerSerial ( player )
	
	mysql_vio_query ( "INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES ('"..pname.."', 'Vio Shield', '"..reason.."', '"..timestamp().."', '"..ip.."', '"..serial.."')" )
	kickPlayer ( player, "Von: Anticheat, Grund: "..reason.." (Gebannt!)" )
end

function banVioPlayerServer ( player, reason )
	
	if reason ~= "Event Faking" then
		reason = MySQL_Save ( reason )
		local pname = MySQL_Save(getPlayerName(player))
		outputChatBox ( pname.." wurde vom Anticheatsystem gebannt.", getRootElement(), 255, 0, 0 )
		local ip = getPlayerIP ( player )
		local serial = getPlayerSerial ( player )
		mysql_vio_query ( "INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES ('"..pname.."', 'Anticheat', '"..reason.."', '"..timestamp().."', '"..ip.."', '"..serial.."')")
		kickPlayer ( player, "Vom Anticheat gebannt!" )
	end
end

function timebanPlayer ( pname, time, admin, reason )

	local player = getPlayerFromName ( pname )
	pname = MySQL_Save ( pname )

	local exist = MySQL_DatasetExist ( "players", "Name LIKE '"..pname.."'")
	
	if exist then
	
		local sec = getTBanSecTime ( time )
		local serial = MySQL_GetString( "players", "Serial", "Name LIKE '"..pname.."'" )
		mysql_vio_query ( "INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial, STime) VALUES ('"..pname.."', '"..admin.."', '"..reason.."', '"..timestamp().."', '0.0.0.0', '"..serial.."', '"..sec.."' ) " )
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