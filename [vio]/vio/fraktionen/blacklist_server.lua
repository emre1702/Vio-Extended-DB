blacklistPlayers = {}
 blacklistPlayers[2] = {}
 blacklistPlayers[3] = {}
 blacklistPlayers[7] = {}
 blacklistPlayers[9] = {}
 
blacklistReason = {}
 blacklistReason[2] = {}
 blacklistReason[3] = {}
 blacklistReason[7] = {}
 blacklistReason[9] = {}

local playersAddetToBlacklist = {}
for i = 1, 9 do
	playersAddetToBlacklist[i] = {}
end

validBlackListFactions = {
 [2]=true,
 [3]=true,
 [7]=true,
 [9]=true
 }

factionBlackListGuns = {
 [2]=26,
 [3]=8,
 [7]=18,
 [9]=28
}

function blacklistLogin ( pname )

	if isOnBlacklist ( pname, 2 ) then
		blacklistPlayers[2][pname] = true
		blacklistReason[2][pname] = getBlacklistGrund ( pname, 2 )
	end
	if isOnBlacklist ( pname, 3 ) then
		blacklistPlayers[3][pname] = true
		blacklistReason[3][pname] = getBlacklistGrund ( pname, 3 )
	end
	if isOnBlacklist ( pname, 7 ) then
		blacklistPlayers[7][pname] = true
		blacklistReason[7][pname] = getBlacklistGrund ( pname, 7 )
	end
	if isOnBlacklist ( pname, 9 ) then
		blacklistPlayers[9][pname] = true
		blacklistReason[9][pname] = getBlacklistGrund ( pname, 9 )
	end
end

function blackListKillCheck ( player, killer, weapon )

	local killerFaction = vioGetElementData ( killer, "fraktion" )
	local name = getPlayerName ( player )
	if validBlackListFactions[killerFaction] then
		if isOnBlacklist ( name, killerFaction ) then
			local prizeMoney = 200
			local prizeText = "Du erhaelst 200 $"
			if factionBlackListGuns[killerFaction] == weapon then
				prizeText = prizeText.." + 100 $ wegen der verwendeten Waffe."
				prizeMoney = prizeMoney + 100
			else
				prizeText = prizeText.."."
			end
			blacklistPlayers[killerFaction][name] = nil
			dbExec( handler, "REMOVE FROM blacklist WHERE Name LIKE ? AND Fraktion LIKE ?", name, killerFaction )
			givePlayerSaveMoney ( killer, prizeMoney )
			outputChatBox ( "Du wurdest von einem Fraktionsmitglied erledigt, weil du auf der Blacklist warst.", player, 200, 0, 0 )
			outputChatBox ( "Du hast jemanden von der Blacklist erledigt!", killer, 0, 200, 0 )
			outputChatBox ( prizeText, killer, 0, 200, 0 )
		end
	end
end

-- Delete old entrys --
local blackListCurTime = getSecTime ( 0 )

local function checkBlackListEntrys_DB ( qh ) 
	result = dbPoll( qh, 0 )
	if result and result[1] then
		blackListData = table.remove( result, 1 )
		mySQLBlackList ()
	end
end


function checkBlackListEntrys()
	dbQuery( checkBlackListEntrys_DB, handler, "SELECT * FROM blackListData" )
end
setTimer ( privVeh_spawning, 5000, 1 )

function mySQLBlackList ()

	local Name = blackListData["Name"]
	local Eintraeger = blackListData["Eintraeger"]
	local Fraktion = blackListData["Fraktion"]
	local Eintragungsdatum = blackListData["Eintragungsdatum"]
	
	if blackListCurTime - Eintragungsdatum > 7 * 24 * 60 * 60 then
		dbExec( handler, "REMOVE FROM blacklist WHERE Name LIKE ? AND Fraktion LIKE ?", Name, Fraktions )
	end
	
	blackListData = table.remove( result, 1 )
	if blackListData then
		mySQLBlackList ()
	end
end
checkBlackListEntrys()
-- Old entrys deleted --

