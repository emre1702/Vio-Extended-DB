function getPlayerWarnCount ( name )

	return tonumber ( MySQL_ExistAmount ( "warns", "player LIKE '"..name.."'" ) )
end

function getLowestWarnExtensionTime ( name )

	return MySQL_GetString ( "warns", "extends_o", "player LIKE	'"..name.."' ORDER BY extends ASC LIMIT 1" )
end

function outputPlayerWarns ( name, reader )

	local count = getPlayerWarnCount ( name )
	outputChatBox ( "Warns: "..count, reader, 200, 200, 0 )
	if count > 0 then
		local result = mysql_query ( handler, "SELECT admin, reason, extends_o, date FROM warns WHERE player = '"..name.."'" )
		for i = 1, count do
			local row = mysql_fetch_assoc ( result )
			outputChatBox ( "Warn "..i..":", reader, 255, 0, 0 )
			outputChatBox ( "Von: "..row["admin"].." ( "..row["date"].." ), Grund: "..row["reason"], reader, 255, 0, 0 )
			outputChatBox ( "Ablaufdatum: "..row["extends_o"], reader, 255, 0, 0 )
		end
	end
end
addCommandHandler ( "warns",
	function ( player )
		outputPlayerWarns ( getPlayerName ( player ), player )
	end
)
addCommandHandler ( "checkwarns",
	function ( player, cmd, name )
		outputPlayerWarns ( name, player )
	end
)
addEvent ( "checkwarns", true )
addEventHandler ( "checkwarns", getRootElement(),
	function ( name )
		outputPlayerWarns ( name, client )
	end
)

function warn_func ( player, cmd, name, extends, ... )

	local suspect = getPlayerFromName ( name )
	local reason = {...}
	reason = table.concat( reason, " " )
	if getElementType ( player ) == "console" then
		vioSetElementData ( player, "adminlvl", 99 )
	end
	if vioGetElementData ( player, "adminlvl" ) >= 1 and ( not client or client == player ) then
		local extends = math.abs ( math.floor ( tonumber ( extends ) ) )
		if extends and extends > 0 and extends < 365 then
			name = MySQL_Safe ( name )
			reason = MySQL_Safe ( reason )
			if isRegistered ( name ) then
				local admin = getPlayerName ( player )
				rt = getRealTime ()
				mysql_vio_query ( "INSERT INTO warns ( player, admin, reason, extends, extends_o, date ) VALUES ( '"..name.."', '"..admin.."', '"..reason.."', '"..( rt.timestamp + 3600 * 24 * extends ).."', '"..timestampDays ( extends )..", 4:00".."', '"..timestamp().."' )" )
				if isElement ( suspect ) then
					if getPlayerWarnCount ( name ) == 3 then
						kickPlayer ( suspect, "Von: "..admin..", Grund: "..reason.." (Gebannt, 3 Verwarnungen)" )
					else
						outputChatBox ( "Du wurdest von "..admin.." verwarnt! Grund: "..reason..", Ablaufzeit: "..extends.." Tage!", suspect, 255, 0, 0 )
						outputChatBox ( "Beim dritten Warn wirst du automatisch gebannt. Tippe /warns, um deine Verwarnungen einzusehen.", suspect, 255, 0, 0 )
					end
				else
					offlinemsg ( "Du wurdest von "..admin.." verwarnt; Grund: "..reason, "Server", name )
				end
				outputChatBox ( "Du hast "..name.." verwarnt!", player, 0, 200, 0 )
			else
				infobox ( player, "Der Spieler\nexistiert nicht!", 5000, 125, 0, 0 )
			end
		else
			infobox ( player, "Gebrauch:\n/warn [Name]\n[Dauer in Tagen]\n[Grund]", 5000, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
	end
end
addCommandHandler ( "warn", warn_func )
addEvent ( "warn", true )
addEventHandler ( "warn", getRootElement(),
	function ( name, extends, reason )
		warn_func ( client, "warn", name, extends, reason )
	end
)