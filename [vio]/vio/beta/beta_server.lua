betaServerIP = "www.FORUMADRESSE"
betaServerPort = 22004
betaServerPasswort = "VioBetatest-Server;InviteOnly!"
validBetakeys = {}
isThisTheBetaServer = false

function betaServerMessage ( player )

	if isThisTheBetaServer () then
		setTimer ( outputChatBox, 5000, 1, "Vio BETA-Server", player, 0, 125, 0 )
		setTimer ( outputChatBox, 5000, 1, "Melde bitte alle Bugs im Beta-Forum", player, 0, 125, 0 )
		setTimer ( outputChatBox, 5000, 1, "\"Muell\", der im Chat ausgegeben wird ( Wirre Zahlenkombinationen o.ae. ) sind irrelevant", player, 0, 125, 0 )
		setTimer ( outputChatBox, 5000, 1, "Mit /beta kannst du dir alle Scheine sowie etwas Bargeld und Spielzeit geben.", player, 0, 125, 0 )
		setTimer ( outputChatBox, 5000, 1, "Um dir ein Fahrzeug zu erstellen, tippe /veh [400-600]", player, 0, 125, 0 )
		setTimer ( outputChatBox, 5000, 1, "_____________", player, 0, 125, 0 )
		setTimer ( outputChatBox, 5000, 1, "Aktuelle Punkte zum Testen: Four Dragons Casino, Caligulas Casino, Kameraflug beim Login", player, 0, 125, 0 )
	end
end

function isThisTheBetaServer ()

	if getServerPort () == betaServerPort then
		return true
	end
	return false
end


local function beta_func_DB ( qh, player, pname, betakey ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		if result[1]["Name"] == pname or string.sub ( pname, 1, 5 ) == "[Vio]" then
			outputChatBox ( "Du wirst weitergeleitet...", player, 125, 0, 0 )
			sendPlayerToBetaServer ( player )
		else
			if result[1]["Name"] == "-" then
				outputChatBox ( "Betakey verifiziert. Du wirst weitergeleitet...", player, 0, 125, 0 )
				dbExec( handler, "UPDATE betakeys SET Name = ? WHERE Betakey LIKE ?", pname, betakey )
				sendPlayerToBetaServer ( player )
			else
				outputChatBox ( "Der Betakey ist bereits in Verwendung!", player, 125, 0, 0 )
			end
		end
	else
		outputChatBox ( "Der Betakey ist ungueltig oder ist bereits aktiviert!", player, 125, 0, 0 )
	end
end



function beta_func ( player, cmd, betakey )

	if not isThisTheBetaServer () then
		if vioGetElementData ( player, "loggedin" ) == 1 then
			if betakey then
				betakey = string.upper ( betakey )
			else
				betakey = ""
			end
			local pname = getPlayerName ( player )
			dbQuery( beta_func_DB, { player, pname, betakey }, handler, "SELECT * FROM betakeys WHERE Name LIKE ? OR Betakey LIKE ?", pname, betakey )
		end
	else
		vioSetElementData ( player, "playingtime", 60 * 500 )
		
		vioSetElementData ( player, "carlicense", 1 )
		vioSetElementData ( player, "gunlicense", 1 )
		vioSetElementData ( player, "bikelicense", 1 )
		vioSetElementData ( player, "lkwlicense", 1 )
		vioSetElementData ( player, "helilicense", 1 )
		vioSetElementData ( player, "planelicensea", 1 )
		vioSetElementData ( player, "planelicenseb", 1 )
		vioSetElementData ( player, "motorbootlicense", 1 )
		vioSetElementData ( player, "segellicense", 1 )
		vioSetElementData ( player, "fishinglicense", 1 )
		
		vioSetElementData ( player, "money", 500000 )
	end
end
addCommandHandler ( "beta", beta_func )

function sendPlayerToBetaServer ( player )

	setTimer ( redirectPlayer, 5000, 1, player, betaServerIP, betaServerPort, betaServerPasswort )
end

function generateBetakeys ( player, cmd, count )

	if not isThisTheBetaServer () then
		if vioGetElementData ( player, "adminlvl" ) >= 2 then
			count = tonumber ( count )
			if not count then
				count = 1
			end
			betakeys = {}
			outputChatBox ( "Betakeys erstellt:", player, 0, 200, 0 )
			for i = 1, count do
				local key = string.sub ( md5 ( "Vio-RL Beta"..math.random ( 1, 100000 ) ), 0, 4 ).."-"..string.sub ( md5 ( "Vio-RL Beta"..math.random ( 1, 100000 ) ), 5, 8 )
				betakeys[i] = key
				outputChatBox ( "Key Nr. "..i..": "..key, player, 200, 200, 0 )
				key = string.upper ( key )
				validBetakeys[key] = true
				dbExec ( handler, "INSERT INTO betakeys (Betakey, Name) VALUES (?, '-')", key )
			end
		end
	end
end
addCommandHandler ( "betakey", generateBetakeys )

function loadBetakeys ()

	local result = dbPoll( dbQuery( handler, "SELECT * FROM betakeys" ), -1 )
	if result and result[1] then
		for i=1, #result do
			local data = result[i]
			if data["Key"] then
				outputServerLog ( "Betakey: "..data["Key"] )
				validBetakeys[data["Betakey"]] = true
			end
		end
	end
end
loadBetakeys ()