local recentSupportRequests = {}
local fastHelpTickets = {}
fastHelpTicketSenders = {}


local function orderSupportTicket_DB ( qh, kathegory, text, player, pname )
	local result = dbPoll( qh, 0, true )
	if result then
		if not fastHelpTicketSenders[pname] and not ( result[1] and result[1][1] ) and not ( result[2] and result[2][1] ) then
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
				dbExec ( handler, "INSERT INTO tickets ( name, kathegory, text ) VALUES ( ?, ?, ? )", pname, kathegory, text )
			end
			recentSupportRequests[pname] = true
			setTimer (
				function ( name )
					recentSupportRequests[name] = false
				end,
			3 * 60 * 1000, 1, pname )
		else
			if result[2] and result[2][1] then
				outputChatBox ( "Du hast noch eine ausstehende Antwort! Tippe /readticket, um sie zu lesen!", player, 200, 0, 0 )
			else
				outputChatBox ( "Es existiert bereits eine Anfrage von dir!", player, 200, 0, 0 )
			end
		end
	end
end

function orderSupportTicket ( kathegory, text )

	local player = client
	local pname = getPlayerName ( player )
	kathegory = math.abs ( math.floor ( tonumber ( kathegory ) ) )
	-- Zeitbeschrünkung ( 3 Mins )
	if not recentSupportRequests[pname] then
		-- Anzahl-Beschrünkung ( Immer nur ein offenes Ticket erlaubt )
		dbQuery( orderSupportTicket_DB, { kathegory, text, player, pname }, handler, "SELECT true FROM tickets WHERE name LIKE ?; SELECT true FROM ticket_answeres WHERE name LIKE ?", pname, pname )
	else
		outputChatBox ( "Du hast vor kurzem bereits eine Anfrage gestellt!", player, 200, 0, 0 )
	end
end
addEvent ( "orderSupportTicket", true )
addEventHandler ( "orderSupportTicket", getRootElement (), orderSupportTicket )


local function readticket_func_DB ( qh, player, pname ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local text = result[1]["text"]
		local admin = result[1]["admin"]
		triggerClientEvent ( player, "readTicketAnswere", player, text, admin )
		dbExec( handler, "DELETE FROM ticket_answeres WHERE name LIKE ?", pname )
	else 
		outputChatBox ( "Du hast keine Antwort auf ein Ticket!", player, 200, 0, 0 )
	end
end

function readticket_func ( player )
	local pname = getPlayerName ( player )
	dbQuery( readticket_func_DB, { player, pname }, handler, "SELECT * FROM ticket_answeres WHERE name LIKE ?", pname )
end
addCommandHandler ( "readticket", readticket_func )


local function retrieveTicketList_DB ( qh )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local tickets = {}
		for i = 1, #result do
			local data = result[i]
			tickets[data["name"]] = data["name"]
		end
		triggerClientEvent ( player, "recieveTicketList", player, 2, tickets )
	else
		triggerClientEvent ( player, "thereAreNoTickets", player )
	end
end

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
		dbQuery ( retrieveTicketList_DB, { player }, handler, "SELECT name FROM tickets WHERE kathegory = ? ORDER BY date ASC LIMIT 10", typ )
	end
end
addEvent ( "retrieveTicketList", true )
addEventHandler ( "retrieveTicketList", getRootElement(), retrieveTicketList )


local function recieveTicketDetails_DB ( qh, player, name )
	local result = dbPoll( qh, 0 )
	local text = result and result[1] and result[1]["name"] or ""
	if not result or not result[1]  then
		for key, index in pairs ( fastHelpTickets ) do
			if index["name"] == name then
				text = index["text"]
				break
			end
		end
	end
	triggerClientEvent ( player, "recieveTicketDetails", player, text )
end

function recieveTicketDetails ( name )
	local player = client
	if vioGetElementData ( player, "adminlvl" ) >= 1 or ticketPermitted[player] then
		dbQuery( recieveTicketDetails_DB, { player, name }, handler, "SELECT text FROM tickets WHERE name LIKE ?", name )
	end
end
addEvent ( "recieveTicketDetails", true )
addEventHandler ( "recieveTicketDetails", getRootElement (), recieveTicketDetails )

function ticketDone ( name, action, answere )

	local player = client
	local supporter = getPlayerName ( player )
	if ticketPermitted[player] or vioGetElementData ( player, "adminlvl" ) >= 1 then
		-- Nachricht senden
		if action == 0 then
			answere = "Dein Ticket wurde ohne Begründung geschlossen."
		else
			outputChatBox ( "Antwort gesendet!", player, 0, 200, 0 )
		end
		outputLog ( "Antwort von "..supporter.." auf das Ticket von "..name.." geantwortet:\n"..answere )
		dbExec( handler, "INSERT INTO ticket_answeres ( name, admin, text ) VALUES ( ?, ?, ? )", name, supporter, answere )
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
		dbExec ( handler, "DELETE FROM tickets WHERE name LIKE ?", name )
		outputChatBox ( "Ticket geschlossen.", player, 200, 200, 0 )
	end
end
addEvent ( "ticketDone", true )
addEventHandler ( "ticketDone", getRootElement (), ticketDone )