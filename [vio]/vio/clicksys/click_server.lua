function number_func ( player, cmd, target )

	local targetNR = getPlayerFromName ( target )
	if targetNR then
		outputChatBox ( "NR von "..target..": "..vioGetElementData ( targetNR, "telenr" ), player, 200, 200, 0 )
	end
end
addCommandHandler ( "number", number_func )

function sprunkAutomatUse_func ( player )

	if player == client then
		takePlayerMoney ( player, 1 )
		playSoundFrontEnd ( player, 40 )
		triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
		vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 1 )
		if getElementHealth ( player ) + sprunkheal < 100 then
			setElementHealth ( player, getElementHealth ( player ) + sprunkheal )
		else
			setElementHealth ( player, 100 )
		end
		sprunkKasse = sprunkKasse + 1
		triggerClientEvent ( player, "sec_health_give", getRootElement(), 999 )
	end
end
addEvent ( "sprunkAutomatUse", true )
addEventHandler ( "sprunkAutomatUse", getRootElement(), sprunkAutomatUse_func )

function radiochange_func ( player, favchannel )

	if tostring ( favchannel ) == MySQL_Save ( tostring ( favchannel ) ) then
		vioSetElementData ( player, "favchannel", favchannel )
	end
end
addEvent ( "radiochange", true )
addEventHandler ( "radiochange", getRootElement(), radiochange_func )

function showLicenses_func ( player )

	if player == client then
		local target = getPlayerFromName ( getElementData ( player, "curclicked" ) )
		local pname = getPlayerName ( player )
		local licenses = ""
		if vioGetElementData ( player, "carlicense" ) == 1 then licenses = licenses.."Fuehrerschein " end
		if vioGetElementData ( player, "bikelicense" ) == 1 then licenses = licenses.."Motorradschein " end
		if vioGetElementData ( player, "fishinglicense" ) == 1 then licenses = licenses.."Angelschein " end
		if vioGetElementData ( player, "lkwlicense" ) == 1 then licenses = licenses.."LKW-Fuehrerschein " end
		if vioGetElementData ( player, "gunlicense" ) == 1 then licenses = licenses.."Waffenschein " end
		if vioGetElementData ( player, "motorbootlicense" ) == 1 then licenses = licenses.."Bootsfuehrerschein " end
		if vioGetElementData ( player, "segellicense" ) == 1 then licenses = licenses.."Segelschein " end
		if vioGetElementData ( player, "planelicenseb" ) == 1 then licenses = licenses.."Flugschein A " end
		if vioGetElementData ( player, "planelicensea" ) == 1 then licenses = licenses.."Flugschein B " end
		if vioGetElementData ( player, "helilicense" ) == 1 then licenses = licenses.."Flugschein C " end
		outputChatBox ( "Vorhandene Lizensen von "..pname..": ", target, 200, 0, 200 )
		outputChatBox ( licenses, target, 200, 200, 0 )
		outputChatBox ( "Du hast "..getPlayerName(target).." deine Scheine gezeigt!", player, 0, 125, 0 )
	end
end
addEvent ( "showLicenses", true )
addEventHandler ( "showLicenses", getRootElement(), showLicenses_func )

function showGWD_func ( player )

	if player == client then
		local target = getPlayerFromName ( getElementData ( player, "curclicked" ) )
		local pname = getPlayerName ( player )
		outputChatBox ( "Du hast "..getPlayerName ( target ).." deine GWD-Note gezeigt!", player, 0, 125, 0 )
		outputChatBox ( getPlayerName ( player ).." zeigt dir seine GWD-Note: "..tostring(vioGetElementData(player,"armyperm9")).." %!", target, 125, 200, 125 )
	end
end
addEvent ( "showGWD", true )
addEventHandler ( "showGWD", getRootElement(), showGWD_func )