local recentSupportRequests = {}
local fastHelpTickets = {}
fastHelpTicketSenders = {}

function orderSupportTicket ( kathegory, text )

	local player = client
	local pname = getPlayerName ( player )
	kathegory = math.abs ( math.floor ( tonumber ( kathegory ) ) )
	-- Zeitbeschrünkung ( 3 Mins )
	if not recentSupportRequests[pname] then
		-- Anzahl-Beschrünkung ( Immer nur ein offenes Ticket erlaubt )
		if not fastHelpTicketSenders[pname] and not MySQL_DatasetExist ( "tickets", "name LIKE '"..pname.."'" ) and not MySQL_DatasetExist ( "ticket_answeres", "name LIKE '"..pname.."'" ) then
			local someoneRecievedTheMessage = false
			
			outputLog ( "------------------\nNeues Ticket von "..pname..":\n"..text, "support_questions" )
			
			if kathegory == 1 then		-- Fast help
				for admin, rank in pairs ( adminsIngame ) do
					outputChatBox ( pname.." braucht Hilfe!", admin, 100, 100, 255 )
					someoneRecievedTheMessage = true
				end
				if someoneRecievedTheMessage then
					fastHelpTicketSenders[pname] = pname
				end
			elseif kathegory == 2 then	-- Questions
				outputChatBox ( 1 )
				for member, name in pairs ( ticketPermitted ) do
					outputChatBox ( 2 )
					outputChatBox ( pname.." hat eine Frage gestellt!", member, 100, 100, 255 )
					someoneRecievedTheMessage = true
				end
			elseif kathegory == 3 then	-- Request
				for admin, rank in pairs ( adminsIngame ) do
					if vioGetElementData ( admin ) == 2 then
						outputChatBox ( "Neue Anfrage von "..pname.."!", admin, 100, 100, 255 )
						someoneRecievedTheMessage = true
					end
				end
			end
			
			if someoneRecievedTheMessage then
				outputChatBox ( "Deine Anfrage wurde entgegen genommen! Du wirst informiert, wenn sie bearbeitet wurde.", player, 200, 0, 0 )
			else
				if kathegory == 1 then
					outputChatBox ( "Im Moment niemand online, der deine Anfrage bearbeiten kann.", player, 200, 0, 0 )
					outputChatBox ( "Um zu sehen, wer online ist, tippe /admins", player, 200, 0, 0 )
					return true
				else
					outputChatBox ( "Deine Anfrage wurde entgegen genommen, jedoch ist im Moment niemand online,", player, 200, 0, 0 )
					outputChatBox ( "der sie bearbeiten kann. Du wirst jedoch informiert, wenn sie bearbeitet wurde.", player, 200, 0, 0 )
				end
			end
			if kathegory == 1 then
				local ticket = { ["name"] = pname, ["text"] = text }
				table.insert ( fastHelpTickets, ticket )
			else
				mysql_vio_query ( "INSERT INTO tickets ( name, kathegory, text ) VALUES ( '"..pname.."', '"..kathegory.."', '"..MySQL_Safe ( text ).."' )" )
			end
			recentSupportRequests[pname] = true
			setTimer (
				function ( name )
					recentSupportRequests[name] = false
				end,
			3 * 60 * 1000, 1, pname )
		else
			if MySQL_DatasetExist ( "ticket_answeres", "name LIKE '"..pname.."'" ) then
				outputChatBox ( "Du hast noch eine ausstehende Antwort! Tippe /readticket, um sie zu lesen!", player, 200, 0, 0 )
			else
				outputChatBox ( "Es existiert bereits eine Anfrage von dir!", player, 200, 0, 0 )
			end
		end
	else
		outputChatBox ( "Du hast vor kurzem bereits eine Anfrage gestellt!", player, 200, 0, 0 )
	end
end
addEvent ( "orderSupportTicket", true )
addEventHandler ( "orderSupportTicket", getRootElement (), orderSupportTicket )

