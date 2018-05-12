local weaponDamages = {}
	weaponDamages[8] = 35
	
	weaponDamages[22] = 10
	weaponDamages[23] = 10
	weaponDamages[24] = 25
	
	weaponDamages[25] = 20
	
	weaponDamages[28] = 5
	weaponDamages[29] = 8
	weaponDamages[32] = 5
	
	weaponDamages[30] = 6
	weaponDamages[31] = 8
	
	weaponDamages[33] = 15
	weaponDamages[34] = 50
	
	weaponDamages[51] = 40

local semiAutomatic = {}
	semiAutomatic[22] = true
	semiAutomatic[23] = true
	semiAutomatic[24] = true
	
	--semiAutomatic[25] = true
	
	semiAutomatic[33] = true
	semiAutomatic[34] = true

function damageCalcServer_func ( attacker, weapon, bodypart, loss, player )

	if attacker and weapon and bodypart and loss then
		-- Spawnschutz
		if not vioGetElementData ( attacker, "spawnProtection" ) and not vioGetElementData (player, "spawnProtection" ) and getElementType ( player ) == "player" then
			-- Spielzeit
			if getElementData ( attacker, "playingtime" ) > 180 and getElementData (player, "playingtime" ) > 180 then
				if getElementData (player, "jailtime" ) == 0 then
					local ammoTyp = vioGetElementData ( attacker, "curAmmoTyp" )
					if weapon == 34 and bodypart == 9 and ammoTyp ~= 5 then
						setPedHeadless ( player, true )
						killPed ( player, attacker, weapon, bodypart )
					else
						local basicDMG = weaponDamages[weapon]
						local dontDealDamage = false
						if rangedWeapons[getPedWeapon ( attacker )] then
							if ammoTyp and ammoTyp > 0 then
								if ammoTyp == 1 and vioGetElementData ( attacker, "ammoTyp1" ) then
									if not getPedOccupiedVehicle (player ) then
										setPedOnFire (player, true )
										setTimer ( setPedOnFire, 350, 1,player, false )
									end
								elseif ammoTyp == 2 and vioGetElementData ( attacker, "ammoTyp2" ) then
									if getPedArmor ( player ) == 0 then
										basicDMG = basicDMG * 1.3
										
									end
								elseif ammoTyp == 3 and vioGetElementData ( attacker, "ammoTyp3" ) then
									if getPedArmor ( player ) > 0 then
										basicDMG = basicDMG * 1.3
										
									end
								elseif ammoTyp == 4 and semiAutomatic[weapon] and vioGetElementData ( attacker, "ammoTyp4" ) then
									dontDealDamage = true
								elseif ammoTyp == 5 and vioGetElementData ( attacker, "ammoTyp5" ) then
									if vioGetElementData ( player, "hitByChokeAmmo" ) then
										killTimer ( vioGetElementData ( player, "stopChokeTimer" ) )
									end
									setPedChoking ( player, true )
									vioSetElementData ( player, "hitByChokeAmmo", true )
									triggerClientEvent ( player, "smokeAmmoHit", player )
									triggerClientEvent ( attacker, "smokeAmmoHit", player )
									local stopChokeTimer = setTimer (
										function ( player )
											if vioGetElementData ( player, "hitByChokeAmmo" ) then
												vioSetElementData ( player, "hitByChokeAmmo", false )
												setPedChoking ( player, false )
											end
										end,
									1000, 1, player )
									vioSetElementData ( player, "stopChokeTimer", stopChokeTimer )
									dontDealDamage = true
								elseif ammoTyp == 6 and vioGetElementData ( attacker, "ammoTyp6" ) then
									setPedHeadless  ( player, true )
									dontDealDamage = true
									
									setTimer ( 
										function ( playerid )
											setPedHeadless  ( playerid, false )
										end,
									600000, 1, player )
								end
							end
						end
												
						if not dontDealDamage then
							if weapon == 0 then
								if getPedFightingStyle ( attacker ) == 7 or getPedFightingStyle ( attacker ) == 15 or getPedFightingStyle ( attacker ) == 16 then
									loss = loss / 2
								end
							end
							local multiply = 1
							if bodypart == 3 or bodypart == 4 then
								multiply = 1.5
							elseif bodypart == 5 or bodypart == 6 then
								multiply = 0.8
							elseif bodypart == 7 or bodypart == 8 then
								multiply = 1.2
							elseif bodypart == 9 then
								multiply = 2
							end
							
							if ( weaponDamages[weapon] ) then
								damagePlayer ( player, basicDMG * multiply, attacker, weapon )
								local aval = basicDMG * multiply
								outputLog ( getPlayerName ( attacker ).." hat "..getPlayerName ( player ).." mit Waffe "..weapon.." an Part "..bodypart.." getroffen, Schaden: "..aval, "dmg" )
							else
								damagePlayer ( player, loss, attacker, weapon )
								outputLog ( getPlayerName ( attacker ).." hat "..getPlayerName ( player ).." mit Waffe "..weapon.." an Part "..bodypart.." getroffen, Schaden: "..loss, "dmg" )
							end
							
							if bodypart == 2 then
								headlessPed ( player )
							end
							
							if attacker then
								vioSetElementData ( attacker, "lastcrime", "violance" )
							end
						end
						
						if not vioGetElementData ( attacker, "curAmmoTyp" ) then
						else
						
							if vioGetElementData ( attacker, "curAmmoTyp" ) ~= 0 then
							
								if gangAreaUnderAttack and gangAreaAttackers and gangAreaDefenders then
									
									local facu = getPlayerFaction ( attacker )
									
									if facu == gangAreaAttackers or gangAreaDefenders == facu then
									
										outputChatBox ("Spieler "..getPlayerName ( attacker ).." wurde von Konsole gekickt! (Grund: Spezialmunition beim GW)", getRootElement(), 255, 0, 0 )
										kickPlayer ( attacker, "Von: Konsole, Grund: Spezialmunition beim Gangwar" )
										
									end
								
								end
							
							end
						
						end
						
					end
				end
			end
		end
	end
