addEvent ( "onVioPlayerLogin", true )
addEvent ( "onLoggedInPlayerQuit", true )

gangData = {}
	gangData["ranks"] = {}


local function loadGangData_DB ( qh, gangID, house )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		gangData[gangID] = {}
			gangData[gangID]["members"] = {}
				gangData[gangID]["members"]["online"] = {}
			gangData[gangID]["msg"] = result[1]["LeaderMSG"]
		
		refreshGangRanks ( gangID )
		vioSetElementData ( house, "gangHQOf", getGangName ( gangID ) )
	else 
		vioSetElementData ( house, "gangHQOf", false )
	end
end

function loadGangData ( gangID )
	local house = houses["pickup"][gangID]
	dbQuery ( loadGangData_DB, { gangID, house }, handler, "SELECT * from gang_basic WHERE HausID LIKE ?", gangID )	
end

function setGangMSG ( id, msg )

	dbExec( handler, "UPDATE gang_basic SET LeaderMSG = ? WHERE HausID LIKE ?", msg, id )
	gangData[id]["msg"] = msg
end

function getGangMSG ( id )

	return gangData[id]["msg"]
end

function isFounderOfGang ( player, gangFounderID )

	if not isElement ( player ) then
		if getPlayerFromName ( player ) then
			player = getPlayerFromName ( player )
		end
	end
	if isElement ( player ) then
		if gangFounderID then
			if getPlayerGangRank ( player ) >= 3 and gangFounderID == vioGetElementData ( player, "housekey" ) then
				return true
			end
		elseif getPlayerGangRank ( player ) >= 3 and getPlayerGang ( player ) == vioGetElementData ( player, "housekey" ) then
			return true
		end
	else
		return MySQL_DatasetExist ( "gang_members", dbPrepareString( handler, "Name LIKE ? AND Gang LIKE ? AND Founder = '1'", player, gangFounderID ) )
	end
	gangFounderID = nil
	return false
end


local function playerLoginGangMembers_DB( qh, player, pname )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		gangData["ranks"][player] = tonumber ( result[1]["Rang"] )
	end
end

function playerLoginGangMembers ()

	local player = source
	local gang = getPlayerGang ( player )
	if gang then
		if gang > 0 then
			local pname = getPlayerName ( player )
			gangData[gang]["members"]["online"][player] = true
			dbQuery( playerLoginGangMembers_DB, { player, pname }, handler, "SELECT Rang FROM gang_members WHERE Name LIKE ?", pname )
		end
	end
end
addEventHandler ( "onVioPlayerLogin", getRootElement(), playerLoginGangMembers )

function isGang ( id )

	if gangData[id] then
		return true
	else
		return false
	end
end

function playerDisconnectGangMembers ()

	local player = source
	local gang = getPlayerGang ( player )
	if gang then
		if gang > 0 then
			gangData[gang]["members"]["online"][player] = nil
			gangData["ranks"][player] = nil
		end
	end
end
addEventHandler ( "onLoggedInPlayerQuit", getRootElement(), playerDisconnectGangMembers )

function getGangMSG ( id )

	return gangData[id]["msg"]
end

function getGangMaxMembers ( id )

	return tonumber ( MySQL_GetString ( "gang_basic", "MaxMembers", dbPrepareString( handler, "HausID LIKE ?", id ) ) )
end

function getGangMoney ( id )

	return tonumber ( MySQL_GetString ( "houses", "Kasse", dbPrepareString( handler, "ID LIKE ?", id ) ) )
end

function setGangMoney ( id, amount )

	MySQL_SetString ( "houses", "Kasse", amount, dbPrepareString( handler, "ID LIKE ?", id ) )
end

function gangVehicleCost ( id )

	return 0
end

function getGangMats ( id )

	return tonumber ( MySQL_GetString ( "gang_basic", "Mats", dbPrepareString( handler, "HausID LIKE ?", id ) ) )
end

function setGangMats ( id, amount )

	MySQL_SetString ( "gang_basic", "Mats", amount, dbPrepareString( handler, "HausID LIKE ?", id ) )
end

function getGangDrugs ( id )

	return tonumber ( MySQL_GetString ( "gang_basic", "Drugs", dbPrepareString( handler, "HausID LIKE ?", id ) ) )
end

function setGangDrugs ( id, amount )

	MySQL_SetString ( "gang_basic", "Drugs", amount, dbPrepareString( handler, "HausID LIKE ?", id ) )
end

function getMembersInGangCount ( id )
	local result = dbPoll( dbQuery( handler, "SELECT * FROM gang_members WHERE Gang LIKE '"..id.."'" ), -1 )
	return result and #result or 0
end

function getGangVehicleCost ( id )

	return 999
end

function getGangMembersString ( id )

	local string = ";"
	local i = 0
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM gang_members WHERE Gang LIKE ?", id ), -1 )
	local num = #result
	if num > 0 then
		dsatz = table.remove( result, 1 )
		while dsatz do
			i = i + 1
			string = string..dsatz["Name"].."|"..dsatz["Rang"]..";"
			dsatz = table.remove( result, 1 )
		end
	end
	return string, i
end

function getGangName ( id )

	return MySQL_GetString ( "gang_basic", "Name", dbPrepareString( handler, "HausID LIKE ?", id ) )
end

