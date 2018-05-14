local deletedPrestige = 0

function createPrestigeObjects ()
	local result = dbPoll( dbQuery( handler, "SELECT * FROM prestige" ), -1 )
	if result and result[1] then
		local length = #result
		for i=1, length do 
			local id = result[i]["ID"]
			local x, y, z = result[i]["X"], result[i]["Y"], result[i]["Z"]
			local besitzer = result[i]["Besitzer"]
			local preis = result[i]["Preis"]

			_G["prestige"..id] = createPickup ( x, y, z, 3, 1239, 1000 )
		
			addEventHandler ( "onPickupHit", _G["prestige"..id], prestigePickupHit )
			
			local pickup = _G["prestige"..id]
			
			vioSetElementData ( pickup, "besitzer", besitzer )
			vioSetElementData ( pickup, "preis", preis )
			vioSetElementData ( pickup, "id", id )
		end
		outputServerLog ( "Es wurden ".. length .." prestige Objekte gefunden und "..deletedPrestige.." Besitzer enteignet." )
	end	
end

function prestigePickupHit ( player )

	local besitzer = vioGetElementData ( source, "besitzer" )
	local preis = vioGetElementData ( source, "preis" )
	vioSetElementData ( player, "lastPrestigePickup", source )
	if besitzer == "" then 
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Dieses Objekt steht\nzum Verkauf, Kosten:\n"..preis.."\nTippe /buyprestige,\num es zu erwerben.", 7500, 200, 200, 0 )
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Dieses Objekt gehoert:\n"..besitzer, 7500, 200, 200, 0 )
	end
end


local function buyprestige_func_DB ( qh, player, pickup, pname ) 
	local result = dbPoll ( qh, 0 )
	if not result or result[1] then
		local isOwning = false
		for i = 1, totalPrestigeObjects do
			if vioGetElementData ( _G["prestige"..i], "besitzer" ) == pname then
				isOwning = true
				break
			end
		end
		if not isOwning then
			local preis = tonumber ( vioGetElementData ( pickup, "preis" ) )
			local money = tonumber ( vioGetElementData ( player, "money" ) )
			local id = vioGetElementData ( pickup, "id" )
			if money >= preis then
				vioSetElementData ( player, "money", money - preis )
				outputChatBox ( "Herzlichen Glueckwunsch, du hast dieses Objekt erworben!", player, 0, 125, 0 )

				dbExec( handler, "UPDATE prestige SET Besitzer = ? WHERE ID LIKE ?", pname, id )
				
				vioSetElementData ( pickup, "besitzer", pname )
			else
				outputChatBox ( "Du hast nicht genug Geld - dieses Objekt kostet "..preis.." $!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Du kannst nur ein Prestigeobjekt besitzen!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Du bietest bereits auf ein Prestige-Object!", player, 125, 0, 0 )
	end
end

function buyprestige_func ( player )

	local pickup = vioGetElementData ( player, "lastPrestigePickup" )
	if pickup then
		local pname = getPlayerName ( player )
		if vioGetElementData ( pickup, "besitzer" ) == "" then
			dbQuery( buyprestige_func_DB, { player, pickup, pname }, handler, "SELECT true FROM buyit WHERE Hoechstbietender LIKE ? AND Typ LIKE 'Prestige'", pname )
		else
			outputChatBox ( "Dieses Objekt steht nicht zum Verkauf!", player, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "buyprestige", buyprestige_func )


local function sellprestige_func_DB2 ( qh, result, player ) 
	local buyitresult = dbPoll( qh, 0 )
	if not buyitresult or not buyitresult[1] then
		local price = tonumber ( result[1]["Preis"] )
		vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + price )
		outputChatBox ( "Du hast dein Prestige-Objekt verkauft und erhaelst "..price.." $!", player, 0, 125, 0 )
		dbExec( handler, "UPDATE prestige SET Besitzer=? WHERE Besitzer LIKE ?", "", getPlayerName( player ) )
		
		for i = 1, totalPrestigeObjects do
			if vioGetElementData ( _G["prestige"..i], "besitzer" ) == getPlayerName ( player ) then
				vioSetElementData ( _G["prestige"..i], "besitzer", "" )
			end
		end
	else
		outputChatBox ( "Dein Prestige-Objekt wird momentan versteigert!", player, 125, 0, 0 )
	end
end

local function sellprestige_func_DB1 ( qh, player ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		dbQuery( sellprestige_func_DB2, { result, player }, handler, "SELECT Anbieter FROM buyit WHERE Anbieter LIKE ? AND Typ LIKE 'Prestige'", pname )
	else
		outputChatBox ( "Dir gehoert kein Prestige-Objekt!", player, 125, 0, 0 )
	end
end

function sellprestige_func ( player )
	dbQuery( sellprestige_func_DB1, { player }, handler, "SELECT Preis FROM prestige WHERE Besitzer LIKE ?", getPlayerName( player ) )
end
addCommandHandler ( "sellprestige", sellprestige_func )