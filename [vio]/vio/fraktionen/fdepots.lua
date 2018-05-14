MafiaLager = createObject ( 3577, -665.37, 940.46, 11.91 )
MafiaCasinoLager = createObject ( 3577, 2170.7622070313, 1611.3020019531, 999.755859375 )
setElementInterior ( MafiaCasinoLager, 1 )
TriadenLager = createObject ( 3577, -2173.9677734375, 633.51196289063, 49.15699005127 )
TriadenCasinoLager = createObject ( 3577, 1911.3869628906, 970.30993652344, 10.602819442749, 0, 0, 0 )

ReporterLager = createObject ( 3577, -2538.8376464844, -628.8955078125, 147.63659667969 )
TerrorLager = createObject ( 3577, -1973.3395996094, -1586.1295166016, 87.407867431641 )
AztecasLager = createObject ( 3577, -761.84, 2414.05, 156.79, 0, 0, 0 )
BikerLager = createObject ( 3577, 2472.2983398438, 1535.1948242188, 10.549208641052, 0, 0, 0 )

depots = { [MafiaCasinoLager]=true, [TriadenCasinoLager]=true, [MafiaLager]=true, [TriadenLager]=true, [ReporterLager]=true, [TerrorLager]=true, [AztecasLager]=true, [BikerLager]=true }

depotFactions = { [2]=true, [3]=true, [4]=true, [5]=true, [7]=true, [9]=true }
factionDepotData = {}
	factionDepotData["money"] = {}
	factionDepotData["drugs"] = {}
	factionDepotData["mats"] = {}


local function depotLoad_DB ( qh ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		for i=1, #result do
			local ID = result[i]["ID"]
			if factionDepotData["money"][ID] then
				factionDepotData["money"][key] = tonumber ( result[i]["DepotGeld"] )
				factionDepotData["drugs"][key] = tonumber ( result[i]["DepotDrogen"] )
				factionDepotData["mats"][key]  = tonumber ( result[i]["DepotMaterials"] )
			end
		end
	end
end

function depotLoad ()
	dbQuery( depotLoad_DB, handler, "SELECT * FROM fraktionen" )
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), depotLoad )
setTimer ( depotLoad, 60000, 1 )


