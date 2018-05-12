dutyIcon = createPickup ( 258.57006835938, 109.79203033447, 1002.7518310547, 3, 1239, 50, 0 )
dutyIconGarage = createPickup ( -1611.27, 679.38, -5.25, 3, 1239, 50, 0 )
setElementInterior ( dutyIcon, 10 )

function takegunlicenseGUI_func ( pname )

	takegunlicense_func ( client, "takegunlicense", pname )
end
addEvent ( "takegunlicenseGUI", true )
addEventHandler ( "takegunlicenseGUI", getRootElement(), takegunlicenseGUI_func )

function takegunlicense_func ( player, cmd, targetName )

	if ( isCop ( player ) or isFBI ( player ) or isArmy ( player ) ) and vioGetElementData ( player, "rang" ) >= 3 then
		local target = findPlayerByName( targetName )
		if isElement ( target ) then
			if vioGetElementData ( target, "gunlicense" ) > 0 then
				vioSetElementData ( target, "gunlicense", 0 )
				mysql_vio_query ( "UPDATE userdata SET Waffenschein = '0' WHERE Name LIKE '"..targetName.."'" )
				infobox ( player, "\n\nDu hast "..targetName.."\n seinen Waffenschein\nabgenommen.", 5000, 125, 0, 0 )
				infobox ( target, "\n\n"..getPlayerName ( player ).." hat dir\ndeinen Waffenschein\nabgenommen.", 7500, 125, 0, 0 )
			else
				infobox ( player, "\n\nDer Spieler hat\nkeinen Waffenschein!", 5000, 125, 0, 0 )
			end
		else
			infobox ( player, "\n\n\nUngueltiger Spieler!", 5000, 125, 0, 0 )
		end
	else
		infobox ( player, "Du bist nicht\nbefugt!", 5000, 125, 0, 0 )
	end
end
addCommandHandler ( "takegunlicense", takegunlicense_func )

function pdComputerSetWanted_func ( wanteds, name, reason )

	if wanteds >= 0 and wanteds <= 6 then
		local player = getPlayerFromName ( name )
		if player then
			if isStateFaction ( client ) then
				vioSetElementData ( player, "wanteds", wanteds )
				setPlayerWantedLevel ( player, wanteds )
				outputChatBox ( "Der Beamte "..getPlayerName ( client ).." hat deinen Fahndungslevel auf "..wanteds.." gesetzt!", player, 0, 0, 255 )
				outputChatBox ( "Grund: "..reason, player, 0, 0, 255 )
				sendMSGForFaction ( getPlayerName ( client ).." hat "..name.." den Fahndungslevel auf "..wanteds.." gesetzt ( "..reason.." )!", 1, 200, 200, 0 )
				sendMSGForFaction ( getPlayerName ( client ).." hat "..name.." den Fahndungslevel auf "..wanteds.." gesetzt ( "..reason.." )!", 6, 200, 200, 0 )
				sendMSGForFaction ( getPlayerName ( client ).." hat "..name.." den Fahndungslevel auf "..wanteds.." gesetzt ( "..reason.." )!", 8, 200, 200, 0 )
			end
		else
			infobox ( client, "Du hast einen\nungueltigen Spieler\nangegeben!", 5000, 125, 0, 0 )
		end
	end
end
addEvent ( "pdComputerSetWanted", true )
addEventHandler ( "pdComputerSetWanted", getRootElement(), pdComputerSetWanted_func )

function pdComputerAddSTVO_func ( name, stvo, reason )

	if stvo >= 0 and stvo <= 15 then
		local player = getPlayerFromName ( name )
		if player then
			vioSetElementData ( player, "stvo_punkte", tonumber ( vioGetElementData ( player, "stvo_punkte" ) + 1) )
			outputChatBox ( "Du hast "..name.." einen STVO-Punkt wegen \""..reason.."\" gegeben!", client, 255, 255, 0 )
			outputChatBox ( "Du hast einen STVO-Punkt erhalten, Grund: \""..reason.."\", Gemeldet von: "..getPlayerName ( client ), player, 255, 255, 0 )
			outputChatBox ( "Das war bereits dein "..vioGetElementData ( player, "stvo_punkte" )..". Punkt - Bei 15 wird dir dein Fuehrerschein beim naechsten Einloggen entzogen!", player, 255, 255, 0 )
		else
			infobox ( client, "Du hast einen\nungueltigen Spieler\nangegeben!", 5000, 125, 0, 0 )
		end
	end
