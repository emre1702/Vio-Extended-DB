TriadenDeliver = createMarker ( -2211.1455078125, 565.84979248047, 49.442939758301, "checkpoint", 7, 0, 125, 0, getRootElement() )
TriadenDeliverBlip = createBlip ( -2211.1455078125, 565.84979248047, 49.442939758301, 19, 2, 255, 0, 0, 255, 0, 99999.0, getRootElement() )
setElementVisibleTo ( TriadenDeliver, getRootElement(), false )
setElementVisibleTo ( TriadenDeliverBlip, getRootElement(), false )
TriadenGunshopEnter = createMarker ( -2186.9372558594, 698.5894165039, 53.9163284301761, "corona", 1, 0, 125, 0, getRootElement() )
createMarker ( 1914.2331542969, 1014.4857788086, 9.8027935028076, "cylinder", 1.5, 125, 0, 0, 125, getRootElement() )
TriadenGunshopEnterCasino = createMarker ( 1914.2331542969, 1014.4857788086, 9.8027935028076 + 1, "corona", 1.5, 0, 0, 0, getRootElement() )

function TriadenDeliver_func ( player, dim )
   
	local veh = getPedOccupiedVehicle ( player )
	if veh then
		if getPedOccupiedVehicleSeat ( player ) == 0 then
			if getElementModel ( veh ) == 455 then
				if vioGetElementData ( veh, "guntruck" ) == 1 then
				
					mafiatransport = 0
					
					TriadenSchlagringe = MySQL_GetString("fraktionswaffen", "Schlagringe", "Fraktion LIKE 'Triaden'")
					TriadenBaseballschlaeger = MySQL_GetString("fraktionswaffen", "Baseballschlaeger", "Fraktion LIKE 'Triaden'")
					TriadenMesser = MySQL_GetString("fraktionswaffen", "Messer", "Fraktion LIKE 'Triaden'")
					TriadenSchaufeln = MySQL_GetString("fraktionswaffen", "Schaufeln", "Fraktion LIKE 'Triaden'")
					TriadenPistolen = MySQL_GetString("fraktionswaffen", "Pistolen", "Fraktion LIKE 'Triaden'")
					TriadenSDPistolen = MySQL_GetString("fraktionswaffen", "SDPistolen", "Fraktion LIKE 'Triaden'")
					TriadenPistolenMagazine = MySQL_GetString("fraktionswaffen", "PistolenMagazine", "Fraktion LIKE 'Triaden'")
					TriadenDesertEagles = MySQL_GetString("fraktionswaffen", "DesertEagles", "Fraktion LIKE 'Triaden'")
					TriadenDesertEagleMunition = MySQL_GetString("fraktionswaffen", "DesertEagleMunition", "Fraktion LIKE 'Triaden'")
					TriadenSchrotflinten = MySQL_GetString("fraktionswaffen", "Schrotflinten", "Fraktion LIKE 'Triaden'")
					TriadenSchrotflintenMunition = MySQL_GetString("fraktionswaffen", "SchrotflintenMunition", "Fraktion LIKE 'Triaden'")
					TriadenMP = MySQL_GetString("fraktionswaffen", "MP", "Fraktion LIKE 'Triaden'")
					TriadenMPMunition = MySQL_GetString("fraktionswaffen", "MPMunition", "Fraktion LIKE 'Triaden'")
					TriadenAK = MySQL_GetString("fraktionswaffen", "AK", "Fraktion LIKE 'Triaden'")
					TriadenAKMunition = MySQL_GetString("fraktionswaffen", "AKMunition", "Fraktion LIKE 'Triaden'")
					TriadenM = MySQL_GetString("fraktionswaffen", "M", "Fraktion LIKE 'Triaden'")
					TriadenMMunition = MySQL_GetString("fraktionswaffen", "MMunition", "Fraktion LIKE 'Triaden'")
					TriadenGewehre = MySQL_GetString("fraktionswaffen", "Gewehre", "Fraktion LIKE 'Triaden'")
					TriadenGewehrPatronen = MySQL_GetString("fraktionswaffen", "GewehrPatronen", "Fraktion LIKE 'Triaden'")
					TriadenSGewehr = MySQL_GetString("fraktionswaffen", "SGewehr", "Fraktion LIKE 'Triaden'")
					TriadenSGewehrMunition = MySQL_GetString("fraktionswaffen", "SGewehrMunition", "Fraktion LIKE 'Triaden'")
					TriadenRaketenwerfer = MySQL_GetString("fraktionswaffen", "Raketenwerfer", "Fraktion LIKE 'Triaden'")
					TriadenRaketen = MySQL_GetString("fraktionswaffen", "Raketen", "Fraktion LIKE 'Triaden'")
					TriadenSpezwaffen = MySQL_GetString("fraktionswaffen", "Spezwaffen", "Fraktion LIKE 'Triaden'")
					TriadenFamkasse = tonumber(MySQL_GetString("fraktionen", "DepotGeld", "Name LIKE 'Triaden'"))
					
					MySQL_SetString("fraktionswaffen", "Schlagringe", vioGetElementData ( veh, "schlagringe" )+TriadenSchlagringe, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "Baseballschlaeger", vioGetElementData ( veh, "baseball" )+TriadenBaseballschlaeger, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "Messer", vioGetElementData ( veh, "knife" )+TriadenMesser, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "Schaufeln", vioGetElementData ( veh, "shovels" )+TriadenSchaufeln, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "Pistolen", vioGetElementData ( veh, "pistol" )+TriadenPistolen, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "SDPistolen", vioGetElementData ( veh, "sdpistol" )+TriadenSDPistolen, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "PistolenMagazine", vioGetElementData ( veh, "pistolammo" )+TriadenPistolenMagazine, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "DesertEagles", vioGetElementData ( veh, "eagle" )+TriadenDesertEagles, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "DesertEagleMunition", vioGetElementData ( veh, "eagleammo" )+TriadenDesertEagleMunition, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "Schrotflinten", vioGetElementData ( veh, "shotgun" )+TriadenSchrotflinten, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "SchrotflintenMunition", vioGetElementData ( veh, "shotgunammo" )+TriadenSchrotflintenMunition, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "MP", vioGetElementData ( veh, "mp" )+TriadenMP, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "MPMunition", vioGetElementData ( veh, "mpammo" )+TriadenMPMunition, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "AK", vioGetElementData ( veh, "ak" )+TriadenAK, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "AKMunition", vioGetElementData ( veh, "akammo" )+TriadenAKMunition, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "M", vioGetElementData ( veh, "m" )+TriadenM, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "MMunition", vioGetElementData ( veh, "mammo" )+TriadenMMunition, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "Gewehre", vioGetElementData ( veh, "gewehr" )+TriadenGewehre, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "GewehrPatronen", vioGetElementData ( veh, "gewehrammo" )+TriadenGewehrPatronen, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "SGewehr", vioGetElementData ( veh, "sgewehr" )+TriadenSGewehr, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "SgewehrMunition", vioGetElementData ( veh, "sgewehrammo" )+TriadenSGewehrMunition, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "Raketenwerfer", vioGetElementData ( veh, "rakwerfer" )+TriadenRaketenwerfer, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "Raketen", vioGetElementData ( veh, "rak" )+TriadenRaketen, "Fraktion LIKE 'Triaden'")
					MySQL_SetString("fraktionswaffen", "Spezwaffen", vioGetElementData ( veh, "spezgun" )+TriadenSpezwaffen, "Fraktion LIKE 'Triaden'")
					
					TriadenSchlagringe = MySQL_GetString("fraktionswaffen", "Schlagringe", "Fraktion LIKE 'Triaden'")
					TriadenBaseballschlaeger = MySQL_GetString("fraktionswaffen", "Baseballschlaeger", "Fraktion LIKE 'Triaden'")
					TriadenMesser = MySQL_GetString("fraktionswaffen", "Messer", "Fraktion LIKE 'Triaden'")
					TriadenSchaufeln = MySQL_GetString("fraktionswaffen", "Schaufeln", "Fraktion LIKE 'Triaden'")
					TriadenPistolen = MySQL_GetString("fraktionswaffen", "Pistolen", "Fraktion LIKE 'Triaden'")
					TriadenSDPistolen = MySQL_GetString("fraktionswaffen", "SDPistolen", "Fraktion LIKE 'Triaden'")
					TriadenPistolenMagazine = MySQL_GetString("fraktionswaffen", "PistolenMagazine", "Fraktion LIKE 'Triaden'")
					TriadenDesertEagles = MySQL_GetString("fraktionswaffen", "DesertEagles", "Fraktion LIKE 'Triaden'")
					TriadenDesertEagleMunition = MySQL_GetString("fraktionswaffen", "DesertEagleMunition", "Fraktion LIKE 'Triaden'")
					TriadenSchrotflinten = MySQL_GetString("fraktionswaffen", "Schrotflinten", "Fraktion LIKE 'Triaden'")
					TriadenSchrotflintenMunition = MySQL_GetString("fraktionswaffen", "SchrotflintenMunition", "Fraktion LIKE 'Triaden'")
					TriadenMP = MySQL_GetString("fraktionswaffen", "MP", "Fraktion LIKE 'Triaden'")
					TriadenMPMunition = MySQL_GetString("fraktionswaffen", "MPMunition", "Fraktion LIKE 'Triaden'")
					TriadenAK = MySQL_GetString("fraktionswaffen", "AK", "Fraktion LIKE 'Triaden'")
					TriadenAKMunition = MySQL_GetString("fraktionswaffen", "AKMunition", "Fraktion LIKE 'Triaden'")
					TriadenM = MySQL_GetString("fraktionswaffen", "M", "Fraktion LIKE 'Triaden'")
					TriadenMMunition = MySQL_GetString("fraktionswaffen", "MMunition", "Fraktion LIKE 'Triaden'")
					TriadenGewehre = MySQL_GetString("fraktionswaffen", "Gewehre", "Fraktion LIKE 'Triaden'")
					TriadenGewehrPatronen = MySQL_GetString("fraktionswaffen", "GewehrPatronen", "Fraktion LIKE 'Triaden'")
					TriadenSGewehr = MySQL_GetString("fraktionswaffen", "SGewehr", "Fraktion LIKE 'Triaden'")
					TriadenSGewehrMunition = MySQL_GetString("fraktionswaffen", "SGewehrMunition", "Fraktion LIKE 'Triaden'")
					TriadenRaketenwerfer = MySQL_GetString("fraktionswaffen", "Raketenwerfer", "Fraktion LIKE 'Triaden'")
					TriadenRaketen = MySQL_GetString("fraktionswaffen", "Raketen", "Fraktion LIKE 'Triaden'")
					TriadenSpezwaffen = MySQL_GetString("fraktionswaffen", "Spezwaffen", "Fraktion LIKE 'Triaden'")
					TriadenFamkasse = TriadenFamkasse - vioGetElementData ( veh, "costs" )
					
					MySQL_SetString("fraktionen", "DepotGeld", TriadenFamkasse, "Name LIKE 'Triaden'")
					outputChatBox ( "Lieferung abgegeben - Du erhaelst "..vioGetElementData ( veh, "costs" ).." $ aus der Familienkasse! zurueck!", player, 0, 125, 0 )
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + vioGetElementData ( veh, "costs" ) )
					givePlayerMoney ( player, vioGetElementData ( veh, "costs" ) )
					if vioGetElementData ( player, "gunloads" ) ~= "done" then 																								-- Achiev: Waffenschieber
						vioSetElementData ( player, "gunloads", vioGetElementData ( player, "gunloads" ) + vioGetElementData ( veh, "costs" ) )										-- Achiev: Waffenschieber
						if vioGetElementData ( player, "gunloads" ) > 50000 then																								-- Achiev: Waffenschieber
							vioSetElementData ( player, "gunloads", "done" )																									-- Achiev: Waffenschieber
							triggerClientEvent ( player, "showAchievmentBox", player, "Waffenschieber", 50, 10000 )															-- Achiev: Waffenschieber
							vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 50 )												-- Achiev: Waffenschieber
							MySQL_SetString("achievments", "Waffenschieber", vioGetElementData ( player, "gunloads" ), "Name LIKE '"..getPlayerName(player).."'")				-- Achiev: Waffenschieber
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
addEventHandler ( "onMarkerHit", TriadenDeliver, TriadenDeliver_func )