local function fDepotServer_func_DB ( qh, player, take, money, drugs, mats, fraktion )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		factionDepotData["money"][fraktion] = tonumber ( result[1]["DepotGeld"] )
		factionDepotData["drugs"][fraktion] = tonumber ( result[1]["DepotDrogen"] )
		factionDepotData["mats"][fraktion]  = tonumber ( result[1]["DepotMaterials"] )

		local pmoney = tonumber ( vioGetElementData ( player, "money" ) )
		local pdrugs = tonumber ( vioGetElementData ( player, "drugs" ) )
		local pmats = tonumber ( vioGetElementData ( player, "mats" ) )
		local money = math.floor ( math.abs ( tonumber ( money ) ) )
		local drugs = math.floor ( math.abs ( tonumber ( drugs ) ) )
		local mats = math.floor ( math.abs ( tonumber ( mats ) ) )
		if take then
			if money > 0 and tonumber ( vioGetElementData ( player, "rang" ) ) < 4 then
				outputChatBox ( "Du darfst noch kein Geld entnehmen!", player, 125, 0, 0 )
				return nil
			end
			if drugs > 0 and tonumber ( vioGetElementData ( player, "rang" ) ) < 2 then
				outputChatBox ( "Du darfst noch keine Drogen entnehmen!", player, 125, 0, 0 )
				return nil
			end
			if mats > 0 and tonumber ( vioGetElementData ( player, "rang" ) ) < 3 then
				outputChatBox ( "Du darfst noch keine Materialien entnehmen!", player, 125, 0, 0 )
				return nil
			end
				if factionDepotData["money"][fraktion] < money then
					outputChatBox ( "In der Fraktionskasse ist nicht genug Geld!", player, 125, 0, 0 )
				elseif factionDepotData["drugs"][fraktion] < drugs then
					outputChatBox ( "In der Fraktionskasse sind nicht genug Drogen!", player, 125, 0, 0 )
				elseif factionDepotData["mats"][fraktion] < mats then
					outputChatBox ( "In der Fraktionskasse sind nicht genug Materialien!", player, 125, 0, 0 )
				else
					local msg = getPlayerName(player).." hat "..money.." $, "..drugs.." Gramm Drogen und "..mats.." Materialien aus dem Depot genommen."
					outputLog ( msg, "fkasse" )
					--sendMSGForFaction ( msg, tonumber(vioGetElementData ( player, "fraktion" )) )
					outputDebugString ( msg )
					vioSetElementData ( player, "money", pmoney + money )
					givePlayerMoney ( player, money )
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
					vioSetElementData ( player, "drugs", pdrugs + drugs )
					vioSetElementData ( player, "mats", pmats + mats )
					factionDepotData["money"][fraktion] = factionDepotData["money"][fraktion] - money
					factionDepotData["drugs"][fraktion] = factionDepotData["drugs"][fraktion] - drugs
					factionDepotData["mats"][fraktion] = factionDepotData["mats"][fraktion] - mats
					dbExec( handler, "UPDATE fraktionen SET DepotGeld=?, DepotDrogen=?, DepotMaterials=? WHERE ID = ?", factionDepotData["money"][fraktion], factionDepotData["drugs"][fraktion], factionDepotData["mats"][fraktion], fraktion )
					triggerClientEvent ( player, "showFDepot", getRootElement(), factionDepotData["money"][fraktion], factionDepotData["mats"][fraktion], factionDepotData["drugs"][fraktion] )
				end
		else
			if money > pmoney then
				outputChatBox ( "Du hast nicht genug Geld dafuer!", player, 125, 0, 0 )
			elseif drugs > pdrugs then
				outputChatBox ( "Du hast nicht genug Drogen dafuer!", player, 125, 0, 0 )
			elseif mats > pmats then
				outputChatBox ( "Du hast nicht genug Materialen dafuer!", player, 125, 0, 0 )
			else
				vioSetElementData ( player, "money", pmoney - money )
				takePlayerMoney ( player, money )
				triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				vioSetElementData ( player, "drugs", pdrugs - drugs )
				vioSetElementData ( player, "mats", pmats - mats )
				factionDepotData["money"][fraktion] = factionDepotData["money"][fraktion] + money
				factionDepotData["drugs"][fraktion] = factionDepotData["drugs"][fraktion] + drugs
				factionDepotData["mats"][fraktion] = factionDepotData["mats"][fraktion] + mats
				local msg = getPlayerName(player).." hat "..money.." $, "..drugs.." Gramm Drogen und "..mats.." Materialien in das Depot gelegt."
				outputLog ( msg, "fkasse" )
				--sendMSGForFaction ( msg, tonumber(vioGetElementData ( player, "fraktion" )) )
				outputDebugString ( msg )
				dbExec( handler, "UPDATE fraktionen SET DepotGeld=?, DepotDrogen=?, DepotMaterials=? WHERE ID = ?", factionDepotData["money"][fraktion], factionDepotData["drugs"][fraktion], factionDepotData["mats"][fraktion], fraktion )
				triggerClientEvent ( player, "showFDepot", getRootElement(), factionDepotData["money"][fraktion],  factionDepotData["mats"][fraktion], factionDepotData["drugs"][fraktion] )
			end
		end
	end
end 

function fDepotServer_func ( player, take, money, drugs, mats )

	if player == client then
		local fraktion = vioGetElementData ( player, "fraktion" )
		if depotFactions[fraktion] then
			if tonumber ( money ) and tonumber ( drugs ) and tonumber ( mats ) and tonumber ( money ) + tonumber ( drugs ) + tonumber ( mats ) > 0 then
				dbQuery( fDepotServer_func_DB, { player, take, money, drugs, mats, fraktion }, handler, "SELECT * FROM fraktionen WHERE ID = ?", fraktion )
			else
				outputChatBox ( "Ungueltige Eingabe!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Du bist in einer ungueltigen Fraktion!", player, 125, 0, 0 )
		end
	end
end
addEvent ( "fDepotServer", true )
addEventHandler ( "fDepotServer", getRootElement(), fDepotServer_func )