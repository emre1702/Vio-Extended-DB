function keybind ( vehicle, seat )								--- Tasten festlegen

	if seat == 1 then
		vioSetElementData ( vehicle, "seat1", 0 )
	end
	if seat == 2 then
		vioSetElementData ( vehicle, "seat2", 0 )
	end
	if seat == 3 then
		vioSetElementData ( vehicle, "seat3", 0 )
	end
	bindKey ( source, "rshift", "down", helidriveby )
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), keybind )

function vehicle_enter ( player, seat, door )					--- Tasten festlegen

	if seat == 1 then
		if getElementData ( source, "seat1" ) == 1 then
			cancelEvent()
		end
	end
	if seat == 2 then
		if getElementData ( source, "seat2" ) == 1 then
			cancelEvent()
		end
	end
	if seat == 3 then
		if getElementData ( source, "seat3" ) == 1 then
			cancelEvent()
		end
	end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), vehicle_enter )

function weaponsup ( source )
	
	if getElementData ( source, "oldseat" ) == 0 or getElementData ( source, "oldseat" ) == nil then
	elseif isElementAttached ( source ) then
		triggerClientEvent ( source, "helidbGunAuslese", getRootElement(), "up" )
	end
end

function weaponsdown ( source )
	
	if getElementData ( source, "oldseat" ) == 0 or getElementData ( source, "oldseat" ) == nil then
	elseif isElementAttached ( source ) then
		triggerClientEvent ( source, "helidbGunAuslese", getRootElement(), "down" )
	end
end

function helidriveby ( source )									--- dranhängen

	vioSetElementData ( source, "playervehicle", getPedOccupiedVehicle ( source ) )
	vioSetElementData ( source, "oldvehicle", getPedOccupiedVehicle ( source ) )
	local playervehicle = getPedOccupiedVehicle ( source )
	if ( getElementData ( source, "playervehicle" ) ) then 
		if ( getElementModel ( getElementData ( source, "playervehicle" ) ) ) == 487 or ( getElementModel ( getElementData ( source, "playervehicle" ) ) ) == 497 then
			vioSetElementData ( source, "seat", ( getPedOccupiedVehicleSeat ( source ) ) )
			if ( getElementData ( source, "seat" ) ) == 2 then 
				removePedFromVehicle ( source )
				attachElements ( source, getElementData ( source, "playervehicle" ) , -1.2, 0.3, 0 )
				setPedWeaponSlot( source, 5 )
				vioSetElementData ( source, "oldseat", 2)
				vioSetElementData ( playervehicle, "seat2", 1 )
			else
				if ( getElementData ( source, "seat" ) ) == 3 then
					removePedFromVehicle ( source )
					attachElements ( source, getElementData ( source, "playervehicle" ) , 1.2, 0.3, 0 )
					setPedWeaponSlot( source, 5 )
					vioSetElementData ( source, "oldseat", 3)
					vioSetElementData ( playervehicle, "seat3", 1 )
				else
					if ( getElementData ( source, "seat" ) ) == 1 then
						removePedFromVehicle ( source )
						attachElements ( source, getElementData ( source, "playervehicle" ) , 1.2, 1.7, 0 )
						setPedWeaponSlot( source, 5 )
						vioSetElementData ( source, "oldseat", 1)
						vioSetElementData ( playervehicle, "seat1", 1 )
						triggerClientEvent ( source, "helidbCameraFix", getRootElement() )
					end
				end
			end
			if ( getElementData ( source, "seat" ) ) > 0 then
				bindKey ( source, "mouse_wheel_up", "down", weaponsup )
				bindKey ( source, "mouse_wheel_down", "down", weaponsdown )
				bindKey ( source , "g", "down", rein )
				bindKey ( source , "enter", "down", eject )
				unbindKey ( source , "rshift", "down", helidriveby )
			end
		elseif ( getElementModel ( getElementData ( source, "playervehicle" ) ) ) == 469 or ( getElementModel ( getElementData ( source, "playervehicle" ) ) ) == 447 then
			vioSetElementData ( source, "seat", ( getPedOccupiedVehicleSeat ( source ) ) )
			if ( getElementData ( source, "seat" ) ) == 2 then 
				removePedFromVehicle ( source )
				attachElements ( source, getElementData ( source, "playervehicle" ) , -1.2, 0.3, 0 )
				setPedWeaponSlot( source, 5 )
				vioSetElementData ( source, "oldseat", 2)
				vioSetElementData ( playervehicle, "seat2", 1 )
			else
				if ( getElementData ( source, "seat" ) ) == 3 then
					removePedFromVehicle ( source )
					attachElements ( source, getElementData ( source, "playervehicle" ) , 1.2, 0.3, 0 )
					setPedWeaponSlot( source, 5 )
					vioSetElementData ( source, "oldseat", 3)
					vioSetElementData ( playervehicle, "seat3", 1 )
				else
					if ( getElementData ( source, "seat" ) ) == 1 then
						removePedFromVehicle ( source )
						attachElements ( source, getElementData ( source, "playervehicle" ) , 1.2, 1.7, 0 )
						setPedWeaponSlot( source, 5 )
						vioSetElementData ( source, "oldseat", 1)
						vioSetElementData ( playervehicle, "seat1", 1 )
						triggerClientEvent ( source, "helidbCameraFix", getRootElement() )
					end
				end
			end
			if ( getElementData ( source, "seat" ) ) > 0 then
				bindKey ( source, "mouse_wheel_up", "down", weaponsup )
				bindKey ( source, "mouse_wheel_down", "down", weaponsdown )
				bindKey ( source , "g", "down", rein )
				bindKey ( source , "enter", "down", eject )
				unbindKey ( source , "rshift", "down", helidriveby )
			end
		end
	end
