AztecasDeliver = createMarker ( -719.68328857422, 2449.1420898438, 125.38581848145, "checkpoint", 7, 0, 125, 0, getRootElement() )
AztecasDeliverBlip = createBlip ( -719.68328857422, 2449.1420898438, 125.38581848145, 19, 2, 255, 0, 0, 255, 0, 99999.0, getRootElement() )
setElementVisibleTo ( AztecasDeliver, getRootElement(), false )
setElementVisibleTo ( AztecasDeliverBlip, getRootElement(), false )
AztecasGunshopEnter = createMarker ( -772.33239746094, 2412.0576171875, 157.06886291504, "corona", 1, 0, 125, 0, getRootElement() )


local function AztecasDeliver_func_DB2 ( qh, veh ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local d = result[1]
		AztecasFamkasse = tonumber( d["DepotGeld"] ) - vioGetElementData ( veh, "costs" )
		dbExec( handler, "UPDATE fraktionen SET DepotGeld = ? WHERE Name LIKE 'Aztecas'", AztecasFamkasse )
	end
end

local function AztecasDeliver_func_DB1 ( qh, player, dim, veh ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local d = result[1]
		AztecasSchlagringe = d["Schlagringe"] + vioGetElementData( veh, "schlagringe" )
		AztecasBaseballschlaeger = d["Baseballschlaeger"] + vioGetElementData( veh, "baseball" )
		AztecasMesser = d["Messer"] + vioGetElementData( veh, "knife" )
		AztecasSchaufeln = d["Schaufeln"] + vioGetElementData( veh, "shovels" )
		AztecasPistolen = d["Pistolen"] + vioGetElementData( veh, "pistol" )
		AztecasSDPistolen = d["SDPistolen"] + vioGetElementData( veh, "sdpistol" )
		AztecasPistolenMagazine = d["PistolenMagazine"] + vioGetElementData( veh, "pistolammo" )
		AztecasDesertEagles = d["DesertEagles"] + vioGetElementData( veh, "eagle" )
		AztecasDesertEagleMunition = d["DesertEagleMunition"] + vioGetElementData( veh, "eagleammo" )
		AztecasSchrotflinten = d["Schrotflinten"] + vioGetElementData( veh, "shotgun" )
		AztecasSchrotflintenMunition = d["SchrotflintenMunition"] + vioGetElementData( veh, "shotgunammo" )
		AztecasMP = d["MP"] + vioGetElementData( veh, "mp" )
		AztecasMPMunition = d["MPMunition"] + vioGetElementData( veh, "mpammo" )
		AztecasAK = d["AK"] + vioGetElementData( veh, "ak" )
		AztecasAKMunition = d["AKMunition"] + vioGetElementData( veh, "akammo" )
		AztecasM = d["M"] + vioGetElementData( veh, "m" )
		AztecasMMunition = d["MMunition"] + vioGetElementData( veh, "mammo" )
		AztecasGewehre = d["Gewehre"] + vioGetElementData( veh, "gewehr" )
		AztecasGewehrPatronen = d["GewehrPatronen"] + vioGetElementData( veh, "gewehrammo" )
		AztecasSGewehr = d["SGewehr"] + vioGetElementData( veh, "sgewehr" )
		AztecasSGewehrMunition = d["SGewehrMunition"] + vioGetElementData( veh, "sgewehrammo" )
		AztecasRaketenwerfer = d["Raketenwerfer"] + vioGetElementData( veh, "rakwerfer" )
		AztecasRaketen = d["Raketen"] + vioGetElementData( veh, "rak" )
		AztecasSpezwaffen = d["Spezwaffen"] + vioGetElementData( veh, "spezgun" )
		
		local querystr = dbPrepareString( handler, "UPDATE fraktionswaffen SET Schlagringe = ?, ", AztecasSchlagringe )
		querystr = querystr .. dbPrepareString( handler, "Baseballschlaeger = ?, ", AztecasBaseballschlaeger )
		querystr = querystr .. dbPrepareString( handler, "Messer = ?, ", AztecasMesser )
		querystr = querystr .. dbPrepareString( handler, "Schaufeln = ?, ", AztecasSchaufeln )
		querystr = querystr .. dbPrepareString( handler, "Pistolen = ?, ", AztecasPistolen )
		querystr = querystr .. dbPrepareString( handler, "SDPistolen = ?, ", AztecasSDPistolen )
		querystr = querystr .. dbPrepareString( handler, "PistolenMagazine = ?, ", AztecasPistolenMagazine )
		querystr = querystr .. dbPrepareString( handler, "DesertEagles = ?, ", AztecasDesertEagles )
		querystr = querystr .. dbPrepareString( handler, "DesertEagleMunition = ?, ", AztecasDesertEagleMunition )
		querystr = querystr .. dbPrepareString( handler, "Schrotflinten = ?, ", AztecasSchrotflinten )
		querystr = querystr .. dbPrepareString( handler, "SchrotflintenMunition = ?, ", AztecasSchrotflintenMunition )
		querystr = querystr .. dbPrepareString( handler, "MP = ?, ", AztecasMP )
		querystr = querystr .. dbPrepareString( handler, "MPMunition = ?, ", AztecasMPMunition )
		querystr = querystr .. dbPrepareString( handler, "AK = ?, ", AztecasAK )
		querystr = querystr .. dbPrepareString( handler, "M = ?, ", AztecasM )
		querystr = querystr .. dbPrepareString( handler, "MMunition = ?, ", AztecasMMunition )
		querystr = querystr .. dbPrepareString( handler, "Gewehre = ?, ", AztecasGewehre )
		querystr = querystr .. dbPrepareString( handler, "GewehrPatronen = ?, ", AztecasGewehrPatronen )
		querystr = querystr .. dbPrepareString( handler, "SGewehr = ?, ", AztecasSGewehr )
		querystr = querystr .. dbPrepareString( handler, "SgewehrMunition = ?, ", AztecasSGewehrMunition )
		querystr = querystr .. dbPrepareString( handler, "Raketenwerfer = ?, ", AztecasRaketenwerfer )
		querystr = querystr .. dbPrepareString( handler, "Raketen = ?, ", AztecasRaketen )
		querystr = querystr .. dbPrepareString( handler, "Spezwaffen = ? ", AztecasSpezwaffen )
		querystr = querystr .. dbPrepareString( handler, "WHERE Fraktion LIKE 'Aztecas'" )
		dbExec( handler, querystr )

		dbQuery( AztecasDeliver_func_DB2, { veh }, handler, "SELECT DepotGeld FROM fraktionen WHERE Name LIKE 'Aztecas'" )
	end
end


function AztecasDeliver_func ( player, dim )
   
	local veh = getPedOccupiedVehicle ( player )
	if veh then
		if getPedOccupiedVehicleSeat ( player ) == 0 then
			if getElementModel ( veh ) == 455 then
				if vioGetElementData ( veh, "guntruck" ) == 1 then
				
					mafiatransport = 0
					
					dbQuery( AztecasDeliver_func_DB1, { player, dim, veh }, handler, "SELECT * FROM fraktionswaffen WHERE Fraktion LIKE 'Aztecas'" )

					outputChatBox ( "Lieferung abgegeben - Du erhaelst "..vioGetElementData ( veh, "costs" ).." $ aus der Familienkasse! zurueck!", player, 0, 125, 0 )
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + vioGetElementData ( veh, "costs" ) )
					givePlayerMoney ( player, vioGetElementData ( veh, "costs" ) )
					if vioGetElementData ( player, "gunloads" ) ~= "done" then 																								-- Achiev: Waffenschieber
						vioSetElementData ( player, "gunloads", vioGetElementData ( player, "gunloads" ) + vioGetElementData ( veh, "costs" ) )										-- Achiev: Waffenschieber
						if vioGetElementData ( player, "gunloads" ) > 50000 then																								-- Achiev: Waffenschieber
							vioSetElementData ( player, "gunloads", "done" )																									-- Achiev: Waffenschieber
							triggerClientEvent ( player, "showAchievmentBox", player, "Waffenschieber", 50, 10000 )															-- Achiev: Waffenschieber
							vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 50 )												-- Achiev: Waffenschieber
							dbExec( handler, "UPDATE achievments SET Waffenschieber=? WHERE Name LIKE ?", vioGetElementData ( player, "gunloads" ), getPlayerName(player) )				-- Achiev: Waffenschieber
						end																																					-- Achiev: Waffenschieber
					end																																						-- Achiev: Waffenschieber
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
					removePedFromVehicle ( player )
					removePedFromVehicle ( getVehicleOccupant ( veh, 1 ) )
					setElementPosition ( veh, 0, 0, -500 )
					destroyElement ( veh )
				end
			end
		end
	end
