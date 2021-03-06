﻿local function createHouse_DB ( qh, player, Preis, Mindestzeit, CurrentInterior )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local ID = tonumber( result[1]["theID"] )
		local SymbolX, SymbolY, SymbolZ = getElementPosition ( player )
		local Besitzer = "none"
		local result = dbExec(handler, "INSERT INTO houses (ID, SymbolX, SymbolY, SymbolZ, Besitzer, Preis, Mindestzeit, CurrentInterior, Kasse, Miete) VALUES (?, '"..SymbolX.."', '"..SymbolY.."', '"..SymbolZ.."', ?, '"..Preis.."', '"..Mindestzeit.."', '"..CurrentInterior.."', '0', '0')", ID, Besitzer )
		if( not result) then
			outputDebugString("Error executing the query at createHouse_DB")
		else
			outputDebugString ("Haus ID "..i.." wurden angelegt!")
			outputChatBox ( "Haus angelegt!", player, 200, 200, 0 )
			createHouse ( ID, SymbolX, SymbolY, SymbolZ, Besitzer, Preis, Mindestzeit, CurrentInterior, 0, 0 )
		end
	end
end


function createHouse ( player, cmd, preis, playtime, int )
	if playtime ~= nil then local playtime = playtime*60 end   -- von Bonus: Hier ist ein Bug! --
	local Preis = tonumber ( math.abs ( preis ) )
	local Mindestzeit = tonumber ( playtime )
	local CurrentInterior = tonumber ( int )
	if vioGetElementData ( player, "adminlvl" ) >= 3 then
		if Preis > 10000 and Mindestzeit > 10 and CurrentInterior ~= nil then
			dbQuery( createHouse_DB, { player, Preis, Mindestzeit, CurrentInterior }, handler, "SELECT MIN(t1.ID + 1) AS theID FROM houses t1 LEFT JOIN houses t2 ON t1.ID + 1 = t2.ID WHERE t2.ID IS NULL" )
		else
			outputChatBox ( "Gebrauch: /newhouse [Preis] [Mind. Spielzeit in Stunden] [Interior ( iraum [1-30] )]", player )
		end
	end
end
addCommandHandler ( "newhouse", createHouse )

function iraeume ( player, cmd, i )

	if vioGetElementData ( player, "adminlvl" ) >= 1 then
		local int, intx, inty, intz = getInteriorData ( i )
		setElementInterior ( player, int, intx, inty, intz )
	end
end
addCommandHandler ( "iraum", iraeume )

function in_func ( player )

	local house = vioGetElementData ( player, "house" )
	local px, py, pz = getElementPosition ( player )
	local hx, hy, hz = getElementPosition ( house )
	if getDistanceBetweenPoints3D ( px, py, pz, hx, hy, hz ) <= 5 then
		if ( getElementModel ( house ) == 1273 or getElementModel ( house ) == 1272 ) and vioGetElementData ( house, "curint" ) > 0 then
			if not vioGetElementData ( house, "locked" ) or math.abs ( vioGetElementData ( player, "housekey" ) ) == vioGetElementData ( house, "id" ) or vioGetElementData ( house, "id" ) == getPlayerGang ( player ) then
				local i = vioGetElementData ( house, "curint" )
				vioSetElementData ( player, "curIntIn", i )
				local int, intx, inty, intz = getInteriorData ( i )
				local dim = vioGetElementData ( house, "id" )
				if i == 0 then
					dim = 0
				end
				setElementDimension ( player, dim )
				fadeElementInterior ( player, int, intx, inty, intz )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Tippe /out, um\ndas Haus zu\nverlassen und\ndruecke F2, um\ndas Hausmenue zu\noeffnen.", 7500, 125, 0, 0 )
				bindKey ( player, "F2", "down", house_func )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nEs ist abgeschlossen!", 7500, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bei\nkeinem Haus!", 7500, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bei\nkeinem Haus!", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "in", in_func )

