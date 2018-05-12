function news_func ( player, cmd, ... )

	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	if isReporter ( player ) then
		if not vioGetElementData ( player, "newsNotPostable" ) then
			if isNewsCar(getPedOccupiedVehicle(player)) then
				if #stringWithAllParameters >= 1 then
					outputChatBox ( "Reporter "..getPlayerName(player)..": "..stringWithAllParameters, getRootElement(), 255, 125, 20 )
					vioSetElementData ( player, "boni", tonumber ( vioGetElementData ( player, "boni" ) ) + 10 )
					vioSetElementData ( player, "newsNotPostable", true )
					setTimer ( vioSetElementData, 3000, 1, player, "newsNotPostable", false )
				else
					outputChatBox ( "Dein Text ist zu kurz.", player, 125, 0, 0 )
				end
			else
				outputChatBox ( "Du sitz in keinem News-Fahrzeug!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Du kannst du nur alle 3 Sekunden News schreiben!", player, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "news", news_func )

function live_func ( player, cmd, target )
	
	if isReporter ( player ) and not vioGetElementData ( player, "isLive" ) then
		local target = findPlayerByName( target )
		if target then
			vioSetElementData ( target, "isLive", true )
			vioSetElementData ( player, "isLive", true )
			vioSetElementData ( target, "isLiveWith", getPlayerName(player) )
			vioSetElementData ( player, "isLiveWith", getPlayerName(target) )
			outputChatBox ( "Du bist nun in einem Interview mit "..getPlayerName(player)..", tippe /endlive zum beenden.", target, 200, 200, 0 )
			outputChatBox ( "Du bist nun in einem Interview mit "..getPlayerName(target)..", tippe /endlive zum beenden.", player, 200, 200, 0 )
		end
	end
end
addCommandHandler ( "live", live_func )

function endlive_func ( player )
	
	if vioGetElementData ( player, "isLive" ) then
		vioSetElementData ( player, "isLive", false )
		outputChatBox ( "Das Interview wurde beendet!", player, 0, 200, 0 )
		local target = vioGetElementData ( player, "isLiveWith" )
		local target = getPlayerFromName ( target )
		if target then
			outputChatBox ( "Das Interview wurde beendet!", target, 0, 200, 0 )
			vioSetElementData ( target, "isLive", false )
		end
	else
		outputChatBox ( "Du bist in keiner Live-Unterhaltung!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "endlive", endlive_func )