end
addEvent ( "pdComputerAddSTVO", true )
addEventHandler ( "pdComputerAddSTVO", getRootElement(), pdComputerAddSTVO_func )

function dutyhit ( player )

	infobox ( player, "Tippe /duty oder\n/swat, um in den\nDienst zu gehen.\n/fskin zum Outfit\naendern.", 5000, 200, 200, 0 )
end
addEventHandler ( "onPickupHit", dutyIcon, dutyhit )
addEventHandler ( "onPickupHit", dutyIconGarage, dutyhit )

function ticket_func ( player, cmd, target, price )

	local target = findPlayerByName( target )
	local price = tonumber ( price )
	if target then
		if price then
			price = math.floor ( math.abs ( price ) )
			if isOnDuty(player) then
				if vioGetElementData ( target, "wanteds" ) == 1 then
					if vioGetElementData ( target, "money" ) >= price then
						outputChatBox ( getPlayerName ( player ).." bietet dir ein Ticket an: "..price.." $ fuer Straferlass.", target, 0, 125, 0 )
						outputChatBox ( "Tippe /accept ticket, um zuzustimmen.", target, 0, 125, 0 )
						vioSetElementData ( target, "ticketprice", price )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nDu hast "..getPlayerName(target).."\nein Ticket angeboten.", 7500, 0, 125, 0 )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDer Spieler hat\nnicht genug Geld\ndabei!", 7500, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nDer Spieler muss\nein Wanted haben!", 7500, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist kein\nPolizist im Dienst!", 7500, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nGebrauch:\n/ticket [Name] [Preis]!", 7500, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nGebrauch:\n/ticket [Name] [Preis]!", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "ticket", ticket_func )

function grab_func ( player, cmd, targetName )

	if not client or client == player then
		local target = findPlayerByName( targetName )
		if isOnDuty(player) then
			if isElement ( target ) then
				if vioGetElementData ( target, "tazered" ) then
					local x1, y1, z1 = getElementPosition ( player )
					local x2, y2, z2 = getElementPosition ( target )
					if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) < 10 then
						local veh = getPedOccupiedVehicle ( player )
						local model = getElementModel ( veh )
						local validSeats = {}
						if copcars[model] or model == 497 or model == 427 or model == 490 or model == 609 or model == 470 then
							for i = 2, 3 do
								if not getVehicleOccupant ( veh, i ) then
								validSeats[i] = true
								end
							end
						elseif copbikes[model] or model == 415 or model == 601 or model == 433 or model == 548 or 563 then
							if not getVehicleOccupant ( veh, 1 ) then
								validSeats[1] = true
							end
						else
							infobox ( player, "\n\n\nDu sitzt in\neinem Ungueltigen\nFahrzeug!", 5000, 125, 0, 0 )
							return
						end
						for key, index in pairs ( validSeats ) do
							warpPedIntoVehicle ( target, veh, key )
							executeCommandHandler ( "tie", player, targetName )
							return
						end
						infobox ( player, "\n\n\nDu hast keinen\nfreien Sitz!", 5000, 125, 0, 0 )
					else
						infobox ( player, "\n\n\nDas Ziel ist\nzu weit entfernt!", 5000, 125, 0, 0 )
					end
				else
					infobox ( player, "\n\n\nDer Spieler muss\ngetazert sein!", 5000, 125, 0, 0 )
				end
			else
				infobox ( player, "\n\n\nUngueltiger Spieler!", 5000, 125, 0, 0 )
			end
		else
			infobox ( player, "\n\n\nDu bist kein\nBeamter im Dienst!", 5000, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "grab", grab_func )
addEvent ( "grab", true )
addEventHandler ( "grab", getRootElement(), grab_func )

