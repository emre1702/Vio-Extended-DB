function checkForOldMails ()

	result, errorcode, errormsg = dbPoll( dbQuery( handler, "SELECT * FROM email"), -1 )
	deletedMails = 0
	mails = 0
	if( not result) then
		outputDebugString("Error executing the query: (" .. errorcode .. ") " .. errormsg )
	else
		if #result > 0 then
			mailData = table.remove ( result, 1 )
			mySQLMailCheck ()
		else
			outputServerLog("Es wurden keine Mails gefunden")
		end
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource() ), checkForOldMails )

function mySQLMailCheck ()

	mails = mails + 1

	if isMailingDateOld ( mailData["Yearday"], mailData["Year"] ) then
		dbExec( handler, "REMOVE FROM email WHERE Name Empfaenger ? AND Text LIKE ?", mailData["Empfaenger"], mailData["Text"] )
		deletedMails = deletedMails + 1
	end
	
	mailData = table.remove ( result, 1 )
	if mailData then
		mySQLMailCheck ()
	else
		outputServerLog("Es wurden "..mails.." E-Mails gefunden und "..deletedMails.." alte Mails geloescht.")
	end
end

function isMailingDateOld ( yd, y )

	local time = getRealTime()
	local year = time.year
	local yearday = time.yearday
	local tCurTime = time.year * 365 + time.yearday
	local tMailTime = y * 365 + y
	local tDiff = tCurTime - tMailTime
	if tDiff >= 10 then
		return true
	end
	return false
end

specMailAdresses = { ["admin@FORUMADRESSE"]=true, ["admin@ltr.net"]=true, ["admin@bund.net"]=true,
["admin@triaden.de"]=true,
["admin@ltr.de"]=true,
["admin@sfpd.de"]=true,
["admin@mafia.de"]=true,
["admin@fbi.de"]=true,
["admin@bundeswehr.de"]=true }


local function sendMail_func_DB ( qh, client, text, betreff, to )
	local result = true
	if qh then
		result = dbPoll( qh, 0 )
	end
	if result and ( not qh or result[1] ) then
		local mail = tostring ( getPlayerName(client).."@FORUMADRESSE|"..betreff.."|"..timestamp()..": "..text )
		outputChatBox ( "E-Mail gesendet!", client, 0, 125, 0 )
		local time = getRealTime()
		local y = time.year
		local yd = time.yearday
		
		local result = dbExec( handler, "INSERT INTO email (Empfaenger, Text, Yearday, Year) VALUES (?, ?, '"..yd.."', '"..y.."')", to, mail )
		if( not result) then
			outputDebugString("Error executing the query sendMail_func_DB: (" .. getPlayerName( client ) .. ") to " .. to .. ": "..betreff )
		end
		if isElement ( getPlayerFromName ( to ) ) and vioGetElementData ( getPlayerFromName ( to ), "loggedin" ) == 1 then
			getMailsForClient_func ( to )
		end
	else
		outputChatBox ( "Ungueltige Eingabe, bitte verwende folgende Eingabe: [Name@FORUMADRESSE]", client, 125, 0, 0 )
	end
end

function sendMail_func ( text, betreff, to )
	if specMailAdresses [ string.lower ( to ) ] then
		sendMail_func_DB( false, client, text, betreff, to )
	else
		to = gettok ( to, 1, string.byte ( '@' ) )
		dbQuery( sendMail_func_DB, { client, text, betreff, to }, handler, "SELECT true FROM players WHERE Name LIKE ?", to )
	end
	
end
addEvent ( "sendMail", true )
addEventHandler ( "sendMail", getRootElement(), sendMail_func )


local function getMailsForClient_func_DB ( qh, pname )
	result = dbPoll( qh, 0 )
	player = getPlayerFromName ( pname )
	if result and result[1] then
		for i=1, #result do
			local mailData = result[i]
			triggerClientEvent ( player, "reciveMail", getRootElement(), mailData["Text"] )
			outputDebugString ( "Empfaenger LIKE "..pname.." AND Text LIKE "..mailData["Text"] )
		end
		dbExec( handler, "DELETE FROM email WHERE Empfaenger LIKE ?", pname )
	end
end

function getMailsForClient_func ( pname )
	dbQuery( getMailsForClient_func_DB, { pname }, handler, "SELECT * FROM email WHERE Empfaenger LIKE ?", pname )
	
end