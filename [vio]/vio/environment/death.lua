function playerdeath ( ammo, killer, weapon, part )

	local player = source
	vioSetElementData ( player, "alcoholFlushPoints", 0 )
	vioSetElementData ( player, "drugFlushPoints", 0 )
	vioSetElementData ( player, "cigarettFlushPoints", 0 )
	if part then
		if part == 9 then
			setPedHeadless ( player, true )
		end
	end
	if getElementData ( player, "In_DMArena" ) == 1 then
		
	else
		if isKeyBound ( player, "enter_exit", "down", heliCoSeat ) then
			heliCoSeat ( player )
		end
		if not vioGetElementData ( player, "isInHighNoon" ) and ( not getElementData ( player, "In_DMArena" ) or getElementData ( player, "In_DMArena" ) == 0 ) then
			vioSetElementData ( player, "hunger", 40 )
			if vioGetElementData ( player, "callswith" ) then
				if vioGetElementData ( player, "callswith" ) ~= "none" then
					local caller = getPlayerFromName ( vioGetElementData ( player, "callswith" ) )
					if caller then
						vioSetElementData ( caller, "callswith", "none" )
						vioSetElementData ( caller, "call", false )
						vioSetElementData ( caller, "calls", "none" )
						vioSetElementData ( caller, "callswith", "none" )
						vioSetElementData ( caller, "calledby", "none" )
						outputChatBox ( "*Knack* - Die Leitung ist tod!", caller, 125, 0, 0 )
					end
					vioSetElementData ( player, "callswith", "none" )
					vioSetElementData ( player, "call", false )
					vioSetElementData ( player, "calls", "none" )
					vioSetElementData ( player, "callswith", "none" )
					vioSetElementData ( player, "calledby", "none" )
				end
			end
			if vioGetElementData ( player, "isInDrivingSchool" ) then
				cancelDrivingSchoolPlayer ( player )
			end
			if getPedOccupiedVehicle ( player ) then
				removePedFromVehicle ( player )
			end
			if isElement ( killer ) and killer ~= player and getPlayerName ( killer ) and weapon and not isOnStateDuty(killer) then
				outputServerLog ( getPlayerName ( killer ).." hat "..getPlayerName(player).." mit Waffe "..weapon.." erledigt!" )
				if vioGetElementData ( player, "fraktion" ) == 0 then
					local x1, y1, z1 = getElementPosition ( player )
					local x2, y2, z2 = getElementPosition ( killer )
					if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) < 7.5 then
						outputChatBox ( "Du hast ein Verbrechen begangen: Mord, gemeldet von: Anonym", killer, 0, 0, 150 )
						if vioGetElementData ( killer, "wanteds" ) <= 5 then
							vioSetElementData ( killer, "wanteds", vioGetElementData ( killer, "wanteds" ) + 1 )
							setPlayerWantedLevel ( killer, vioGetElementData ( killer, "wanteds" ) )
						end
					elseif getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) < 15 then
						if math.random ( 1, 2 ) == 1 then
							outputChatBox ( "Du hast ein Verbrechen begangen: Mord, gemeldet von: Anonym", killer, 0, 0, 150 )
							if vioGetElementData ( killer, "wanteds" ) <= 5 then
								vioSetElementData ( killer, "wanteds", vioGetElementData ( killer, "wanteds" ) + 1 )
								setPlayerWantedLevel ( killer, vioGetElementData ( killer, "wanteds" ) )
							end
						else
							vioSetElementData ( killer, "lastcrime", "mord" )
						end
					else
						vioSetElementData ( killer, "lastcrime", "mord" )
					end
				end
			end
			vioSetElementData ( player, "isinairportmission", false )
			setPlayerNametagColor ( player, 200, 200, 200 )
			vioSetElementData ( player, "isInRace", false )
			unbindKey ( player, "mouse_wheel_up", "down", weaponsup )
			unbindKey ( player, "mouse_wheel_down", "down", weaponsdown )
			unbindKey ( player , "g", "down", rein )
			unbindKey ( player, "enter", "down", eject )
			unbindKey ( player, "rshift", "down", helidriveby )
			unbindKey ( player, "1", "down", tazer_func )
			local timeToBeDeath = 60*1000
			if vioGetElementData ( player, "playingtime" ) >= 100 then
				timeToBeDeath = timeToBeDeath + 2
			elseif vioGetElementData ( player, "playingtime" ) >= 50 then
				timeToBeDeath = timeToBeDeath + 1
			end
			if isElement ( killer ) then
				if isHitman ( killer ) then
					local contract = vioGetElementData ( player, "contract" )
					if contract > 0 then
						vioSetElementData ( player, "hitmandeath", true )
						timeToBeDeath = timeToBeDeath + 2
						vioSetElementData ( player, "contract", 0 )
						vioSetElementData ( killer, "money", tonumber ( vioGetElementData ( killer, "money" ) ) + contract )
						givePlayerMoney ( killer, contract )
						triggerClientEvent ( killer, "HudEinblendenMoney", getRootElement() )
						playSoundFrontEnd ( killer, 40 )
						outputChatBox ( "Du solltest dir Gedanken machen - auf dich waren "..contract.." $ Kopfgeld ausgesetzt!", player, 125, 0, 0 )
						outputChatBox ( "Ziel erledigt. Belohnung: "..contract.." $.", killer, 125, 0, 0 )
					end
				end
				if vioGetElementData ( player, "fraktion" ) > 0 and vioGetElementData ( player, "fraktion" ) > 0 then
					if vioGetElementData ( player, "fraktion" ) ~= vioGetElementData ( player, "fraktion" ) then
						timeToBeDeath = timeToBeDeath + 60
					end
				end
			end
			
			vioSetElementData ( player, "heaventime", timeToBeDeath )
			setTimer ( endfade, 5000, 1, player, timeToBeDeath )
			vioSetElementData ( player, "hitmandeath", false )
			if vioGetElementData ( source, "isInArea51Mission" ) then
				setPlayerOutOfArea51 ( source )
				outputChatBox ( "Mission gescheitert!", source, 125, 0, 0 )
			end
			if killer and killer ~= player and getElementType ( killer ) == "player" then 
				local kills = tonumber ( vioGetElementData ( killer, "kills" ) )
				vioSetElementData ( killer, "kills", kills + 1 )
				blackListKillCheck ( player, killer, weapon )
				if isOnDuty ( killer ) or isArmy ( killer ) then
					if vioGetElementData ( player, "wanteds" ) == 0 then
						vioSetElementData ( killer, "boni", vioGetElementData ( killer, "boni" )-wantedprice*3 )
						outputChatBox ( "Du hast einen Zivilisten erledigt - dir werden "..(wantedprice*3).." $ bei der naechsten Abrechnung abgezogen!", killer, 125, 0, 0 )
					else
						local strafe = vioGetElementData ( player, "wanteds" ) * wantedprice
						local wanteds = vioGetElementData ( player, "wanteds" )
						local time = vioGetElementData ( player, "wanteds" ) * jailtimeperwanted * 1.2
						vioSetElementData ( player, "wanteds", 0 )
						setPlayerWantedLevel ( player, 0 )
						if tonumber(strafe) > vioGetElementData ( player, "money" ) then		
							takePlayerMoney ( player, vioGetElementData ( player, "money" ) )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement()	)
							vioSetElementData ( player, "money", 0 )
						else
							vioSetElementData ( player, "money", tonumber(vioGetElementData ( player, "money" )) - tonumber(strafe) )
							takePlayerMoney ( player, tonumber(strafe) )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
						end
						vioSetElementData ( player, "jailtime", time )
						vioSetElementData ( player, "bail", 0 )
						local grammafix  = " ohne Kaution " 
						outputChatBox ( "Du wurdest von Polizist "..getPlayerName(killer).." erledigt und"..grammafix.."fuer "..strafe.." $ und "..time.." Minuten eingesperrt!", player, 0, 125, 0 )
						vioSetElementData ( killer, "boni", vioGetElementData ( killer, "boni" )+wanteds*(wantedprice/3) )
						outputChatBox ( "Du hast "..getPlayerName ( player ).." erledigt und erhaelst bei der naechsten Abrechnung "..wanteds*(wantedprice/3).." $ Bonus!", killer, 0, 125, 0 )
					end
				end
			end
			if isKeyBound ( player, "mouse3", "up", explodeTerror, player ) then
				explodeTerror ( player )
			end
			vioSetElementData ( player, "deaths", vioGetElementData ( player, "deaths" ) + 1 )
			setPlayerNametagShowing ( player, true )
			if not vioGetElementData ( player, "isInHighNoon" ) then
			
				local curdrogen = vioGetElementData ( player, "drugs" )
				local amount = getDropAmount ( curdrogen )
				if amount > 0 then
					vioSetElementData ( player, "drugs", curdrogen - amount )
					local x, y, z = getElementPosition ( player )
					pickup = createPickup ( 0, 0, 0, 3, 1210, 1 )
					setElementPosition ( pickup, x, y, z )
					vioSetElementData ( pickup, "amount", amount )
					setElementDimension ( pickup, getElementDimension ( player ) )
					setElementInterior ( pickup, getElementInterior ( player ) )
					
					addEventHandler ( "onPickupHit", pickup, drugDropHit )
				end
				local curmats = vioGetElementData ( player, "mats" )
				amount = getDropAmount ( curmats )
				if amount > 0 then
					vioSetElementData ( player, "mats", curmats - amount )
					local x, y, z = getElementPosition ( player )
					pickup = createPickup ( 0, 0, 0, 3, 1210, 1 )
					setElementPosition ( pickup, x + 0.5, y, z )
					vioSetElementData ( pickup, "amount", amount )
					setElementDimension ( pickup, getElementDimension ( player ) )
					setElementInterior ( pickup, getElementInterior ( player ) )
					
					addEventHandler ( "onPickupHit", pickup, matDropHit )
				end
				
				local money = vioGetElementData ( player, "money" )
				loss = 5
				if money > 0 then
					vioSetElementData ( player, "money", math.abs(math.floor(money/100*(100-loss))) )
					takePlayerMoney ( player, math.floor(money/100*loss) )
					local x, y, z = getElementPosition ( player )
					pickup = createPickup ( 0, 0, 0, 3, 1212, 1 )
					setElementPosition ( pickup, x, y + 0.5, z )
					vioSetElementData ( pickup, "money", math.floor(money/100*loss) )
					setElementDimension ( pickup, getElementDimension ( player ) )
					setElementInterior ( pickup, getElementInterior ( player ) )
					
					addEventHandler ( "onPickupHit", pickup, moneyDropHit )
				end
			end
			setElementDimension ( player, 0 )
			setElementInterior ( player, 0 )
		else
			vioSetElementData ( player, "isInHighNoon", false )
			setTimer ( savespawn, 5000, 1, player, -2617.2189941406, 212, 4.4970808029175, 0, 0, 0, true )
		end
	end
	showChat ( player, true )
	showPlayerHudComponent ( player, "radar", true )
	if isElement ( killer ) then
		outputLog ( getPlayerName ( player ).." wurde von "..tostring ( getPlayerName ( killer ) ).." getoetet ( Waffe: "..weapon.." )", "kill" )
	else
		outputLog ( getPlayerName ( player ).." ist gestorben.", "death" )
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), playerdeath )

