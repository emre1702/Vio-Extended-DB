function drugDropHit ( player )
	
	if not getPedOccupiedVehicle ( player ) then
		local pickup = source
		local amount = vioGetElementData ( pickup, "amount" )
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast soeben\nein Paket mit\n"..amount.." Gramm Drogen\ngefunden!", 7500, 200, 0, 0 )
		vioSetElementData ( player, "drugs", vioGetElementData ( player, "drugs" ) + amount )
		playSoundFrontEnd ( player, 40 )
		destroyElement ( source )
	end
end

function matDropHit ( player )
	
	if not getPedOccupiedVehicle ( player ) then
		local pickup = source
		local amount = vioGetElementData ( pickup, "amount" )
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast soeben\nein Paket mit\n"..amount.." Materials\ngefunden!", 7500, 200, 0, 0 )
		vioSetElementData ( player, "mats", vioGetElementData ( player, "mats" ) + amount )
		playSoundFrontEnd ( player, 40 )
		destroyElement ( source )
	end
end

function moneyDropHit ( player )
	
	if not getPedOccupiedVehicle ( player ) then
		local money = vioGetElementData ( pickup, "money" )
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast soeben\n"..money.." $ gefunden!", 7500, 200, 0, 0 )
		givePlayerSaveMoney ( player, money )
		destroyElement ( source )
	end
end

function deleteObject ( object )

	if getElementModel ( object ) == 1210 then
		destroyElement ( object )
	elseif getElementModel ( object ) == 1212 then
		destroyElement ( object )
	end
end

function getDropAmount ( amount )

	return math.floor ( amount / 5 )
end