function loadAddictionsForPlayer ( player )

	local pname = getPlayerName ( player )
	
	local dataString1 = MySQL_GetString ( "userdata", "Rausch", "Name LIKE '"..pname.."'" )
	local dataString2 = MySQL_GetString ( "userdata", "Sucht", "Name LIKE '"..pname.."'" )
	
	local cigarettFlushPoints = tonumber ( gettok ( dataString1, 1, string.byte ( '|' ) ) )
	local alcoholFlushPoints = tonumber ( gettok ( dataString1, 2, string.byte ( '|' ) ) )
	local drugFlushPoints = tonumber ( gettok ( dataString1, 3, string.byte ( '|' ) ) )
	
	local cigarettAddictPoints = tonumber ( gettok ( dataString2, 1, string.byte ( '|' ) ) )
	local alcoholAddictPoints = tonumber ( gettok ( dataString2, 2, string.byte ( '|' ) ) )
	local drugAddictPoints = tonumber ( gettok ( dataString2, 3, string.byte ( '|' ) ) )
	
	vioSetElementData ( player, "cigarettFlushPoints", cigarettFlushPoints )
	vioSetElementData ( player, "alcoholFlushPoints", alcoholFlushPoints )
	vioSetElementData ( player, "drugFlushPoints", drugFlushPoints )

	vioSetElementData ( player, "cigarettAddictPoints", cigarettAddictPoints )
	vioSetElementData ( player, "alcoholAddictPoints", alcoholAddictPoints )
	vioSetElementData ( player, "drugAddictPoints", drugAddictPoints )
end

function saveAddictionsForPlayer ( player )

	local pname = getPlayerName ( player )
	
	local dataString1 = vioGetElementData ( player, "cigarettFlushPoints" ).."|"..vioGetElementData ( player, "alcoholFlushPoints" ).."|"..vioGetElementData ( player, "drugFlushPoints" ).."|"
	local dataString2 = vioGetElementData ( player, "cigarettAddictPoints" ).."|"..vioGetElementData ( player, "alcoholAddictPoints" ).."|"..vioGetElementData ( player, "drugAddictPoints" ).."|"
	
	MySQL_SetString ( "userdata", "Rausch", dataString1, "Name LIKE '"..pname.."'" )
	MySQL_SetString ( "userdata", "Sucht", dataString2, "Name LIKE '"..pname.."'" )
end