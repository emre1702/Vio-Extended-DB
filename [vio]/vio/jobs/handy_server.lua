function handychange_func ( player )

	if player == client then
		if vioGetElementData ( player, "handystate" ) == "on" then
			vioSetElementData ( player, "handystate", "off" )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nHandy ausgeschaltet!", 5000, 0, 200, 0 )
		else
			vioSetElementData ( player, "handystate", "on" )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nHandy angeschaltet!", 5000, 0, 200, 0 )
		end
	end
end
addEvent ( "handychange", true )
addEventHandler ( "handychange", getRootElement(), handychange_func )

function smscmd_func ( player, cmd, number, ... )

	if number then
		local parametersTable = {...}
		local sendtext = table.concat( parametersTable, " " )
		if sendtext then
			if #sendtext >= 1 then
				SMS_func ( player, tonumber(number), sendtext )
			else
				outputChatBox ( "Bitte gib einen Text ein!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Bitte gib einen Text ein!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Bitte gib eine gueltige Nummer an!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "sms", smscmd_func )

function callcmd_func ( player, cmd, number )

	callSomeone_func ( player, number )
end
addCommandHandler ( "call", callcmd_func )

function SMS_func ( player, sendnr, sendtext )

	if player == client or not client then
		if vioGetElementData ( player, "handystate" ) == "on" then
			local pmoney = vioGetElementData ( player, "money" )
			if ( vioGetElementData ( player, "handyType" ) == 2 and vioGetElementData ( player, "handyCosts" ) >= smsprice ) or vioGetElementData ( player, "handyType" ) ~= 2 then
				for id, playeritem in ipairs(getElementsByType("player")) do 
					if vioGetElementData ( playeritem, "telenr" ) then
						if vioGetElementData ( playeritem, "telenr" ) == sendnr then
							if vioGetElementData ( playeritem, "handystate" ) == "on" then
								triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSMS versendet!", 5000, 0, 200, 0 )
								playSoundFrontEnd ( player, 40 )
								outputChatBox ( "SMS von "..getPlayerName(player).."("..vioGetElementData(player,"telenr").."): "..sendtext, playeritem, 255, 255, 0 )
								if vioGetElementData ( player, "handyType" ) == 2 then
									vioSetElementData ( player, "handyCosts", vioGetElementData ( player, "handyCosts" ) - smsprice )
								elseif vioGetElementData ( player, "handyType" ) == 1 then
									vioSetElementData ( player, "handyCosts", vioGetElementData ( player, "handyCosts" ) + smsprice )
								end
								return
							end
						end
					end
				end
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Das Handy des\nSpielers ist ausge-\nschaltet oder der\nSpieler ist nicht\nonline!", 7500, 125, 0, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\nmehr genug Guthaben!\nDu kannst im 24-7\ndein Guthaben\naufladen.", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDein Handy ist\naus!", 5000, 125, 0, 0 )
		end
	end
end
addEvent ( "SMS", true )
addEventHandler ( "SMS", getRootElement(), SMS_func )

function callSomeone_func ( player, number )

	if player == client or not client then
		if vioGetElementData ( player, "handystate" ) == "on" then
			local pmoney = vioGetElementData ( player, "money" )
			if number == "*100#" then
				if vioGetElementData ( player, "handyType" ) == 2 then
					outputChatBox ( "Aktuelles Guthaben: "..vioGetElementData ( player, "handyCosts" ).." $", player, 200, 200, 0 )
				elseif vioGetElementData ( player, "handyType" ) == 3 then
					outputChatBox ( "Du hast eine Flatrate, Kosten pro Stunde: 50 $", player, 200, 200, 0 )
				elseif vioGetElementData ( player, "handyType" ) == 1 then
					outputChatBox ( "Aktuelle Kosten: "..vioGetElementData ( player, "handyCosts" ).." $", player, 200, 200, 0 )
				end
			elseif not speznr[tonumber(number)] then
				number = tonumber ( number )
				if ( vioGetElementData ( player, "handyType" ) == 2 and vioGetElementData ( player, "handyCosts" ) >= callprice ) or vioGetElementData ( player, "handyType" ) ~= 2 then
					for id, playeritem in ipairs(getElementsByType("player")) do 
						if vioGetElementData ( playeritem, "telenr" ) then
							if vioGetElementData ( playeritem, "telenr" ) == number then
								if vioGetElementData ( playeritem, "handystate" ) == "on" then
									if vioGetElementData ( player, "call" ) == false then
										if vioGetElementData ( playeritem, "call" ) == false then
											outputChatBox ( "Tippe /hangup ( /hup ), um aufzulegen!", player, 200, 200, 200 )
											outputChatBox ( getPlayerName(player).." (Nummer: "..vioGetElementData(player,"telenr")..") ruft an, tippe /pickup ( /pup ) um abzunehmen!", playeritem, 50, 125, 0 )
											vioSetElementData ( player, "calls", getPlayerName ( playeritem ) )
											vioSetElementData ( playeritem, "calledby", getPlayerName ( player ) )
											vioGetElementData ( player, "call", true )
											triggerClientEvent ( playeritem, "phonesound", getRootElement() )
											if vioGetElementData ( player, "handyType" ) == 2 then
												vioSetElementData ( player, "handyCosts", vioGetElementData ( player, "handyCosts" ) - callprice )
											elseif vioGetElementData ( player, "handyType" ) == 1 then
												vioSetElementData ( player, "handyCosts", vioGetElementData ( player, "handyCosts" ) + callprice )
											end
											return
										else
											outputChatBox ( "Besetzt...", player, 125, 0, 0 )
										end
									else
										outputChatBox ( "Du telefonierst bereits!", player, 125, 0, 0 )
									end
								end
							end
						end
					end
					if vioGetElementData ( player, "money" ) == pmoney then
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Das Handy des\nSpielers ist ausge-\nschaltet oder der\nSpieler ist nicht\nonline!", 7500, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld!\nEin Anruf kostet\n"..callprice.." $!", 7500, 125, 0, 0 )
				end
			else
				--speznr = { [911]=true, [333]=true, [400]=true, [666666]=true }
				number = tonumber ( number )
				if number == 911 then
					outputChatBox ( "Sie sprechen mit der Polizei von San Fierro - bitte nennen sie den Namen des Täters.", player, 0, 0, 125 )
					vioSetElementData ( player, "callswithpolice", true )
				elseif number == 333 then
					outputChatBox ( "Coming soon!", player, 0, 0, 125 )
				elseif number == 400 then
					orderTaxi ( player )
				elseif number == 666666 then
					outputChatBox ( "Coming soon!", player, 0, 0, 125 )
				end
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDein Handy ist\naus!", 7500, 125, 0, 0 )
		end
	end