function accept_ticket_func ( player, cmd, after )

	if after == "ticket" then
		local price = vioGetElementData ( player, "ticketprice" )
		local money = vioGetElementData ( player, "money" )
		if price then
			if money >= price then
				if vioGetElementData ( player, "wanteds" ) == 1 then
					vioSetElementData ( player, "wanteds", 0 )
					setPlayerWantedLevel ( player, 0 )
					
					takePlayerSaveMoney ( player, price )
					
					vioSetElementData ( player, "ticketprice", nil )
					
					infobox ( player, "\n\nDeine Strafe wurde\ndir erlassen.", 5000, 0, 200, 0 )
					
					local fmoney = tonumber ( MySQL_GetString("fraktionen", "DepotGeld", "ID LIKE '1'") )
					MySQL_SetString("fraktionen", "DepotGeld", fmoney + price, "ID LIKE '1'")
				else
					infobox ( player, "\n\n\nDu hast keine\nWanteds!", 7500, 125, 0, 0 )
				end
			else
				infobox ( player, "\n\n\nDu hast nicht\ngenug Geld!", 7500, 125, 0, 0 )
			end
		else
			infobox ( player, "\n\n\nNiemand hat dir\nein Ticket angeboten!", 7500, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "accept", accept_ticket_func )

function fdraw_func ( player, cmd, amount )

	if isOnDuty(player) then
		if vioGetElementData ( player, "rang" ) >= 4 then
			local amount = tonumber ( amount )
			if amount then
				amount = math.abs ( math.floor ( amount ) )
				local fmoney = tonumber ( MySQL_GetString("fraktionen", "DepotGeld", "ID LIKE '1'") )
				if fmoney >= amount then
					MySQL_SetString("fraktionen", "DepotGeld", fmoney - amount, "ID LIKE '1'")
					givePlayerSaveMoney ( player, amount )
					outputLog ( getPlayerName(player).." hat "..amount.." $ aus der Staatskasse genommen.", "fkasse" )
				else
					infobox ( player, "\n\nEs ist nicht mehr\ngenug Geld in der\nKasse!", 7500, 125, 0, 0 )
				end
			else
				infobox ( player, "\n\n\nGebrauch: /fdraw [Summe]", 7500, 125, 0, 0 )
			end
		else
			infobox ( player, "\n\n\nDu bist nicht\nbefugt!", 7500, 125, 0, 0 )
		end
	else
		infobox ( player, "\n\n\nDu bist kein\nCop!", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "fdraw", fdraw_func )

function fbank_func ( player, cmd, amount )

	if isOnDuty(player) then
		if vioGetElementData ( player, "rang" ) >= 4 then
			local amount = tonumber ( amount )
			if amount then
				amount = math.abs ( math.floor ( amount ) )
				local fmoney = tonumber ( MySQL_GetString("fraktionen", "DepotGeld", "ID LIKE '1'") )
				if vioGetElementData ( player, "bankmoney" ) >= amount then
					MySQL_SetString("fraktionen", "DepotGeld", fmoney + amount, "ID LIKE '1'")
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - amount )
					outputLog ( getPlayerName(player).." hat "..amount.." $ in die Staatskasse gezahlt.", "fkasse" )
				else
					infobox ( player, "\n\nDu hast nicht\nsoviel Geld!", 7500, 125, 0, 0 )
				end
			else
				infobox ( player, "\n\n\nGebrauch: /fbank [Summe]", 7500, 125, 0, 0 )
			end
		else
			infobox ( player, "\n\n\nDu bist nicht\nbefugt!", 7500, 125, 0, 0 )
		end
	else
		infobox ( player, "\n\n\nDu bist kein\nCop!", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "fbank", fbank_func )