function out_func ( player )

	local dim = getElementDimension ( player )
	local haus = vioGetElementData ( player, "house" )
	if not isElement ( haus ) then
		haus = houses["pickup"][getElementDimension ( player )]
	end
	if isElement ( haus ) then
		local i = vioGetElementData ( haus, "curint" )
		local int, intx, inty, intz = getInteriorData ( i )
		local px, py, pz = getElementPosition ( player )
		if getDistanceBetweenPoints3D ( px, py, pz, intx, inty, intz ) <= 10 then
			vioGetElementData ( player, "curIntIn", 0 )
			local dim = getElementDimension ( player )
			local sx, sy, sz = getElementPosition ( haus )
			fadeElementInterior ( player, 0, sx, sy, sz )
			setElementDimension ( player, 0 )
			unbindKey ( player, "F2", "down", house_func )
		end
	else
		outputChatBox ( "Du bist in keinem Haus!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "out", out_func )


local function rent_func_DB ( qh, hause, miete )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		kasse = tonumber( result[1]["Kasse"] )
		dbExec( handler, "UPDATE houses SET Kasse = Kasse + ? WHERE ID LIKE ?", miete, vioGetElementData( haus, "id" ) )
		vioSetElementData ( haus, "kasse", kasse + miete )
	end
end

function rent_func ( player )

	local haus = vioGetElementData ( player, "house" )
	local x1, y1, z1 = getElementPosition ( player )
	local x2, y2, z2 = getElementPosition ( haus )
	local pname = getPlayerName ( player )
	local distance = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 )
	local miete = tonumber ( vioGetElementData ( haus, "miete" ) )
	local kasse = tonumber ( vioGetElementData ( haus, "kasse" ) )
	if distance < 5 then
		if vioGetElementData ( haus, "miete" ) >= 1 and vioGetElementData ( haus, "owner" ) ~= "none" then
			if vioGetElementData ( player, "housekey" ) == 0 then
				if vioGetElementData ( player, "money" ) >= miete then
					vioSetElementData ( player, "housekey", tonumber ( vioGetElementData ( haus, "id" ) ) * -1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast dich\nerfolgreich einge-\nmietet, tippe /unrent,\num auszuziehen!", 7500, 0, 200, 0 )
					moneychange ( player, miete*-1 )
					dbQuery( rent_func_DB, { haus, miete }, handler, "SELECT Kasse FROM houses WHERE ID LIKE ?", vioGetElementData ( haus, "id" ) )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast zu\nwenig Geld!", 7500, 125, 0, 0 )
				end
			elseif vioGetElementData ( player, "housekey" ) < 0 then
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist bereits\nin ein Haus\neingemietet! Tippe\n/unrent, um aus-\nzuziehen!", 7500, 125, 0, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Dir gehoert bereits\nein Haus - Tippe\nzuerst /sellhouse!", 7500, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nHier kansnt du\ndich nicht\neinmieten!", 7500, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bei\nkeinem Haus!", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "rent", rent_func )


local function sellhouse_func_DB ( qh, player, ID, haus, pname )
	local result = dbPoll( qh, 0 )
	if not result or not result[1] then
		if not isGang ( ID ) then
			outputLog ( pname.." hat sein Haus verkauft.", "house" )
			vioSetElementData ( player, "spawnpos_x", -2458.288085 )
			vioSetElementData ( player, "spawnpos_y", 774.354492 )
			vioSetElementData ( player, "spawnpos_z", 35.171875 )
			vioSetElementData ( player, "spawnrot_x", 52 )
			vioSetElementData ( player, "spawnint", 0 )
			vioSetElementData ( player, "spawndim", 0 )
			vioSetElementData ( player, "housekey", 0 )
			local owner = vioGetElementData ( haus, "owner" )
			vioSetElementData ( haus, "owner", "none" )
			setElementModel ( haus, 1273 )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast soeben\ndein Haus verkauft!", 7500, 0, 200, 0 )
			dbExec( handler, "UPDATE houses SET Besitzer='none' WHERE Besitzer LIKE ?", getPlayerName(player) )
			dbExec( handler, "UPDATE userdata SET Hausschluessel = '0' WHERE Name LIKE ?", getPlayerName(player) )
			local hauswert = tonumber ( vioGetElementData ( haus, "preis" ) )
			moneychange ( player, hauswert )
			datasave_remote(player)
		else
			infobox ( player, "\n\n\nLoese erst deine\nGang auf!", 5000, 125, 0, 0 )
		end
	else
		outputChatBox ( "Dein Haus wird momentan versteigert!", player, 125, 0, 0 )
	end
end

function sellhouse_func ( player )

	local ID = tonumber ( vioGetElementData ( player, "housekey" ) )
	if ID > 0 then
		local haus = houses["pickup"][ID]
		local pname = getPlayerName ( player )
		dbQuery( sellhouse_func_DB, { player, ID, haus, pname }, handler, "SELECT true FROM buyit WHERE Anbieter LIKE ? AND Typ LIKE 'Houses'", pname )
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDir gehoert\nkein Haus!", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "sellhouse", sellhouse_func )

function unrent_func ( player )

	local ID = vioGetElementData ( player, "housekey" )
	if ID < 0 then
		vioSetElementData ( player, "spawnpos_x", -2458.288085 )
		vioSetElementData ( player, "spawnpos_y", 774.354492 )
		vioSetElementData ( player, "spawnpos_z", 35.171875 )
		vioSetElementData ( player, "spawnrot_x", 52 )
		vioSetElementData ( player, "spawnint", 0 )
		vioSetElementData ( player, "spawndim", 0 )
		vioSetElementData ( player, "housekey", 0 )
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast dich\nausgemietet!", 7500, 0, 200, 0 )
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist nirgends\neingemietet!", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "unrent", unrent_func )