function TriadenGunshopEnter_func ( hitElement )

	if getElementType ( hitElement ) == "player" or getElementType ( hitElement ) == "ped" then
		if isTriad(hitElement) then
			triggerClientEvent ( hitElement, "showTriadGunshop", getRootElement() )
			showCursor ( hitElement, true )
			vioSetElementData ( hitElement, "ElementClicked", true )
		else
			outputChatBox ( "Nur für Triaden!", hitElement, 125, 0, 0 )
		end
	end
end
addEventHandler ( "onMarkerHit", TriadenGunshopEnter, TriadenGunshopEnter_func )
addEventHandler ( "onMarkerHit", TriadenGunshopEnterCasino, TriadenGunshopEnter_func )


function gunbuyTriaden_func ( player, itemtype, item,  w0, w1, w2, w3, w4, w5, w6, w7 )

	local success = 0
	if player == client or not client then
		TriadenFamkasse = tonumber(MySQL_GetString("fraktionen", "DepotGeld", "Name LIKE 'Triaden'"))
		if itemtype == "armor" then
			if vioGetElementData ( player, "money" ) >= armor_price then
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - armor_price )
				takePlayerMoney ( player, armor_price )
				triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				setPedArmor ( player, 100 )
				triggerClientEvent ( player, "sec_armor_give", getRootElement(), 100 )
				local success = 1
				TriadenFamkasse = TriadenFamkasse + armor_price
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld!\nRuestung kostet\n"..armor_price.." $!", 5000, 125, 0, 0 )
			end
		elseif itemtype == "ammo" then
			if item == "9mmammo" then
				if vioGetElementData ( player, "money" ) >= pistolammo_price then
					if tonumber(TriadenPistolenMagazine) >= 1 then
						if w2 == 22 or w2 == 23 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - pistolammo_price )
							takePlayerMoney ( player, pistolammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w2, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w2, 17 )
							success = 1
							MySQL_SetString("fraktionswaffen", "PistolenMagazine", TriadenPistolenMagazine-1, "Fraktion LIKE 'Triaden'")
							TriadenPistolenMagazine = TriadenPistolenMagazine-1
							TriadenFamkasse = TriadenFamkasse + pistolammo_price
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
					if tonumber(TriadenDesertEagleMunition) >= 1 then
						if w2 == 24 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - eagleammo_price )
							takePlayerMoney ( player, eagleammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w2, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w2, 7 )
							success = 1
							MySQL_SetString("fraktionswaffen", "DesertEagleMunition", TriadenDesertEagleMunition-1, "Fraktion LIKE 'Triaden'")
							TriadenDesertEagleMunition = TriadenDesertEagleMunition-1
							TriadenFamkasse = TriadenFamkasse + eagleammo_price
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
					if tonumber(TriadenMPMunition) >= 1 then
						if w4 == 29 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mpammo_price )
							takePlayerMoney ( player, mpammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w4, 30, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w4, 30 )
							success = 1
							MySQL_SetString("fraktionswaffen", "MPMunition", TriadenMPMunition-1, "Fraktion LIKE 'Triaden'")
							TriadenMPMunition = TriadenMPMunition-1
							TriadenFamkasse = TriadenFamkasse + mpammo_price
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
					if tonumber(TriadenSchrotflintenMunition) >= 1 then
						if w3 == 25 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shotgunammo_price )
							takePlayerMoney ( player, shotgunammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w3, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w3, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "SchrotflintenMunition", TriadenSchrotflintenMunition-1, "Fraktion LIKE 'Triaden'")
							TriadenSchrotflintenMunition = TriadenSchrotflintenMunition-1
							TriadenFamkasse = TriadenFamkasse + shotgunammo_price
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
					if tonumber(TriadenAKMunition) >= 1 then
						if w5 == 30 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - akammo_price )
							takePlayerMoney ( player, akammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w5, 30, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w5, 30 )
							success = 1
							MySQL_SetString("fraktionswaffen", "AKMunition", TriadenAKMunition-1, "Fraktion LIKE 'Triaden'")
							TriadenAKMunition = TriadenAKMunition-1
							TriadenFamkasse = TriadenFamkasse + akammo_price
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
					if tonumber(TriadenMMunition) >= 1 then
						if w5 == 31 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mammo_price )
							takePlayerMoney ( player, mammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w5, 50, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w5, 50 )
							success = 1
							MySQL_SetString("fraktionswaffen", "MMunition", TriadenMMunition-1, "Fraktion LIKE 'Triaden'")
							TriadenMMunition = TriadenMMunition-1
							TriadenFamkasse = TriadenFamkasse + mammo_price
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
					if tonumber(TriadenGewehrPatronen) >= 1 then
						if w6 == 33 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - gewehrammo_price )
							takePlayerMoney ( player, gewehrammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w6, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "GewehrPatronen", TriadenGewehrPatronen-1, "Fraktion LIKE 'Triaden'")
							TriadenGewehrPatronen = TriadenGewehrPatronen-1
							TriadenFamkasse = TriadenFamkasse + gewehrammo_price
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
					if tonumber(TriadenSGewehrMunition) >= 1 then
						if w6 == 34 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sgewehrammo_price )
							takePlayerMoney ( player, sgewehrammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w6, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "SGewehrMunition", TriadenSGewehrMunition-1, "Fraktion LIKE 'Triaden'")
							TriadenSGewehrMunition = TriadenSGewehrMunition-1
							TriadenFamkasse = TriadenFamkasse + sgewehrammo_price
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
					if tonumber(TriadenRaketen) >= 1 then
						if w7 == 35 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - rak_price )
							takePlayerMoney ( player, rak_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w7, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w7, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Raketen", TriadenRaketen-1, "Fraktion LIKE 'Triaden'")
							TriadenRaketen = TriadenRaketen-1
							TriadenFamkasse = TriadenFamkasse + rak_price
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
					if tonumber(TriadenBaseballschlaeger) >= 1 then
						if w1 ~= 5 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - baseball_price )
							takePlayerMoney ( player, baseball_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 5, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 5, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Baseballschlaeger", TriadenBaseballschlaeger-1, "Fraktion LIKE 'Triaden'")
							TriadenBaseballschlaeger = TriadenBaseballschlaeger-1
							TriadenFamkasse = TriadenFamkasse + baseball_price
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
					if tonumber(TriadenSchaufeln) >= 1 then
						if w1 ~= 6 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shovels_price )
							takePlayerMoney ( player, shovels_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 6, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Schaufeln", TriadenSchaufeln-1, "Fraktion LIKE 'Triaden'")
							TriadenSchaufeln = TriadenSchaufeln-1
							TriadenFamkasse = TriadenFamkasse + shovels_price
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
					if tonumber(TriadenMesser) >= 1 then
						if w1 ~= 4 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - knife_price )
							takePlayerMoney ( player, knife_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 4, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 4, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Messer", TriadenMesser-1, "Fraktion LIKE 'Triaden'")
							TriadenMesser = TriadenMesser-1
							TriadenFamkasse = TriadenFamkasse + knife_price
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
					if tonumber(TriadenSchlagringe) >= 1 then
						if w1 == 0 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - schlagringe_price )
							takePlayerMoney ( player, schlagringe_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 1, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 1, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Schlagringe", TriadenSchlagringe-1, "Fraktion LIKE 'Triaden'")
							TriadenSchlagringe = TriadenSchlagringe-1
							TriadenFamkasse = TriadenFamkasse + schlagringe_price
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
					if tonumber(TriadenPistolen) >= 1 then
						if w2 ~= 22 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - pistol_price )
							takePlayerMoney ( player, pistol_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 22, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 22, 17 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Pistolen", TriadenPistolen-1, "Fraktion LIKE 'Triaden'")
							TriadenPistolen = TriadenPistolen-1
							TriadenFamkasse = TriadenFamkasse + pistol_price
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
					if tonumber(TriadenSDPistolen) >= 1 then
						if w2 ~= 23 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sdpistol_price )
							takePlayerMoney ( player, sdpistol_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 23, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 23, 17 )
							success = 1
							MySQL_SetString("fraktionswaffen", "SDPistolen", TriadenSDPistolen-1, "Fraktion LIKE 'Triaden'")
							TriadenSDPistolen = TriadenSDPistolen-1
							TriadenFamkasse = TriadenFamkasse + sdpistol_price
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
					if tonumber(TriadenDesertEagles) >= 1 then
						if w2 ~= 24 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - eagle_price )
							takePlayerMoney ( player, eagle_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 24, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 24, 7 )
							success = 1
							MySQL_SetString("fraktionswaffen", "DesertEagles", TriadenDesertEagles-1, "Fraktion LIKE 'Triaden'")
							TriadenDesertEagles = TriadenDesertEagles-1
							TriadenFamkasse = TriadenFamkasse + eagle_price
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
					if tonumber(TriadenMP) >= 1 then
						if w4 ~= 29 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mp_price )
							takePlayerMoney ( player, mp_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 29, 30, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 29, 30 )
							success = 1
							MySQL_SetString("fraktionswaffen", "MP", TriadenMP-1, "Fraktion LIKE 'Triaden'")
							TriadenMP = TriadenMP-1
							TriadenFamkasse = TriadenFamkasse + mp_price
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
					if tonumber(TriadenSchrotflinten) >= 1 then
						if w3 ~= 25 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shotgun_price )
							takePlayerMoney ( player, shotgun_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 25, 5, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 25, 5 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Schrotflinten", TriadenSchrotflinten-1, "Fraktion LIKE 'Triaden'")
							TriadenSchrotflinten = TriadenSchrotflinten-1
							TriadenFamkasse = TriadenFamkasse + shotgun_price
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
					if TriadenAK >= 1 then
						if vioGetElementData ( player, "rang" ) >= 2 then
							if w5 ~= 30 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - ak_price )
								takePlayerMoney ( player, ak_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 30, 30, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 30, 30 )
								success = 1
								MySQL_SetString("fraktionswaffen", "AK", TriadenAK-1, "Fraktion LIKE 'Triaden'")
								TriadenAK = TriadenAK-1
								TriadenFamkasse = TriadenFamkasse + ak_price
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
					if tonumber(TriadenM) >= 1 then
						if vioGetElementData ( player, "rang" ) >= 2 then
							if w5 ~= 30 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - m_price )
								takePlayerMoney ( player, m_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 31, 50, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 31, 50 )
								success = 1
								MySQL_SetString("fraktionswaffen", "M", TriadenM-1, "Fraktion LIKE 'Triaden'")
								TriadenM = TriadenM-1
								TriadenFamkasse = TriadenFamkasse + m_price
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
					if tonumber(TriadenGewehre) >= 1 then
						if  w6 ~= 33 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - gewehr_price )
							takePlayerMoney ( player, gewehr_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 33, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 33, 7 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Gewehre", TriadenGewehre-1, "Fraktion LIKE 'Triaden'")
							TriadenGewehre = TriadenGewehre-1
							TriadenFamkasse = TriadenFamkasse + gewehr_price
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
					if tonumber(TriadenSGewehr) >= 1 then
						if vioGetElementData ( player, "rang" ) >= 3 then
							if w6 ~= 34 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sgewehr_price )
								takePlayerMoney ( player, sgewehr_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 34, 7, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 34, 7 )
								success = 1
								MySQL_SetString("fraktionswaffen", "SGewehr", TriadenSGewehr-1, "Fraktion LIKE 'Triaden'")
								TriadenSGewehr = TriadenSGewehr-1
								TriadenFamkasse = TriadenFamkasse + sgewehr_price
							else
								triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits ein\nScharfschuetzen-\ngewehr!", 5000, 125, 0, 0 )
							end
						else
							outputChatBox ( "Du musst mindestens Rang 3 besitzen!", player, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nScharfschuetzen-\ngewehre mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nScharfschuetzen-\ngewehr kostet\n"..sgewehr_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "raketenwerfer" then
				if vioGetElementData ( player, "money" ) >= rakwerfer_price then
					if vioGetElementData ( player, "rang" ) >= 4 then
						if tonumber(TriadenRaketenwerfer) >= 1 then
							if w7 ~= 35 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - rakwerfer_price )
								takePlayerMoney ( player, rakwerfer_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 35, 1, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 35, 1 )
								success = 1
								MySQL_SetString("fraktionswaffen", "Raketenwerfer", TriadenRaketenwerfer-1, "Fraktion LIKE 'Triaden'")
								TriadenRaketenwerfer = TriadenRaketenwerfer-1
								TriadenFamkasse = TriadenFamkasse + rakwerfer_price
							else
								triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits einen\nRaketenwerfer!", 5000, 125, 0, 0 )
							end
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nRaketenwerfer mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
						end
					else
						outputChatBox ( "Du musst mindestens Rang 4 besitzen!", player, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nRaketenwerfer kostet\n"..rakwerfer_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "katana" then
				if vioGetElementData ( player, "money" ) >= spezgun_price then
					if tonumber(TriadenSpezwaffen) >= 1 then
						if w1 ~= 8 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - spezgun_price )
							takePlayerMoney ( player, spezgun_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 8, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 8, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Spezwaffen", TriadenSpezwaffen-1, "Fraktion LIKE 'Triaden'")
							TriadenSpezwaffen = TriadenSpezwaffen-1
							TriadenFamkasse = TriadenFamkasse + spezgun_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nLupara!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nKatanas mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Ein\nKatana kostet\n"..spezgun_price.." $!", 5000, 125, 0, 0 )
				end
			end
		end
		if success == 1 then 
			playSoundFrontEnd ( player, 40 )
		end
		MySQL_SetString("fraktionen", "DepotGeld", TriadenFamkasse, "Name LIKE 'Triaden'")
	end
end
addEvent ( "gunbuyTriaden", true )
addEventHandler ( "gunbuyTriaden", getRootElement(), gunbuyTriaden_func )