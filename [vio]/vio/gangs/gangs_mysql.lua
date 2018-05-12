addEvent ( "onVioPlayerLogin", true )
addEvent ( "onLoggedInPlayerQuit", true )

gangData = {}
	gangData["ranks"] = {}

function loadGangData ( gangID )

	local gangDataDSatz
	local house = houses["pickup"][gangID]
	local gangDataResult = mysql_query ( handler, "SELECT * from gang_basic WHERE HausID LIKE '"..gangID.."'" )
	if gangDataResult then
		if ( mysql_num_rows ( gangDataResult ) > 0 ) then
			gangDataDSatz = mysql_fetch_assoc ( gangDataResult )
			mysql_free_result ( gangDataResult )
			
			gangData[gangID] = {}
				gangData[gangID]["members"] = {}
					gangData[gangID]["members"]["online"] = {}
				gangData[gangID]["msg"] = MySQL_GetString ( "gang_basic", "LeaderMSG", "HausID LIKE '"..gangID.."'" )
			
			refreshGangRanks ( gangID )
			vioSetElementData ( house, "gangHQOf", getGangName ( gangID ) )
			return nil
		end
	end
	vioSetElementData ( house, "gangHQOf", false )
end

function setGangMSG ( id, msg )

	MySQL_SetString ( "gang_basic", "LeaderMSG", msg, "HausID LIKE '"..id.."'" )
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
		return MySQL_DatasetExist ( "gang_members", "Name LIKE '"..player.."' AND Gang LIKE '"..gangFounderID.."' AND Founder = '1'" )
	end
	gangFounderID = nil
	return false
end

function playerLoginGangMembers ()

	local player = source
	local gang = getPlayerGang ( player )
	if gang then
		if gang > 0 then
			local pname = getPlayerName ( player )
			gangData[gang]["members"]["online"][player] = true
			gangData["ranks"][player] = tonumber ( MySQL_GetString ( "gang_members", "Rang", "Name LIKE '"..pname.."'" ) )
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

	return tonumber ( MySQL_GetString ( "gang_basic", "MaxMembers", "HausID LIKE '"..id.."'" ) )
end

function getGangMoney ( id )

	return tonumber ( MySQL_GetString ( "houses", "Kasse", "ID LIKE '"..id.."'" ) )
end

function setGangMoney ( id, amount )

	MySQL_SetString ( "houses", "Kasse", amount, "ID LIKE '"..id.."'" )
end

function gangVehicleCost ( id )

	return 0
end

function getGangMats ( id )

	return tonumber ( MySQL_GetString ( "gang_basic", "Mats", "HausID LIKE '"..id.."'" ) )
end

function setGangMats ( id, amount )

	MySQL_SetString ( "gang_basic", "Mats", amount, "HausID LIKE '"..id.."'" )
end

function getGangDrugs ( id )

	return tonumber ( MySQL_GetString ( "gang_basic", "Drugs", "HausID LIKE '"..id.."'" ) )
end

function setGangDrugs ( id, amount )

	MySQL_SetString ( "gang_basic", "Drugs", amount, "HausID LIKE '"..id.."'" )
end

function getMembersInGangCount ( id )

	local result = mysql_query ( handler, "SELECT * FROM gang_members WHERE Gang LIKE '"..id.."'" )
	local num = mysql_num_rows ( result )
	mysql_free_result ( result )
	return tonumber ( num )
end

function getGangVehicleCost ( id )

	return 999
end

function getGangMembersString ( id )

	local string = ";"
	local i = 0
	local result = mysql_query ( handler, "SELECT * FROM gang_members WHERE Gang LIKE '"..id.."'" )
	local num = mysql_num_rows ( result )
	if num > 0 then
		dsatz = mysql_fetch_assoc ( result )
		while dsatz do
			i = i + 1
			string = string..dsatz["Name"].."|"..dsatz["Rang"]..";"
			dsatz = mysql_fetch_assoc ( result )
		end
	end
	mysql_free_result ( result )
	return string, i
end

function getGangName ( id )

	return MySQL_GetString ( "gang_basic", "Name", "HausID LIKE '"..id.."'" )
end

function removePlayerFromGang ( pname )

	if isElement ( pname ) then
		pname = getPlayerName ( pname )
	end
	if getPlayerFromName ( pname ) then
		gangData[getPlayerGang ( pname )]["members"]["online"][getPlayerFromName ( pname )] = false
		gangData["ranks"][getPlayerFromName ( pname )] = 0
	end
	mysql_vio_query ( "DELETE FROM gang_members WHERE Name LIKE '"..MySQL_Save ( pname ).."'" )