function m_func ( player, cmd, ... )

	local veh = getPedOccupiedVehicle ( player )

	if veh then
		if isFederalCar( veh ) and isOnDuty(player) then
			local parametersTable = {...}
			local stringWithAllParameters = table.concat( parametersTable, " " )
			local posX, posY, posZ = getElementPosition ( player )
			local chatSphere = createColSphere( posX, posY, posZ, 30 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				local x1, y1, z1 = getElementPosition ( player )
				local x2, y2, z2 = getElementPosition ( nearbyPlayer)
				local distance = getDistanceBetweenPoints3D ( x1,y1,z1,x2,y2,z2 )
				local pname = getPlayerName ( player )
				if getElementDimension ( player ) == getElementDimension ( nearbyPlayer ) then
					outputChatBox ( "["..getPlayerRankName ( player ).." "..pname.."]: " ..stringWithAllParameters, nearbyPlayer, 255, 255, 20 )
				end
			end
		else
			outputChatBox ( "Du bist nicht im Dienst/sitzt in keinem Polizeifahrzeug!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Du sitzt in keinem Fahrzeug!", player, 125, 0, 0 )
	end
	
end

addCommandHandler ( "m", m_func )

function test_func ( player, cmd, target )

	if not client or client == player then
		if isOnDuty(player) then
			target = findPlayerByName( target )
			if target then
				outputChatBox ( "Officer "..getPlayerName ( player ).." fordert dich zu einem Alkohol- und Drogentest auf.", target, 125, 0, 0 )
				outputChatBox ( "Tippe /accept test, um zuzustimmen.", target, 125, 125, 0 )
				outputChatBox ( "Du hast "..getPlayerName ( target ).." zu einem Test aufgefordert.", player, 0, 125, 0 )
				
				vioSetElementData ( target, "tester", player )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nGebrauch: /test\n[Name]", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist nicht\nim Dienst!", 5000, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "test", test_func )
addEvent ( "test", true )
addEventHandler ( "test", getRootElement(), test_func )

function frisk_func ( player, cmd, target )

	local playerid = findPlayerByName( target )
	if player == client or not client then
		if playerid then
			local x1, y1, z1 = getElementPosition ( player )
			local x2, y2, z2 = getElementPosition ( playerid )
			if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 5 then
				outputChatBox ( "Gegenstaende von "..target..":", player, 0, 0, 125 )
				outputChatBox ( "Materials: "..vioGetElementData(playerid,"mats")..", Drogen: "..vioGetElementData(playerid,"drugs"),player,200,200,0)
				outputChatBox ( getPlayerName(player).." hat dich durchsucht!", playerid, 125, 0, 0 )
			else
				outputChatBox ( "Du bist zu weit entfernt!", player, 125, 0, 0 )
			end
		end
	end
end
addEvent ( "friskGUI", true )
addEventHandler ( "friskGUI", getRootElement(), frisk_func )
addCommandHandler ( "frisk", frisk_func )

function offduty_func ( player )

	if isAbleOffduty ( player ) then
		if not getPedOccupiedVehicle ( player ) then
			setPedSkin ( player, vioGetElementData ( player, "skinid" ) )
			takeAllWeapons ( player )
			setPlayerNametagColor ( player, 200, 200, 200 )
		else
			outputChatBox ( "Du darfst nicht in einem Fahrzeug sitzen.", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Du bist kein Beamter im Dienst!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "offduty", offduty_func )

function takeillegal_func ( player, cmd, target )

	local playerid = findPlayerByName( target )
	if player == client or not client then
		if playerid then
			if isOnDuty(player) then
				outputChatBox ( "Du hast "..target.." seine Illegalen Gegenstaende abgenommen!", player, 0, 125, 0 )
				vioSetElementData ( playerid, "drugs", 0 )
				vioSetElementData ( playerid, "mats", 0 )
				outputChatBox ( getPlayerName(player).." hat dir deine Illegalen Gegenstaende abgenommen!", playerid, 125, 0, 0 )
			else
				outputChatBox ( "Du bist kein Cop im Dienst!", player, 125, 0, 0 )
			end
		end
	end
end
addEvent ( "takeillegalGUI", true )
addEventHandler ( "takeillegalGUI", getRootElement(), takeillegal_func )
addCommandHandler ( "takeillegal", takeillegal_func )

