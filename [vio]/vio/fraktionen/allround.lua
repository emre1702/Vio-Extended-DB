fraktionMembers = {}

for i = 0, 99 do
	fraktionMembers[i] = {}
end

factionVehicles = {}
factionVehicles[1] = {}
factionVehicles[2] = {}
factionVehicles[3] = {}
factionVehicles[4] = {}
factionVehicles[5] = {}
factionVehicles[6] = {}
factionVehicles[7] = {}
factionVehicles[8] = {}
factionVehicles[9] = {}

factionSkins = {}
factionSkins[1] = { [1]=280, [2]=281, [3]=282, [4]=283, [5]=284, [6]=285, [7]=288, [8]=265, [9]=266, [10]=267 }
factionSkins[2] = { [1]=111, [2]=112, [3]=113, [4]=124, [5]=125, [6]=126, [7]=127, [8]=237, [9]=211, [10]=272 }
factionSkins[3] = { [1]=49, [2]=117, [3]=118, [4]=120, [5]=122, [6]=123, [7]=141, [8]=169, [9]=186, [10]=294 }
factionSkins[4] = { [1]=221, [2]=222, [3]=220, [4]=143, [5]=142, [6]=307 }
factionSkins[5] = { [1]=59, [2]=141, [3]=187, [4]=188, [5]=189, [6]=296 }
factionSkins[6] = { [1]=285, [2]=286, [3]=165, [4]=164, [5]=163, [6]=295 }
factionSkins[7] = { [1]=173, [2]=174, [3]=175, [4]=115, [5]=114, [6]=116, [7]=293 }
factionSkins[8] = { [1]=287, [2]=312, [3]=191 }
factionSkins[9] = { [1]=100, [2]=247, [3]=248, [4]=298 }

fraktionNames = {}
fraktionNames = { [1]="SFPD", [2]="Mafia", [3]="Triaden", [4]="Terroristen", [5]="Reporter", [6]="FBI", [7]="Aztecas", [8]="Army", [9]="Angels of Death" }

---------------------------------------------------------------------------------------------------------------

function isPDCar ( car )
	if factionVehicles[1][car] then return true else return false end
end

function isMafiaCar ( car )
	if factionVehicles[2][car] then return true else return false end
end

function isTriadenCar ( car )
	if factionVehicles[3][car] then return true else return false end
end

function isTerrorCar ( car )
	if factionVehicles[4][car] then return true else return false end
end

function isNewsCar ( car )
	if factionVehicles[5][car] then return true else return false end
end

function isFBICar ( car )
	if factionVehicles[6][car] then return true else return false end
end

function isAztecasCar ( car )
	if factionVehicles[7][car] then return true else return false end
end

function isArmyCar ( car )
	if factionVehicles[8][car] then return true else return false end
end

function isBikerCar ( car )
	if factionVehicles[9][car] then return true else return false end
end

function isFederalCar ( car )
	if isArmyCar( car ) or isFBICar( car ) or isPDCar ( car ) then
		return true
	else
		return false
	end
end

function isEvilCar ( car )
	if isMafiaCar( car ) or isTriadenCar( car ) or isTerrorCar ( car ) or isAztecasCar ( car ) or isBikerCar ( car ) then
		return true
	else
		return false
	end
end

function getPlayerFaction ( player )

	local fac = vioGetElementData ( player, "fraktion" )
	
	if fac then
	
		return tonumber(fac)
	
	else

		return false
	
	end

end

function getPlayerRank ( player )

	local ran = vioGetElementData ( player, "rang" )
	
	if ran then
	
		return tonumber(ran)
	
	else
	
		return false
	
	end

end

function getPlayerRankName ( player )

	local ran = getPlayerRank ( player )
	local fac = getPlayerFaction ( player )
	
	if ran then
	
		return factionRankNames[fac][ran]
	
	else
	
		return false
	
	end

end

-----------------------------------------------------------------------------------------------------

