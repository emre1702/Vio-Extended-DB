function sendBuyItMessage ( pname, text )

	local player = getPlayerFromName ( pname )
	if player then
		outputChatBox ( text, player, 0, 125, 0 )
	else
		offlinemsg ( text, "BuyIt.com", pname )
	end
end

function buyItGetFreeCarslot ( pname )

	local player = getPlayerFromName ( pname )
	local count = 0
	for i = 1, 10 do
		if vioGetElementData ( player, "carslot"..i ) == 0 then
			return i
		elseif count >= vioGetElementData ( player, "maxcars" ) then
			return false
		else
			count = count + 1
		end
	end
end

function buyItMoneyChange ( pname, amount )

	local player = getPlayerFromName ( pname )
	if isElement ( player ) then
		local money = vioGetElementData ( player, "bankmoney" )
		vioSetElementData ( player, "bankmoney", money + amount )
	elseif MySQL_DatasetExist ( "players", "Name LIKE '"..pname.."' " ) then
		local money = MySQL_GetString("userdata", "Bankgeld", "Name LIKE '" ..pname.."'")
		MySQL_SetString("userdata", "Bankgeld", money + amount, "Name LIKE '" ..pname.."'")
	end
end

function getFreeAuktionID ()

	i = 1
	while true do
		if not usedAuktionIDs[i] then
			usedAuktionIDs[i] = true
			return i
		end
		i = i + 1
	end
end

function formatDateToInteger ( minute, hour, yearday, year )

	return minute + hour * 60 + yearday * 1440 + (year-2010) * 525600
end

function calcTimeToRunOptical ( minute, hour, yearday, year )

	local time = getRealTime()
	local ttime1 = formatDateToInteger ( time.minute, time.minute, time.yearday, time.year + 1900 )
	local ttime2 = formatDateToInteger ( minute, hour, yearday, year )
	
	local minute = ttime2 - ttime1
	
	local hour = 0
	
	while minute >= 60 do
		minute = minute - 60
		hour = hour + 1
	end
	
	return hour.." Stunden und "..minute.." Minuten"
end

function buyItSendMail ( to, text )

	local mail = tostring ( "info@BuyIt.com|Auktion|"..timestamp()..": Du wurdest von "..getPlayerName ( player ).." ueberboten!" )

	local time = getRealTime()
	local y = time.year + 1900
	local yd = time.yearday
	
	local result = mysql_query(handler, "INSERT INTO email (Empfaenger, Text, Yearday, Year) VALUES ('"..to.."', '"..mail.."', '"..yd.."', '"..y.."')")
	if( not result) then
		outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		mysql_free_result(result)
	end
end