function removePlayerFromGang ( pname )

	if isElement ( pname ) then
		pname = getPlayerName ( pname )
	end
	if getPlayerFromName ( pname ) then
		gangData[getPlayerGang ( pname )]["members"]["online"][getPlayerFromName ( pname )] = false
		gangData["ranks"][getPlayerFromName ( pname )] = 0
	end
	dbExec( handler, "DELETE FROM gang_members WHERE Name LIKE ?", pname )
end

function getPlayerGang ( pname )

	if isElement ( pname ) then
		pname = getPlayerName ( pname )
	end
	return tonumber ( MySQL_GetString ( "gang_members", "Gang", dbPrepareString( handler, "Name LIKE ?", pname ) ) )
end

function isInGang ( pname, id )

	if isElement ( pname ) then
		pname = getPlayerName ( pname )
	end
	if not id then
		return MySQL_DatasetExist ( "gang_members", dbPrepareString( handler, "Name LIKE ?", pname ) )
	else
		return MySQL_DatasetExist ( "gang_members", dbPrepareString( handler, "Name LIKE ? AND Gang LIKE ?", pname, id ) )
	end
end

function getPlayerGangRank ( player )

	if player then
		return gangData["ranks"][player]
	else
		return tonumber ( MySQL_GetString ( "gang_members", "Rang", dbPrepareString( handler, "Name LIKE ?", getPlayerName( player ) ) ) )
	end
end

function setPlayerGangRank ( pname, newRank )

	if isElement ( pname ) then
		pname = getPlayerName ( pname )
	end
	MySQL_SetString ( "gang_members", "Rang", newRank, dbPrepareString( handler, "Name LIKE ?", pname ) )
	local player = getPlayerFromName ( pname )
	if player then
		gangData["ranks"][player] = newRank
		infobox ( "Dir wurde Rang\n"..newRank.." zugewiesen.", player, 125, 0, 0 )
	end
	return true
end


local function refreshGangRanks_DB ( qh, gangID )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local gDsatz = result[1] 
		
		local rang1 = gDsatz["Rang1"]
		local rang2 = gDsatz["Rang2"]
		local rang3 = gDsatz["Rang3"]
		
		gangData[gangID]["ranks"] = {}
		
		gangData[gangID]["ranks"][1] = rang1
		gangData[gangID]["ranks"][2] = rang2
		gangData[gangID]["ranks"][3] = rang3
	end
end

function refreshGangRanks ( gangID )
	dbQuery( refreshGangRanks_DB, { gangID }, handler, "SELECT * FROM gang_basic WHERE HausID LIKE ?", gangID )
end

function getGangRankName ( id, rank )

	return gangData[id]["ranks"][rank]
end

function setGangRankName ( id, rank, string )

	gangData[id]["ranks"][rank] = string
	dbExec( handler,"UPDATE gang_basic SET ?? = ? WHERE HausID LIKE ?", "Rang"..rank, string, id )
	refreshGangRanks ( id )
end

function insertInGang ( pname, id, rank, founder )

	if not rank then
		rank = 1
	end
	if isElement ( pname ) then
		pname = getPlayerName ( pname )
	end
	if getPlayerFromName ( pname ) then
		gangData[id]["members"]["online"][getPlayerFromName ( pname )] = true
	end
	dbExec( handler, "INSERT INTO gang_members ( Name, Gang, Rang ) VALUES ( ?, ?, ? )", pname, id, rank )
	if founder then
		dbExec( handler, "UPDATE gang_members SET Founder = '1' WHERE Name LIKE ?", pname )
	end
end

function getPlayerRankNameInGang ( player )

	local gang = getPlayerGang ( player )
	return gangData[gang]["ranks"][getPlayerRankInGang ( player )]
	
end

function getPlayerRankInGang ( pname )

	if isElement ( pname ) then
		pname = getPlayerName ( pname )
	end
	return tonumber ( MySQL_GetString ( "gang_members", "Rang", dbPrepareString( handler, "Name LIKE ?", pname ) ) )
end

function sendMessageToGangMembers ( id, msg )

	for key, index in pairs ( gangData[id]["members"]["online"] ) do
		if isElement ( key ) then
			outputChatBox ( msg, key, 200, 200, 0 )
		end
	end
end

function createNewGang ( name, leaderSkin, houseID )

	dbExec( handler, "INSERT INTO gang_basic ( Name, LeaderMSG, HausID ) VALUES ( ?, 'Gang wurde gegruendet.', ? )", name, houseID )
	loadGangData ( houseID )
end

function getGangFromName ( name )

	return tonumber ( MySQL_GetString ( "gang_basic", "HausID", dbPrepareString( handler, "Name LIKE ?", name ) ) )
end

function setGangName ( id, name )

	MySQL_SetString ( "gang_basic", "Name", name, "HausID LIKE '"..id.."'" )
	vioSetElementData ( _G["HouseNR"..id], "gangHQOf", name )
end

function deleteGang ( id )

	sendMessageToGangMembers ( id, "Deine Gang wurde aufgeloest." )
	for key, index in pairs ( gangData[id]["members"]["online"] ) do
		if isElement ( key ) then
			gangData["ranks"][key] = nil
		end
	end
	dbExec( handler, "DELETE FROM gang_basic WHERE HausID LIKE '"..id.."'" )
	dbExec( handler, "DELETE FROM gang_members WHERE Gang LIKE '"..id.."'" )
	dbExec( handler, "DELETE FROM gang_vehicles WHERE GangID LIKE '"..id.."'" )
	gangData[id] = nil
	vioSetElementData ( _G["HouseNR"..id], "gangHQOf", false )
end