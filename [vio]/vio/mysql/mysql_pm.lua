function pm_func ( player, cmd, target, ... )

	if vioGetElementData ( player, "adminlvl" ) < 1 then
		outputChatBox ( "PMs sind deaktiviert! Bitte nutze /call, /sms oder schreibe eine E-Mail.", player, 125, 0, 0 )
		return true
	end
	
	
	local parametersTable = {...}
	local msg = MySQL_Save ( table.concat( parametersTable, " " ) )
	target = MySQL_Save ( target )
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
					if msg == MySQL_Save ( msg ) and sender == MySQL_Save ( sender ) and empfaenger == MySQL_Save ( empfaenger ) then
						local result = MySQL_GetString( "players", "Name", "Name LIKE '"..target.."'" )
						if result then
							offlinemsg ( msg, pname, target )
							outputChatBox ( "Der Spieler ist offline - die Nachricht wird später zugestellt!", player, 200, 200, 0 )
							--takeMSGMoney ( player )
						else
							outputChatBox ( "Der Spieler existiert nicht!", player, 125, 0, 0 )
						end
					else
						outputChatBox ( "Deine Nachricht enthaelt ungueltige Zeichen!", player, 125, 0, 0 )
					end
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
		mysql_query(handler, "INSERT INTO pm (Sender, Empfaenger, Text, Datum) VALUES ('"..sender.."','"..empfaenger.."','"..msg.."','"..datum.."')")
	--end
end

function checkmsgs ( player )

	local i = 1
	while true and i <= 10 do
		local msg = MySQL_GetString( "pm", "Text", "Empfaenger LIKE '"..getPlayerName(player).."'" )
		if msg then
			local datum = MySQL_GetString( "pm", "Datum", "Empfaenger LIKE '"..getPlayerName(player).."'" )
			local sender = MySQL_GetString( "pm", "Sender", "Empfaenger LIKE '"..getPlayerName(player).."'" )
			local text = msg
			local msg = "Nachricht von "..sender.."("..datum.."): "..msg
			outputChatBox ( msg, player, 200, 200, 0 )
			MySQL_DelRow("pm", "Empfaenger LIKE '"..getPlayerName(player).."' AND Text LIKE '"..text.."' AND Sender LIKE '"..sender.."' AND Datum LIKE '"..datum.."'")
			i = i + 1
		else
			break
		end
	end
end

function takeMSGMoney ( player )

	--if getElementData ( player, "premium" ) then
	--else
		setElementData ( player, "money", getElementData(player,"money")-pm_price )
	--end
end