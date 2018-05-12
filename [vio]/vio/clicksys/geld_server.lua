function pay_func ( player, cmd, target, money )

	local money = tonumber ( money )
	local target = getPlayerFromName ( target )
	if target and money then
		money = math.abs ( math.floor ( money + 0.5 ) )
		local pmoney = vioGetElementData ( player, "money" )
		if pmoney >= money then
			local x1, y1, z1 = getElementPosition ( player )
			local x2, y2, z2 = getElementPosition ( target )
			if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 5 then
				if vioGetElementData ( player, "playingtime" ) >= 180 then
					takePlayerSaveMoney ( player, money )
					givePlayerSaveMoney ( target, money )
					meCMD_func ( player, "meCMD", "steckt "..getPlayerName ( target ).." ein paar Scheine zu..." )
					infobox ( target, "\n\nDu hast von\n"..getPlayerName ( player ).." "..money.." $\nerhalten!", 5000, 0, 200, 0 )
					infobox ( player, "\n\nDu hast \n"..getPlayerName ( target ).." "..money.." $\ngegeben!", 5000, 0, 200, 0 )
					outputPayLog ( getPlayerName ( player ).." hat "..getPlayerName ( target ).." "..money.." $ gegeben!" )
				else
					infobox ( player, "\n\n\nErst ab 3\nStunden moeglich!", 5000, 150, 0, 0 )
				end
			else
				infobox ( player, "\n\n\nDu bist zu\nweit entfernt!", 5000, 150, 0, 0 )
			end
		else
			infobox ( player, "\n\n\nSoviel Geld hast\ndu nicht!", 5000, 150, 0, 0 )
		end
	else
		infobox ( player, "\n\n\nGebrauch:\n/pay [Name] [Summe]", 5000, 150, 0, 0 )
	end
end
addCommandHandler ( "pay", pay_func )

function moneychange ( player, betrag )

	vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + betrag )
	if betrag >= 0 then
		givePlayerMoney ( player, betrag )
	else
		takePlayerMoney ( player, betrag )
	end
	triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
	playSoundFrontEnd ( player, 40 )
end

function givePlayerSaveMoney ( player, amount )

	local amount = tonumber ( amount )
	if isElement ( player ) and amount then
		vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + amount )
		givePlayerMoney ( player, amount )
		playSoundFrontEnd ( player, 40 )
		triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
	end
end

function takePlayerSaveMoney ( player, amount )

	local amount = tonumber ( amount )
	if isElement ( player ) and amount then
		vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - amount )
		takePlayerMoney ( player, amount )
		playSoundFrontEnd ( player, 40 )
		triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
	end
end

function showBankMoney_func ()

	if source == source then
		local bankmoney = vioGetElementData ( source, "bankmoney" )
		outputChatBox ("Du hast "..bankmoney.." $ auf der Bank.", source, 0, 0, 255 )
		triggerClientEvent ( source, "HudEinblendenMoney", getRootElement() )
	end
end
addEvent ( "showBankMoney", true )
addEventHandler ("showBankMoney", getRootElement(), showBankMoney_func )

function cashPointPayIn_func ( summe )

	local summe = math.abs(math.floor(tonumber(summe)))
	if source == client then
		if vioGetElementData ( source, "money" ) >= tonumber(summe) then
			outputChatBox ("Du hast "..tonumber(summe).." $ eingezahlt!", source, 0, 0, 255 )
			vioSetElementData ( source, "money", vioGetElementData ( source, "money" ) - tonumber(summe) )
			vioSetElementData ( source, "bankmoney", vioGetElementData ( source, "bankmoney" ) + tonumber(summe) )
			takePlayerMoney ( source, tonumber(summe) )
			playSoundFrontEnd ( source, 40 )
			triggerClientEvent ( source, "HudEinblendenMoney", getRootElement() )
			
			triggerClientEvent ( source, "createNewStatementEntry", source, "Einzahlung\n", summe, "Geldautomat\n"..getPlaceOfPlayer ( source ) )
		end
	end
end
addEvent ( "cashPointPayIn", true )
addEventHandler ( "cashPointPayIn", getRootElement(), cashPointPayIn_func )

function getPlaceOfPlayer ( player )

	local x, y, z = getElementPosition ( player )
	return getZoneName ( x, y, z, true )
end

function cashPointPayOut_func ( summe )

	local summe = math.abs(math.floor(tonumber(summe)))
	if source == client then
		if vioGetElementData ( source, "bankmoney" ) >= tonumber(summe) then
			outputChatBox ("Du hast "..tonumber(summe).." $ abgehoben!", source, 0, 0, 255 )
			vioSetElementData ( source, "bankmoney", vioGetElementData ( source, "bankmoney" ) - tonumber(summe) )
			vioSetElementData ( source, "money", vioGetElementData ( source, "money" ) + tonumber(summe) )
			givePlayerMoney ( source, tonumber(summe) )
			playSoundFrontEnd ( source, 40 )
			triggerClientEvent ( source, "HudEinblendenMoney", getRootElement() )
			
			triggerClientEvent ( source, "createNewStatementEntry", source, "Auszahlung\n", summe * -1, "Geldautomat\n"..getPlaceOfPlayer ( source ) )
		end
	end
end
addEvent ( "cashPointPayOut", true )
addEventHandler ( "cashPointPayOut", getRootElement(), cashPointPayOut_func )