end

function getPlayerGang ( pname )

	if isElement ( pname ) then
		pname = getPlayerName ( pname )
	end
	return tonumber ( MySQL_GetString ( "gang_members", "Gang", "Name LIKE '"..pname.."'" ) )
end

function isInGang ( pname, id )

	if isElement ( pname ) then
		pname = getPlayerName ( pname )
	end
	if not id then
		return MySQL_DatasetExist ( "gang_members", "Name LIKE '"..pname.."'" )
	else
		return MySQL_DatasetExist ( "gang_members", "Name LIKE '"..pname.."' AND Gang LIKE '"..id.."'" )
	end
end

function getPlayerGangRank ( player )

	if player then
		return gangData["ranks"][player]
	else
		return tonumber ( MySQL_GetString ( "gang_members", "Rang", "Name LIKE '"..getPlayerName(player).."'" ) )
	end
end

function setPlayerGangRank ( pname, newRank )

	if isElement ( pname ) then
		pname = getPlayerName ( pname )
	end
	MySQL_SetString ( "gang_members", "Rang", newRank, "Name LIKE '"..pname.."'" )
	local player = getPlayerFromName ( pname )
	if player then
		gangData["ranks"][player] = newRank
		infobox ( "Dir wurde Rang\n"..newRank.." zugewiesen.", player, 125, 0, 0 )
	end
	return true
end

function refreshGangRanks ( gangID )

	local gDsatz
	local gResult = mysql_query ( handler, "SELECT * from gang_basic WHERE HausID LIKE '"..gangID.."'" )
	if gResult then
		if ( mysql_num_rows ( gResult ) > 0 ) then
			gDsatz = mysql_fetch_assoc ( gResult )
			mysql_free_result ( gResult )
			
			local rang1 = gDsatz["Rang1"]
			local rang2 = gDsatz["Rang2"]
			local rang3 = gDsatz["Rang3"]
			
			gangData[gangID]["ranks"] = {}
			
			gangData[gangID]["ranks"][1] = rang1
			gangData[gangID]["ranks"][2] = rang2
			gangData[gangID]["ranks"][3] = rang3
		end
	end
end

function getGangRankName ( id, rank )

	return gangData[id]["ranks"][rank]
end

function setGangRankName ( id, rank, string )

	string = MySQL_Save ( string )
	gangData[id]["ranks"][rank] = string
	mysql_vio_query ( "UPDATE gang_basic SET Rang"..rank.." = '"..string.."' WHERE HausID LIKE '"..id.."'" )
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
	mysql_vio_query ( "INSERT INTO gang_members ( Name, Gang, Rang ) VALUES ( '"..pname.."', '"..id.."', '"..rank.."' )" )
	if founder then
		mysql_vio_query ( "UPDATE gang_members SET Founder = '1' WHERE Name LIKE '"..pname.."'" )
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
	return tonumber ( MySQL_GetString ( "gang_members", "Rang", "Name LIKE '"..pname.."'" ) )
end

function sendMessageToGangMembers ( id, msg )

	for key, index in pairs ( gangData[id]["members"]["online"] ) do
		if isElement ( key ) then
			outputChatBox ( msg, key, 200, 200, 0 )
		end
	end
end

function createNewGang ( name, leaderSkin, houseID )

	mysql_vio_query ( "INSERT INTO gang_basic ( Name, LeaderMSG, HausID ) VALUES ( '"..name.."', 'Gang wurde gegruendet.', '"..houseID.."' )" )
	loadGangData ( houseID )
end

function getGangFromName ( name )

	return tonumber ( MySQL_GetString ( "gang_basic", "HausID", "Name LIKE '"..name.."'" ) )
end

function setGangName ( id, name )

	MySQL_SetString ( "gang_basic", "Name", name, "HausID LIKE '"..id.."'" )
	vioSetElementData ( _G["HouseNR"..id], "gangHQOf", name )
end

function deleteGang ( id )

	sendMessageToGangMembers ( id, "Deine Gang wurde aufgeloest." )
	mysql_vio_query ( "DELETE FROM gang_basic WHERE HausID LIKE '"..id.."'" )
	mysql_vio_query ( "DELETE FROM gang_members WHERE Gang LIKE '"..id.."'" )
	mysql_vio_query ( "DELETE FROM gang_vehicles WHERE GangID LIKE '"..id.."'" )
	for key, index in pairs ( gangData[id]["members"]["online"] ) do
		if isElement ( key ) then
			gangData["ranks"][key] = nil
		end
	end
	gangData[id] = nil
	vioSetElementData ( _G["HouseNR"..id], "gangHQOf", false )
end