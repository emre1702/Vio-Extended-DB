setGarageOpen ( 45, true )

function changeVehicleColor_func ( c1, c2, c3, c4 )

	local veh = getPedOccupiedVehicle ( client )
	if veh then
		if getPedOccupiedVehicleSeat ( client ) == 0 then
			setVehicleColor ( veh, c1, c2, c3, c4 )
		end
	end
end
addEvent ( "changeVehicleColor", true )
addEventHandler ( "changeVehicleColor", getRootElement(), changeVehicleColor_func )

PnsLVCity = createColSphere ( 1976.6048583984, 2162.4150390625, 9.5703125, 3 )
PnsFortCarson = createColSphere ( -99.773811340332, 1118.3737792969, 18.294296264648, 3 )
setGarageOpen ( 36, true )
setGarageOpen ( 41, true )
PnsLVCityBlip = createBlip ( 1976.6048583984, 2162.4150390625, 9.5703125, 63, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
PnsFortCarsonBlip = createBlip ( -99.773811340332, 1118.3737792969, 18.294296264648, 63, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

vioSetElementData ( PnsLVCity, "gateID", 36 )
vioSetElementData ( PnsFortCarson, "gateID", 41 )

PnsSFWangCars = createColCircle (-1904.47949, 289.4714660, 5 )
PnsSFJuniperHill = createColCircle (-2425.8376464844, 1020.0791015625, 5 )
PnsSFJuniperHillBlip = createBlip ( -2425.8376464844, 1020.0791015625, 50, 63, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
setGarageOpen ( 19, true )
setGarageOpen ( 27, true )

function PnsSFWangCarsHit ( hitelement )
	if getElementType ( hitelement ) == "vehicle" then
		if getVehicleOccupant ( hitelement ) ~= false then
			local player = getVehicleOccupant ( hitelement )
			if vioGetElementData ( player, "money" ) >= paynsprayprice then
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - paynsprayprice )
				takePlayerMoney ( player, paynsprayprice )
				triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				local veh = hitelement
				local x, y, z = getElementPosition ( hitelement )
				if z > 37 and z < 46 and motorboats[getElementModel ( veh )] ~= true and raftboats[getElementModel ( veh )] ~= true and helicopters[getElementModel ( veh )] ~= true and planea[getElementModel ( veh )] ~= true and planeb[getElementModel ( veh )] ~= true then
					setElementFrozen ( player, true )
					setElementFrozen ( veh, true )
					pnsDohertyKasse = pnsDohertyKasse + math.floor(paynsprayprice/3)
					setTimer ( wangrepair, 3000, 1, veh, hitelement )
					if isGarageOpen ( 19 ) == true then
						setGarageOpen ( 19, false )
					end
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDein Auto um-\nzulackieren kostet\n"..paynsprayprice.." $!", 5000, 125, 0, 0 )
			end
		end
	end
end
addEventHandler ( "onColShapeHit", PnsSFWangCars, PnsSFWangCarsHit )

function PnsSFJuniperHillHit ( hitelement )

	if getElementType ( hitelement ) == "vehicle" then
		if getVehicleOccupant ( hitelement ) ~= false then
			local player = getVehicleOccupant ( hitelement )
			if vioGetElementData ( player, "money" ) >= paynsprayprice then
				local veh = hitelement
				if not helicopters[getElementModel ( veh )] and not planea[getElementModel ( veh )] and not planeb[getElementModel ( veh )] then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - paynsprayprice )
					takePlayerMoney ( player, paynsprayprice )
					pnsJuniperKasse = pnsJuniperKasse + math.floor(paynsprayprice/3)
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
					local x, y, z = getElementPosition ( hitelement )
					setElementFrozen ( player, true )
					setElementFrozen ( veh, true )
					setTimer ( juniperrepair, 3000, 1, veh, hitelement )
					if isGarageOpen ( 27 ) then
						setGarageOpen ( 27, false )
					end
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDein Auto um-\nzulackieren kostet\n"..paynsprayprice.." $!", 5000, 125, 0, 0 )
			end
		end
	end
end
addEventHandler ( "onColShapeHit", PnsSFJuniperHill, PnsSFJuniperHillHit )

function PnsLVHit ( hitelement )

	if getElementType ( hitelement ) == "vehicle" then
		if getVehicleOccupant ( hitelement ) ~= false then
			local player = getVehicleOccupant ( hitelement )
			if vioGetElementData ( player, "money" ) >= paynsprayprice then
				local veh = hitelement
				if not helicopters[getElementModel ( veh )] and not planea[getElementModel ( veh )] and not planeb[getElementModel ( veh )] then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - paynsprayprice )
					takePlayerMoney ( player, paynsprayprice )
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
					local x, y, z = getElementPosition ( hitelement )
					setElementFrozen ( player, true )
					setElementFrozen ( veh, true )

					local gateID = vioGetElementData ( source, "gateID" )
					if isGarageOpen ( gateID ) then
						setGarageOpen ( gateID, false )
					end
					setTimer ( LVRepair, 3000, 1, veh, hitelement, gateID )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDein Auto um-\nzulackieren kostet\n"..paynsprayprice.." $!", 5000, 125, 0, 0 )
			end
		end
	end
end
addEventHandler ( "onColShapeHit", PnsLVCity, PnsLVHit )
addEventHandler ( "onColShapeHit", PnsFortCarson, PnsLVHit )

function wangrepair ( veh, hitelement )

	if not isGarageOpen ( 19 ) then
		setGarageOpen ( 19, true )
	end
	playSoundFrontEnd ( getVehicleOccupant ( hitelement ), 46 )
	setElementFrozen ( getVehicleOccupant ( hitelement ), false )

	pnsFixVehicle ( veh )
end

function juniperrepair ( veh, hitelement )

	if not isGarageOpen ( 27 ) then
		setGarageOpen ( 27, true )
	end
	playSoundFrontEnd ( getVehicleOccupant ( hitelement ), 46 )
	setElementFrozen ( getVehicleOccupant ( hitelement ), false )
	
	pnsFixVehicle ( veh )
end

function LVRepair ( veh, hit, gateID )

	local player = getVehicleOccupant ( hit )
	if not isGarageOpen ( gateID ) then
		setGarageOpen ( gateID, true )
	end
	playSoundFrontEnd ( player, 46 )
	setElementFrozen ( player, false )
	
	pnsFixVehicle ( veh )
end

function pnsFixVehicle ( veh )

	fixVehicle ( veh )
	if vioGetElementData ( veh, "stuning2" ) then
		setElementHealth ( veh, 1700 )
	end
	setElementFrozen ( veh, false )
end