end
addEvent ( "callSomeone", true )
addEventHandler ( "callSomeone", getRootElement(), callSomeone_func )

function hangup ( player )

	vioSetElementData ( getPlayerFromName ( vioGetElementData ( player, "calls" ) ), "calledby", "none" )
	local caller = getPlayerFromName ( vioGetElementData ( player, "callswith" ) )
	if caller then
		vioSetElementData ( caller, "callswith", "none" )
		vioSetElementData ( caller, "call", false )
		vioSetElementData ( caller, "calls", "none" )
		vioSetElementData ( caller, "callswith", "none" )
		vioSetElementData ( caller, "calledby", "none" )
	end
	vioSetElementData ( player, "callswith", "none" )
	vioSetElementData ( player, "call", false )
	vioSetElementData ( player, "calls", "none" )
	vioSetElementData ( player, "callswith", "none" )
	vioSetElementData ( player, "calledby", "none" )
	outputChatBox ( "Aufgelegt.", player, 200, 200, 200 )
	if getPlayerPing ( caller ) ~= false then outputChatBox ( "Aufgelegt.", caller, 200, 200, 200 ) end
end
addCommandHandler ( "hangup", hangup )
addCommandHandler ( "hup", hangup )

function pickup ( player )

	local caller = getPlayerFromName ( vioGetElementData ( player, "calledby" ) )
	vioSetElementData ( player, "calledby", "none" )
	if caller and vioGetElementData ( player, "call" ) == false then
		vioSetElementData ( player, "call", true )
		vioSetElementData ( caller, "call", true )
		vioSetElementData ( player, "callswith", getPlayerName ( caller ) )
		vioSetElementData ( caller, "callswith", getPlayerName ( player ) )
		outputChatBox ( "Abgehoben.", player, 0, 125, 0 )
		outputChatBox ( "Abgehoben.", caller, 0, 125, 0 )
	else
		outputChatBox ( "Du kannst keinen Anruf annehmen!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "pickup", pickup )
addCommandHandler ( "pup", pickup )