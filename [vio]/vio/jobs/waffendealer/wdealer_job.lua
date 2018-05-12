wdealerjobicon = createPickup ( -2627.5083007813, 209.36631774902, 4.1959328651428, 3, 1239, 100, 0 )

function wdealerjobiconHit ( player )
	
	if vioGetElementData ( player, "job" ) == "wdealer" then
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nTippe /buymats, um\ndir 10 Materialien\nfuer 200 $ zu\nkaufen!", 7000, 200, 200, 0 )
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Tippe /job, um\nWaffendealer zu werden.\nDazu brauchst\ndu einen Waffen-\nschein.", 7000, 200, 200, 0 )
	end
end
addEventHandler ( "onPickupHit", wdealerjobicon, wdealerjobiconHit )

function sellgun_func ( player, cmd, target, ggst, ammo )

	local target = getPlayerFromName ( target )
	if target then
		if tonumber(vioGetElementData ( target, "gunlicense" )) == 1 then
			local tx, ty, tz = getElementPosition ( target )
			local x, y, z = getElementPosition ( player )
			if getDistanceBetweenPoints3D ( tx, ty, tz, x, y, z ) < 10 then
				local sellingFromGunTruckVan = false
				local veh = getPedOccupiedVehicle ( player )
				if veh then
					--print ( "1" )
					if vioGetElementData ( veh, "mats" ) then
						local faction = getPlayerFaction ( player )
						if faction ~= 9 then
							outputChatBox ( "Du hast keinen Schluessel fuer den Materialien-Tresor!", player, 125, 0, 0 )
							return
						end
					
						sellingFromGunTruckVan = true
						--print ( "2" )
					end
				end
				--outputChatBox ( tostring ( vioGetElementData ( getPedOccupiedVehicle ( player ), "mats" ) ) )
				if not sellingFromGunTruckVan then
					mats = tonumber ( vioGetElementData ( player, "mats" ) )
				else
					mats = vioGetElementData ( veh, "mats" )
				end
				vioSetElementData ( player, "lastcrime", "mats" )
				if ggst == "9mmsd" then
					if mats >= 10 then
						if sellingFromGunTruckVan then
							vioSetElementData ( getPedOccupiedVehicle ( player ), "mats", mats - 10 )
						else
							vioSetElementData ( player, "mats", mats - 10 )
						end
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( target, 40 )
						
						local weapon = 23
						local ammo = 85
						giveWeapon ( target, weapon, ammo, true )
					else infobox ( player, "Du hast nicht\ngenug Materialien!", 5000, 125, 0, 0 ) end
				elseif ggst == "9mm" then
					if mats >= 7 then
						if sellingFromGunTruckVan then
							vioSetElementData ( getPedOccupiedVehicle ( player ), "mats", mats - 7 )
						else
							vioSetElementData ( player, "mats", mats - 7 )
						end
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( target, 40 )
						
						local weapon = 22
						local ammo = 85
						giveWeapon ( target, weapon, ammo, true )
					else infobox ( player, "Du hast nicht\ngenug Materialien!", 5000, 125, 0, 0 ) end
				elseif ggst == "eagle" then
					if mats >= 20 then
						if sellingFromGunTruckVan then
							vioSetElementData ( getPedOccupiedVehicle ( player ), "mats", mats - 20 )
						else
							vioSetElementData ( player, "mats", mats - 20 )
						end
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( target, 40 )
						
						local weapon = 24
						local ammo = 35
						giveWeapon ( target, weapon, ammo, true )
					else infobox ( player, "Du hast nicht\ngenug Materialien!", 5000, 125, 0, 0 ) end
				elseif ggst == "shotgun" then
					if mats >= 10 then
						if sellingFromGunTruckVan then
							vioSetElementData ( getPedOccupiedVehicle ( player ), "mats", mats - 10 )
						else
							vioSetElementData ( player, "mats", mats - 10 )
						end
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( target, 40 )
						
						local weapon = 25
						local ammo = 15
						giveWeapon ( target, weapon, ammo, true )
					else infobox ( player, "Du hast nicht\ngenug Materialien!", 5000, 125, 0, 0 ) end
				elseif ggst == "mp5" then
					if mats >= 17 then
						if sellingFromGunTruckVan then
							vioSetElementData ( getPedOccupiedVehicle ( player ), "mats", mats - 17 )
						else
							vioSetElementData ( player, "mats", mats - 17 )
						end
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( target, 40 )
						
						local weapon = 29
						local ammo = 150
						giveWeapon ( target, weapon, ammo, true )
					else infobox ( player, "Du hast nicht\ngenug Materialien!", 5000, 125, 0, 0 ) end
				elseif ggst == "messer" then
					if mats >= 3 then
						if sellingFromGunTruckVan then
							vioSetElementData ( getPedOccupiedVehicle ( player ), "mats", mats - 3 )
						else
							vioSetElementData ( player, "mats", mats - 3 )
						end
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( target, 40 )
						
						local weapon = 4
						local ammo = 1
						giveWeapon ( target, weapon, ammo, true )
					else infobox ( player, "Du hast nicht\ngenug Materialien!", 5000, 125, 0, 0 ) end
				elseif ggst == "gewehr" then
					if mats >= 10 then
						if sellingFromGunTruckVan then
							vioSetElementData ( getPedOccupiedVehicle ( player ), "mats", mats - 10 )
						else
							vioSetElementData ( player, "mats", mats - 10 )
						end
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( target, 40 )
						
						local weapon = 33
						local ammo = 15
						giveWeapon ( target, weapon, ammo, true )
					else infobox ( player, "Du hast nicht\ngenug Materialien!", 5000, 125, 0, 0 ) end
				elseif ggst == "ak47" then
					if mats >= 25 then
						if sellingFromGunTruckVan then
							vioSetElementData ( getPedOccupiedVehicle ( player ), "mats", mats - 25 )
						else
							vioSetElementData ( player, "mats", mats - 25 )
						end
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( target, 40 )
						
						local weapon = 30
						local ammo = 150
						giveWeapon ( target, weapon, ammo, true )
					else infobox ( player, "Du hast nicht\ngenug Materialien!", 5000, 125, 0, 0 ) end
				elseif ggst == "mats" and not sellingFromGunTruckVan then
					if not ammo then ammo = 5 else ammo = tonumber ( ammo ) end
					if mats >= ammo then
						vioSetElementData ( player, "mats", mats - ammo )
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( target, 40 )
						
						vioSetElementData ( target, "mats", tonumber ( vioGetElementData ( target, "mats" ) ) + ammo )
						outputChatBox ( "Du hast soeben "..ammo.." Materialien erhalten!", target, 0, 125, 0 )
						outputChatBox ( "Du hast soeben "..ammo.." Materialien an "..getPlayerName(target).." gegeben!", player, 0, 125, 0 )
					else
						infobox ( player, "Du hast nicht\ngenug Materialien!", 5000, 125, 0, 0 )
					end
				elseif ggst == "phosphor" or ggst == "dumdum" or ggst == "armorpiercing" or ggst == "vulcano" then
					if mats >= 2 then
						if sellingFromGunTruckVan then
							vioSetElementData ( getPedOccupiedVehicle ( player ), "mats", mats - 2 )
						else
							vioSetElementData ( player, "mats", mats - 2 )
						end
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( target, 40 )
						
						local typ, amount
						if ggst == "phosphor" then
							typ = 1
							amount = 3
							infobox ( target, "Du hast von\n"..getPlayerName ( player ).."\nspezielle Munnition er-\nhalten: Phosphor!", 5000, 125, 0, 0 )
						elseif ggst == "dumdum" then
							typ = 2
							amount = 5
							infobox ( target, "Du hast von\n"..getPlayerName ( player ).."\nspezielle Munnition er-\nhalten: Dum-Dum!", 5000, 125, 0, 0 )
						elseif ggst == "armorpiercing" then
							typ = 3
							amount = 5
							infobox ( target, "Du hast von\n"..getPlayerName ( player ).."\nspezielle Munnition er-\nhalten: Panzerbrechend!", 5000, 125, 0, 0 )
						else
							infobox ( player, "Momentan deaktiviert.", 5000, 125, 0, 0 )
							typ = 4
							if getPlayerName ( player ) == "[Vio]Zipper" or getPlayerName ( player ) == "[Vio]Michael" then
								amount = 5
							end
							--infobox ( target, "Du hast von\n"..getPlayerName ( player ).."\nspezielle Munnition er-\nhalten: Vulcano!\nDu kannst sie mit\nHalbautomatischen benutzen.", 5000, 125, 0, 0 )
						end
						if typ ~= 4 or getPlayerName ( player ) == "[Vio]Zipper" or getPlayerName ( player ) == "[Vio]Michael" then
							if not vioGetElementData ( target, "ammoTyp"..typ ) then
								vioSetElementData ( target, "ammoTyp"..typ, 0 )
							end
							infobox ( player, "Du hast\n"..getPlayerName ( target ).."\nein Paket mit\nspezieller Munnition\ngegeben.", 5000, 125, 0, 0 )
							vioSetElementData ( target, "ammoTyp"..typ, vioGetElementData ( target, "ammoTyp"..typ ) + amount )
						end
					else
						infobox ( player, "Du hast nicht\ngenug Materialien!", 5000, 125, 0, 0 )
					end
				else
					gunhelp_func ( player )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist zu\nweit weg!", 7000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nFehler! Der\nSpieler hat keinen\nWaffenschein!", 7000, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nFehler!\nGebrauch: /sellgun\n[Ziel] [Gegenstand]", 7000, 125, 0, 0 )
	end
