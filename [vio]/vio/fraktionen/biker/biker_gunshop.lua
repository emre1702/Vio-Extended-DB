BikerDeliver = createMarker ( -2192.0986328125, -2356.501953125, 30.47654914856, "checkpoint", 7, 0, 125, 0, getRootElement() )
BikerDeliverBlip = createBlip(-2192.0986328125, -2356.501953125, 30.47654914856, 19, 2, 255, 0, 0, 255, 0, 99999.0, getRootElement() )
setElementVisibleTo ( BikerDeliver, getRootElement(), false )
setElementVisibleTo ( BikerDeliverBlip, getRootElement(), false )
BikerGunshopEnter = createMarker ( 2560.8564453125, 1561.583984375, 10.8203125, "corona", 1, 0, 125, 0, getRootElement() )
Biker = "Biker"
function ddasettings ()
	local mafia = "Biker"

	local result = dbPoll( dbQuery( handler, "SELECT * FROM fraktionswaffen WHERE Fraktion LIKE ?", mafia ), -1 )
	if result and result[1] then
		local d = result[1]
		BikerSchlagringe = tonumber( d["Schlagringe"] )
		BikerBaseballschlaeger = tonumber( d["Baseballschlaeger"] )
		BikerMesser = tonumber( d["Messer"] )
		BikerSchaufeln = tonumber( d["Schaufeln"] )
		BikerPistolen = tonumber( d["Pistolen"] )
		BikerSDPistolen = tonumber( d["SDPistolen"] )
		BikerPistolenMagazine = tonumber( d["PistolenMagazine"]  )
		BikerDesertEagles = tonumber( d["DesertEagles"]  )
		BikerDesertEagleMunition = tonumber( d["DesertEagleMunition"]  )
		BikerSchrotflinten = tonumber( d["Schrotflinten"]  )
		BikerSchrotflintenMunition = tonumber( d["SchrotflintenMunition"]  )
		BikerMP = tonumber( d["MP"]  )
		BikerMPMunition = tonumber( d["MPMunition"]  )
		BikerAK = tonumber( d["AK"] ) 
		BikerAKMunition = tonumber( d["AKMunition"] )
		BikerM = tonumber( d["M"] ) 
		BikerMMunition = tonumber( d["MMunition"] ) 
		BikerGewehre = tonumber( d["Gewehre"] ) 
		BikerGewehrPatronen = tonumber( d["GewehrPatronen"] ) 
		BikerSGewehr = tonumber( d["SGewehr"]  )
		BikerSGewehrMunition = tonumber( d["SGewehrMunition"]  )
		BikerRaketenwerfer = tonumber( d["Raketenwerfer"]  )
		BikerRaketen = tonumber( d["Raketen"]  )
		BikerSpezwaffen = tonumber( d["Spezwaffen"]  )
	end

	result = dbPoll( dbQuery( handler, "SELECT DepotGeld FROM fraktionen WHERE Name LIKE ?", mafia ), -1 )
	if result and result[1] then
		BikerFamkasse = tonumber( d["DepotGeld"] )
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), ddasettings )