function endfade ( player, timeToBeDeath )

	if isElement ( player ) then
		removePedFromVehicle ( player )
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu wurdest erledigt\nund wirst nun im\nKrankenhaus wieder\nzusammen geflickt!", 7500, 125, 0, 0 )
		
		local x1, y1, z1 = getElementPosition ( player )
		local x2, y2, z2 = 1605.4418945313, 1868.0090332031, 27.071100234985
		local x3, y3, z3 = -2537.9006347656, 618.84533691406, 33.35578918457
		local distToSF = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 )
		local distToLV = getDistanceBetweenPoints3D ( x1, y1, z1, x3, y3, z3 )
		if distToSF > distToLV then
			setCameraMatrix ( player, -2537.9006347656, 618.84533691406, 33.35578918457, -2616.6801757813, 619.22979736328, 39.688884735107 )
		else
			setCameraMatrix ( player, 1605.4418945313, 1868.0090332031, 27.071100234985, 1606.3515625, 1819.0625, 22.315660476685 )
		end
		
		if tonumber ( vioGetElementData ( player, "adminlvl" ) ) < 1 then
			toggleAllControls ( player, false )
		end
		showPlayerHudComponent ( player, "radar", false )
		triggerClientEvent ( player, "showProgressBar", player )
		showChat ( player, true )
		
		refreshDeathTimeForPlayer ( player, 0, timeToBeDeath )
	end