function duty_func ( player, cmd, skin )

	if vioGetElementData ( player, "fraktion" ) == 1 or isFBI ( player ) then
		triggerClientEvent ( player, "eatSomething", getRootElement() )
		takeAllWeapons ( player )
		local x, y, z = getElementPosition ( player )
		local px, py, pz = 258.57006835938, 109.79203033447, 1002.7518310547
		local px2, py2, pz2 = getElementPosition ( FBIDutyIcon )
		local px3, py3, pz3 = getElementPosition ( dutyIconGarage )
		if getDistanceBetweenPoints3D ( x, y, z, px3, py3, pz3 ) <= 5 or getDistanceBetweenPoints3D ( x, y, z, px, py, pz ) <= 5 or ( isNearLVPDDutyIcon ( player ) and not isFBI ( player ) ) then
			if not isOnDuty(player) then
				setElementModel ( player, math.random ( 281, 284 ) )
				-- Schlagstock
				local weapon = 3		
				local ammo = 1
				giveWeapon ( player, weapon, ammo, true )
				triggerClientEvent ( player, "sec_gun_give", getRootElement(), weapon, ammo )
				-- Pistol ( 9mm )
				if vioGetElementData ( player, "rang" ) < 3 then
					local weapon = 22
					local ammo = 102*2*2
					giveWeapon ( player, weapon, ammo, true )
				else -- Eagle
					local weapon = 24
					local ammo = 49*2
					giveWeapon ( player, weapon, ammo, true )
				end
				-- Schrotflinte
				if vioGetElementData ( player, "rang" ) >= 1 then
					local weapon = 25
					local ammo = 50
					giveWeapon ( player, weapon, ammo, true )
				end
				-- MP5
				if vioGetElementData ( player, "rang" ) >= 3 then
					local weapon = 29
					local ammo = 90*2
					giveWeapon ( player, weapon, ammo, true )
				end
				if vioGetElementData ( player, "rang" ) >= 1 then
					vioSetElementData ( player, "ammoTyp5", 15 )
				end
				if vioGetElementData ( player, "rang" ) >= 2 then
					vioSetElementData ( player, "ammoTyp2", 15 )
				end
				if vioGetElementData ( player, "rang" ) >= 3 then
					vioSetElementData ( player, "ammoTyp3", 15 )
				end
				local armor = 100
				setPedArmor ( player, armor )
				triggerClientEvent ( player, "sec_armor_give", getRootElement(), armor )
				bindKey ( player, "1", "down", tazer_func )
				setPlayerNametagColor ( player, 0, 100, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bereits\nim Dienst!", 7500, 125, 0, 0 )
			end
		elseif ( getDistanceBetweenPoints3D ( x, y, z, px2, py2, pz2 ) <= 5 or isNearLVPDDutyIcon ( player ) ) and isFBI ( player ) then
			if not isOnDuty(player) then
				if skin == "2" then
					setElementModel ( player, 165 )
				elseif skin == "3" then
					setElementModel ( player, 164 )
				elseif skin == "4" then
					setElementModel ( player, 163 )
				else
					setElementModel ( player, 286 )
				end
				-- 9mm SD
				if vioGetElementData ( player, "rang" ) < 1 then
					local weapon = 23
					local ammo = 102*2*2
					giveWeapon ( player, weapon, ammo, true )
				else -- Eagle
					local weapon = 24
					local ammo = 49*2
					giveWeapon ( player, weapon, ammo, true )
				end
				-- Schrotflinte
				if vioGetElementData ( player, "rang" ) >= 2 then
					local weapon = 25
					local ammo = 20
					giveWeapon ( player, weapon, ammo, true )
				end
				-- MP5
				if vioGetElementData ( player, "rang" ) >= 1 then
					local weapon = 29
					local ammo = 300
					giveWeapon ( player, weapon, ammo, true )
				end
				-- M4
				if vioGetElementData ( player, "rang" ) >= 3 then
					local weapon = 31
					local ammo = 150
					giveWeapon ( player, weapon, ammo, true )
				end
				if vioGetElementData ( player, "rang" ) >= 1 then
					vioSetElementData ( player, "ammoTyp5", 15 )
				end
				if vioGetElementData ( player, "rang" ) >= 2 then
					vioSetElementData ( player, "ammoTyp2", 15 )
				end
				if vioGetElementData ( player, "rang" ) >= 3 then
					vioSetElementData ( player, "ammoTyp3", 15 )
				end
				local armor = 100
				setPedArmor ( player, armor )
				triggerClientEvent ( player, "sec_armor_give", getRootElement(), armor )
				bindKey ( player, "1", "down", tazer_func )
				setPlayerNametagColor ( player, 0, 100, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bereits\nim Dienst!", 7500, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nan der Richtigen\nStelle", 7500, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "duty", duty_func )

function swat_func ( player )

	if vioGetElementData ( player, "fraktion" ) == 1 or isFBI ( player ) then
		triggerClientEvent ( player, "eatSomething", getRootElement() )
		local x, y, z = getElementPosition ( player )
		local px, py, pz = 258.57006835938, 109.79203033447, 1002.7518310547
		local px2, py2, pz2 = getElementPosition ( FBIDutyIcon )
		local px3, py3, pz3 = getElementPosition ( dutyIconGarage )
		if getDistanceBetweenPoints3D ( x, y, z, px, py, pz ) <= 5 or isNearLVPDDutyIcon ( player ) or getDistanceBetweenPoints3D ( x, y, z, px3, py3, pz3 ) <= 5 then
			local curskin = getElementModel ( player )
			if curskin ~= 285 then
				if vioGetElementData ( player, "rang" ) >= 3 then
					setElementModel ( player, 285 )
					-- Messer
					local weapon = 4		
					local ammo = 1
					giveWeapon ( player, weapon, ammo, true )
					-- 9mm SD
					local weapon = 23
					local ammo = 102
					giveWeapon ( player, weapon, ammo, true )
					-- Traenengas
					local weapon = 17
					local ammo = 3
					giveWeapon ( player, weapon, ammo, true )
					-- MP5
					local weapon = 29
					local ammo = 300
					giveWeapon ( player, weapon, ammo, true )
					-- Sniper
					if vioGetElementData ( player, "rang" ) >= 4 then
						local weapon = 34
						local ammo = 5*2
						giveWeapon ( player, weapon, ammo, true )
						triggerClientEvent ( player, "sec_gun_give", getRootElement(), weapon, ammo )
					end
					-- M4
					local weapon = 31
					local ammo = 150
					--giveWeapon ( player, weapon, ammo, true )
					
					vioSetElementData ( player, "ammoTyp2", 25 )
					vioSetElementData ( player, "ammoTyp3", 25 )
					vioSetElementData ( player, "ammoTyp5", 25 )
					
					local armor = 100
					setPedArmor ( player, armor )
					triggerClientEvent ( player, "sec_armor_give", getRootElement(), armor )
					bindKey ( player, "1", "down", tazer_func )
					setPlayerNametagColor ( player, 100, 100, 100 )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nNur fuer Inspector\noder hoeher!", 7500, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bereits\nim Dienst!", 7500, 125, 0, 0 )
			end
		elseif ( getDistanceBetweenPoints3D ( x, y, z, px2, py2, pz2 ) <= 5 or isNearLVPDDutyIcon ( player ) ) and isFBI ( player ) then
			local curskin = getElementModel ( player )
			if curskin ~= 285 then
				if vioGetElementData ( player, "rang" ) >= 2 then
					setElementModel ( player, 285 )
					-- Messer
					local weapon = 4		
					local ammo = 1
					giveWeapon ( player, weapon, ammo, true )
					-- 9mm SD
					local weapon = 24
					local ammo = 49
					giveWeapon ( player, weapon, ammo, true )
					-- Traenengas
					local weapon = 17
					local ammo = 3
					giveWeapon ( player, weapon, ammo, true )
					-- MP5
					local weapon = 29
					local ammo = 300
					giveWeapon ( player, weapon, ammo, true )
					if vioGetElementData ( player, "rang" ) >= 4 then
						-- Sniper
						local weapon = 34
						local ammo = 5
						giveWeapon ( player, weapon, ammo, true )
						triggerClientEvent ( player, "sec_gun_give", getRootElement(), weapon, ammo )
					end
					-- M4
					local weapon = 31
					local ammo = 150
					giveWeapon ( player, weapon, ammo, true )
					
					local armor = 100
					setPedArmor ( player, armor )
					triggerClientEvent ( player, "sec_armor_give", getRootElement(), armor )
					bindKey ( player, "1", "down", tazer_func )
					setPlayerNametagColor ( player, 100, 100, 100 )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nNur fuer Inspector\noder hoeher!", 7500, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bereits\nim Dienst!", 7500, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nan der richtigen\nStelle", 7500, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "swat", swat_func )