end
addEvent ( "sellgun", true )
addEventHandler ( "sellgun", getRootElement(), sellgun_func )
addCommandHandler ( "sellgun", sellgun_func )

function gunhelp_func ( player )
	
	outputChatBox ( "Mgl.: 9mmsd | 10 Mats, 9mm | 7 Mats, eagle | 20 Mats", player, 200, 200, 0 )
	outputChatBox ( "shotgun | 10 Mats, mp5 | 17 Mats, messer | 3 Mats", player, 200, 200, 0 )
	outputChatBox ( "gewehr | 10 Mats, ak47 | 25 Mats, mats | 5 Mats", player, 200, 200, 0 )
	outputChatBox ( "______________________________", player, 200, 200, 0 )
	outputChatBox ( "Munnitionsarten ( Jeweils fuer 1 Materialien ):", player, 200, 200, 0 )
	outputChatBox ( "phosphor x 3 | dumdum x 5 | armorpiercing x 5", player, 200, 200, 0 )
end
addCommandHandler ( "gunhelp", gunhelp_func )

function buymats_func ( player )
	
	if vioGetElementData ( player, "job" ) == "wdealer" then
		if vioGetElementData ( player, "money" ) >= 200 then
			if tonumber ( vioGetElementData ( player, "jobtime" ) ) == 0 then
				local x, y, z = getElementPosition ( player )
				if getDistanceBetweenPoints3D ( -2627.5083007813, 209.36631774902, 4.1959328651428, x, y, z ) < 10 then
					vioSetElementData ( player, "lastcrime", "mats" )
					vioSetElementData ( player, "mats", tonumber ( vioGetElementData ( player, "mats" ) ) + 10 )
					vioSetElementData ( player, "jobtime", 5 )
					vioSetElementData ( player, "money", vioGetElementData(player,"money")-200 )
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist zu\nweit weg!", 7000, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu musst noch\n"..vioGetElementData(player,"jobtime").." Minuten warten!", 7000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast zu\nwenig Geld!", 7000, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist kein\nWaffendealer!", 7000, 125, 0, 0 )
	end
end
addCommandHandler ( "buymats", buymats_func )