function readticket_func ( player )

	local pname = getPlayerName ( player )
	local text = MySQL_GetString ( "ticket_answeres", "text", "name LIKE '"..pname.."'" )
	if text then
		local admin = MySQL_GetString ( "ticket_answeres", "admin", "name LIKE '"..pname.."'" )
		triggerClientEvent ( player, "readTicketAnswere", player, text, admin )
		mysql_vio_query ( "DELETE FROM ticket_answeres WHERE name LIKE '"..pname.."'" )
	else
		outputChatBox ( "Du hast keine Antwort auf ein Ticket!", player, 200, 0, 0 )
	end
end
addCommandHandler ( "readticket", readticket_func )

function retrieveTicketList ( typ )

	local player = client
	-- Schnellhilfe
	if vioGetElementData ( player, "adminlvl" ) >= 1 and typ == 1 then
		if next ( fastHelpTickets ) then
			triggerClientEvent ( player, "recieveTicketList", player, 1, fastHelpTickets )
		else
			triggerClientEvent ( player, "thereAreNoTickets", player )
		end
	-- Anfragen & Fragen
	elseif ( typ == 2 and ticketPermitted[player] ) or ( vioGetElementData ( player, "adminlvl" ) >= 1 and typ == 3 ) then
		local tickets = {}
		local result = mysql_query ( handler, "SELECT name FROM tickets WHERE kathegory = '"..typ.."' ORDER BY date ASC LIMIT 10" )
		local rows = mysql_num_rows ( result )
		if rows > 0 then
			local data
			for i = 1, rows do
				data = mysql_fetch_assoc ( result )
				tickets[data["name"]] = data["name"]
			end
			triggerClientEvent ( player, "recieveTicketList", player, 2, tickets )
		else
			triggerClientEvent ( player, "thereAreNoTickets", player )
		end
		mysql_free_result ( result )
	end
end
addEvent ( "retrieveTicketList", true )
addEventHandler ( "retrieveTicketList", getRootElement(), retrieveTicketList )

function recieveTicketDetails ( name )

	local player = client
	if vioGetElementData ( player, "adminlvl" ) >= 1 or ticketPermitted[player] then
		local text = MySQL_GetString ( "tickets", "text", "name LIKE '"..MySQL_Safe ( name ).."'" )
		if not text then
			for key, index in pairs ( fastHelpTickets ) do
				if index["name"] == name then
					text = index["text"]
					break
				end
			end
		end
		triggerClientEvent ( player, "recieveTicketDetails", player, text )
	end
end
addEvent ( "recieveTicketDetails", true )
addEventHandler ( "recieveTicketDetails", getRootElement (), recieveTicketDetails )

function ticketDone ( name, action, answere )

	local player = client
	local supporter = getPlayerName ( player )
	if ticketPermitted[player] or vioGetElementData ( player, "adminlvl" ) >= 1 then
		name = MySQL_Safe ( name )
		-- Nachricht senden
		if action == 0 then
			answere = "Dein Ticket wurde ohne Begründung geschlossen."
		else
			outputChatBox ( "Antwort gesendet!", player, 0, 200, 0 )
		end
		outputLog ( "Antwort von "..supporter.." auf das Ticket von "..name.." geantwortet:\n"..answere )
		answere = MySQL_Safe ( answere )
		mysql_vio_query ( "INSERT INTO ticket_answeres ( name, admin, text ) VALUES ( '"..name.."', '"..supporter.."', '"..answere.."' )" )
		if getPlayerFromName ( name ) then
			outputChatBox ( "Deine Anfrage wurde bearbeitet. Tippe /readticket, um die Antwort zu lesen.", getPlayerFromName ( name ), 200, 200, 0 )
		end
		-- Ticket löschen, falls es nur lokal ist
		if fastHelpTicketSenders[name] then
			for key, index in pairs ( fastHelpTickets ) do
				if index["name"] == name then
					fastHelpTickets[key] = nil
					fastHelpTicketSenders[name] = nil
					break
				end
			end
		end
		-- Ticket schließen
		mysql_vio_query ( "DELETE FROM tickets WHERE name LIKE '"..name.."'" )
		outputChatBox ( "Ticket geschlossen.", player, 200, 200, 0 )
	end
end
addEvent ( "ticketDone", true )
addEventHandler ( "ticketDone", getRootElement (), ticketDone )