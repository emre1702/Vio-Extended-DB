lottoJackpotPath = ":vio_stored_files/lotto/jackpot.vio"
local jackpotFile = fileOpen ( lottoJackpotPath, false )
local filesize = fileGetSize ( jackpotFile )
lottoJackpot = tonumber ( fileRead ( jackpotFile, filesize ) )
fileClose ( jackpotFile )

function lotto ( player )

	if vioGetElementData ( player, "loggedin" ) == 1 and string.upper ( getPlayerName ( player ) ) == string.upper ( "[Vio]Zipper" ) then
		drawLottoWinners ()
	end
end
addCommandHandler ( "lotto", lotto )

function drawLottoWinners ()

	local l1, l2, l3
	l1 = math.random ( 1, 12 )
	l2 = l1
	while l2 == l1 do
		l2 = math.random ( 1, 12 )
	end
	l3 = l2
	while l1 == l3 or l2 == l3 do
		l3 = math.random ( 1, 12 )
	end
	
	local array = { [1]=l1, [2]=l2, [3]=l3 }
	
	array = sortArray ( array )
	
	l1 = array[1]
	l2 = array[2]
	l3 = array[3]
	
	outputChatBox ( "Die Lottozahlen:", getRootElement(), 0, 125, 0 )
	
	setTimer ( outputChatBox, 3000, 1, tostring ( l1 ), getRootElement(), 200, 0, 0 )
	setTimer ( outputChatBox, 6000, 1, tostring ( l2 ), getRootElement(), 200, 0, 0 )
	setTimer ( outputChatBox, 9000, 1, tostring ( l3 ), getRootElement(), 200, 0, 0 )
	
	setTimer ( getLottoWinners, 10000, 1, l1, l2, l3 )
	setTimer ( mysql_vio_query, 30000, 1, "DELETE FROM lotto" )
end

function getLottoWinners ( l1, l2, l3 )

	outputChatBox ( "Die Gewinner werden automatisch benachrichtigt.", getRootElement(), 200, 200, 0 )
	local result = mysql_query ( handler, "SELECT id, name FROM lotto WHERE z1 = '"..l1.."' AND z2 = '"..l2.."' AND z3 = '"..l3.."' " )
	if ( mysql_num_rows ( result ) > 0 ) then
		local winnerName, winnerID, lottoWinner
		lottoWinner = mysql_fetch_assoc ( result )
		while lottoWinner do
			winnerName = lottoWinner["name"]
			winnerID = lottoWinner["id"]
			
			outputChatBox ( winnerName.." hat den Jackpot geknackt und gewinnt: "..formNumberToMoneyString ( lottoJackpot ), getRootElement(), 200, 200, 0 )
			
			if isElement ( getPlayerFromName ( winnerName ) ) then
				local player = getPlayerFromName ( winnerName )
				
				outputChatBox ( "Du hast soeben im Lotto "..formNumberToMoneyString ( lottoJackpot ).." gewonnen!", player, 0, 200, 0 )
				outputChatBox ( "Das Geld liegt jetzt auf deinem Konto - viel Spass!", player, 0, 200, 0 )
				
				vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) + lottoJackpot )
			else
				if MySQL_DatasetExist ( "players", "Name LIKE '"..winnerName.."'" ) then
					MySQL_SetString ( "userdata", "Bankgeld", lottoJackpot + MySQL_GetString ( "userdata", "Bankgeld", "Name LIKE '"..winnerName.."'" ), "Name LIKE '"..winnerName.."'" )
				else
					MySQL_SetOldString ( "userdata", "Bankgeld", lottoJackpot + MySQL_GetOldString ( "userdata", "Bankgeld", "Name LIKE '"..winnerName.."'" ), "Name LIKE '"..winnerName.."'" )
				end
				
				offlinemsg ( "Du hast im Lotto "..formNumberToMoneyString ( lottoJackpot ).." gewonnen! Das Geld ist auf deinem Konto.", "LTR Lotto", winnerName )
			end
			
			mysql_vio_query ( "DELETE FROM lotto WHERE id LIKE '"..winnerID.."'" )
			lottoWinner = mysql_fetch_assoc ( result )
		end
		
		lottoJackpot = 50000
		
		local file = fileCreate ( lottoJackpotPath )
		fileWrite ( file, "50000" )
		fileClose ( file )
	else
		lottoJackpot = lottoJackpot * 2
		if lottoJackpot > 1600000 then
			lottoJackpot = 2000000
		end
		outputChatBox ( "Der Jackpot wurde nicht geknackt - damit steigt er auf "..formNumberToMoneyString ( lottoJackpot ).."!", getRootElement(), 125, 0, 0 )
		
		local file = fileCreate ( lottoJackpotPath )
		fileWrite ( file, tostring ( lottoJackpot ) )
		fileClose ( file )
	end
	if result then
		mysql_free_result ( result )
	end
	
	-- Two correct ticks ( 1.000 $ ) --
	for a = 1, 3 do
		for b = 1, 3 do
			local sql = "SELECT id, name FROM lotto WHERE ( z"..a.." = '"..l1.."' AND z"..b.." = '"..l2.."' ) OR ( z"..a.." = '"..l3.."' AND z"..b.." = '"..l2.."' ) OR ( z"..a.." = '"..l1.."' AND z"..b.." = '"..l3.."' )"
			local result = mysql_query ( handler, sql )
			if ( mysql_num_rows ( result ) > 0 ) then
				local winnerName, winnerID, lottoWinner
				while lottoWinner do
					winnerName = lottoWinner["name"]
					winnerID = lottoWinner["id"]
					
					lottoWinner = mysql_fetch_assoc ( result )
					
					if isElement ( getPlayerFromName ( winnerName ) ) then
						local player = getPlayerFromName ( winnerName )
						
						outputChatBox ( "Du hast soeben im Lotto "..formNumberToMoneyString ( 1000 ).." gewonnen!", player, 0, 200, 0 )
						outputChatBox ( "Das Geld liegt jetzt auf deinem Konto - viel Spass damit!", player, 0, 200, 0 )
						
						vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) + 1000 )
					else
						if MySQL_DatasetExist ( "players", "Name LIKE '"..winnerName.."'" ) then
							MySQL_SetString ( "userdata", "Bankgeld", 1000 + MySQL_GetString ( "userdata", "Bankgeld", "Name LIKE '"..winnerName.."'" ), "Name LIKE '"..winnerName.."'" )
						else
							MySQL_SetOldString ( "userdata", "Bankgeld", 1000 + MySQL_GetOldString ( "userdata", "Bankgeld", "Name LIKE '"..winnerName.."'" ), "Name LIKE '"..winnerName.."'" )
						end
						
						offlinemsg ( "Du hast im Lotto "..formNumberToMoneyString ( 1000 ).." gewonnen! Das Geld ist auf deinem Konto.", "LTR Lotto", winnerName )
					end
					
					mysql_vio_query ( "DELETE FROM lotto WHERE id LIKE '"..winnerID.."'" )
					lottoWinner = mysql_fetch_assoc ( result )
				end
			end
			if result then
				mysql_free_result ( result )
			end
		end
	end
	
	-- One correct tick ( 50 $ ) --
	for a = 1, 3 do
		local sql = "SELECT id, name FROM lotto WHERE z"..a.." = '"..l1.."' OR z"..a.." = '"..l2.."' OR z"..a.." = '"..l3.."'"
		local result = mysql_query ( handler, sql )
		if ( mysql_num_rows ( result ) > 0 ) then
			local winnerName, winnerID, lottoWinner
			lottoWinner = mysql_fetch_assoc ( result )
			while lottoWinner do
				winnerName = lottoWinner["name"]
				winnerID = lottoWinner["id"]
				
				if isElement ( getPlayerFromName ( winnerName ) ) then
					local player = getPlayerFromName ( winnerName )
					
					outputChatBox ( "Du hast soeben im Lotto "..formNumberToMoneyString ( 50 ).." gewonnen!", player, 0, 200, 0 )
					outputChatBox ( "Das Geld liegt jetzt auf deinem Konto - viel Spass damit!", player, 0, 200, 0 )
					
					vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) + 50 )
				else
					if MySQL_DatasetExist ( "players", "Name LIKE '"..winnerName.."'" ) then
						MySQL_SetString ( "userdata", "Bankgeld", 50 + MySQL_GetString ( "userdata", "Bankgeld", "Name LIKE '"..winnerName.."'" ), "Name LIKE '"..winnerName.."'" )
					else
						MySQL_SetOldString ( "userdata", "Bankgeld", 50 + MySQL_GetOldString ( "userdata", "Bankgeld", "Name LIKE '"..winnerName.."'" ), "Name LIKE '"..winnerName.."'" )
					end
					
					offlinemsg ( "Du hast im Lotto "..formNumberToMoneyString ( 50 ).." gewonnen! Das Geld ist auf deinem Konto.", "LTR Lotto", winnerName )
				end
				
				mysql_vio_query ( "DELETE FROM lotto WHERE id LIKE '"..winnerID.."'" )
				lottoWinner = mysql_fetch_assoc ( result )
			end
		end
		if result then
			mysql_free_result ( result )
		end
	end
