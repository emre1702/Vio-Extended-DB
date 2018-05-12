AztecasDeliver = createMarker ( -719.68328857422, 2449.1420898438, 125.38581848145, "checkpoint", 7, 0, 125, 0, getRootElement() )
AztecasDeliverBlip = createBlip ( -719.68328857422, 2449.1420898438, 125.38581848145, 19, 2, 255, 0, 0, 255, 0, 99999.0, getRootElement() )
setElementVisibleTo ( AztecasDeliver, getRootElement(), false )
setElementVisibleTo ( AztecasDeliverBlip, getRootElement(), false )
AztecasGunshopEnter = createMarker ( -772.33239746094, 2412.0576171875, 157.06886291504, "corona", 1, 0, 125, 0, getRootElement() )

function AztecasDeliver_func ( player, dim )
   
	local veh = getPedOccupiedVehicle ( player )
	if veh then
		if getPedOccupiedVehicleSeat ( player ) == 0 then
			if getElementModel ( veh ) == 455 then
				if vioGetElementData ( veh, "guntruck" ) == 1 then
				
					mafiatransport = 0
					
					AztecasSchlagringe = MySQL_GetString("fraktionswaffen", "Schlagringe", "Fraktion LIKE 'Aztecas'")
					AztecasBaseballschlaeger = MySQL_GetString("fraktionswaffen", "Baseballschlaeger", "Fraktion LIKE 'Aztecas'")
					AztecasMesser = MySQL_GetString("fraktionswaffen", "Messer", "Fraktion LIKE 'Aztecas'")
					AztecasSchaufeln = MySQL_GetString("fraktionswaffen", "Schaufeln", "Fraktion LIKE 'Aztecas'")
					AztecasPistolen = MySQL_GetString("fraktionswaffen", "Pistolen", "Fraktion LIKE 'Aztecas'")
					AztecasSDPistolen = MySQL_GetString("fraktionswaffen", "SDPistolen", "Fraktion LIKE 'Aztecas'")
					AztecasPistolenMagazine = MySQL_GetString("fraktionswaffen", "PistolenMagazine", "Fraktion LIKE 'Aztecas'")
					AztecasDesertEagles = MySQL_GetString("fraktionswaffen", "DesertEagles", "Fraktion LIKE 'Aztecas'")
					AztecasDesertEagleMunition = MySQL_GetString("fraktionswaffen", "DesertEagleMunition", "Fraktion LIKE 'Aztecas'")
					AztecasSchrotflinten = MySQL_GetString("fraktionswaffen", "Schrotflinten", "Fraktion LIKE 'Aztecas'")
					AztecasSchrotflintenMunition = MySQL_GetString("fraktionswaffen", "SchrotflintenMunition", "Fraktion LIKE 'Aztecas'")
					AztecasMP = MySQL_GetString("fraktionswaffen", "MP", "Fraktion LIKE 'Aztecas'")
					AztecasMPMunition = MySQL_GetString("fraktionswaffen", "MPMunition", "Fraktion LIKE 'Aztecas'")
					AztecasAK = MySQL_GetString("fraktionswaffen", "AK", "Fraktion LIKE 'Aztecas'")
					AztecasAKMunition = MySQL_GetString("fraktionswaffen", "AKMunition", "Fraktion LIKE 'Aztecas'")
					AztecasM = MySQL_GetString("fraktionswaffen", "M", "Fraktion LIKE 'Aztecas'")
					AztecasMMunition = MySQL_GetString("fraktionswaffen", "MMunition", "Fraktion LIKE 'Aztecas'")
					AztecasGewehre = MySQL_GetString("fraktionswaffen", "Gewehre", "Fraktion LIKE 'Aztecas'")
					AztecasGewehrPatronen = MySQL_GetString("fraktionswaffen", "GewehrPatronen", "Fraktion LIKE 'Aztecas'")
					AztecasSGewehr = MySQL_GetString("fraktionswaffen", "SGewehr", "Fraktion LIKE 'Aztecas'")
					AztecasSGewehrMunition = MySQL_GetString("fraktionswaffen", "SGewehrMunition", "Fraktion LIKE 'Aztecas'")
					AztecasRaketenwerfer = MySQL_GetString("fraktionswaffen", "Raketenwerfer", "Fraktion LIKE 'Aztecas'")
					AztecasRaketen = MySQL_GetString("fraktionswaffen", "Raketen", "Fraktion LIKE 'Aztecas'")
					AztecasSpezwaffen = MySQL_GetString("fraktionswaffen", "Spezwaffen", "Fraktion LIKE 'Aztecas'")
					AztecasFamkasse = tonumber(MySQL_GetString("fraktionen", "DepotGeld", "Name LIKE 'Aztecas'"))
					
					MySQL_SetString("fraktionswaffen", "Schlagringe", vioGetElementData ( veh, "schlagringe" )+AztecasSchlagringe, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "Baseballschlaeger", vioGetElementData ( veh, "baseball" )+AztecasBaseballschlaeger, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "Messer", vioGetElementData ( veh, "knife" )+AztecasMesser, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "Schaufeln", vioGetElementData ( veh, "shovels" )+AztecasSchaufeln, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "Pistolen", vioGetElementData ( veh, "pistol" )+AztecasPistolen, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "SDPistolen", vioGetElementData ( veh, "sdpistol" )+AztecasSDPistolen, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "PistolenMagazine", vioGetElementData ( veh, "pistolammo" )+AztecasPistolenMagazine, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "DesertEagles", vioGetElementData ( veh, "eagle" )+AztecasDesertEagles, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "DesertEagleMunition", vioGetElementData ( veh, "eagleammo" )+AztecasDesertEagleMunition, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "Schrotflinten", vioGetElementData ( veh, "shotgun" )+AztecasSchrotflinten, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "SchrotflintenMunition", vioGetElementData ( veh, "shotgunammo" )+AztecasSchrotflintenMunition, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "MP", vioGetElementData ( veh, "mp" )+AztecasMP, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "MPMunition", vioGetElementData ( veh, "mpammo" )+AztecasMPMunition, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "AK", vioGetElementData ( veh, "ak" )+AztecasAK, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "AKMunition", vioGetElementData ( veh, "akammo" )+AztecasAKMunition, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "M", vioGetElementData ( veh, "m" )+AztecasM, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "MMunition", vioGetElementData ( veh, "mammo" )+AztecasMMunition, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "Gewehre", vioGetElementData ( veh, "gewehr" )+AztecasGewehre, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "GewehrPatronen", vioGetElementData ( veh, "gewehrammo" )+AztecasGewehrPatronen, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "SGewehr", vioGetElementData ( veh, "sgewehr" )+AztecasSGewehr, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "SgewehrMunition", vioGetElementData ( veh, "sgewehrammo" )+AztecasSGewehrMunition, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "Raketenwerfer", vioGetElementData ( veh, "rakwerfer" )+AztecasRaketenwerfer, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "Raketen", vioGetElementData ( veh, "rak" )+AztecasRaketen, "Fraktion LIKE 'Aztecas'")
					MySQL_SetString("fraktionswaffen", "Spezwaffen", vioGetElementData ( veh, "spezgun" )+AztecasSpezwaffen, "Fraktion LIKE 'Aztecas'")
					
					AztecasSchlagringe = MySQL_GetString("fraktionswaffen", "Schlagringe", "Fraktion LIKE 'Aztecas'")
					AztecasBaseballschlaeger = MySQL_GetString("fraktionswaffen", "Baseballschlaeger", "Fraktion LIKE 'Aztecas'")
					AztecasMesser = MySQL_GetString("fraktionswaffen", "Messer", "Fraktion LIKE 'Aztecas'")
					AztecasSchaufeln = MySQL_GetString("fraktionswaffen", "Schaufeln", "Fraktion LIKE 'Aztecas'")
					AztecasPistolen = MySQL_GetString("fraktionswaffen", "Pistolen", "Fraktion LIKE 'Aztecas'")
					AztecasSDPistolen = MySQL_GetString("fraktionswaffen", "SDPistolen", "Fraktion LIKE 'Aztecas'")
					AztecasPistolenMagazine = MySQL_GetString("fraktionswaffen", "PistolenMagazine", "Fraktion LIKE 'Aztecas'")
					AztecasDesertEagles = MySQL_GetString("fraktionswaffen", "DesertEagles", "Fraktion LIKE 'Aztecas'")
					AztecasDesertEagleMunition = MySQL_GetString("fraktionswaffen", "DesertEagleMunition", "Fraktion LIKE 'Aztecas'")
					AztecasSchrotflinten = MySQL_GetString("fraktionswaffen", "Schrotflinten", "Fraktion LIKE 'Aztecas'")
					AztecasSchrotflintenMunition = MySQL_GetString("fraktionswaffen", "SchrotflintenMunition", "Fraktion LIKE 'Aztecas'")
					AztecasMP = MySQL_GetString("fraktionswaffen", "MP", "Fraktion LIKE 'Aztecas'")
					AztecasMPMunition = MySQL_GetString("fraktionswaffen", "MPMunition", "Fraktion LIKE 'Aztecas'")
					AztecasAK = MySQL_GetString("fraktionswaffen", "AK", "Fraktion LIKE 'Aztecas'")
					AztecasAKMunition = MySQL_GetString("fraktionswaffen", "AKMunition", "Fraktion LIKE 'Aztecas'")
					AztecasM = MySQL_GetString("fraktionswaffen", "M", "Fraktion LIKE 'Aztecas'")
					AztecasMMunition = MySQL_GetString("fraktionswaffen", "MMunition", "Fraktion LIKE 'Aztecas'")
					AztecasGewehre = MySQL_GetString("fraktionswaffen", "Gewehre", "Fraktion LIKE 'Aztecas'")
					AztecasGewehrPatronen = MySQL_GetString("fraktionswaffen", "GewehrPatronen", "Fraktion LIKE 'Aztecas'")
					AztecasSGewehr = MySQL_GetString("fraktionswaffen", "SGewehr", "Fraktion LIKE 'Aztecas'")
					AztecasSGewehrMunition = MySQL_GetString("fraktionswaffen", "SGewehrMunition", "Fraktion LIKE 'Aztecas'")
					AztecasRaketenwerfer = MySQL_GetString("fraktionswaffen", "Raketenwerfer", "Fraktion LIKE 'Aztecas'")
					AztecasRaketen = MySQL_GetString("fraktionswaffen", "Raketen", "Fraktion LIKE 'Aztecas'")
					AztecasSpezwaffen = MySQL_GetString("fraktionswaffen", "Spezwaffen", "Fraktion LIKE 'Aztecas'")
					AztecasFamkasse = AztecasFamkasse - vioGetElementData ( veh, "costs" )
					
					MySQL_SetString("fraktionen", "DepotGeld", AztecasFamkasse, "Name LIKE 'Aztecas'")
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

