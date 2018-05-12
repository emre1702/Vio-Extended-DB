createInvulnerablePed ( 100, 498.78802490234, -77.749015808105, 998.41430664063, 0, 11, 0 )

local ped = createPed ( 100, 1141.158203125, -2.271484375, 1000.671875, 90 )
setElementInterior ( ped, 12 )
setElementPosition ( ped, 1141.158203125, -2.271484375, 1000.671875 )
setElementRotation ( ped, 0, 0, 90 )
setElementFrozen ( ped, true )
function cancelPedDamageBiker ( attacker )
	cancelEvent() 
end

addEventHandler ( "onClientPedDamage", ped, cancelPedDamageBiker )