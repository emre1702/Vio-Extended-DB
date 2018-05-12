function buyDonuts_func ( id )

	local player = client
	local price = donutPrices[id]
	local money = vioGetElementData ( player, "money" )
	local hp = 100
	if id == 2 then
		hp = 50
	elseif id == 3 then
		hp = 25
	end
	if price then
		if money >= price then
			setElementHealth ( player, getElementHealth ( player ) + hp )
			setElementData ( player, "hunger", getElementData ( player, "hunger" ) + hp )
			if getElementData ( player, "hunger" ) > 100 then
				setElementData ( player, "hunger", 100 )
			end
			vioSetElementData ( player, "money", money - price )
		else
			infobox ( player, "Du hast nicht\ngenug Geld!", 5000, 125, 0, 0 )
		end
	end
end
addEvent ( "buyDonuts", true )
addEventHandler ( "buyDonuts", getRootElement(), buyDonuts_func )