function Spenden_func ( summe )

	local summe = math.abs(math.floor(tonumber(summe)))
	if source == client then
		if vioGetElementData ( source, "bankmoney" ) >= tonumber(summe) then
			outputChatBox ("Du hast "..tonumber(summe).." $ gespendet!", source, 0, 0, 255 )
			vioSetElementData ( source, "bankmoney", vioGetElementData ( source, "bankmoney" ) - tonumber(summe) )
			playSoundFrontEnd ( source, 40 )
			triggerClientEvent ( source, "HudEinblendenMoney", getRootElement() )
		end
	end
end
addEvent ( "Spenden", true )
addEventHandler ("Spenden", getRootElement(), Spenden_func )

function cashPointTransfer_func ( summe, ziel, online, reason )

	if source == client then
		if online then
			vioSetElementData ( source, "bankmoney", vioGetElementData ( source, "bankmoney" ) - 10 )
			reason = "Onlineueberweisung"
		end
		local summe = math.abs(math.floor(tonumber(summe)))
		if vioGetElementData ( source, "playingtime" ) >= 180 then
			if getPlayerFromName ( ziel ) then
				if tonumber(summe) >= 1 then
					if vioGetElementData ( source, "bankmoney" ) >= tonumber(summe) then
						local player = getPlayerFromName ( ziel )
						if vioGetElementData ( player, "loggedin" ) == 1 then
							vioSetElementData ( source, "bankmoney", vioGetElementData ( source, "bankmoney" ) - tonumber(summe) )
							vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) + tonumber(summe) )
							outputChatBox ( "Du hast von "..getPlayerName(source).." "..tonumber(summe).." $ erhalten ("..reason..")!", player, 0, 255, 0 )
							outputChatBox ( "Du hast "..getPlayerName(player).." "..tonumber(summe).." $ ueberwiesen!", source, 0, 0, 255 )
							playSoundFrontEnd ( source, 40 )
							playSoundFrontEnd ( player, 40 )
							triggerClientEvent ( source, "HudEinblendenMoney", getRootElement() )
							if vioGetElementData ( source, "playingtime" ) <= 60 then
								for id, playeritem in ipairs(getElementsByType("player")) do 
									if tonumber(vioGetElementData ( playeritem, "adminlvl" )) >= 1 then
										outputChatBox ( "Log: "..getPlayerName(source).." hat an "..ziel.." "..summe.." $ Ueberwiesen!", playeritem, 200, 200, 0 )
									end
								end
							end
							triggerClientEvent ( source, "createNewStatementEntry", source, "Ueberweisung\n", summe * - 1, "An\n"..getPlayerName ( player ) )
							triggerClientEvent ( player, "createNewStatementEntry", player, "Ueberweisung\n", summe, "Von\n"..getPlayerName ( source ) )
							outputPayLog ( getPlayerName(source).." hat an "..ziel.." "..summe.." $ Ueberwiesen!" )
						else
							outputChatBox ("Der Spieler ist noch nicht eingeloggt!", source, 255, 0, 0 )
						end
					else
						outputChatBox ("Du hast nicht genug Geld!", source, 255, 0, 0 )
					end
				else
					outputChatBox ("Ungueltiger Betrag!", source, 255, 0, 0 )
				end
			else
				outputChatBox ("Du musst einen gueltigen Spielernamen eingeben!", source, 255, 0, 0 )
			end
		else
			outputChatBox ( "Du kannst erst ab 3 Stunden Spielzeit Geld vergeben!", source, 125, 0, 0 )
		end
	end
end
addEvent ( "Ueberweisen", true )
addEvent ( "cashPointTransfer", true )
addEventHandler ( "Ueberweisen", getRootElement(), cashPointTransfer_func )
addEventHandler ( "cashPointTransfer", getRootElement(), cashPointTransfer_func )

function geldgeben_func ( summe )

	if source == client then
		local summe = math.abs(math.floor(tonumber(summe)))
		if tonumber(summe) + 5 ~= nil then
			if vioGetElementData ( source, "playingtime" ) >= 180 then
				local x1, y1, z1 = getElementPosition ( source )
				local player = getPlayerFromName ( vioGetElementData ( source, "curclicked" ) )
				local x2, y2, z2 = getElementPosition ( player )
				local summe = tonumber(summe)
				if summe <= vioGetElementData ( source, "money" ) then
					if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 10 then
						vioSetElementData ( source, "money", vioGetElementData ( source, "money" ) - summe )
						vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + summe )
						setPlayerMoney( source, vioGetElementData ( source, "money" ) )
						setPlayerMoney( player, vioGetElementData ( player, "money" ) )
						outputChatBox ( "Du hast "..getPlayerName(player).. " "..summe.." $ gegeben!", source, 0, 255, 0 )
						outputChatBox ( "Du hast von "..getPlayerName(source).. " "..summe.." $ erhalten!", player, 0, 0, 255 )
						triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
						triggerClientEvent ( source, "HudEinblendenMoney", getRootElement() )
						playSoundFrontEnd ( player, 40 )
						playSoundFrontEnd ( source, 40 )
						outputPayLog ( getPlayerName(source).." hat an "..ziel.." "..summe.." $ gegeben!" )
					else
						outputChatBox ( "Du bist zu weit weg!", source, 255, 0, 0 )
					end
				else
					outputChatBox ( "Du hast nicht genug Geld!", source, 255, 0, 0 )
				end
			else
				outputChatBox ( "Du kannst erst ab 3 Stunden Spielzeit Geld vergeben!", source, 125, 0, 0 )
			end
		else
			outputChatBox ( "Ungültiger Betrag!", source, 255, 0, 0 )
		end
	end
end
addEvent ( "geldgeben", true )
addEventHandler ( "geldgeben", getRootElement(), geldgeben_func )