function suspect_func ( player, cmd, target, r1, r2, r3, r4 )

	if player == client or not client then
		if r1 == nil then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast keinen\nGrund angegeben!", 7500, 125, 0, 0 )
		else
			if isOnDuty(player) then
				local target = findPlayerByName( target )
				if not r2 then r2 = "" end
				if not r3 then r3 = "" end
				if not r4 then r4 = "" end
				local reason = r1..r2..r3..r4
				if getElementType ( target ) == "player" and vioGetElementData ( target, "loggedin" ) == 1 then
					local model = getElementModel ( getPedOccupiedVehicle ( player ) )
					if copcars[model] or model == 497 or model == 427 or model == 490 or model == 609 or model == 470 or copbikes[model] or model == 415 or model == 601 or model == 433 or model == 548 or 563 then
						if vioGetElementData ( target, "wanteds" ) <= 5 then
							vioSetElementData ( target, "wanteds", vioGetElementData ( target, "wanteds" ) + 1 )
							setPlayerWantedLevel ( target, vioGetElementData ( target, "wanteds" ) )
						end
						outputChatBox ( "Du hast ein Verbrechen begangen: "..reason..", Gemeldet von: "..getPlayerName(player), target, 255, 255, 0 )
						local msg = getPlayerName(player).." hat "..getPlayerName(target).." ein Wanted wegen "..reason.." gegeben!"
						sendMSGForFaction ( msg, 1, 0, 0, 200 )
						sendMSGForFaction ( msg, 6, 0, 0, 200 )
						sendMSGForFaction ( msg, 8, 0, 0, 200 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 7500, 125, 0, 0 )
				end
			end
		end
	end
