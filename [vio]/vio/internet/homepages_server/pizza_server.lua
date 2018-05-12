function deliverPizza_func ()

	if source == client and vioGetElementData ( client, "money" ) >= 50 then
		if getElementInterior ( client ) == 0 and getElementDimension ( client ) == 0 then
			local player = source
			local x, y, z = getElementPosition ( player )
			outputChatBox ( "Deine Bestellung wird geliefert!", player, 0, 125, 0 )
			playSoundFrontEnd ( player, 40 )
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 50 )
			triggerClientEvent ( player, "createNewStatementEntry", player, "Bestellung auf\nPizza.com", 50 * -1, "Mit extra\nKaese" )
			pizzaStackKasse = pizzaStackKasse + 10
			local pizzaboy = createVehicle ( 448, x + 2, y + 2, z )
			local pizzaboyDriver = createPed ( 155, x, y, z )
			warpPedIntoVehicle ( pizzaboyDriver, pizzaboy )
			setTimer ( createPizzaPickup, 3500, 1, x, y, z )
			setTimer ( destroyElement, 5000, 1, pizzaboyDriver )
			setTimer ( destroyElement, 5000, 1, pizzaboy )
			setVehicleEngineState ( pizzaboy, true )
		else
			outputChatBox ( "Das kannst du nur draussen bestellen!", player, 125, 0, 0 )
		end
	end
end
addEvent ( "deliverPizza", true )
addEventHandler ( "deliverPizza", getRootElement(), deliverPizza_func )

function createPizzaPickup ( x, y, z )

	local pickup = createPickup ( x+2, y+2, z, 3, 1582 )
	addEventHandler ( "onPickupHit", pickup, 
		function ( player )
			setElementHealth ( player, 1 )
			setElementHealth ( player, 100 )
			playSoundFrontEnd ( player, 40 )
			vioSetElementData ( player, "hunger", 100 )
			setElementData ( player, "hunger", 100 )
			destroyElement ( source )
		end
	)
end