end

function requestLottoJackpot ()

	triggerClientEvent ( client, "recieveLottoJackpot", client, lottoJackpot )
end
addEvent ( "requestLottoJackpot", true )
addEventHandler ( "requestLottoJackpot", getRootElement(), requestLottoJackpot )

function recieveClientLotto ( l1, l2, l3 )

	local player = client
	local pname = getPlayerName ( player )
	
	l1 = math.abs ( math.floor ( tonumber ( l1 ) ) )
	l2 = math.abs ( math.floor ( tonumber ( l2 ) ) )
	l3 = math.abs ( math.floor ( tonumber ( l3 ) ) )
	
	if l1 >= 1 and l2 >= 1 and l3 >= 1 and l1 <= 12 and l2 <= 12 and l3 <= 12 then
		if l1 ~= l2 and l1 ~= l3 and l2 ~= l3 then
			local money = vioGetElementData ( player, "money" )
			if money >= 10 then
				if MySQL_ExistAmount ( "lotto", "name LIKE '"..pname.."'" ) < 3 then
					local array = { [1]=l1, [2]=l2, [3]=l3 }
					
					array = sortArray ( array )
					
					l1 = array[1]
					l2 = array[2]
					l3 = array[3]
					
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 10 )
					
					mysql_vio_query ( "INSERT INTO lotto ( name, z1, z2, z3 ) VALUES ( '"..pname.."', '"..l1.."', '"..l2.."', '"..l3.."' )" )
					
					infobox ( player, "Du hast ein Los\nerworben - die Ziehung\nfindet jeden Freitag\n um 22:00 statt!", 5000, 0, 125, 0 )
					
					ReporterMoney = ReporterMoney + 10
					MySQL_SetString ( "fraktionen", "DepotGeld", ReporterMoney, "Name LIKE 'Reporter'" )
				else
					infobox ( player, "Du kannst maximal\n3 Scheine ausfuellen!", 5000, 125, 0, 0 )
				end
			else
				infobox ( player, "Du hast nicht\ngenug Geld, um\neinen Lottoschein\nzu kaufen!", 5000, 125, 0, 0 )
			end
		end
	end
end
addEvent ( "recieveClientLotto", true )
addEventHandler ( "recieveClientLotto", getRootElement(), recieveClientLotto )