end
addCommandHandler("suspect", suspect_func)
addEvent ("suspect", true )
addEventHandler ("suspect", getRootElement(), suspect_func )

function clear_func ( player, cmd, target )

	if player == client or not client then
		if isOnDuty(player) then
			local target = findPlayerByName( target )
			if getElementType ( target ) == "player" and vioGetElementData ( target, "loggedin" ) == 1 then
				vioSetElementData ( target, "wanteds", 0 )
				setPlayerWantedLevel ( target, 0 )
				outputChatBox ( "Du hast die Akten von "..getPlayerName(target).." geloescht!", player,255, 255, 0 )
				outputChatBox ( getPlayerName(player).." hat deine Akten geloescht!", target, 255, 255, 0 )
				local msg = getPlayerName(player).." hat "..getPlayerName(target).." die Akten geloescht!"
				sendMSGForFaction ( msg, 1, 0, 0, 200 )
				sendMSGForFaction ( msg, 6, 0, 0, 200 )
				sendMSGForFaction ( msg, 8, 0, 0, 200 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
			end
		end
	end
end
addCommandHandler("clear", clear_func)
addEvent ("clear", true )
addEventHandler ("clear", getRootElement(), clear_func )

function stvopunkte_func ( player, cmd, target, r1, r2, r3, r4 )

	if player == client or not client then
		if r1 == nil then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nKein Grund\nangegeben!", 5000, 125, 0, 0 )
		else
			if isOnDuty(player) then
				local target = findPlayerByName( target )
				if not r2 then r2 = "" end
				if not r3 then r3 = "" end
				if not r4 then r4 = "" end
				local reason = r1..r2..r3..r4
				if getElementType ( target ) == "player" and vioGetElementData ( target, "loggedin" ) == 1 then
					vioSetElementData ( target, "stvo_punkte", tonumber(vioGetElementData ( target, "stvo_punkte" ) + 1) )
					outputChatBox ( "Du hast "..getPlayerName(target).." einen STVO-Punkt wegen \""..reason.."\" gegeben!", player,255, 255, 0 )
					outputChatBox ( "Du hast einen STVO-Punkt erhalten, Grund: \""..reason.."\", Gemeldet von: "..getPlayerName(player), target, 255, 255, 0 )
					outputChatBox ( "Das war bereits dein "..vioGetElementData(target, "stvo_punkte")..". Punkt - Bei 15 wird dir dein Fuehrerschein beim naechsten Einloggen entzogen!", target, 255, 255, 0 )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
				end
			end
		end
	end
end
addCommandHandler("stvopunkte", stvopunkte_func)
addEvent ("stvopunkte", true )
addEventHandler ("stvopunkte", getRootElement(), stvopunkte_func )

function takeweapons_func ( player, cmd, target )

	if player == client or not client then
		if isOnDuty(player) then
			if findPlayerByName( target ) then
				local target = findPlayerByName( target )
				local x, y, z = getElementPosition ( player )
				local tx, ty, tz = getElementPosition ( target )
				if getDistanceBetweenPoints3D ( x, y, z, tx, ty, tz ) < 5 then
					vioSetElementData ( player, "hasBomb", false )
					takeAllWeapons ( target )
					outputChatBox ( "Du hast "..getPlayerName(target).." entwaffnet!", player, 0, 125, 0 )
					outputChatBox ( "Du wurdest von "..getPlayerName(player).." entwaffnet!", target, 125, 0, 0 )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDer Spieler\nist zu weit\nentfernt!", 5000, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist kein\nPolizist im\nDienst!", 5000, 125, 0, 0 )
		end
	end