function isReporter(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 5 then return true else return false end
end

function isTerror(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 4 then return true else return false end
end

function isTriad(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 3 then return true else return false end
end

function isMafia(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 2 then return true else return false end
end

function isCop(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 1 then return true else return false end
end

function isFBI(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 6 then return true else return false end
end

function isAztecas(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 7 then return true else return false end
end

function isArmy(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 8 then return true else return false end
end

function isBiker(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 9 then return true else return false end
end

------------------------------------------------------------------------------------------------------

function isStateFaction(player)
	if isArmy(player) or isCop(player) or isFBI(player) then return true else return false end
end

function isOnStateDuty(player)
	return isOnDuty(player)
end

function isOnDuty(player)

	local model = getElementModel(player) 
	
	for i, skin in pairs ( factionSkins[1] ) do
	
		if skin == model then
		
			return true
		
		end
	
	end
	
	for i, skin in pairs ( factionSkins[6] ) do
	
		if skin == model then
		
			return true
		
		end
	
	end
	
	for i, skin in pairs ( factionSkins[8] ) do
	
		if skin == model then
		
			return true
		
		end
	
	end
	
	return false
	
end

function isAbleOffduty ( player )

	local model = getElementModel(player) 
	
	for i, skin in pairs ( factionSkins[1] ) do
	
		if skin == model then
		
			return true
		
		end
	
	end
	
	for i, skin in pairs ( factionSkins[6] ) do
	
		if skin == model then
		
			return true
		
		end
	
	end
	
	return false

end

function isEvil(player)
	if isMafia(player) or isTriad(player) or isTerror(player) or isAztecas(player) or isBiker(player) then return true else return false end
end

function isInDepotFaction(player)
	if isMafia(player) or isTriad(player) or isTerror(player) or isReporter(player) or isAztecas(player) or isBiker(player) then return true else return false end
end

---------------------------------------------------------------------------------------------------

function sendMSGForFaction ( msg, faction, r, g, b )

	if not r then
		local r, g, b = 200, 200, 100
	end
	
	for playeritem, key in pairs ( fraktionMembers[faction] ) do
		outputChatBox ( msg, playeritem, r, g, b )
	end
	
end

function getFactionMembersOnline ( faction )

	if faction then
		counter = 0
		for playeritem, index in pairs ( fraktionMembers[faction] ) do
			counter = counter + 1
		end
		return counter
	else
		return false
	end
	
end
function policeComputer ( presser, key, state )

	if state == "down" and isOnDuty(presser) and isFederalCar ( getPedOccupiedVehicle ( presser ) ) and getElementModel ( getPedOccupiedVehicle ( presser ) ) ~= 520 then
		triggerClientEvent ( presser,"showPDComputer", getRootElement() )
	end
	
end
function createTeleportMarker ( x1, y1, z1, int1, dim1, x2, y2, z2, int2, dim2, rot, needetFaction )

	if not needetFaction then
		needetFaction = 0
	end
	
	local marker1 = createMarker ( x1, y1, z1 + 0.5, "corona", 1, 0, 0, 0, 0 )
	local marker2 = createMarker ( x1, y1, z1, "cylinder", 1, 255, 0, 0, 150 )
	setElementDimension ( marker1, dim1 )
	setElementDimension ( marker2, dim1 )
	setElementInterior ( marker1, int1 )
	setElementInterior ( marker2, int1 )
	
	addEventHandler ( "onMarkerHit", marker1,
		function ( hit, dim )
			if dim then
				if getElementType ( hit ) == "player" then
					if not getPedOccupiedVehicle ( hit ) then
						if needetFaction == 0 or getElementData ( hit, "fraktion" ) == needetFaction then
							fadeElementInterior ( hit, int2, x2, y2, z2, rot, dim2 )
						else
							infobox ( hit, "Du bist nicht\nbefugt!", 5000, 125, 0, 0 )
						end
					end
				end
			end
		end
	)
	
end

function createFactionVehicle ( model, x, y, z, rx, ry, rz, faction, c1, c2, c3, c4, numberplate )

	if not c3 then
		c3 = 0
	end
	
	if not c4 then
		c4 = 0
	end
	
	if not numberplate then
		numberplate = fraktionNames[faction]
	end
	
	local veh = createVehicle ( model, x, y, z, rx, ry, rz, numberplate )
	
	setVehicleColor ( veh, c1, c2, c3, c4 )
	setVehiclePaintjob ( veh, 3 )
	toggleVehicleRespawn ( veh, true )
	setVehicleRespawnDelay ( veh, FCarDestroyRespawn * 1000 * 60 )
	setVehicleIdleRespawnDelay ( veh, FCarIdleRespawn * 1000 * 60 )
	factionVehicles[faction][veh] = true
	
	vioSetElementData ( veh, "owner", fraktionNames[faction] )
	vioSetElementData ( veh, "ownerfraktion", faction )
	
	if faction == 1 then
	
		addEventHandler ( "onVehicleEnter", veh,
			function ( player, seat )
				local veh = source
				if getPedOccupiedVehicleSeat ( player ) == 0 then
					if not isOnDuty( player ) then
						opticExitVehicle ( player )
						infobox ( player, "Du bist kein\n"..fraktionNames[faction].."!", 5000, 125, 0, 0 )
					else
						if not isKeyBound ( player, "sub_mission", "down", policeComputer ) then
							bindKey ( player, "sub_mission", "down", policeComputer )
						end
					end
				else
				
					if not isKeyBound ( player, "sub_mission", "down", policeComputer ) and isOnDuty( player ) then
						bindKey ( player, "sub_mission", "down", policeComputer )
					end
				
				end
			end )
			
	elseif faction == 6 then
	
		addEventHandler ( "onVehicleEnter", veh,
			function ( player, seat )
				local veh = source
				if getPedOccupiedVehicleSeat ( player ) == 0 then
				
					if isFBI ( player ) and isOnDuty( player ) then
						if not isKeyBound ( player, "sub_mission", "down", policeComputer ) then
							bindKey ( player, "sub_mission", "down", policeComputer )
						end
					else
						opticExitVehicle ( player )
						infobox ( player, "Du bist kein\n"..fraktionNames[faction].."!", 5000, 125, 0, 0 )
					end

				else
				
					if not isKeyBound ( player, "sub_mission", "down", policeComputer ) and isOnDuty( player ) then
						bindKey ( player, "sub_mission", "down", policeComputer )
					end
				
				end
			end )
			
	elseif faction == 8 then
		
		addEventHandler ( "onVehicleEnter", veh,
			function ( player, seat )
				local veh = source
				if getPedOccupiedVehicleSeat ( player ) == 0 then
				
					if not isArmy(player) then
						opticExitVehicle ( player )
						infobox ( player, "Du bist kein\n"..fraktionNames[faction].."!", 5000, 125, 0, 0 )
					else
					
						if not isKeyBound ( player, "sub_mission", "down", policeComputer ) and getElementModel ( veh ) ~= 520 then
							bindKey ( player, "sub_mission", "down", policeComputer )
						end
					
						if getElementModel ( veh ) == 433 then
						
							setElementHealth ( player, 100 )
							triggerClientEvent ( player, "sec_health_give", getRootElement(), 999 )
							setPedArmor ( player, 100 )
							triggerClientEvent ( player, "sec_armor_give", getRootElement(), 100 )
							triggerClientEvent ( player, "eatSomething", getRootElement() )
							
						elseif getElementModel ( veh ) == 432 then
						
							if vioGetElementData ( player, "job" ) ~= "tankcommander" then
								opticExitVehicle ( player )
								outputChatBox ( "Du hast nicht die erforderliche Klasse!", player, 125, 0, 0 )
							end
							
						elseif getElementModel ( veh ) == 425 or getElementModel ( veh ) == 520 then
						
							if vioGetElementData ( player, "job" ) ~= "air" then
								opticExitVehicle ( player )
								outputChatBox ( "Du hast nicht die erforderliche Klasse!", player, 125, 0, 0 )
							end	
							
						elseif getElementModel ( veh ) == 563 or getElementModel ( veh ) == 595 then
							
							if vioGetElementData ( player, "job" ) ~= "marine" and seat == 0 then
								opticExitVehicle ( player )
								outputChatBox ( "Du hast nicht die erforderliche Klasse!", player, 125, 0, 0 )
							else
								giveWeapon ( player, 46, 3, true )
								triggerClientEvent ( player, "sec_gun_give", getRootElement(), 46, 3 )
							end
							
						end
					
					end
					
				else

					if not isKeyBound ( player, "sub_mission", "down", policeComputer ) and isOnDuty( player ) then
						bindKey ( player, "sub_mission", "down", policeComputer )
					end
					
					if getElementModel ( veh ) == 433 then
					
						setElementHealth ( player, 100 )
						triggerClientEvent ( player, "sec_health_give", getRootElement(), 999 )
						setPedArmor ( player, 100 )
						triggerClientEvent ( player, "sec_armor_give", getRootElement(), 100 )
						triggerClientEvent ( player, "eatSomething", getRootElement() )
					
					end
					
				end
			end )
	
	else
	
		addEventHandler ( "onVehicleEnter", veh,
			function ( player, seat )
				local veh = source
				if getPedOccupiedVehicleSeat ( player ) == 0 then
					if vioGetElementData ( player, "fraktion" ) ~= faction then
						opticExitVehicle ( player )
						infobox ( player, "Du bist kein\n"..fraktionNames[faction].."!", 5000, 125, 0, 0 )
					end
				end
			end )
		
	end
		
	return veh
	
end

function block_tie_cmds ( cmd )
	cancelEvent()
end

function tie_func ( player, cmd, target )

	local target = findPlayerByName( target )
	
	if target and target ~= player and getPedOccupiedVehicle ( target ) then
	
		if isEvil(player) or isOnDuty(player) then
		
			if getVehicleOccupant( getPedOccupiedVehicle ( player ) ) ~= target and getPedOccupiedVehicleSeat ( target ) > 0 then
			
				local x1, y1, z1 = getElementPosition ( player )
				local x2, y2, z2 = getElementPosition ( target )
				
				if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 5 then
				
					local boolean = not vioGetElementData ( target, "tied" )
					vioSetElementData ( target, "tied", boolean )
					toggleAllControls ( target, boolean )
					if boolean then fix = "ent" else fix = "ge" end
					
					if fix == "ge" then
					
						addEventHandler( "onPlayerCommand", target, block_tie_cmds )
							
					elseif fix == "ent" then
					
						removeEventHandler ( "onPlayerCommand", target, block_tie_cmds )
					
					end
					
					if fix == "ent" then
					
						fadeCamera ( target, true, 0.5, 0, 0, 0 )
						
					elseif isEvil ( player ) then
					
						fadeCamera ( target, false, 0.5, 0, 0, 0 )
						
					end
					
					outputChatBox ( "Du hast "..getPlayerName(target).." "..fix.."fesselt!", player, 0, 125, 0 )
					outputChatBox ( "Du wurdest von "..getPlayerName(player).." "..fix.."fesselt!", target, 200, 200, 0 )
					
				else
				
					outputChatBox ( "Du bist zu weit weg!", player, 125, 0, 0 )
					
				end
				
			else
			
				outputChatBox ( "Ungueltiges Ziel!", player, 125, 0, 0 )
				
			end
			
		else
		
			outputChatBox ( "Du bist in einer ungueltigen Fraktion!", player, 125, 0, 0 )
			
		end
		
	else
	
		outputChatBox ( "Ungueltiges Ziel!", player, 125, 0, 0 )
		
	end
	
end

addCommandHandler ( "tie", tie_func )


local function fstate_func_depotgeld_DB ( qh, player ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		outputChatBox ( "Geld in der Fraktionskasse: "..result[1]["DepotGeld"], player, 200, 200, 0 )
	end
end

function fstate_func(player)

	if isMafia ( player ) then
		outputChatBox ( "Bestand:", player, 0, 0, 125 )
		outputChatBox ( "Schlagringe: "..MafiaSchlagringe.." von "..baseballcap, player, 0, 125, 0 )
		outputChatBox ( "Baseballschlaeger: "..MafiaBaseballschlaeger.." von "..baseballcap, player, 0, 125, 0 )
		outputChatBox ( "Messer: "..MafiaMesser.." von "..knifecap, player, 0, 125, 0 )
		outputChatBox ( "Schaufeln: "..MafiaSchaufeln.." von "..shovelscap, player, 0, 125, 0 )
		outputChatBox ( "Pistolen: "..MafiaPistolen.." von "..pistolcap, player, 0, 125, 0 )
		outputChatBox ( "SD-Pistolen: "..MafiaSDPistolen.." von "..sdpistolcap, player, 0, 125, 0 )
		outputChatBox ( "9mm Magazine: "..MafiaPistolenMagazine.." von "..pistolammocap, player, 0, 125, 0 )
		outputChatBox ( "Desert Eagles: "..MafiaDesertEagles.." von "..eaglecap, player, 0, 125, 0 )
		outputChatBox ( "Desert Eagle Magazine: "..MafiaDesertEagleMunition.." von "..eagleammocap, player, 0, 125, 0 )
		outputChatBox ( "Schrotflinten: "..MafiaSchrotflinten.." von "..shotguncap, player, 0, 125, 0 )
		outputChatBox ( "Schrotkugeln: "..MafiaSchrotflintenMunition.." von "..shotgunammocap, player, 0, 125, 0 )
		outputChatBox ( "MP5: "..MafiaMP.." von "..mpcap, player, 0, 125, 0 )
		outputChatBox ( "MP5 Magazine: "..MafiaMPMunition.." von "..mpammocap, player, 0, 125, 0 )
		outputChatBox ( "AK-47: "..MafiaAK.." von "..akcap, player, 0, 125, 0 )
		outputChatBox ( "Ak-47 Magazine "..MafiaAKMunition.." von "..akammocap, player, 0, 125, 0 )
		outputChatBox ( "M4: "..MafiaM.." von "..mcap, player, 0, 125, 0 )
		outputChatBox ( "M4 Magazine "..MafiaMMunition.." von "..mammocap, player, 0, 125, 0 )
		outputChatBox ( "Gewehre: "..MafiaGewehre.." von "..gewehrcap, player, 0, 125, 0 )
		outputChatBox ( "Gewehr Patronen: "..MafiaGewehrPatronen.." von "..gewehrammocap, player, 0, 125, 0 )
		outputChatBox ( "Scharfschuetzengewehre: "..MafiaSGewehr.." von "..sgewehrcap, player, 0, 125, 0 )
		outputChatBox ( "Scharfschuetzengewehr Patronen: "..MafiaSGewehrMunition.." von "..sgewehrammocap, player, 0, 125, 0 )
		outputChatBox ( "Raketenwerfer: "..MafiaRaketenwerfer.." von "..raketenwerfercap, player, 0, 125, 0 )
		outputChatBox ( "Raketen: "..MafiaRaketen.." von "..raketencap, player, 0, 125, 0 )
		outputChatBox ( "Luparas: "..MafiaSpezwaffen.." von "..spezguncap, player, 0, 125, 0 )
	elseif isTriad ( player ) then
		outputChatBox ( "Bestand:", player, 0, 0, 125 )
		outputChatBox ( "Schlagringe: "..TriadenSchlagringe.." von "..baseballcap, player, 0, 125, 0 )
		outputChatBox ( "Baseballschlaeger: "..TriadenBaseballschlaeger.." von "..baseballcap, player, 0, 125, 0 )
		outputChatBox ( "Messer: "..TriadenMesser.." von "..knifecap, player, 0, 125, 0 )
		outputChatBox ( "Schaufeln: "..TriadenSchaufeln.." von "..shovelscap, player, 0, 125, 0 )
		outputChatBox ( "Pistolen: "..TriadenPistolen.." von "..pistolcap, player, 0, 125, 0 )
		outputChatBox ( "SD-Pistolen: "..TriadenSDPistolen.." von "..sdpistolcap, player, 0, 125, 0 )
		outputChatBox ( "9mm Magazine: "..TriadenPistolenMagazine.." von "..pistolammocap, player, 0, 125, 0 )
		outputChatBox ( "Desert Eagles: "..TriadenDesertEagles.." von "..eaglecap, player, 0, 125, 0 )
		outputChatBox ( "Desert Eagle Magazine: "..TriadenDesertEagleMunition.." von "..eagleammocap, player, 0, 125, 0 )
		outputChatBox ( "Schrotflinten: "..TriadenSchrotflinten.." von "..shotguncap, player, 0, 125, 0 )
		outputChatBox ( "Schrotkugeln: "..TriadenSchrotflintenMunition.." von "..shotgunammocap, player, 0, 125, 0 )
		outputChatBox ( "MP5: "..TriadenMP.." von "..mpcap, player, 0, 125, 0 )
		outputChatBox ( "MP5 Magazine: "..TriadenMPMunition.." von "..mpammocap, player, 0, 125, 0 )
		outputChatBox ( "AK-47: "..TriadenAK.." von "..akcap, player, 0, 125, 0 )
		outputChatBox ( "Ak-47 Magazine "..TriadenAKMunition.." von "..akammocap, player, 0, 125, 0 )
		outputChatBox ( "M4: "..TriadenM.." von "..mcap, player, 0, 125, 0 )
		outputChatBox ( "M4 Magazine "..TriadenMMunition.." von "..mammocap, player, 0, 125, 0 )
		outputChatBox ( "Gewehre: "..TriadenGewehre.." von "..gewehrcap, player, 0, 125, 0 )
		outputChatBox ( "Gewehr Patronen: "..TriadenGewehrPatronen.." von "..gewehrammocap, player, 0, 125, 0 )
		outputChatBox ( "Scharfschuetzengewehre: "..TriadenSGewehr.." von "..sgewehrcap, player, 0, 125, 0 )
		outputChatBox ( "Scharfschuetzengewehr Patronen: "..TriadenSGewehrMunition.." von "..sgewehrammocap, player, 0, 125, 0 )
		outputChatBox ( "Raketenwerfer: "..TriadenRaketenwerfer.." von "..raketenwerfercap, player, 0, 125, 0 )
		outputChatBox ( "Raketen: "..TriadenRaketen.." von "..raketencap, player, 0, 125, 0 )
		outputChatBox ( "Katanas: "..TriadenSpezwaffen.." von "..spezguncap, player, 0, 125, 0 )
	elseif isAztecas ( player ) then
		outputChatBox ( "Bestand:", player, 0, 0, 125 )
		outputChatBox ( "Schlagringe: "..AztecasSchlagringe.." von "..baseballcap, player, 0, 125, 0 )
		outputChatBox ( "Baseballschlaeger: "..AztecasBaseballschlaeger.." von "..baseballcap, player, 0, 125, 0 )
		outputChatBox ( "Messer: "..AztecasMesser.." von "..knifecap, player, 0, 125, 0 )
		outputChatBox ( "Schaufeln: "..AztecasSchaufeln.." von "..shovelscap, player, 0, 125, 0 )
		outputChatBox ( "Pistolen: "..AztecasPistolen.." von "..pistolcap, player, 0, 125, 0 )
		outputChatBox ( "SD-Pistolen: "..AztecasSDPistolen.." von "..sdpistolcap, player, 0, 125, 0 )
		outputChatBox ( "9mm Magazine: "..AztecasPistolenMagazine.." von "..pistolammocap, player, 0, 125, 0 )
		outputChatBox ( "Desert Eagles: "..AztecasDesertEagles.." von "..eaglecap, player, 0, 125, 0 )
		outputChatBox ( "Desert Eagle Magazine: "..AztecasDesertEagleMunition.." von "..eagleammocap, player, 0, 125, 0 )
		outputChatBox ( "Schrotflinten: "..AztecasSchrotflinten.." von "..shotguncap, player, 0, 125, 0 )
		outputChatBox ( "Schrotkugeln: "..AztecasSchrotflintenMunition.." von "..shotgunammocap, player, 0, 125, 0 )
		outputChatBox ( "MP5: "..AztecasMP.." von "..mpcap, player, 0, 125, 0 )
		outputChatBox ( "MP5 Magazine: "..AztecasMPMunition.." von "..mpammocap, player, 0, 125, 0 )
		outputChatBox ( "AK-47: "..AztecasAK.." von "..akcap, player, 0, 125, 0 )
		outputChatBox ( "Ak-47 Magazine "..AztecasAKMunition.." von "..akammocap, player, 0, 125, 0 )
		outputChatBox ( "M4: "..AztecasM.." von "..mcap, player, 0, 125, 0 )
		outputChatBox ( "M4 Magazine "..AztecasMMunition.." von "..mammocap, player, 0, 125, 0 )
		outputChatBox ( "Gewehre: "..AztecasGewehre.." von "..gewehrcap, player, 0, 125, 0 )
		outputChatBox ( "Gewehr Patronen: "..AztecasGewehrPatronen.." von "..gewehrammocap, player, 0, 125, 0 )
		outputChatBox ( "Scharfschuetzengewehre: "..AztecasSGewehr.." von "..sgewehrcap, player, 0, 125, 0 )
		outputChatBox ( "Scharfschuetzengewehr Patronen: "..AztecasSGewehrMunition.." von "..sgewehrammocap, player, 0, 125, 0 )
		outputChatBox ( "Raketenwerfer: "..AztecasRaketenwerfer.." von "..raketenwerfercap, player, 0, 125, 0 )
		outputChatBox ( "Raketen: "..AztecasRaketen.." von "..raketencap, player, 0, 125, 0 )
		outputChatBox ( "Molotovs: "..AztecasSpezwaffen.." von "..spezguncap, player, 0, 125, 0 )
	elseif isBiker(player) then
		outputChatBox ( "Bestand:", player, 0, 0, 125 )
		outputChatBox ( "Schlagringe: "..BikerSchlagringe.." von "..baseballcap, player, 0, 125, 0 )
		outputChatBox ( "Baseballschlaeger: "..BikerBaseballschlaeger.." von "..baseballcap, player, 0, 125, 0 )
		outputChatBox ( "Messer: "..BikerMesser.." von "..knifecap, player, 0, 125, 0 )
		outputChatBox ( "Schaufeln: "..BikerSchaufeln.." von "..shovelscap, player, 0, 125, 0 )
		outputChatBox ( "Pistolen: "..BikerPistolen.." von "..pistolcap, player, 0, 125, 0 )
		outputChatBox ( "SD-Pistolen: "..BikerSDPistolen.." von "..sdpistolcap, player, 0, 125, 0 )
		outputChatBox ( "9mm Magazine: "..BikerPistolenMagazine.." von "..pistolammocap, player, 0, 125, 0 )
		outputChatBox ( "Desert Eagles: "..BikerDesertEagles.." von "..eaglecap, player, 0, 125, 0 )
		outputChatBox ( "Desert Eagle Magazine: "..BikerDesertEagleMunition.." von "..eagleammocap, player, 0, 125, 0 )
		outputChatBox ( "Schrotflinten: "..BikerSchrotflinten.." von "..shotguncap, player, 0, 125, 0 )
		outputChatBox ( "Schrotkugeln: "..BikerSchrotflintenMunition.." von "..shotgunammocap, player, 0, 125, 0 )
		outputChatBox ( "MP5: "..BikerMP.." von "..mpcap, player, 0, 125, 0 )
		outputChatBox ( "MP5 Magazine: "..BikerMPMunition.." von "..mpammocap, player, 0, 125, 0 )
		outputChatBox ( "AK-47: "..BikerAK.." von "..akcap, player, 0, 125, 0 )
		outputChatBox ( "Ak-47 Magazine "..BikerAKMunition.." von "..akammocap, player, 0, 125, 0 )
		outputChatBox ( "M4: "..BikerM.." von "..mcap, player, 0, 125, 0 )
		outputChatBox ( "M4 Magazine "..BikerMMunition.." von "..mammocap, player, 0, 125, 0 )
		outputChatBox ( "Gewehre: "..BikerGewehre.." von "..gewehrcap, player, 0, 125, 0 )
		outputChatBox ( "Gewehr Patronen: "..BikerGewehrPatronen.." von "..gewehrammocap, player, 0, 125, 0 )
		outputChatBox ( "Scharfschuetzengewehre: "..BikerSGewehr.." von "..sgewehrcap, player, 0, 125, 0 )
		outputChatBox ( "Scharfschuetzengewehr Patronen: "..BikerSGewehrMunition.." von "..sgewehrammocap, player, 0, 125, 0 )
		outputChatBox ( "Raketenwerfer: "..BikerRaketenwerfer.." von "..raketenwerfercap, player, 0, 125, 0 )
		outputChatBox ( "Raketen: "..BikerRaketen.." von "..raketencap, player, 0, 125, 0 )
		outputChatBox ( "Uzis: "..BikerSpezwaffen.." von "..spezguncap, player, 0, 125, 0 )
	elseif isCop ( player ) or isFBI ( player ) or isArmy ( player ) then
		dbQuery( fstate_func_depotgeld_DB, { player }, handler, "SELECT DepotGeld FROM fraktionen WHERE ID LIKE '1'" )
	end
end

addCommandHandler ( "fstate", fstate_func )

function fskin_func ( player )
	
	local curskin = getElementModel ( player )
	local faction = getPlayerFaction ( player )
	local val = false
	
	if getPedOccupiedVehicle ( player ) then
	
		outputChatBox ( "Bitte nutze diesen Befehl nur ausserhalb von Fahrzeugen!", player, 125, 0, 0 )
		
	elseif faction == 1 and isOnDuty(player) and getElementModel ( player ) ~= 285 then
	
		for i, skin in pairs (factionSkins[1]) do
		
			if skin == getElementModel(player) then
			
				val = i
				break
				
			end
		
		end
		
		if val == false or val == #factionSkins[1] then
		
			setElementModel ( player, factionSkins[1][1] )
			return
		
		elseif val == 5 then
		
			setElementModel ( player, factionSkins[1][7] )
			return
		
		else
		
			setElementModel ( player, factionSkins[1][val+1] )
			return
		
		end
			
	elseif faction == 6 and isOnDuty(player) and getElementModel ( player ) ~= 285 then
	
		for i, skin in pairs (factionSkins[6]) do
		
			if skin == getElementModel(player) then
			
				val = i
				break
				
			end
		
		end
		
		if val == false or val == #factionSkins[6] then
		
			setElementModel ( player, factionSkins[6][2] )
			return
				
		else
		
			setElementModel ( player, factionSkins[6][val+1] )
			return
		
		end
		
	elseif faction >= 1 and faction ~= 1 and faction ~= 6 then
	
		for i, skin in pairs (factionSkins[faction]) do
		
			if skin == getElementModel(player) then
			
				val = i
				break
				
			end
		
		end
		
		if val == false or val == #factionSkins[faction] then
		
			setElementModel ( player, factionSkins[faction][1] )
			vioSetElementData ( player, "skinid", factionSkins[faction][1] )
			return
				
		else
		
			setElementModel ( player, factionSkins[faction][val+1] )
			vioSetElementData ( player, "skinid", factionSkins[faction][val+1] )
			return
		
		end

	else
	
		outputChatBox ( "Du darfst diesen Befehl nicht benutzen!", player, 125, 0, 0 )
		
	end
end

addCommandHandler ( "fskin", fskin_func )


function invite_func ( player, cmd, target )

	local faction = getPlayerFaction ( player )
	local rank = getPlayerRank ( player )

	if faction ~= 0 and rank >= 5 then
	
		local target = findPlayerByName( target )
		
		if target ~= false then
		
			if getPlayerFaction( target ) == 0 then
			
				if not isInGang ( getPlayerName ( target ) ) then
				
					vioSetElementData ( target, "fraktion", faction )
					vioSetElementData ( target, "rang", 0 )
					fraktionMembers[faction][target] = faction
					outputChatBox ( "Du wurdest soeben in eine Fraktion aufgenommen! Tippe /t [Text] fuer den Chat und F1, um mehr zu erfahren!", target, 0, 125, 0 )
					outputChatBox ( "Du hast den Spieler "..getPlayerName(target).." in deine Fraktion aufgenommen!", player, 0, 125, 0 )
					
				else
				
					infobox ( player, "\n\n\nDer Spieler ist\nin einer Gang!", 5000, 125, 0, 0 )
					
				end
				
			else
			
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler ist\nbereits in\neiner Fraktion!", 5000, 125, 0, 0 )
				
			end
			
		else
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
		
	end
	
end

addCommandHandler ( "invite", invite_func )

function uninvite_func ( player, cmd, target )

	local faction = getPlayerFaction ( player )
	local rank = getPlayerRank ( player )

	if faction > 0 and rank >= 5 then
	
		local target = findPlayerByName( target )
		
		if target ~= false then
		
			if faction == getPlayerFaction( target ) and getPlayerRank ( target ) <= 4 then
			
				local model = malehomeless[math.random ( 1, 5 )]
				setElementModel ( target, model )
				vioSetElementData ( target, "skinid", model )
				
				vioSetElementData ( target, "rang", 0 )
				fraktionMembers[faction][target] = nil
				vioSetElementData ( target, "fraktion", 0 )
				outputChatBox ( "Du wurdest soeben aus deiner Fraktion geworfen!", target, 0, 125, 0 )
				dbExec( handler, "UPDATE userdata SET LastFactionChange = ? WHERE Name LIKE ?", timestampOptical(), getPlayerName( target ) )
				outputChatBox ( "Du hast den Spieler "..getPlayerName(target).." aus deiner Fraktion entfernt!", player, 0, 125, 0 )
				
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du kannst den\nSpieler nicht aus\nder Fraktion\nentfernen!", 5000, 125, 0, 0 )
			end
			
		else
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
		
	end
	
end

addCommandHandler ( "uninvite", uninvite_func )


local function getchangestate_func_DB ( qh, player )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		outputChatBox ( "Letzter Fraktions-Uninvite: ".. result[1]["LastFactionChange"], player, 200, 200, 0 )
	end
end

function getchangestate_func ( player, cmd, target )

	local target = findPlayerByName( target )
	
	if isElement ( target ) then
	
		if vioGetElementData ( player, "adminlvl" ) >= 1 or vioGetElementData ( player, "rang" ) >= 4 then
		
			dbQuery( getchangestate_func_DB, { player }, handler, "SELECT LastFactionChange FROM userdata WHERE Name LIKE ?", getPlayerName( target ) )
			
		else
		
			outputChatBox ( "Du bist kein Admin/Leader/Coleader!", player, 125, 0, 0 )
			
		end
		
	else
	
		outputChatBox ( "Der Spieler ist nicht online!", player, 125, 0, 0 )
		
	end
	
end

addCommandHandler ( "getchangestate", getchangestate_func )

function giverank_func ( player, cmd, target, newrank )

	local newrank = math.abs ( math.floor ( tonumber ( newrank ) ) )
	local target = findPlayerByName( target )
	local faction = getPlayerFaction ( player )
	local rank = getPlayerRank ( player )
	
	if target then
	
		local targetfaction = getPlayerFaction ( target )
		local targetrank = getPlayerRank ( target )
	
		if faction >= 1 and rank >= 4 and faction == targetfaction and rank > newrank and targetrank ~= newrank then
		
			if newrank < 5 and newrank >= 0 then
			
				if newrank > targetrank then
				
					outputChatBox ( "Glueckwunsch, du wurdest soeben von "..getPlayerName ( player ).." zum "..factionRankNames[faction][newrank].." befoerdert!", target, 0, 125, 0 )
					
				else
				
					outputChatBox ( "Du wurdest soeben von "..getPlayerName ( player ).." zum "..factionRankNames[faction][newrank].." degradiert!", target, 125, 0, 0 )
					
				end
				
				vioSetElementData ( target, "rang", newrank )
				outputChatBox ( "Du hast "..getPlayerName(target).." soeben Rang "..factionRankNames[faction][newrank].." ( "..newrank.." ) gegeben!", player, 0, 125, 0 )
				
			end
			
		else
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
			
		end
	
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
		
	end
	
end

addCommandHandler ( "giverank", giverank_func )