end

function rein ( source )										--- Wieder einsteigen

    if ( getElementData ( source, "oldvehicle" ) ) ~= 0 then
		detachElements ( source, getElementData ( source, "oldvehicle" ), getElementData ( source, "oldseat" ) )
		warpPedIntoVehicle ( source, getElementData ( source, "oldvehicle" ), getElementData ( source, "oldseat" ) )
		if ( getElementData ( source, "oldseat") == 1) then
			vioSetElementData ( getElementData ( source, "playervehicle" ), "seat 1", 0 )
		end
		if ( getElementData ( source, "oldseat") == 2) then
			vioSetElementData ( getElementData ( source, "playervehicle" ), "seat 2", 0 )
		end
		if ( getElementData ( source, "oldseat") == 3) then
			vioSetElementData ( getElementData ( source, "playervehicle" ), "seat 3", 0 )
		end
		vioSetElementData ( source, "oldseat", 0)
		vioSetElementData ( source, "oldvehicle", 0)
		unbindKey ( source, "mouse_wheel_up", "down", weaponsup )
		unbindKey ( source, "mouse_wheel_down", "down", weaponsdown )
		unbindKey ( source , "g", "down", rein )
		unbindKey ( source , "enter", "down", eject )
		bindKey ( source, "rshift", "down", helidriveby )
    end
end

function eject ( source )										--- Abspringen

	local veh = getElementData ( source, "playervehicle" )
	if getElementData ( source, "oldseat") == 1 then
		vioSetElementData ( veh, "seat1", 0 )
	end
	if getElementData ( source, "oldseat") == 2 then
		vioSetElementData ( veh, "seat2", 0 )
	end
	if getElementData ( source, "oldseat") == 3 then
		vioSetElementData ( veh, "seat3", 0 )
	end
	vioSetElementData ( source, "oldseat", 0 )
	vioSetElementData ( source, "oldvehicle", 0 )
	unbindKey ( source, "mouse_wheel_up", "down", weaponsup )
	unbindKey ( source, "mouse_wheel_down", "down", weaponsdown )
	unbindKey ( source , "g", "down", rein )
	unbindKey ( source , "enter", "down", eject )
	unbindKey ( source, "rshift", "down", helidriveby )
	detachElements ( source )
end

function helidestroyed ()

	if not isElement(source) then
		return
	end
	
	if not getElementData ( source, "seat1" ) or not getElementData ( source, "seat2" ) or not getElementData ( source, "seat3" ) then
		return
	end

	if getElementData ( source, "seat1" ) == 1 or getElementData ( source, "seat2" ) == 1 or getElementData ( source, "seat3" ) == 1 then
		vioSetElementData ( source, "seat1", 0 )
		vioSetElementData ( source, "seat2", 0 )
		vioSetElementData ( source, "seat3", 0 )
	end
end
addEventHandler ( "onVehicleExplode", getRootElement(), helidestroyed )