local function pm_func_DB ( qh, msg, pname, target, player )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local result = result[1]["Name"]
		offlinemsg ( msg, pname, target )
		outputChatBox ( "Der Spieler ist offline - die Nachricht wird später zugestellt!", player, 200, 200, 0 )
		--takeMSGMoney ( player )
	else
		outputChatBox ( "Der Spieler existiert nicht!", player, 125, 0, 0 )
	end
end


function pm_func ( player, cmd, target, ... )

	if vioGetElementData ( player, "adminlvl" ) < 1 then
		outputChatBox ( "PMs sind deaktiviert! Bitte nutze /call, /sms oder schreibe eine E-Mail.", player, 125, 0, 0 )
		return true
	end
	
	local parametersTable = {...}
	local msg = table.concat( parametersTable, " " )
	local money = getElementData ( player, "money" )
	local pname = getPlayerName ( player )
	if true then
		--if money >= pm_price then
			if target and #msg >= 1 then	
				if getElementData ( getPlayerFromName(target), "loggedin" ) == 1 then
					local msg = "Nachricht von "..pname.."("..timestamp().."): "..msg
					outputChatBox ( "Nachricht wurde gesendet!", player, 0, 125, 0 )
					outputChatBox ( msg, getPlayerFromName(target), 200, 200, 0 )
					--takeMSGMoney ( player )
				else
					dbQuery( pm_func_DB, { msg, pname, target, player }, handler, "SELECT Name FROM players WHERE Name LIKE ?", target )
				end
			else
				outputChatBox ( "Gebrauch: /pm [Empfaenger] [Text]", player, 125, 0, 0 )
			end
		--else
		--	outputChatBox ( "Eine PM kostet "..pm_price.." $!", player, 125, 0, 0 )
		--end
	end
end
addCommandHandler ( "pm", pm_func )

function offlinemsg ( msg, sender, empfaenger )

	datum = timestamp()
	--if msg == MySQL_Save ( msg ) and sender == MySQL_Save ( sender ) and empfaenger == MySQL_Save ( empfaenger ) then
		dbExec(handler, "INSERT INTO pm (Sender, Empfaenger, Text, Datum) VALUES (?, ?, ?,'"..datum.."')", sender, empfaenger, msg )
	--end
end


local function checkmsgs_DB ( qh, player )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		for i=1, #result do
			local msg = result[i]["Text"]
			local datum = result[i]["Datum"]
			local sender = result[i]["Sender"]
			local text = msg
			local msg = "Nachricht von "..sender.."("..datum.."): "..msg
			outputChatBox ( msg, player, 200, 200, 0 )
		end
		dbExec( handler, "REMOVE FROM pm WHERE Empfaenger LIKE ?", getPlayerName( player ) )
	end
end

function checkmsgs ( player )
	dbQuery( checkmsgs_DB, { player }, handler, "SELECT * FROM pm WHERE Empfaenger LIKE ?", getPlayerName( player ) )
end

function takeMSGMoney ( player )

	--if getElementData ( player, "premium" ) then
	--else
		setElementData ( player, "money", getElementData(player,"money")-pm_price )
	--end
end