end
addCommandHandler("takeweapons", takeweapons_func)
addEvent ("takeweapons", true )
addEventHandler ("takeweapons", getRootElement(), takeweapons_func )


function getDatabaseFile ( name )

	local player = client
	local name = MySQL_Save ( name )
	if MySQL_DatasetExist ( "players", "Name LIKE '"..name.."'" ) or MySQL_DatasetOldExist ( "players", "Name LIKE '"..name.."'" ) then
		local data = MySQL_GetStringDataset ( "state_files", "text, editor, faction", "name LIKE '"..name.."'" )
		if data then
			triggerClientEvent ( player, "recieveDatabaseFile", player, name, data["text"], data["editor"], tonumber ( data[faction] ) )
		else
			triggerClientEvent ( player, "recieveDatabaseFile", player, name, "[Leerer Eintrag]", "", 0 )
		end
	else
		infobox ( player, "Ungültiger Name!", 5000, 200, 0, 0 )
	end
end
addEvent ( "getDatabaseFile", true )
addEventHandler ( "getDatabaseFile", getRootElement (), getDatabaseFile )

function saveDatabaseFile ( name, text )

	local player = client
	name = MySQL_Save ( name )
	text = MySQL_Save ( text )
	if #text <= 1000 then
		if MySQL_DatasetExist ( "players", "Name LIKE '"..name.."'" ) or MySQL_DatasetOldExist ( "players", "Name LIKE '"..name.."'" ) then
			mysql_vio_query ( "DELETE FROM state_files WHERE name = '"..name.."' LIMIT 1" )
			mysql_vio_query ( "INSERT INTO state_files ( name, text, editor, faction ) VALUES ( '"..name.."', '"..text.."', '"..factionRankNames[vioGetElementData ( player, "fraktion" )][vioGetElementData ( player, "rang" )]..getPlayerName ( player ).."', '"..vioGetElementData ( player, "fraktion" ).."' )" )
			infobox ( player, "Akte gespeichert.", 5000, 0, 200, 0 )
		else
			infobox ( player, "Ungültiger Name!", 5000, 200, 0, 0 )
		end
	else
		infobox ( player, "Der Text ist zu\nlang!", 5000, 200, 0, 0 )
	end
end
addEvent ( "saveDatabaseFile", true )
addEventHandler ( "saveDatabaseFile", getRootElement (), saveDatabaseFile )