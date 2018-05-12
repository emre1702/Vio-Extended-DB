-------------------------
------- (c) 2009 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

function createInvulnerablePed ( skin, x, y, z, r, int, dim )

	local ped = createPed ( skin, x, y, z )
	if not dim then
		dim = 0
	end
	setElementInterior ( ped, int )
	setElementDimension ( ped, dim )
	setPedRotation ( ped, r )
	addEventHandler ( "onClientPedDamage", ped,
		function ()
			cancelEvent()
		end
	)
	return ped
end

function makePedInvulnerable_func ( ped )

	addEventHandler ( "onClientPedDamage", ped,
		function ()
			cancelEvent()
		end
	)
end
addEvent ( "makePedInvulnerable", true )
addEventHandler ( "makePedInvulnerable", getRootElement(), makePedInvulnerable_func )