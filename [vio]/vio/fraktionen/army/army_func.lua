function armyClassSpawn ( player )

	if not isKeyBound ( player, "1", "down", tazer_func ) then
		bindKey ( player, "1", "down", tazer_func )
	end
	if vioGetElementData ( player, "job" ) == "soldat" then
		giveWeapon ( player, 31, 150, true )
		triggerClientEvent ( player, "sec_gun_give", getRootElement(), 29, 150 )
		vioSetElementData ( player, "ammoTyp2", 15 )
		vioSetElementData ( player, "ammoTyp3", 15 )
		vioSetElementData ( player, "ammoTyp5", 30 )
	elseif vioGetElementData ( player, "job" ) == "pionier" then
		giveWeapon ( player, 6, 1, true )
		triggerClientEvent ( player, "sec_gun_give", getRootElement(), 6, 1 )
		giveWeapon ( player, 16, 3, true )
		triggerClientEvent ( player, "sec_gun_give", getRootElement(), 16, 3 )
		vioSetElementData ( player, "ammoTyp1", 15 )
		vioSetElementData ( player, "ammoTyp4", 3 )
	elseif vioGetElementData ( player, "job" ) == "marine" then
		giveWeapon ( player, 25, 25, true )
		triggerClientEvent ( player, "sec_gun_give", getRootElement(), 25, 25 )
		vioSetElementData ( player, "ammoTyp2", 15 )
		vioSetElementData ( player, "ammoTyp3", 15 )
	elseif vioGetElementData ( player, "job" ) == "air" then
		giveWeapon ( player, 29, 150, true )
		triggerClientEvent ( player, "sec_gun_give", getRootElement(), 29, 150 )
		giveWeapon ( player, 46, 3, true )
		triggerClientEvent ( player, "sec_gun_give", getRootElement(), 46, 3 )
	elseif vioGetElementData ( player, "job" ) == "tankcommander" then
		giveWeapon ( player, 36, 3, true )
		triggerClientEvent ( player, "sec_gun_give", getRootElement(), 36, 3 )
		vioSetElementData ( player, "ammoTyp2", 30 )
		vioSetElementData ( player, "ammoTyp3", 30 )
	end
	
	giveWeapon ( player, 22, 85, true )
	
	setPedArmor ( player, 100 )
	triggerClientEvent ( player, "sec_armor_give", getRootElement(), 100 )
	giveWeapon ( player, 31, 300, true )
	triggerClientEvent ( player, "sec_gun_give", getRootElement(), 31, 300 )
end

explosiveCount = 0

