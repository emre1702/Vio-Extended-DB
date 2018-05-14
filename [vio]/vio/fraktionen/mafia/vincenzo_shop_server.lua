local function gunbuy_func_DB ( qh, player, itemtype, item,  w0, w1, w2, w3, w4, w5, w6, w7 )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		MafiaFamkasse = result[1]["DepotGeld"]
		local success = 0
		if itemtype == "armor" then
			if vioGetElementData ( player, "money" ) >= armor_price then
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - armor_price )
				takePlayerMoney ( player, armor_price )
				triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				setPedArmor ( player, 100 )
				triggerClientEvent ( player, "sec_armor_give", getRootElement(), 100 )
				local success = 1
				MafiaFamkasse = MafiaFamkasse + armor_price
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld!\nRuestung kostet\n"..armor_price.." $!", 5000, 125, 0, 0 )
			end
		elseif itemtype == "ammo" then
			if item == "9mmammo" then
				if vioGetElementData ( player, "money" ) >= pistolammo_price then
					if tonumber(MafiaPistolenMagazine) >= 1 then
						if w2 == 22 or w2 == 23 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - pistolammo_price )
							takePlayerMoney ( player, pistolammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w2, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w2, 17 )
							success = 1
							MySQL_SetString("fraktionswaffen", "PistolenMagazine", MafiaPistolenMagazine-1, "Fraktion LIKE 'Mafia'")
							MafiaPistolenMagazine = MafiaPistolenMagazine-1
							MafiaFamkasse = MafiaFamkasse + pistolammo_price
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
					if tonumber(MafiaDesertEagleMunition) >= 1 then
						if w2 == 24 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - eagleammo_price )
							takePlayerMoney ( player, eagleammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w2, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w2, 7 )
							success = 1
							MySQL_SetString("fraktionswaffen", "DesertEagleMunition", MafiaDesertEagleMunition-1, "Fraktion LIKE 'Mafia'")
							MafiaDesertEagleMunition = MafiaDesertEagleMunition-1
							MafiaFamkasse = MafiaFamkasse + eagleammo_price
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
					if tonumber(MafiaMPMunition) >= 1 then
						if w4 == 29 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mpammo_price )
							takePlayerMoney ( player, mpammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w4, 30, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w4, 30 )
							success = 1
							MySQL_SetString("fraktionswaffen", "MPMunition", MafiaMPMunition-1, "Fraktion LIKE 'Mafia'")
							MafiaMPMunition = MafiaMPMunition-1
							MafiaFamkasse = MafiaFamkasse + mpammo_price
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
					if tonumber(MafiaSchrotflintenMunition) >= 1 then
						if w3 == 25 or w3 == 26 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shotgunammo_price )
							takePlayerMoney ( player, shotgunammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w3, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w3, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "SchrotflintenMunition", MafiaSchrotflintenMunition-1, "Fraktion LIKE 'Mafia'")
							MafiaSchrotflintenMunition = MafiaSchrotflintenMunition-1
							MafiaFamkasse = MafiaFamkasse + shotgunammo_price
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
					if tonumber(MafiaAKMunition) >= 1 then
						if w5 == 30 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - akammo_price )
							takePlayerMoney ( player, akammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w5, 30, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w5, 30 )
							success = 1
							MySQL_SetString("fraktionswaffen", "AKMunition", MafiaAKMunition-1, "Fraktion LIKE 'Mafia'")
							MafiaAKMunition = MafiaAKMunition-1
							MafiaFamkasse = MafiaFamkasse + akammo_price
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
					if tonumber(MafiaMMunition) >= 1 then
						if w5 == 31 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mammo_price )
							takePlayerMoney ( player, mammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w5, 50, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w5, 50 )
							success = 1
							MySQL_SetString("fraktionswaffen", "MMunition", MafiaMMunition-1, "Fraktion LIKE 'Mafia'")
							MafiaMMunition = MafiaMMunition-1
							MafiaFamkasse = MafiaFamkasse + mammo_price
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
					if tonumber(MafiaGewehrPatronen) >= 1 then
						if w6 == 33 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - gewehrammo_price )
							takePlayerMoney ( player, gewehrammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w6, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "GewehrPatronen", MafiaGewehrPatronen-1, "Fraktion LIKE 'Mafia'")
							MafiaGewehrPatronen = MafiaGewehrPatronen-1
							MafiaFamkasse = MafiaFamkasse + gewehrammo_price
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
					if tonumber(MafiaSGewehrMunition) >= 1 then
						if w6 == 34 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sgewehrammo_price )
							takePlayerMoney ( player, sgewehrammo_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w6, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "SGewehrMunition", MafiaSGewehrMunition-1, "Fraktion LIKE 'Mafia'")
							MafiaSGewehrMunition = MafiaSGewehrMunition-1
							MafiaFamkasse = MafiaFamkasse + sgewehrammo_price
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
					if tonumber(MafiaRaketen) >= 1 then
						if w7 == 35 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - rak_price )
							takePlayerMoney ( player, rak_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, w7, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), w7, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Raketen", MafiaRaketen-1, "Fraktion LIKE 'Mafia'")
							MafiaRaketen = MafiaRaketen-1
							MafiaFamkasse = MafiaFamkasse + rak_price
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
					if tonumber(MafiaBaseballschlaeger) >= 1 then
						if w1 ~= 5 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - baseball_price )
							takePlayerMoney ( player, baseball_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 5, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 5, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Baseballschlaeger", MafiaBaseballschlaeger-1, "Fraktion LIKE 'Mafia'")
							MafiaBaseballschlaeger = MafiaBaseballschlaeger-1
							MafiaFamkasse = MafiaFamkasse + baseball_price
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
					if tonumber(MafiaSchaufeln) >= 1 then
						if w1 ~= 6 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shovels_price )
							takePlayerMoney ( player, shovels_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 6, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 6, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Schaufeln", MafiaSchaufeln-1, "Fraktion LIKE 'Mafia'")
							MafiaSchaufeln = MafiaSchaufeln-1
							MafiaFamkasse = MafiaFamkasse + shovels_price
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
					if tonumber(MafiaMesser) >= 1 then
						if w1 ~= 4 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - knife_price )
							takePlayerMoney ( player, knife_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 4, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 4, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Messer", MafiaMesser-1, "Fraktion LIKE 'Mafia'")
							MafiaMesser = MafiaMesser-1
							MafiaFamkasse = MafiaFamkasse + knife_price
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
					if tonumber(MafiaSchlagringe) >= 1 then
						if w1 == 0 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - schlagringe_price )
							takePlayerMoney ( player, schlagringe_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 1, 1, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 1, 1 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Schlagringe", MafiaSchlagringe-1, "Fraktion LIKE 'Mafia'")
							MafiaSchlagringe = MafiaSchlagringe-1
							MafiaFamkasse = MafiaFamkasse + schlagringe_price
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
					if tonumber(MafiaPistolen) >= 1 then
						if w2 ~= 22 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - pistol_price )
							takePlayerMoney ( player, pistol_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 22, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 22, 17 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Pistolen", MafiaPistolen-1, "Fraktion LIKE 'Mafia'")
							MafiaPistolen = MafiaPistolen-1
							MafiaFamkasse = MafiaFamkasse + pistol_price
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
					if tonumber(MafiaSDPistolen) >= 1 then
						if w2 ~= 23 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sdpistol_price )
							takePlayerMoney ( player, sdpistol_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 23, 17, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 23, 17 )
							success = 1
							MySQL_SetString("fraktionswaffen", "SDPistolen", MafiaSDPistolen-1, "Fraktion LIKE 'Mafia'")
							MafiaSDPistolen = MafiaSDPistolen-1
							MafiaFamkasse = MafiaFamkasse + sdpistol_price
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
					if tonumber(MafiaDesertEagles) >= 1 then
						if w2 ~= 24 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - eagle_price )
							takePlayerMoney ( player, eagle_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 24, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 24, 7 )
							success = 1
							MySQL_SetString("fraktionswaffen", "DesertEagles", MafiaDesertEagles-1, "Fraktion LIKE 'Mafia'")
							MafiaDesertEagles = MafiaDesertEagles-1
							MafiaFamkasse = MafiaFamkasse + eagle_price
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
					if tonumber(MafiaMP) >= 1 then
						if w4 ~= 29 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - mp_price )
							takePlayerMoney ( player, mp_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 29, 30, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 29, 30 )
							success = 1
							MySQL_SetString("fraktionswaffen", "MP", MafiaMP-1, "Fraktion LIKE 'Mafia'")
							MafiaMP = MafiaMP-1
							MafiaFamkasse = MafiaFamkasse + mp_price
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
					if tonumber(MafiaSchrotflinten) >= 1 then
						if w3 ~= 25 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - shotgun_price )
							takePlayerMoney ( player, shotgun_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 25, 5, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 25, 5 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Schrotflinten", MafiaSchrotflinten-1, "Fraktion LIKE 'Mafia'")
							MafiaSchrotflinten = MafiaSchrotflinten-1
							MafiaFamkasse = MafiaFamkasse + shotgun_price
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
					if MafiaAK >= 1 then
						if vioGetElementData ( player, "rang" ) >= 2 then
							if w5 ~= 30 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - ak_price )
								takePlayerMoney ( player, ak_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 30, 30, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 30, 30 )
								success = 1
								MySQL_SetString("fraktionswaffen", "AK", MafiaAK-1, "Fraktion LIKE 'Mafia'")
								MafiaAK = MafiaAK-1
								MafiaFamkasse = MafiaFamkasse + ak_price
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
					if vioGetElementData ( player, "rang" ) >= 2 then
						if tonumber(MafiaM) >= 1 then
							if w5 ~= 30 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - m_price )
								takePlayerMoney ( player, m_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 31, 50, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 31, 50 )
								success = 1
								MySQL_SetString("fraktionswaffen", "M", MafiaM-1, "Fraktion LIKE 'Mafia'")
								MafiaM = MafiaM-1
								MafiaFamkasse = MafiaFamkasse + m_price
							else
								triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nM4!", 5000, 125, 0, 0 )
							end
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "Es ist keine\nM4 mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
						end
					else
						outputChatBox ( "Du musst mindestens Rang 2 besitzen!", player, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nM4 kostet\n"..m_price.." $!", 5000, 125, 0, 0 )
				end
			end
			if item == "gewehr" then
				if vioGetElementData ( player, "money" ) >= gewehr_price then
					if tonumber(MafiaGewehre) >= 1 then
						if  w6 ~= 33 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - gewehr_price )
							takePlayerMoney ( player, gewehr_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 33, 7, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 33, 7 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Gewehre", MafiaGewehre-1, "Fraktion LIKE 'Mafia'")
							MafiaGewehre = MafiaGewehre-1
							MafiaFamkasse = MafiaFamkasse + gewehr_price
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
						if tonumber(MafiaSGewehr) >= 1 then
							if w6 ~= 34 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - sgewehr_price )
								takePlayerMoney ( player, sgewehr_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 34, 7, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 34, 7 )
								success = 1
								MySQL_SetString("fraktionswaffen", "SGewehr", MafiaSGewehr-1, "Fraktion LIKE 'Mafia'")
								MafiaSGewehr = MafiaSGewehr-1
								MafiaFamkasse = MafiaFamkasse + sgewehr_price
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
					if vioGetElementData ( player, "rang" ) >= 4 then
						if tonumber(MafiaRaketenwerfer) >= 1 then
							if w7 ~= 35 then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - rakwerfer_price )
								takePlayerMoney ( player, rakwerfer_price )
								triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
								triggerClientEvent ( player, "hudEinblendenDmg", player, player )
								giveWeapon ( player, 35, 1, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 35, 1 )
								success = 1
								MySQL_SetString("fraktionswaffen", "Raketenwerfer", MafiaRaketenwerfer-1, "Fraktion LIKE 'Mafia'")
								MafiaRaketenwerfer = MafiaRaketenwerfer-1
								MafiaFamkasse = MafiaFamkasse + rakwerfer_price
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
			if item == "lupara" then
				if vioGetElementData ( player, "money" ) >= spezgun_price then
					if tonumber(MafiaSpezwaffen) >= 1 then
						if w3 ~= 26 then
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - spezgun_price )
							takePlayerMoney ( player, spezgun_price )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
							triggerClientEvent ( player, "hudEinblendenDmg", player, player )
							giveWeapon ( player, 26, 6, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), 26, 6 )
							success = 1
							MySQL_SetString("fraktionswaffen", "Spezwaffen", MafiaSpezwaffen-1, "Fraktion LIKE 'Mafia'")
							MafiaSpezwaffen = MafiaSpezwaffen-1
							MafiaFamkasse = MafiaFamkasse + spezgun_price
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nbereits eine\nLupara!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Es sind keine\nLuparas mehr\nauf Lager! Warte\nauf die naechste\nLieferung!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld! Eine\nLupara kostet\n"..spezgun_price.." $!", 5000, 125, 0, 0 )
				end
			end
		end
		if success == 1 then 
			playSoundFrontEnd ( player, 40 )
		end
		dbExec( handler, "UPDATE fraktionen SET DepotGeld = ? WHERE Name LIKE 'Mafia'", MafiaFamkasse )
	end
end

function gunbuy_func ( player, itemtype, item,  w0, w1, w2, w3, w4, w5, w6, w7 )
	if isMafia ( client ) then
		if player == client then
			dbQuery( gunbuy_func_DB, { player, itemtype, item,  w0, w1, w2, w3, w4, w5, w6, w7 }, handler, "SELECT DepotGeld FROM fraktionen WHERE Name LIKE 'Mafia'") 
		end
	end
end
addEvent ( "gunbuy", true )
addEventHandler ( "gunbuy", getRootElement(), gunbuy_func )