end

function refreshDeathTimeForPlayer ( player, timeDone, holeTime )

	if isElement ( player ) then
		if timeDone / holeTime >= 1 then
			revive ( player )
			triggerClientEvent ( player, "updateDeathBar", player, 100 )
			return nil
		end
		triggerClientEvent ( player, "updateDeathBar", player, timeDone / holeTime * 100 )
		setTimer ( refreshDeathTimeForPlayer, 2500, 1, player, timeDone + 2500, holeTime )
	end
end

function revive ( player )

	if isElement ( player ) then
		toggleAllControls ( player, true )
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist wieder\nfit! Pass beim\nnaechsten mal\nbesser auf!", 7500, 0, 125, 0 )
		vioSetElementData ( player, "heaventime", 0 )
		
		if vioGetElementData ( player, "money" ) >= hospitalcosts then
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - hospitalcosts )
			takePlayerMoney ( player, hospitalcosts )
		else
			takePlayerMoney ( player, vioGetElementData ( player, "money" ) )
			vioSetElementData ( player, "money", 0 )
		end
		triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
		playSoundFrontEnd ( player, 17 )
		RemoteSpawnPlayer ( player )
		showChat ( player, true )
	end
end

function headFixOnSpawn ()

	setPedHeadless ( source, false )
end
addEventHandler ( "onPlayerSpawn", getRootElement(), headFixOnSpawn )

function botGekillt ()

	detachElements ( source )
	if vioGetElementData ( source, "bot" ) then
		local x = vioGetElementData ( source, "sx" )
		local y = vioGetElementData ( source, "sy" )
		local z = vioGetElementData ( source, "sz" )
		local dim = vioGetElementData ( source, "dim" )
		local int = vioGetElementData ( source, "int" )
		local rot = vioGetElementData ( source, "rot" )
		local botname = vioGetElementData ( source, "botname" )
		local model = getElementModel ( source )
		
		destroyElement ( source )
		
		_G[botname] = createPed ( model, x, y, z )
		setPedRotation ( _G[botname], rot )
		setElementInterior ( _G[botname], int )
		setElementDimension ( _G[botname], dim )
	end
end
addEventHandler ( "onPedWasted", getRootElement(), botGekillt )