function explosive_func ( player )
	if vioGetElementData ( player, "job" ) == "pionier" and isArmy ( player ) then
		if not vioGetElementData ( player, "expTimer" ) then
			vioSetElementData ( player, "expTimer", true )
			setTimer ( vioSetElementData, 30000, 1, player, "expTimer", false )
			local x, y, z = getElementPosition ( player )
			local z = z - 0.73
			local x = x + 0.3
			local y = y + 0.3
			_G["explosive"..explosiveCount] = createObject ( 1654, x, y, z )
			setTimer ( explodeExplosive, 10000, 1, _G["explosive"..explosiveCount], player )
			outputChatBox ( "Sprengladung ist scharf, du hast 10 Sekunden!", player, 125, 0, 0 )
			explosiveCount = explosiveCount + 1
		else
			outputChatBox ( "Du kannst nur alle 30 Sekunden eine Sprengladung legen!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Du bist nicht befugt!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "explosive", explosive_func )

function explodeExplosive ( explosive, player )

	local x, y, z = getElementPosition ( explosive )
	createExplosion ( x, y, z, 0, player )
	destroyElement ( explosive )
end

function setpermission_func ( player, cmd, target, perm, bool )
	
	local target = findPlayerByName( target )
	if target then
		if isArmy ( player ) then
			if getPlayerRank ( player ) == 5 then
				local perm = tonumber ( perm )
				if perm then
					if perm > 0 and perm < 10 then
						if perm == 9 then
							bool = tonumber ( bool )
							if bool then
								vioSetElementData ( target, "armyperm9", bool )
								saveArmyPermissions ( target )
								outputChatBox ( "Du hast "..getPlayerName ( target ).." die GWD-Note "..bool.." gegeben!", player, 0, 125, 0 )
								outputChatBox ( getPlayerName ( player ).." hat dir die GWD-Note "..bool.." gegeben!", target, 0, 125, 0 )
							end
						else
							if bool == "1" then
								fix = "gegeben"
								vioSetElementData ( target, "armyperm"..perm, 1 )
							else
								fix = "genommen"
								vioSetElementData ( target, "job", "none" )
								vioSetElementData ( target, "armyperm"..perm, 0 )
							end
							saveArmyPermissions ( target )
							outputChatBox ( "Du hast "..getPlayerName ( target ).." "..permNames[perm].." "..fix..".", player, 0, 125, 0 )
							outputChatBox ( getPlayerName ( player ).." hat dir "..permNames[perm].." "..fix..".", target, 0, 125, 0 )
						end
					else
						outputChatBox ( "Gebrauch: /setpermission [Name] [Permission 1-9] [1 oder 0]", player, 125, 0, 0 )
					end
				else
					outputChatBox ( "Gebrauch: /setpermission [Name] [Permission 1-9] [1 oder 0]", player, 125, 0, 0 )
				end
			else
				outputChatBox ( "Gebrauch: /setpermission [Name] [Permission 1-9] [1 oder 0]", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Du bist kein Soldat!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Gebrauch: /setpermission [Name] [Permission 1-9] [1 oder 0]", player, 125, 0, 0 )
		outputChatBox ( "Permissions: 1=Soldat,2=Pionier,3=Marine,4=Luftwaffe,5=Panzerkommandoer,6=Ehrenm.,7=Luftwaffenm.,8=Verdienstm.,9=GWD", player, 125, 125, 0 )
	end
end
addCommandHandler ( "setpermission", setpermission_func )

permNames = {}
	permNames[1] = "Soldat"
	permNames[2] = "Pionier"
	permNames[3] = "Marine"
	permNames[4] = "Luftwaffe"
	permNames[5] = "Panzerkommandoer"
	permNames[6] = "Ehrenmedallie"
	permNames[7] = "Luftwaffen Orden"
	permNames[8] = "Verdienstkreuz"
	permNames[9] = "Zeugnis"
	
validClasses = {}
validClasses = { ["soldat"]=true, ["pionier"]=true, ["marine"]=true, ["air"]=true, ["tankcommander"]=true }

function class_func ( player, cmd, class )

	if validClasses[class] then
		suc = false
		if vioGetElementData ( player, "armyperm5" ) == 1 and class == "tankcommander" then
			suc = true
		elseif vioGetElementData ( player, "armyperm4" ) == 1 and class == "air" then
			suc = true
		elseif vioGetElementData ( player, "armyperm3" ) == 1 and class == "marine" then
			suc = true
		elseif vioGetElementData ( player, "armyperm2" ) == 1 and class == "pionier" then
			suc = true
		elseif vioGetElementData ( player, "armyperm1" ) == 1 and class == "soldat" then
			suc = true
		end
		if suc then
			vioSetElementData ( player, "job", class )
			outputChatBox ( "Klasse geaendert!", player, 125, 0, 0 )
		else
			outputChatBox ( "Du darfst diese Klasse nicht benutzen!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Gebrauch: /class [soldat|pionier|marine|air|tankcommander]", player, 125, 0, 0 )
	end
end
addCommandHandler ( "class", class_func )

function rearm_func ( player )

	if isArmy ( player ) then
		triggerClientEvent ( player, "eatSomething", getRootElement() )
		local veh = getPedOccupiedVehicle ( player )
		
		if veh then
			if getElementModel ( veh ) == 433 then
				takeAllWeapons ( player )
				armyClassSpawn ( player )
				return nil
			end
		end
				
	end
	
	if isCop(player) or isFBI(player) then
		triggerClientEvent ( player, "eatSomething", getRootElement() )
		takeAllWeapons ( player )
		local x, y, z = getElementPosition ( player )
		local px, py, pz = 258.57006835938, 109.79203033447, 1002.7518310547
		local px2, py2, pz2 = getElementPosition ( FBIDutyIcon )
		local px3, py3, pz3 = getElementPosition ( dutyIconGarage )
		if getDistanceBetweenPoints3D ( x, y, z, px3, py3, pz3 ) <= 5 or getDistanceBetweenPoints3D ( x, y, z, px, py, pz ) <= 5 or ( isNearLVPDDutyIcon ( player ) and not isFBI ( player ) ) then
			if isOnDuty(player) then
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
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist nicht\nim Dienst!", 7500, 125, 0, 0 )
			end
		elseif ( getDistanceBetweenPoints3D ( x, y, z, px2, py2, pz2 ) <= 5 or isNearLVPDDutyIcon ( player ) ) and isFBI ( player ) then
			if isOnDuty(player) then
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
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist nicht\nim Dienst!", 7500, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nan der Richtigen\nStelle", 7500, 125, 0, 0 )
		end
	end
	
end
addCommandHandler ( "rearm", rearm_func )