end
addEventHandler ( "onMarkerHit", AztecasDeliver, AztecasDeliver_func )

function AztecasGunshopEnter_func ( hitElement )

	if getElementType ( hitElement ) == "player" or getElementType ( hitElement ) == "ped" then
		if isAztecas(hitElement) then
			triggerClientEvent ( hitElement, "showAztecasGunshop", getRootElement() )
			showCursor ( hitElement, true )
			vioSetElementData ( hitElement, "ElementClicked", true )
		else
			outputChatBox ( "Nur für Aztecas!", hitElement, 125, 0, 0 )
		end
	end
end
addEventHandler ( "onMarkerHit", AztecasGunshopEnter, AztecasGunshopEnter_func )


local function gunbuyAztecas_func_DB ( qh, player, itemtype, item, w0, w1, w2, w3, w4, w5, w6, w7 ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		AztecasFamkasse = result[1]["DepotGeld"]
		if itemtype == "armor" then
			if vioGetElementData ( player, "money" ) >= armor_price then
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - armor_price )
				takePlayerMoney ( player, armor_price )
				triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				setPedArmor ( player, 100 )
				triggerClientEvent ( player, "sec_armor_give", getRootElement(), 100 )
				local success = 1
				AztecasFamkasse = AztecasFamkasse + armor_price
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld!\nRuestung kostet\n"..armor_price.." $!", 5000, 125, 0, 0 )
			end
		elseif itemtype == "ammo" then
			if item == "9mmammo" then
				if vioGetElementData ( player, "money" ) >= pistolammo_price then
					if tonumber(AztecasPistolenMagazine) >= 1 then
						if w2 == 22 or w2 == 23 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - pistolammo_price )
							takePlayerMoney ( player, pistolammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w2, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w2, 17 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET PistolenMagazine = PistolenMagazine - 1 WHERE Fraktion LIKE 'Aztecas'")
							AztecasPistolenMagazine = AztecasPistolenMagazine-1
							AztecasFamkasse = AztecasFamkasse + pistolammo_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast\nkeine Pistole!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nMagazine mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nMagazin kostet\n"..pistolammo_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "eagleammo" then
				if vioGetElementData ( player, "money" ) >= eagleammo_price then
					if tonumber(AztecasDesertEagleMunition) >= 1 then
						if w2 == 24 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - eagleammo_price )
							takePlayerMoney ( player, eagleammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w2, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w2, 7 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET DesertEagleMunition = DesertEagleMunition - 1 WHERE Fraktion LIKE 'Aztecas'")
							AztecasDesertEagleMunition = AztecasDesertEagleMunition-1
							AztecasFamkasse = AztecasFamkasse + eagleammo_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast keine\nDesert Eagle!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nMagazine mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nMagazin kostet\n"..eagleammo_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "mp5ammo" then
				if vioGetElementData ( player, "money" ) >= mpammo_price then
					if tonumber(AztecasMPMunition) >= 1 then
						if w4 == 29 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mpammo_price )
							takePlayerMoney ( player, mpammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w4, 30, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w4, 30 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET MPMunition = MPMunition - 1 WHERE Fraktion LIKE 'Aztecas'")
							AztecasMPMunition = AztecasMPMunition-1
							AztecasFamkasse = AztecasFamkasse + mpammo_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast keine\nMP5!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nMagazine mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nMagazin kostet\n"..mpammo_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "schrot" then
				if vioGetElementData ( player, "money" ) >= shotgunammo_price then
					if tonumber(AztecasSchrotflintenMunition) >= 1 then
						if w3 == 25 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shotgunammo_price )
							takePlayerMoney ( player, shotgunammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w3, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w3, 1 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET SchrotflintenMunition = SchrotflintenMunition - 1 WHERE Fraktion LIKE 'Aztecas'")
							AztecasSchrotflintenMunition = AztecasSchrotflintenMunition-1
							AztecasFamkasse = AztecasFamkasse + shotgunammo_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast keine\nSchrotflinte!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nPatronen mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nPatrone kostet\n"..shotgunammo_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "ak47ammo" then
				if vioGetElementData ( player, "money" ) >= akammo_price then
					if tonumber(AztecasAKMunition) >= 1 then
						if w5 == 30 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - akammo_price )
							takePlayerMoney ( player, akammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w5, 30, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w5, 30 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET AKMunition = AKMunition - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasAKMunition = AztecasAKMunition-1
							AztecasFamkasse = AztecasFamkasse + akammo_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast keine\nAK-47", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es ist keine\nMagazine mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nMagazin kostet\n"..akammo_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "m4ammo" then
				if vioGetElementData ( player, "money" ) >= mammo_price then
					if tonumber(AztecasMMunition) >= 1 then
						if w5 == 31 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mammo_price )
							takePlayerMoney ( player, mammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w5, 50, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w5, 50 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET MMunition = MMunition - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasMMunition = AztecasMMunition-1
							AztecasFamkasse = AztecasFamkasse + mammo_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast keine\nM4", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es ist keine\nMagazine mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nMagazin kostet\n"..mammo_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "gewehrammo" then
				if vioGetElementData ( player, "money" ) >= gewehrammo_price then
					if tonumber(AztecasGewehrPatronen) >= 1 then
						if w6 == 33 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - gewehrammo_price )
							takePlayerMoney ( player, gewehrammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w6, 1 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET GewehrPatronen = GewehrPatronen - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasGewehrPatronen = AztecasGewehrPatronen-1
							AztecasFamkasse = AztecasFamkasse + gewehrammo_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast kein\nGewehr!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nPatronen mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nPatrone kostet\n"..gewehrammo_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "sgewehrammo" then
				if vioGetElementData ( player, "money" ) >= sgewehrammo_price then
					if tonumber(AztecasSGewehrMunition) >= 1 then
						if w6 == 34 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sgewehrammo_price )
							takePlayerMoney ( player, sgewehrammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w6, 1 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET SGewehrMunition = SGewehrMunition - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasSGewehrMunition = AztecasSGewehrMunition-1
							AztecasFamkasse = AztecasFamkasse + sgewehrammo_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast kein\nGewehr!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nPatronen mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nPatrone kostet\n"..sgewehrammo_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "rocket" then
				if vioGetElementData ( player, "money" ) >= rak_price then
					if tonumber(AztecasRaketen) >= 1 then
						if w7 == 35 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - rak_price )
							takePlayerMoney ( player, rak_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w7, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w7, 1 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET Raketen = Raketen - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasRaketen = AztecasRaketen-1
							AztecasFamkasse = AztecasFamkasse + rak_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast keinen\nRaketenwerfer!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nRaketen mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nRakete kostet\n"..rak_price.." $!", 5000, 125, 0, 0 )
				end
			end
		elseif itemtype == "gun" then
			if item == "baseballbat" then
				if vioGetElementData ( player, "money" ) >= baseball_price then
					if tonumber(AztecasBaseballschlaeger) >= 1 then
						if w1 ~= 5 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - baseball_price )
							takePlayerMoney ( player, baseball_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 5, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 5, 1 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET Baseballschlaeger = Baseballschlaeger - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasBaseballschlaeger = AztecasBaseballschlaeger-1
							AztecasFamkasse = AztecasFamkasse + baseball_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits einen\nSchlaeger!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nSchlaeger mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nSchlaeger kostet\n"..baseball_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "schaufel" then
				if vioGetElementData ( player, "money" ) >= shovels_price then
					if tonumber(AztecasSchaufeln) >= 1 then
						if w1 ~= 6 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shovels_price )
							takePlayerMoney ( player, shovels_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 6, 1 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET Schaufeln = Schaufeln - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasSchaufeln = AztecasSchaufeln-1
							AztecasFamkasse = AztecasFamkasse + shovels_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nSchaufel!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nSchaufeln mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nSchaufel kostet\n"..shovels_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "messer" then
				if vioGetElementData ( player, "money" ) >= knife_price then
					if tonumber(AztecasMesser) >= 1 then
						if w1 ~= 4 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - knife_price )
							takePlayerMoney ( player, knife_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 4, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 4, 1 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET Messer = Messer - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasMesser = AztecasMesser-1
							AztecasFamkasse = AztecasFamkasse + knife_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits ein\nMesser!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nMesser mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nMesser kostet\n"..knife_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "schlagring" then
				if vioGetElementData ( player, "money" ) >= schlagringe_price then
					if tonumber(AztecasSchlagringe) >= 1 then
						if w1 == 0 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - schlagringe_price )
							takePlayerMoney ( player, schlagringe_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 1, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 1, 1 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET Schlagringe = Schlagringe - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasSchlagringe = AztecasSchlagringe-1
							AztecasFamkasse = AztecasFamkasse + schlagringe_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits einen\nSchlagring!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nSchlagringe mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nSchlagring kostet\n"..schlagringe_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "9mm" then
				if vioGetElementData ( player, "money" ) >= pistol_price then
					if tonumber(AztecasPistolen) >= 1 then
						if w2 ~= 22 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - pistol_price )
							takePlayerMoney ( player, pistol_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 22, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 22, 17 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET Pistolen = Pistolen - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasPistolen = AztecasPistolen-1
							AztecasFamkasse = AztecasFamkasse + pistol_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nPistole!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nSPistolen mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nPistole kostet\n"..pistol_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "9mmsd" then
				if vioGetElementData ( player, "money" ) >= sdpistol_price then
					if tonumber(AztecasSDPistolen) >= 1 then
						if w2 ~= 23 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sdpistol_price )
							takePlayerMoney ( player, sdpistol_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 23, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 23, 17 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET SDPistolen = SDPistolen - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasSDPistolen = AztecasSDPistolen-1
							AztecasFamkasse = AztecasFamkasse + sdpistol_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nSD-Pistole!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nSD-Pistolen mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nSD-Pistole kostet\n"..sdpistol_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "eagle" then
				if vioGetElementData ( player, "money" ) >= eagle_price then
					if tonumber(AztecasDesertEagles) >= 1 then
						if w2 ~= 24 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - eagle_price )
							takePlayerMoney ( player, eagle_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 24, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 24, 7 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET DesertEagles = DesertEagles - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasDesertEagles = AztecasDesertEagles-1
							AztecasFamkasse = AztecasFamkasse + eagle_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nDesert Eagle!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es ist keine\nDesert Eagle mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nDesert Eagle kostet\n"..eagle_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "mp5" then
				if vioGetElementData ( player, "money" ) >= mp_price then
					if tonumber(AztecasMP) >= 1 then
						if w4 ~= 29 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mp_price )
							takePlayerMoney ( player, mp_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 29, 30, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 29, 30 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET MP = MP - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasMP = AztecasMP-1
							AztecasFamkasse = AztecasFamkasse + mp_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nMP5!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es ist keine\nMP5 mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nMP5 kostet\n"..mp_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "shotty" then
				if vioGetElementData ( player, "money" ) >= shotgun_price then
					if tonumber(AztecasSchrotflinten) >= 1 then
						if w3 ~= 25 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shotgun_price )
							takePlayerMoney ( player, shotgun_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 25, 5, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 25, 5 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET Schrotflinten = Schrotflinten - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasSchrotflinten = AztecasSchrotflinten-1
							AztecasFamkasse = AztecasFamkasse + shotgun_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nSchrotflinte!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nSchrotflinten mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nSchrotflinte kostet\n"..shotgun_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "ak47" then
				if vioGetElementData ( player, "money" ) >= ak_price then
					if AztecasAK >= 1 then
						if vioGetElementData ( player, "rang" ) >= 2 then
							if w5 ~= 30 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - ak_price )
								takePlayerMoney ( player, ak_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 30, 30, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 30, 30 )
								success = 1
								dbExec( handler, "UPDATE fraktionswaffen SET AK = AK - 1 WHERE Fraktion LIKE 'Aztecas'" )
								AztecasAK = AztecasAK-1
								AztecasFamkasse = AztecasFamkasse + ak_price
							else
								triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nAK-47!", 5000, 125, 0, 0 )
							end
						else
							outputChatBox ( "Du musst mindestens Rang 2 besitzen!", player, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es ist keine\nAK-47 mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nAK-47 kostet\n"..ak_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "m4" then
				if vioGetElementData ( player, "money" ) >= m_price then
					if tonumber(AztecasM) >= 1 then
						if vioGetElementData ( player, "rang" ) >= 2 then
							if w5 ~= 30 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - m_price )
								takePlayerMoney ( player, m_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 31, 50, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 31, 50 )
								success = 1
								dbExec( handler, "UPDATE fraktionswaffen SET M = M - 1 WHERE Fraktion LIKE 'Aztecas'" )
								AztecasM = AztecasM-1
								AztecasFamkasse = AztecasFamkasse + m_price
							else
								triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nM4!", 5000, 125, 0, 0 )
							end
						else
							outputChatBox ( "Du musst mindestens Rang 2 besitzen!", player, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es ist keine\nM4 mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nM4 kostet\n"..m_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "gewehr" then
				if vioGetElementData ( player, "money" ) >= gewehr_price then
					if tonumber(AztecasGewehre) >= 1 then
						if  w6 ~= 33 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - gewehr_price )
							takePlayerMoney ( player, gewehr_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 33, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 33, 7 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET Gewehre = Gewehre - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasGewehre = AztecasGewehre-1
							AztecasFamkasse = AztecasFamkasse + gewehr_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits ein\nGewehr!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nGewehre mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nGewehr kostet\n"..gewehr_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "sniper" then
				if vioGetElementData ( player, "money" ) >= sgewehr_price then
					if vioGetElementData ( player, "rang" ) >= 3 then
						if tonumber(AztecasSGewehr) >= 1 then
							if w6 ~= 34 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sgewehr_price )
								takePlayerMoney ( player, sgewehr_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 34, 7, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 34, 7 )
								success = 1
								dbExec( handler, "UPDATE fraktionswaffen SET SGewehr = SGewehr - 1 WHERE Fraktion LIKE 'Aztecas'" )
								AztecasSGewehr = AztecasSGewehr-1
								AztecasFamkasse = AztecasFamkasse + sgewehr_price
							else
								triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits ein\nScharfschuetzen-\ngewehr!", 5000, 125, 0, 0 )
							end
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nScharfschuetzen-\ngewehre mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
						end
					else
						outputChatBox ( "Du musst mindestens Rang 3 besitzen!", player, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nScharfschuetzen-\ngewehr kostet\n"..sgewehr_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "raketenwerfer" then
				if vioGetElementData ( player, "money" ) >= rakwerfer_price then
					if tonumber(AztecasRaketenwerfer) >= 1 then
						if vioGetElementData ( player, "rang" ) >= 4 then
							if w7 ~= 35 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - rakwerfer_price )
								takePlayerMoney ( player, rakwerfer_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 35, 1, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 35, 1 )
								success = 1
								dbExec( handler, "UPDATE fraktionswaffen SET Raketenwerfer = Raketenwerfer - 1 WHERE Fraktion LIKE 'Aztecas'" )
								AztecasRaketenwerfer = AztecasRaketenwerfer-1
								AztecasFamkasse = AztecasFamkasse + rakwerfer_price
							else
								triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits einen\nRaketenwerfer!", 5000, 125, 0, 0 )
							end
						else
							outputChatBox ( "Du musst mindestens Rang 4 besitzen!", player, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nRaketenwerfer mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nRaketenwerfer kostet\n"..rakwerfer_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "molly" then
				if vioGetElementData ( player, "money" ) >= spezgun_price then
					if tonumber(AztecasSpezwaffen) >= 1 then
						if w1 ~= 18 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - spezgun_price )
							takePlayerMoney ( player, spezgun_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 18, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 18, 1 )
							success = 1
							dbExec( handler, "UPDATE fraktionswaffen SET Spezwaffen = Spezwaffen - 1 WHERE Fraktion LIKE 'Aztecas'" )
							AztecasSpezwaffen = AztecasSpezwaffen-1
							AztecasFamkasse = AztecasFamkasse + spezgun_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nBrandbombe!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nBrandbomben mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nBrandbombe kostet\n"..spezgun_price.." $!", 5000, 125, 0, 0 )
				end
			end
		end
		if success == 1 then 
			playSoundFrontEnd ( player, 40 )
		end
		dbExec( handler, "UPDATE fraktionen SET DepotGeld=? WHERE Name LIKE 'Aztecas'", AztecasFamkasse)
	end
end

function gunbuyAztecas_func ( player, itemtype, item,  w0, w1, w2, w3, w4, w5, w6, w7 )

	local success = 0
	if player == client then
		dbQuery( gunbuyAztecas_func_DB, { player, itemtype, w0, w1, w2, w3, w4, w5, w6, w7 }, handler, "SELECT DepotGeld FROM fraktionen WHERE Name LIKE 'Aztecas'" )
	end
end
addEvent ( "gunbuyAztecas", true )
addEventHandler ( "gunbuyAztecas", getRootElement(), gunbuyAztecas_func )