local invulnerablePeds = {}

local ped
function createInvulnerableTicketPed ( skin, x, y, z, rot, int, dim )

	ped = createPed ( skin, x, y, z, rot )
	setPedRotation ( ped, rot )
	vioSetElementData ( ped, "x", x )
	vioSetElementData ( ped, "y", y )
	vioSetElementData ( ped, "z", z )
	vioSetElementData ( ped, "rot", rot )
	setElementDimension ( ped, dim )
	setElementInterior ( ped, int )
	addEventHandler ( "onPedWasted", ped,
		function ()
			local x = vioGetElementData ( source, "x" )
			local y = vioGetElementData ( source, "y" )
			local z = vioGetElementData ( source, "z" )
			local skin = getElementModel ( source )
			local dim = getElementDimension ( source )
			local int = getElementInterior ( source )
			local rot = vioGetElementData ( source, "rot" )
			destroyElement ( source )
			createInvulnerableTicketPed ( skin, x, y, z, rot, int, dim )
			--[[ped = createPed ( skin, x, y, z, rot )
			vioSetElementData ( ped, "x", x )
			vioSetElementData ( ped, "y", y )
			vioSetElementData ( ped, "z", z )
			vioSetElementData ( ped, "rot", rot )
			setElementDimension ( ped, dim )
			setElementInterior ( ped, int )]]
		end
	)
end
-- SF
createInvulnerableTicketPed ( 283, 238.91540527344, 112.89644622803, 1002.867980957, -90, 10, 0 )
-- LV
createInvulnerableTicketPed ( 283, 293.81640625, 182.29084777832, 1006.821105957, 180 - 45, 3, 0 )

function createInvulnerablePed ( skin, x, y, z, rot, int, dim )

	if not int then
		int = 0
	end
	if not dim then
		dim = 0
	end
	local ped = createPed ( skin, x, y, z, rot )
	setElementInterior ( ped, int )
	setElementDimension ( ped, dim )
	triggerClientEvent ( root, "makePedInvulnerable", root, ped )
	invulnerablePeds[ped] = true
	return ped
end

function syncInvulnerablePedsWithPlayer ()

	local player = source
	for key, index in pairs ( invulnerablePeds ) do
		if not isElement ( key ) then
			invulnerablePeds[key] = nil
		else
			triggerClientEvent ( player, "makePedInvulnerable", player, key )
		end
	end
end
addEvent ( "onVioPlayerLogin", true )
addEventHandler ( "onVioPlayerLogin", getRootElement(), syncInvulnerablePedsWithPlayer )