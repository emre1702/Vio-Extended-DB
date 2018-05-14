function housePickup ( player )

	if getElementModel ( source ) == 1273 or getElementModel ( source ) == 1272 then
		if vioGetElementData ( source, "owner" ) == "none" then					--Frei
			preis = vioGetElementData ( source, "preis" )
			mintime = vioGetElementData (source, "mintime")
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Dieses Haus steht\nzum Verkauf fuer\n"..preis..",\nMindestspielzeit:\n"..mintime.." Stunden!", 5000, 0, 125, 0 )
			outputChatBox ( "Tippe /buyhouse [bank/bar] um das Haus mit Bargeld/vom Konto zu kaufen (2% mehr Kosten!)", player, 0, 125, 0 )
			local x, y, z = getElementPosition ( source )
			vioSetElementData ( player, "housex", x )
			vioSetElementData ( player, "housey", y )
			vioSetElementData ( player, "housez", z )
			vioSetElementData ( player, "house", source )
		elseif vioGetElementData ( source, "owner" ) ~= "none" then				-- Verkauft
			if not getElementData ( source, "gangHQOf" ) then
				mintime = vioGetElementData (source, "mintime")
				fix = ""
				if vioGetElementData ( source, "miete" ) > 0 then
					fix = "Miete: "..vioGetElementData ( source, "miete" ).." $, /rent\nzum mieten!"
				else
					fix = ""
				end
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Dieses Haus gehoert:\n"..vioGetElementData(source,"owner")..",\nMindestspielzeit:\n"..mintime.." Stunden!\n"..fix, 7500, 200, 200, 0 )
			end
			local x, y, z = getElementPosition ( source )
			vioSetElementData ( player, "housex", x )
			vioSetElementData ( player, "housey", y )
			vioSetElementData ( player, "housez", z )
			vioSetElementData ( player, "house", source )
		end
	end
end
addEventHandler ( "onPickupHit", getRootElement(), housePickup )


local function buyhouse_func_DB ( qh, player, zahlart, hause, pname )
	local result = dbPoll( qh, 0 )
	if not result or not result[1] then
		if haus ~= "none" then
			if tonumber(vioGetElementData ( player, "housekey" )) <= 0 then
				local hauskosten = tonumber(vioGetElementData ( haus, "preis" ))
				if zahlart == "bank" then
					local hauskosten = hauskosten*1.02
					if vioGetElementData ( player, "bankmoney" ) >= hauskosten then
						MySQL_SetString("houses", "Besitzer", pname, "ID LIKE '"..vioGetElementData ( haus, "id" ).."'")
						
						vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) - hauskosten )
						
						triggerClientEvent ( player, "createNewStatementEntry", player, "Hauskauf", hauskosten * - 1, "\n" )
						
						vioSetElementData ( player, "housekey", vioGetElementData ( haus, "id" ) )
						vioSetElementData ( haus, "owner", pname )
						setElementModel ( haus, 1272 )
						
						datasave_remote(player)
						
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Glueckwunsch,\ndu hast das Haus\ngekauft!Fuer\nmehr Infos, oeffne\ndas Hilfemenue!", 10000, 125, 0, 0 )
						triggerClientEvent ( player, "achievsound", getRootElement() )
						outputLog ( getPlayerName ( player ).." hat ein Haus gekauft ( "..vioGetElementData ( haus, "id" ).." )", "house" )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld auf\ndemKonto!", 5000, 125, 0, 0 )
					end
				else
					if vioGetElementData ( player, "money" ) >= hauskosten then
						MySQL_SetString("houses", "Besitzer", pname, "ID LIKE '"..vioGetElementData ( haus, "id" ).."'")

						vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - hauskosten )
						takePlayerMoney ( player, hauskosten )
						triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
						
						vioSetElementData ( player, "housekey", vioGetElementData ( haus, "id" ) )
						vioSetElementData ( haus, "owner", pname )
						setElementModel ( haus, 1272 )
						
						datasave_remote(player)

						triggerClientEvent ( player, "infobox_start", getRootElement(), "Glueckwunsch,\ndu hast das Haus\ngekauft!Fuer\nmehr Infos, oeffne\ndas Hilfemenue!", 10000, 125, 0, 0 )
						triggerClientEvent ( player, "achievsound", getRootElement() )
						
						outputLog ( getPlayerName ( player ).." hat ein Haus gekauft ( "..vioGetElementData ( haus, "id" ).." )", "house" )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Bargeld!", 5000, 125, 0, 0 )
					end
				end
				MySQL_SetString("userdata", "Hausschluessel", vioGetElementData ( player, "housekey" ), dbPrepareString( handler, "Name LIKE ?", getPlayerName(player) ) )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast bereits\nein Haus!", 5000, 125, 0, 0 )
			end
		end
	else
		outputChatBox ( "Du ersteigerst momentan bereits ein Haus!", player, 0, 125, 0 )
	end
end

function buyhouse_func ( player, cmd, zahlart )

	if zahlart == "bank" or zahlart == "bar" then
		if vioGetElementData ( player, "housex" ) ~= 0 then
			local haus = vioGetElementData ( player, "house" )
			local x1, y1, z1 = getElementPosition ( player )
			local x2 = vioGetElementData ( player, "housex" )
			local y2 = vioGetElementData ( player, "housey" )
			local z2 = vioGetElementData ( player, "housez" )
			local pname = getPlayerName ( player )
			local distance = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 )
			if distance < 5 then
				if vioGetElementData ( haus, "owner" ) == "none" then
					if vioGetElementData ( player, "playingtime" )/60 > vioGetElementData ( haus, "mintime" ) then
						dbQuery( buyhouse_func_DB, { player, zahlart, haus, pname }, handler, "SELECT true FROM buyit WHERE Hoechstbietender LIKE ? AND Typ LIKE 'Houses'", pname )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\nlange genug\ngespielt!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 5000, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bei\nkeinem Haus!", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bei\nkeinem Haus!", 5000, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nBitte als Zahlart\nbar oder bank\nangeben!!", 5000, 125, 0, 0 )
	end
end
addCommandHandler ( "buyhouse", buyhouse_func )