end
addEvent ( "damageCalcServer", true )
addEventHandler ( "damageCalcServer", getRootElement(), damageCalcServer_func )

function specialBulletWeaponFire ( weapon, ammo, ammoInClip, x, y, z, hit )

	local player = client
	local ammoTyp = vioGetElementData ( player, "curAmmoTyp" )
	if ammoTyp > 0 then
		local amount = vioGetElementData ( player, "ammoTyp"..ammoTyp )
		if amount > 0 then
			giveWeapon ( player, weapon, 1 )
			if ammoTyp == 4 then
				createExplosion ( x, y, z, 12, player )
			end
			vioSetElementData ( player, "ammoTyp"..ammoTyp, amount - 1 )
			if vioGetElementData ( player, "ammoTyp"..ammoTyp ) == 0 then
				vioSetElementData ( player, "ammoTyp", 0 )
			end
		end
	end
end
addEvent ( "specialBulletWeaponFire", true )
addEventHandler ( "specialBulletWeaponFire", getRootElement(), specialBulletWeaponFire )

function headlessPed ( player )

	if isPedDead ( player ) then
		setPedHeadless ( player, true )
	end
end
--[[
function sniperPlayerKill ( attacker, weapon, bodypart )

	if weapon and isElement ( attacker ) and bodypart then
		if not vioGetElementData ( attacker, "spawnProtection" ) and not vioGetElementData ( source, "spawnProtection" ) then
			if getElementData ( attacker, "playingtime" ) > 180 and getElementData ( source, "playingtime" ) > 180 then
				if weapon == 34 and bodypart == 9 then
					setPedHeadless ( source, true )
					killPed ( source, attacker, weapon, bodypart )
				end
			end
		end
	end
end
addEvent ( "onPlayerDamage", true )
addEventHandler ( "onPlayerDamage", getRootElement(), sniperPlayerKill )]]

addEventHandler ( "onPlayerSpawn", getRootElement(),
	function ()
		vioSetElementData ( source, "spawnProtection", true )
		setTimer ( vioSetElementData, 10000, 1, source, "spawnProtection", false )
	end
)

--[[
    3: Torso
    4: Ass
    5: Left Arm
    6: Right Arm
    7: Left Leg
    8: Right leg
    9: Head 
]]