function setrent_func ( player, cmd, preis )

	local ID = vioGetElementData ( player, "housekey" )
	local haus = houses["pickup"][ID]
	local preis = math.abs(math.floor(preis))
	if ID > 0 then
		local miete =  math.abs ( tonumber ( preis ) )
		if miete and miete <= 500 then
			vioSetElementData ( haus, "miete", miete )
			MySQL_SetString("houses", "Miete", miete, "ID LIKE '"..vioGetElementData ( haus, "id" ).."'")
			if miete == 0 then
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDein Haus ist\nnun nicht mehr\nzu mieten!", 7500, 0, 200, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDein Haus ist\nnun fuer "..miete.." $\nzu mieten!", 7500, 0, 200, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Fehler: Tippe\n/setrent [Summe],\n0 $ = Nicht\nmietbar, max.\n500 $!", 7500, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDir gehoert\nkein Haus!", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "setrent", setrent_func )


local function house_func_DB ( qh, player, key, state )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local amount = tonumber( result[1]["Kasse"] )
		if amount then
			if not getElementData ( player, "ElementClicked" ) then
				setElementData ( player, "ElementClicked", true )
				showCursor ( player, true )
				local id = getElementDimension ( player )
				if isInGang ( player, id ) then
					openClientGangWindow ( player, id )
				else
					triggerClientEvent ( player, "showHouseGui", player, amount )
				end
			end
		end
	end
end

function house_func ( player, key, state )

	if isInUserHouse ( player ) then
		dbQuery( house_func_DB, { player, key, state }, handler, "SELECT Kasse FROM houses WHERE ID LIKE ?", getElementDimension( player ) )
	end
end

function hlock_func ( player )

	local hkey = vioGetElementData ( player, "housekey" )
	if hkey > 0 then
		vioSetElementData ( houses["pickup"][hkey], "locked", not vioGetElementData ( houses["pickup"][hkey], "locked" ) )
		if vioGetElementData ( houses["pickup"][hkey], "locked" ) then fix = "ab" else fix = "auf" end
		outputChatBox ( "Haustuer "..fix.."geschlossen!", player, 0, 125, 0 )
	else
		outputChatBox ( "Dir gehoert kein Haus!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "hlock", hlock_func )


local function houseClickServer_func_DB ( qh, player, cmd, amount ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local houseAmount = tonumber ( result[1]["Kasse"] )
		if cmd == "take" then
			if houseAmount >= amount then
				givePlayerSaveMoney ( player, amount )
				dbExec( handler, "UPDATE houses SET Kasse = Kasse - ? WHERE ID LIKE ?", amount, vioGetElementData ( player, "housekey" ) )
				triggerClientEvent ( "showHouseGui", player, houseAmount - amount )
			else
				outputChatBox ( "Du hast nicht genug Geld in deiner Hauskasse!", player, 125, 0, 0 )
			end
		elseif cmd == "give" then
			if vioGetElementData ( player, "money" ) >= amount then
				takePlayerSaveMoney ( player, amount )
				dbExec( handler, "UPDATE houses SET Kasse = Kasse + ? WHERE ID LIKE ?", amount, vioGetElementData ( player, "housekey" ) )
				triggerClientEvent ( "showHouseGui", player, houseAmount + amount )
			else
				outputChatBox ( "Du hast nicht genug Geld!", player, 125, 0, 0 )
			end
		end
	end
end

function houseClickServer_func ( player, cmd, amount )

	playSoundFrontEnd ( player, 20 )
	if cmd == "eat" then
		setPedAnimation ( player, "food", "EAT_Burger", 1, true, false, true )
		setTimer ( setPedAnimation, 1200, 1, player )
		setTimer ( triggerClientEvent, 1200, 1, player, "eatSomething", getRootElement(), 100 )
	elseif cmd == "heal" then
		triggerClientEvent ( player, "sec_health_give", getRootElement(), 999 )
		setElementHealth ( player, 100 )
	elseif cmd == "take" or cmd == "give" then
		if amount then
			amount = math.abs(math.floor(amount))
			if getElementDimension ( player ) == vioGetElementData ( player, "housekey" ) then
				dbQuery( houseClickServer_func_DB, { player, cmd, amount }, handler, "SELECT Kasse FROM houses WHERE ID LIKE ?", vioGetElementData( player, "housekey" ) )
			else
				outputChatBox ( "Du bist nicht befugt!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Ungueltiger Wert!", player, 125, 0, 0 )
		end
	end
end
addEvent ( "houseClickServer", true )
addEventHandler ( "houseClickServer", getRootElement(), houseClickServer_func )