local function BikerDeliver_func_DB2 ( qh, veh ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local d = result[1]
		BikerFamkasse = tonumber( d["DepotGeld"] ) - vioGetElementData ( veh, "costs" )
		dbExec( handler, "UPDATE fraktionen SET DepotGeld = ? WHERE Name LIKE 'Biker'", BikerFamkasse )
	end
end

local function BikerDeliver_func_DB1 ( qh, player, dim, veh ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local d = result[1]
		BikerSchlagringe = d["Schlagringe"] + vioGetElementData( veh, "schlagringe" )
		BikerBaseballschlaeger = d["Baseballschlaeger"] + vioGetElementData( veh, "baseball" )
		BikerMesser = d["Messer"] + vioGetElementData( veh, "knife" )
		BikerSchaufeln = d["Schaufeln"] + vioGetElementData( veh, "shovels" )
		BikerPistolen = d["Pistolen"] + vioGetElementData( veh, "pistol" )
		BikerSDPistolen = d["SDPistolen"] + vioGetElementData( veh, "sdpistol" )
		BikerPistolenMagazine = d["PistolenMagazine"] + vioGetElementData( veh, "pistolammo" )
		BikerDesertEagles = d["DesertEagles"] + vioGetElementData( veh, "eagle" )
		BikerDesertEagleMunition = d["DesertEagleMunition"] + vioGetElementData( veh, "eagleammo" )
		BikerSchrotflinten = d["Schrotflinten"] + vioGetElementData( veh, "shotgun" )
		BikerSchrotflintenMunition = d["SchrotflintenMunition"] + vioGetElementData( veh, "shotgunammo" )
		BikerMP = d["MP"] + vioGetElementData( veh, "mp" )
		BikerMPMunition = d["MPMunition"] + vioGetElementData( veh, "mpammo" )
		BikerAK = d["AK"] + vioGetElementData( veh, "ak" )
		BikerAKMunition = d["AKMunition"] + vioGetElementData( veh, "akammo" )
		BikerM = d["M"] + vioGetElementData( veh, "m" )
		BikerMMunition = d["MMunition"] + vioGetElementData( veh, "mammo" )
		BikerGewehre = d["Gewehre"] + vioGetElementData( veh, "gewehr" )
		BikerGewehrPatronen = d["GewehrPatronen"] + vioGetElementData( veh, "gewehrammo" )
		BikerSGewehr = d["SGewehr"] + vioGetElementData( veh, "sgewehr" )
		BikerSGewehrMunition = d["SGewehrMunition"] + vioGetElementData( veh, "sgewehrammo" )
		BikerRaketenwerfer = d["Raketenwerfer"] + vioGetElementData( veh, "rakwerfer" )
		BikerRaketen = d["Raketen"] + vioGetElementData( veh, "rak" )
		BikerSpezwaffen = d["Spezwaffen"] + vioGetElementData( veh, "spezgun" )
		
		local querystr = dbPrepareString( handler, "UPDATE fraktionswaffen SET Schlagringe = ?, ", BikerSchlagringe )
		querystr = querystr .. dbPrepareString( handler, "Baseballschlaeger = ?, ", BikerBaseballschlaeger )
		querystr = querystr .. dbPrepareString( handler, "Messer = ?, ", BikerMesser )
		querystr = querystr .. dbPrepareString( handler, "Schaufeln = ?, ", BikerSchaufeln )
		querystr = querystr .. dbPrepareString( handler, "Pistolen = ?, ", BikerPistolen )
		querystr = querystr .. dbPrepareString( handler, "SDPistolen = ?, ", BikerSDPistolen )
		querystr = querystr .. dbPrepareString( handler, "PistolenMagazine = ?, ", BikerPistolenMagazine )
		querystr = querystr .. dbPrepareString( handler, "DesertEagles = ?, ", BikerDesertEagles )
		querystr = querystr .. dbPrepareString( handler, "DesertEagleMunition = ?, ", BikerDesertEagleMunition )
		querystr = querystr .. dbPrepareString( handler, "Schrotflinten = ?, ", BikerSchrotflinten )
		querystr = querystr .. dbPrepareString( handler, "SchrotflintenMunition = ?, ", BikerSchrotflintenMunition )
		querystr = querystr .. dbPrepareString( handler, "MP = ?, ", BikerMP )
		querystr = querystr .. dbPrepareString( handler, "MPMunition = ?, ", BikerMPMunition )
		querystr = querystr .. dbPrepareString( handler, "AK = ?, ", BikerAK )
		querystr = querystr .. dbPrepareString( handler, "M = ?, ", BikerM )
		querystr = querystr .. dbPrepareString( handler, "MMunition = ?, ", BikerMMunition )
		querystr = querystr .. dbPrepareString( handler, "Gewehre = ?, ", BikerGewehre )
		querystr = querystr .. dbPrepareString( handler, "GewehrPatronen = ?, ", BikerGewehrPatronen )
		querystr = querystr .. dbPrepareString( handler, "SGewehr = ?, ", BikerSGewehr )
		querystr = querystr .. dbPrepareString( handler, "SgewehrMunition = ?, ", BikerSGewehrMunition )
		querystr = querystr .. dbPrepareString( handler, "Raketenwerfer = ?, ", BikerRaketenwerfer )
		querystr = querystr .. dbPrepareString( handler, "Raketen = ?, ", BikerRaketen )
		querystr = querystr .. dbPrepareString( handler, "Spezwaffen = ? ", BikerSpezwaffen )
		querystr = querystr .. dbPrepareString( handler, "WHERE Fraktion LIKE 'Biker'" )
		dbExec( handler, querystr )

		dbQuery( BikerDeliver_func_DB2, { veh }, handler, "SELECT DepotGeld FROM fraktionen WHERE Name LIKE 'Biker'" )
	end
end


function BikerDeliver_func ( player, dim )
   
	local veh = getPedOccupiedVehicle ( player )
	if veh then
		if getPedOccupiedVehicleSeat ( player ) == 0 then
			if getElementModel ( veh ) == 455 then
				if vioGetElementData ( veh, "guntruck" ) == 1 then
				
					mafiatransport = 0
					
					dbQuery( BikerDeliver_func_DB1, { player, dim, veh }, handler, "SELECT * FROM fraktionswaffen WHERE Fraktion LIKE 'Biker'" )

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
addEventHandler ( "onMarkerHit", BikerDeliver, BikerDeliver_func )

function BikerGunshopEnter_func ( hitElement )

	if client then
		if client ~= hitElement then
			return
		end
	end

	if getElementType ( hitElement ) == "player" or getElementType ( hitElement ) == "ped" then
		if isBiker(hitElement) then
			triggerClientEvent ( hitElement, "showBikerGunshop", getRootElement() )
			showCursor ( hitElement, true )
			vioSetElementData ( hitElement, "ElementClicked", true )
		else
			outputChatBox ( "Nur f�r Biker!", hitElement, 125, 0, 0 )
		end
	end
end
addEventHandler ( "onMarkerHit", BikerGunshopEnter, BikerGunshopEnter_func )
addEvent( "onBikershopMenuTest", true )
addEventHandler( "onBikershopMenuTest", getRootElement(), BikerGunshopEnter_func )


local function gunbuyBiker_func_DB ( qh, player, itemtype, item, w0, w1, w2, w3, w4, w5, w6, w7 ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		BikerFamkasse = result[1]["DepotGeld"]
		if itemtype == "armor" then
			if vioGetElementData ( player, "money" ) >= armor_price then
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - armor_price )
				takePlayerMoney ( player, armor_price )
				triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				setPedArmor ( player, 100 )
				triggerClientEvent ( player, "sec_armor_give", getRootElement(), 100 )
				local success = 1
				BikerFamkasse = BikerFamkasse + armor_price
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld!\nRuestung kostet\n"..armor_price.." $!", 5000, 125, 0, 0 )
			end
		elseif itemtype == "ammo" then
			if item == "9mmammo" then
				if vioGetElementData ( player, "money" ) >= pistolammo_price then
					if tonumber(BikerPistolenMagazine) >= 1 then
						if w2 == 22 or w2 == 23 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - pistolammo_price )
							takePlayerMoney ( player, pistolammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w2, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w2, 17 )
							success = 1
							MySQL_SetString("fraktionswaffen", "PistolenMagazine", BikerPistolenMagazine-1, "Fraktion LIKE 'Biker'")
							BikerPistolenMagazine = BikerPistolenMagazine-1
							BikerFamkasse = BikerFamkasse + pistolammo_price
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
					if tonumber(BikerDesertEagleMunition) >= 1 then
						if w2 == 24 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - eagleammo_price )
							takePlayerMoney ( player, eagleammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w2, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w2, 7 )
							success = 1
							MySQL_SetString("fraktionswaffen", "DesertEagleMunition", BikerDesertEagleMunition-1, "Fraktion LIKE 'Biker'")
							BikerDesertEagleMunition = BikerDesertEagleMunition-1
							BikerFamkasse = BikerFamkasse + eagleammo_price
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
					if tonumber(BikerMPMunition) >= 1 then
						if w4 == 29 or w4 == 28 then
							local tabu = {}
							tabu[29] = 30
							tabu[28] = 50
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mpammo_price )
							takePlayerMoney ( player, mpammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, getPedWeapon ( player, 4 ), tabu[getPedWeapon ( player, 4 )], true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), getPedWeapon ( player, 4 ), tabu[getPedWeapon ( player, 4 )] )
							success = 1
							MySQL_SetString("fraktionswaffen", "MPMunition", BikerMPMunition-1, "Fraktion LIKE 'Biker'")
							BikerMPMunition = BikerMPMunition-1
							BikerFamkasse = BikerFamkasse + mpammo_price
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
					if tonumber(BikerSchrotflintenMunition) >= 1 then
						if w3 == 25 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shotgunammo_price )
							takePlayerMoney ( player, shotgunammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w3, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w3, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "SchrotflintenMunition", BikerSchrotflintenMunition-1, "Fraktion LIKE 'Biker'")
							BikerSchrotflintenMunition = BikerSchrotflintenMunition-1
							BikerFamkasse = BikerFamkasse + shotgunammo_price
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
					if tonumber(BikerAKMunition) >= 1 then
						if w5 == 30 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - akammo_price )
							takePlayerMoney ( player, akammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w5, 30, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w5, 30 )
							success = 1
							MySQL_SetString("fraktionswaffen", "AKMunition", BikerAKMunition-1, "Fraktion LIKE 'Biker'")
							BikerAKMunition = BikerAKMunition-1
							BikerFamkasse = BikerFamkasse + akammo_price
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
					if tonumber(BikerMMunition) >= 1 then
						if w5 == 31 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mammo_price )
							takePlayerMoney ( player, mammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w5, 50, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w5, 50 )
							success = 1
							MySQL_SetString("fraktionswaffen", "MMunition", BikerMMunition-1, "Fraktion LIKE 'Biker'")
							BikerMMunition = BikerMMunition-1
							BikerFamkasse = BikerFamkasse + mammo_price
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
					if tonumber(BikerGewehrPatronen) >= 1 then
						if w6 == 33 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - gewehrammo_price )
							takePlayerMoney ( player, gewehrammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w6, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "GewehrPatronen", BikerGewehrPatronen-1, "Fraktion LIKE 'Biker'")
							BikerGewehrPatronen = BikerGewehrPatronen-1
							BikerFamkasse = BikerFamkasse + gewehrammo_price
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
					if tonumber(BikerSGewehrMunition) >= 1 then
						if w6 == 34 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sgewehrammo_price )
							takePlayerMoney ( player, sgewehrammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w6, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "SGewehrMunition", BikerSGewehrMunition-1, "Fraktion LIKE 'Biker'")
							BikerSGewehrMunition = BikerSGewehrMunition-1
							BikerFamkasse = BikerFamkasse + sgewehrammo_price
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
					if tonumber(BikerRaketen) >= 1 then
						if w7 == 35 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - rak_price )
							takePlayerMoney ( player, rak_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w7, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w7, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Raketen", BikerRaketen-1, "Fraktion LIKE 'Biker'")
							BikerRaketen = BikerRaketen-1
							BikerFamkasse = BikerFamkasse + rak_price
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
					if tonumber(BikerBaseballschlaeger) >= 1 then
						if w1 ~= 5 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - baseball_price )
							takePlayerMoney ( player, baseball_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 5, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 5, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Baseballschlaeger", BikerBaseballschlaeger-1, "Fraktion LIKE 'Biker'")
							BikerBaseballschlaeger = BikerBaseballschlaeger-1
							BikerFamkasse = BikerFamkasse + baseball_price
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
					if tonumber(BikerSchaufeln) >= 1 then
						if w1 ~= 6 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shovels_price )
							takePlayerMoney ( player, shovels_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 6, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Schaufeln", BikerSchaufeln-1, "Fraktion LIKE 'Biker'")
							BikerSchaufeln = BikerSchaufeln-1
							BikerFamkasse = BikerFamkasse + shovels_price
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
					if tonumber(BikerMesser) >= 1 then
						if w1 ~= 4 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - knife_price )
							takePlayerMoney ( player, knife_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 4, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 4, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Messer", BikerMesser-1, "Fraktion LIKE 'Biker'")
							BikerMesser = BikerMesser-1
							BikerFamkasse = BikerFamkasse + knife_price
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
					if tonumber(BikerSchlagringe) >= 1 then
						if w1 == 0 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - schlagringe_price )
							takePlayerMoney ( player, schlagringe_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 1, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 1, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Schlagringe", BikerSchlagringe-1, "Fraktion LIKE 'Biker'")
							BikerSchlagringe = BikerSchlagringe-1
							BikerFamkasse = BikerFamkasse + schlagringe_price
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
					if tonumber(BikerPistolen) >= 1 then
						if w2 ~= 22 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - pistol_price )
							takePlayerMoney ( player, pistol_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 22, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 22, 17 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Pistolen", BikerPistolen-1, "Fraktion LIKE 'Biker'")
							BikerPistolen = BikerPistolen-1
							BikerFamkasse = BikerFamkasse + pistol_price
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
					if tonumber(BikerSDPistolen) >= 1 then
						if w2 ~= 23 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sdpistol_price )
							takePlayerMoney ( player, sdpistol_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 23, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 23, 17 )
							success = 1
							MySQL_SetString("fraktionswaffen", "SDPistolen", BikerSDPistolen-1, "Fraktion LIKE 'Biker'")
							BikerSDPistolen = BikerSDPistolen-1
							BikerFamkasse = BikerFamkasse + sdpistol_price
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
					if tonumber(BikerDesertEagles) >= 1 then
						if w2 ~= 24 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - eagle_price )
							takePlayerMoney ( player, eagle_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 24, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 24, 7 )
							success = 1
							MySQL_SetString("fraktionswaffen", "DesertEagles", BikerDesertEagles-1, "Fraktion LIKE 'Biker'")
							BikerDesertEagles = BikerDesertEagles-1
							BikerFamkasse = BikerFamkasse + eagle_price
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
					if tonumber(BikerMP) >= 1 then
						if w4 ~= 29 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mp_price )
							takePlayerMoney ( player, mp_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 29, 30, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 29, 30 )
							success = 1
							MySQL_SetString("fraktionswaffen", "MP", BikerMP-1, "Fraktion LIKE 'Biker'")
							BikerMP = BikerMP-1
							BikerFamkasse = BikerFamkasse + mp_price
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
					if tonumber(BikerSchrotflinten) >= 1 then
						if w3 ~= 25 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shotgun_price )
							takePlayerMoney ( player, shotgun_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 25, 5, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 25, 5 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Schrotflinten", BikerSchrotflinten-1, "Fraktion LIKE 'Biker'")
							BikerSchrotflinten = BikerSchrotflinten-1
							BikerFamkasse = BikerFamkasse + shotgun_price
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
					if BikerAK >= 1 then
						if vioGetElementData ( player, "rang" ) >= 2 then
							if w5 ~= 30 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - ak_price )
								takePlayerMoney ( player, ak_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 30, 30, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 30, 30 )
								success = 1
								MySQL_SetString("fraktionswaffen", "AK", BikerAK-1, "Fraktion LIKE 'Biker'")
								BikerAK = BikerAK-1
								BikerFamkasse = BikerFamkasse + ak_price
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
					if tonumber(BikerM) >= 1 then
						if vioGetElementData ( player, "rang" ) >= 2 then
							if w5 ~= 30 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - m_price )
								takePlayerMoney ( player, m_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 31, 50, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 31, 50 )
								success = 1
								MySQL_SetString("fraktionswaffen", "M", BikerM-1, "Fraktion LIKE 'Biker'")
								BikerM = BikerM-1
								BikerFamkasse = BikerFamkasse + m_price
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
					if tonumber(BikerGewehre) >= 1 then
						if  w6 ~= 33 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - gewehr_price )
							takePlayerMoney ( player, gewehr_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 33, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 33, 7 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Gewehre", BikerGewehre-1, "Fraktion LIKE 'Biker'")
							BikerGewehre = BikerGewehre-1
							BikerFamkasse = BikerFamkasse + gewehr_price
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
						if tonumber(BikerSGewehr) >= 1 then
							if w6 ~= 34 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sgewehr_price )
								takePlayerMoney ( player, sgewehr_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 34, 7, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 34, 7 )
								success = 1
								MySQL_SetString("fraktionswaffen", "SGewehr", BikerSGewehr-1, "Fraktion LIKE 'Biker'")
								BikerSGewehr = BikerSGewehr-1
								BikerFamkasse = BikerFamkasse + sgewehr_price
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
					if tonumber(BikerRaketenwerfer) >= 1 then
						if vioGetElementData ( player, "rang" ) >= 4 then
							if w7 ~= 35 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - rakwerfer_price )
								takePlayerMoney ( player, rakwerfer_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 35, 1, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 35, 1 )
								success = 1
								MySQL_SetString("fraktionswaffen", "Raketenwerfer", BikerRaketenwerfer-1, "Fraktion LIKE 'Biker'")
								BikerRaketenwerfer = BikerRaketenwerfer-1
								BikerFamkasse = BikerFamkasse + rakwerfer_price
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
			if item == "uzi" then
				if vioGetElementData ( player, "money" ) >= spezgun_price then
					if tonumber(BikerSpezwaffen) >= 1 then
						if w4 ~= 28 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - spezgun_price )
							takePlayerMoney ( player, spezgun_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 28, 50, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 28, 50 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Spezwaffen", BikerSpezwaffen-1, "Fraktion LIKE 'Biker'")
							BikerSpezwaffen = BikerSpezwaffen-1
							BikerFamkasse = BikerFamkasse + spezgun_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nUzi!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nUzi mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nUzi kostet\n"..spezgun_price.." $!", 5000, 125, 0, 0 )
				end
			end
		end
		if success == 1 then 
			playSoundFrontEnd ( player, 40 )
		end
		dbExec( handler, "UPDATE fraktionen SET DepotGeld=? WHERE Name LIKE 'Biker'", BikerFamkasse )
	end
end

function gunbuyBiker_func ( player, itemtype, item,  w0, w1, w2, w3, w4, w5, w6, w7 )

	local success = 0
	if player == client then
		dbQuery( gunbuyBiker_func_DB, { player, itemtype, w0, w1, w2, w3, w4, w5, w6, w7 }, handler, "SELECT DepotGeld FROM fraktionen WHERE Name LIKE 'Biker'" )
	end
end
addEvent ( "gunbuyBiker", true )
addEventHandler ( "gunbuyBiker", getRootElement(), gunbuyBiker_func )