﻿drugjobicon = createPickup ( -1868.9344482422, -144.03060913086, 11.665347099304, 3, 1239, 1000, 0 )
drugfarmicon = createPickup ( -1096.7784423828, -1614.6346435547, 76.240158081055, 3, 1239, 1000, 0 )

drugsjobiconblip = createBlip ( -1868.9344482422, -144.03060913086, 11.665347099304, 59, 1, 255, 0, 0, 255, 0, 99999 )
setElementVisibleTo ( drugsjobiconblip, getRootElement(), false )

drugcar1 = createVehicle ( 422, -1854.0776367188, -1678.4970703125, 21.836410522461, 0, 0, 0, "COLORS!" )
toggleVehicleRespawn ( drugcar1, true )
setVehicleRespawnDelay ( drugcar1, 1000*10 )
setVehicleIdleRespawnDelay ( drugcar1, 1000*60 )
setVehicleLocked ( drugcar1, true )
setElementFrozen ( drugcar1, true )
setVehicleDamageProof ( drugcar1, true )

drugboat = createVehicle ( 472, -1854.8267822266, -1490.4476318359, -8.1978225708008, 357.5, 0, 0, "COLORS!" )
setVehicleLocked ( drugboat, true )
setElementFrozen ( drugboat, true )
setVehicleDamageProof ( drugboat, true )

function usedrugs_func ( player )

	if vioGetElementData ( player, "drugs" ) >= 3 then
		vioSetElementData ( player, "lastcrime", "drogen" )
		
		vioSetElementData ( player, "drugs", vioGetElementData ( player, "drugs" ) - 3 )
		
		takeDrugs ( player )
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Drogen\ndabei ( mind. 3 g)!", 7500, 200, 0, 0 )
	end
end
addCommandHandler ( "usedrugs", usedrugs_func )

function jobicon_dealer ( player )
	
	triggerClientEvent ( player, "infobox_start", getRootElement(), "Tippe /job, um\nDealer zu werden -\ndazu brauchst du\nnichts, aber es\nist illegal!", 7500, 200, 200, 0 )
end
addEventHandler ( "onPickupHit", drugjobicon, jobicon_dealer )

function jobicon_drugs ( player )

	triggerClientEvent ( player, "infobox_start", getRootElement(), "Tippe /buydrugs\n[Summe], um hier\nDrogen fuer "..drugprice.."$\nje Gramm zu\nerwerben.", 7500, 200, 200, 0 )
end
addEventHandler ( "onPickupHit", drugfarmicon, jobicon_drugs )

function buydrugs_func ( player, cmd, zahl )

	if tonumber ( zahl ) then
		local zahl = math.floor ( math.abs ( tonumber ( zahl ) ) )
		if vioGetElementData ( player, "job" ) == "dealer" then
			if zahl <= 30 then
				if vioGetElementData ( player, "money" ) >= zahl*drugprice then
					local jobtime = tonumber ( vioGetElementData ( player, "jobtime" ) )
					if jobtime == 0 then
						vioSetElementData ( player, "drugs", vioGetElementData ( player, "drugs" ) + zahl )
						vioSetElementData ( player, "lastcrime", "drugdealing" )
						vioSetElementData ( player, "jobtime", tonumber ( vioGetElementData ( player, "jobtime" ) ) + 20 )
						vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - zahl*drugprice )
						takePlayerMoney ( player, zahl )
						playSoundFrontEnd ( player, 40 )
						triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nun\n"..vioGetElementData ( player, "drugs" ).." Gramm Drogen\ndabei!", 7500, 125, 0, 0 )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Du musst noch\n"..jobtime.." Minuten warten,\nbis du wieder\nDrogen kaufen\nkannst.", 7500, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld!\n"..zahl.." Gramm Drogen\nkosten "..drugprice*zahl.." $!", 7500, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du kannst max.\n30 Gramm pro\n20 Minuten er-\nwerben!", 7500, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist kein\nDealer!", 7500, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nUngueltige Zahl!", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "buydrugs", buydrugs_func )

function drugRecieve_func ( drugs )

	if source == client then
		if drugs == "boom" then
			setTimer ( Boomplane, 3000, 1 )
			setTimer ( Boomplane2, 3500, 1 )
		elseif drugs == "cops" then
			if vioGetElementData ( source, "wanteds" ) >= 5 then
				vioSetElementData ( source, "wanteds", 6 )
			else
				vioSetElementData ( source, "wanteds", vioGetElementData ( source, "wanteds" ) + 2 )
			end
			setPlayerWantedLevel ( source, vioGetElementData ( source, "wanteds" ) )
		else
			vioSetElementData ( source, "drugs", vioGetElementData ( source, "drugs" ) + drugs )
		end
		setElementVisibleTo ( drugsjobiconblip, source, true )
		vioSetElementData ( source, "jobtime", tonumber ( vioGetElementData ( source, "jobtime" ) ) + 20 )
	end
end
addEvent ( "drugRecieve", true )
addEventHandler ( "drugRecieve", getRootElement(), drugRecieve_func )

function Boomplane ()

	createExplosion ( -2301.7600097656+math.random ( -1, 1 ), -2804.5095214844+math.random ( -1, 1 ), 14+math.random ( -.3, .3 ), math.random ( 4, 7 ) )
end

function Boomplane2 ()

	setTimer ( Boomplane, 400, 4 )
end

function givedrugs_func ( player, cmd, target, summe )
	
	if player == client or not client then
		if vioGetElementData ( player, "job" ) == "dealer" then
			local target = getPlayerFromName ( target )
			local summe = math.abs(math.floor(tonumber(summe)))
			if vioGetElementData ( player, "drugs" ) >= summe then
				playSoundFrontEnd ( player, 40 )
				vioSetElementData ( player, "lastcrime", drugdealing )
				playSoundFrontEnd ( target, 40 )
				vioSetElementData ( player, "drugs", vioGetElementData ( player, "drugs" ) - summe )
				vioSetElementData ( target, "drugs", vioGetElementData ( target, "drugs" ) + summe )
				outputChatBox ( "Du hast "..getPlayerName(target).." "..summe.." Gramm Drogen gegeben!", player, 0, 125, 0 )
				outputChatBox ( "Du hast von "..getPlayerName(player).." "..summe.." Gramm Drogen bekommen!", target, 0, 125, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Drogen dabei!", 7000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist kein\nDrogendealer!", 7000, 125, 0, 0 )
		end
	end
end
addEvent ( "givedrugs", true )
addEventHandler ( "givedrugs", getRootElement(), givedrugs_func )
addCommandHandler ( "givedrugs", givedrugs_func )