local deletedPrestige = 0

function createPrestigeObjects ( i )

	if MySQL_DatasetExist ( "prestige", "ID LIKE '"..i.."'" ) then
		local x, y, z = MySQL_GetVar( "prestige", "x", "ID LIKE '"..i.."'"), MySQL_GetVar( "prestige", "y", "ID LIKE '"..i.."'"), MySQL_GetVar( "prestige", "z", "ID LIKE '"..i.."'")
		local besitzer = MySQL_GetString( "prestige", "Besitzer", "ID LIKE '"..i.."'")
		local preis = MySQL_GetString( "prestige", "Preis", "ID LIKE '"..i.."'")
		local id = MySQL_GetString( "prestige", "ID", "ID LIKE '"..i.."'")
		
		_G["prestige"..id] = createPickup ( x, y, z, 3, 1239, 1000 )
		
		addEventHandler ( "onPickupHit", _G["prestige"..id], prestigePickupHit )
		
		local pickup = _G["prestige"..id]
		
		vioSetElementData ( pickup, "besitzer", besitzer )
		vioSetElementData ( pickup, "preis", preis )
		vioSetElementData ( pickup, "id", id )
		
		i = i + 1
		createPrestigeObjects ( i )
	else
		totalPrestigeObjects = i - 1
		outputServerLog ( "Es wurden "..( i - 1 ).." prestige Objekte gefunden und "..deletedPrestige.." Besitzer enteignet." )
	end
end
setTimer ( createPrestigeObjects, 1000, 1, 1 )

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

function buyprestige_func ( player )

	local pickup = vioGetElementData ( player, "lastPrestigePickup" )
	if pickup then
		local pname = MySQL_Save ( getPlayerName ( player ) )
		if vioGetElementData ( pickup, "besitzer" ) == "" then
			if not MySQL_DatasetExist ( "buyit", "Hoechstbietender LIKE '"..pname.."' AND Typ LIKE 'Prestige'" ) then
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
						
						MySQL_SetString( "prestige", "Besitzer", pname, "ID LIKE '"..id.."'")
						
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
		else
			outputChatBox ( "Dieses Objekt steht nicht zum Verkauf!", player, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "buyprestige", buyprestige_func )

function sellprestige_func ( player )

	if MySQL_DatasetExist ( "prestige", "Besitzer LIKE '"..MySQL_Save( getPlayerName ( player ) ).."'" ) then
		if not MySQL_DatasetExist ("buyit", "Anbieter LIKE '"..pname.."' AND Typ LIKE 'Prestige'") then
			local price = tonumber ( MySQL_GetString( "prestige", "Preis", "Besitzer LIKE '"..MySQL_Save ( getPlayerName ( player ) ).."'") )
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + price )
			outputChatBox ( "Du hast dein Prestige-Objekt verkauft und erhaelst "..price.." $!", player, 0, 125, 0 )
			MySQL_SetString( "prestige", "Besitzer", "", "Besitzer LIKE '"..MySQL_Save ( getPlayerName ( player ) ).."'")
			
			for i = 1, totalPrestigeObjects do
				if vioGetElementData ( _G["prestige"..i], "besitzer" ) == getPlayerName ( player ) then
					vioSetElementData ( _G["prestige"..i], "besitzer", "" )
				end
			end
		else
			outputChatBox ( "Dein Prestige-Objekt wird momentan versteigert!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Dir gehoert kein Prestige-Objekt!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "sellprestige", sellprestige_func )