function blacklist_func ( player, cmd, add, target, ... )

	if not add then
		infobox ( player, "\n\nGebrauch:\n/blacklist [add/delte\n/show] [Name]!", 5000, 125, 0, 0 )
	else
		if validBlackListFactions[vioGetElementData ( player, "fraktion" )] then
			if add == "add" then
				
				local parametersTable = {...}
				local text = table.concat( parametersTable, " " )
				
				if text == nil then
				
					outputChatBox ( "Gebrauch: /blacklist add Name Grund", player, 255, 0, 0 )
				
				else
			
					addBlacklist_func ( player, target, text )
					
				end
				
			elseif add == "delete" then
				blacklistdelete_func ( player, target )
			elseif add == "show" then
				showblacklist_func ( player )
			else
				infobox ( player, "\n\nGebrauch:\n/blacklist [add/delete\n/show] [Name]!", 5000, 125, 0, 0 )
			end
		else
			infobox ( player, "\n\nDu bist in\neiner ungueltigen\nFraktion!", 5000, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "blacklist", blacklist_func )

function blacklistdelete_func ( player, name )

	local name = getPlayerName ( getPlayerFromName ( name ) )
	if name then
		local fraktion = vioGetElementData ( player, "fraktion" )
		blacklistPlayers[fraktion][name] = nil
		dbExec( handler, "REMOVE FROM blacklist WHERE Name LIKE ? AND Fraktion LIKE ?", name, fraktion )
		outputChatBox ( "Der Spieler wurde von der Blacklist geloescht!", player, 0, 125, 0 )
	else
		outputChatBox ( "Der Spieler ist nicht auf der Blacklist!", player, 125, 0, 0 )
	end
end

function showblacklist_func ( player )

	local fraktion = vioGetElementData ( player, "fraktion" )
	if blacklistPlayers[fraktion] then
		outputChatBox ( "Spieler auf der Blacklist:", player, 200, 200, 0 )
		outputChatBox ( "__________________________", player, 200, 200, 0 )
		for key, index in pairs ( blacklistPlayers[fraktion] ) do
			if getPlayerName ( getPlayerFromName ( key ) ) then
				outputChatBox ( tostring( key )..": "..blacklistReason[fraktion][tostring(key)], player, 200, 200, 0 )
				outputChatBox ( "__________________________", player, 200, 200, 0 )
			else
				blacklistPlayers[fraktion][key] = nil
			end
		end
	else
		outputChatBox ( "Du bist in einer ungueltigen Fraktion!", player, 125, 0, 0 )
	end
end

function addBlacklist_func ( player, member, text )

	local pname = getPlayerName ( player )
	local target = getPlayerFromName ( member )
	local fraktion = vioGetElementData ( player, "fraktion" )
	if target then
		if vioGetElementData ( player, "rang" ) >= 3 then
			if isOnBlacklist ( member, fraktion ) then
				infobox ( player, "\n\nDer Spieler ist\nbereits auf\nder Blacklist!", 5000, 125, 0, 0 )
			else
				if vioGetElementData ( getPlayerFromName(member), "fraktion" ) ~= fraktion then
					if not playersAddetToBlacklist[vioGetElementData(player,"fraktion")][member] then
						playersAddetToBlacklist[vioGetElementData(player,"fraktion")][member] = true
						
						dbExec( handler, "INSERT INTO blacklist ( Name, Eintraeger, Fraktion, Grund, Eintragungsdatum ) VALUES ( ?, ?, ?, ?, '"..getSecTime ( 0 ).."' ) ", member, pname, fraktion, text )
						infobox ( player, "\n\nDu hast den\nSpieler auf die\nBlacklist gesetzt!", 5000, 125, 0, 0 )
						blacklistPlayers[fraktion][getPlayerName(getPlayerFromName(member))] = true
						blacklistReason[fraktion][getPlayerName(getPlayerFromName(member))] = text
					else
						infobox ( player, "\n\n\nDer Spieler war heute bereits auf der Blacklist deiner Fraktion!", 5000, 125, 0, 0 )
					end
				else
					infobox ( player, "\n\n\nDer Spieler ist\nin deiner Fraktion!", 5000, 125, 0, 0 )
				end
			end
		else
			infobox ( player, "\n\n\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
		end
	else
		infobox ( player, "\n\n\nDer Spieler ist\nnicht online!", 5000, 125, 0, 0 )
	end
end

function isOnBlacklist ( pname, fraktion )
	local result = dbPoll( dbQuery( handler, "SELECT Name FROM blacklist WHERE Name LIKE ? AND Fraktion LIKE ?", pname, fraktion ), -1 )
	return result ~= nil and result[1] ~= nil
end

function getBlacklistGrund ( pname, fraktion )

	local ress = dbPoll( dbQuery( handler, "SELECT Grund FROM blacklist WHERE Name LIKE ? AND Fraktion LIKE ?", pname, fraktion ), -1 ) 
	
	return ress and ress[1] and ress[1]["Grund"] or "-"
	
end