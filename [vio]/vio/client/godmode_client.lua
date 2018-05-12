function cancelAllDamage ( attacker, weapon, bodypart, loss )

	if source == lp then
		if attacker and weapon and bodypart and loss then
			if weaponDamages[weapon] then
				cancelEvent ()
			end
		end
	end
end
addEventHandler ( "onClientPlayerDamage", lp, cancelAllDamage )

--[[function spawnProtection ()

	if source == lp then
		addEventHandler ( "onClientPlayerDamage", lp, localPlayerCancelDamage )
		setTimer (
			function ()
				removeEventHandler ( "onClientPlayerDamage", lp, localPlayerCancelDamage )
			end,
		10000, 1 )
	end
end
addEventHandler ( "onClientPlayerSpawn", lp, spawnProtection )

function localPlayerCancelDamage ()

	if source == lp then
		cancelEvent ()
	end
end

function playerDamage_func ( attacker )

	local victim = source
	if victim == lp or attacker == lp then
		if attacker then
			if getElementData ( lp, "isInHighNoon" ) or getElementData ( lp, "In_DMArena" ) == 1 then
			
			else
				if getElementData ( attacker, "jailtime" ) >= 1 or getElementData ( source, "jailtime" ) >= 1 then
					cancelEvent()
				else
					if getElementData ( attacker, "playingtime" ) <= 180 then
						if attacker == lp then
							outputChatBox ( "Du kannst erst nach 3 Spielstunde jemanden verletzen!", 125, 0, 0 )
						end
						cancelEvent()
					elseif getElementData ( victim, "playingtime" ) <= 180 then
						if victim == lp then
							outputChatBox ( "Da du noch nicht 180 Minuten gespielt hast, kannst du nicht von anderen Spielern verletzt werden.", 125, 0, 0 )
						end
						if attacker == lp then
							outputChatBox ( "Der Spieler, den du angegriffen hast, hat noch keine 3 Stunden gespielt und erhaelt keinen Schaden.", 125, 0, 0 )
						end
						cancelEvent()
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerDamage", getRootElement(), playerDamage_func )

function gasCancel ( attacker, weapon )

	if source == getLocalPlayer() then
		if weapon == 17 then
			if getElementModel ( source ) == 285 then
				cancelEvent()
			end
		end
		if getElementData ( lp, "tazered" ) then
			cancelEvent()
		end
	end
end
addEventHandler ( "onClientPlayerDamage", getRootElement(), gasCancel ) ]]