function gunbuyAztecas_func ( player, itemtype, item,  w0, w1, w2, w3, w4, w5, w6, w7 )

	local success = 0
	if player == client then
		AztecasFamkasse = tonumber(MySQL_GetString("fraktionen", "DepotGeld", "Name LIKE 'Aztecas'"))
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
							MySQL_SetString("fraktionswaffen", "PistolenMagazine", AztecasPistolenMagazine-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "DesertEagleMunition", AztecasDesertEagleMunition-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "MPMunition", AztecasMPMunition-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "SchrotflintenMunition", AztecasSchrotflintenMunition-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "AKMunition", AztecasAKMunition-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "MMunition", AztecasMMunition-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "GewehrPatronen", AztecasGewehrPatronen-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "SGewehrMunition", AztecasSGewehrMunition-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "Raketen", AztecasRaketen-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "Baseballschlaeger", AztecasBaseballschlaeger-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "Schaufeln", AztecasSchaufeln-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "Messer", AztecasMesser-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "Schlagringe", AztecasSchlagringe-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "Pistolen", AztecasPistolen-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "SDPistolen", AztecasSDPistolen-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "DesertEagles", AztecasDesertEagles-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "MP", AztecasMP-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "Schrotflinten", AztecasSchrotflinten-1, "Fraktion LIKE 'Aztecas'")
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
								MySQL_SetString("fraktionswaffen", "AK", AztecasAK-1, "Fraktion LIKE 'Aztecas'")
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
								MySQL_SetString("fraktionswaffen", "M", AztecasM-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "Gewehre", AztecasGewehre-1, "Fraktion LIKE 'Aztecas'")
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
								MySQL_SetString("fraktionswaffen", "SGewehr", AztecasSGewehr-1, "Fraktion LIKE 'Aztecas'")
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
								MySQL_SetString("fraktionswaffen", "Raketenwerfer", AztecasRaketenwerfer-1, "Fraktion LIKE 'Aztecas'")
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
							MySQL_SetString("fraktionswaffen", "Spezwaffen", AztecasSpezwaffen-1, "Fraktion LIKE 'Aztecas'")
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
		MySQL_SetString("fraktionen", "DepotGeld", AztecasFamkasse, "Name LIKE 'Aztecas'")
	end
end
addEvent ( "gunbuyAztecas", true )
addEventHandler ( "gunbuyAztecas", getRootElement(), gunbuyAztecas_func )