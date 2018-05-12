katjCount = 0
kS = 1000
katjMoving = 50

function createKatjuscha ( x, y, z, rx, ry, rz )

	_G["katjuschaNo"..katjCount] = createVehicle ( 422, 2481.6918945313, -1660.9809570313, 13.423749923706 )
	vioSetElementData ( _G["katjuschaNo"..katjCount], "katjuscha", true )
	vioSetElementData ( _G["katjuschaNo"..katjCount], "fireAble", true )
	vioSetElementData ( _G["katjuschaNo"..katjCount], "katjuschaID", katjCount )
	_G["katjuschaNo"..katjCount.."SAM"] = createObject ( 3267, 2481.6518554688, -1662.2526855469, 12.468755722046+0.2 )
	
	_G["katjuschaNo"..katjCount.."SAM1"] = createObject ( 1239, 2482.3203125, -1660.6856689453, 15.020451545715+0.2 )
	_G["katjuschaNo"..katjCount.."SAM2"] = createObject ( 1239, 2482.2885742188, -1660.9114990234, 15.4204454422+0.2 )
	_G["katjuschaNo"..katjCount.."SAM3"] = createObject ( 1239, 2480.9584960938, -1660.8966064453, 15.47044467926+0.2 )
	_G["katjuschaNo"..katjCount.."SAM4"] = createObject ( 1239, 2480.9384765625, -1660.6474609375, 14.945441246033+0.2 )
	
	for i = 1, 4 do
		setElementAlpha ( _G["katjuschaNo"..katjCount.."SAM"..i], 0 )
	end
	
	attachElementsInCorrectWay ( _G["katjuschaNo"..katjCount.."SAM"], _G["katjuschaNo"..katjCount] )
	attachElementsInCorrectWay ( _G["katjuschaNo"..katjCount.."SAM1"], _G["katjuschaNo"..katjCount] )
	attachElementsInCorrectWay ( _G["katjuschaNo"..katjCount.."SAM2"], _G["katjuschaNo"..katjCount] )
	attachElementsInCorrectWay ( _G["katjuschaNo"..katjCount.."SAM3"], _G["katjuschaNo"..katjCount] )
	attachElementsInCorrectWay ( _G["katjuschaNo"..katjCount.."SAM4"], _G["katjuschaNo"..katjCount] )
	
	setElementPosition ( _G["katjuschaNo"..katjCount], x, y, z )
	setVehicleRotation ( _G["katjuschaNo"..katjCount], rx, ry, rz )
	
	katjCount = katjCount + 1
end

function fireKatjuscha ( id, x, y, z )

	local katjuscha = _G["katjuschaNo"..id]
	local player = getVehicleOccupant ( katjuscha, 0 )
	if player and isTerror ( player ) then
		if vioGetElementData ( katjuscha, "fireAble" ) then
			vioSetElementData ( katjuscha, "fireAble", false )
			setTimer ( vioSetElementData, 60*kS, 1, katjuscha, "fireAble", true )
			outputChatBox ( "Salve abgefeuert - naechste Salve in 1 Minute verfügbar!", player, 0, 125, 0 )
			setElementFrozen ( katjuscha, true )
			
			local kx, ky, kz = getElementPosition ( katjuscha )
			soundSphere = createColSphere ( kx, ky, kz, 30 )
			playersInRange = getElementsWithinColShape ( soundSphere, "player" )
			for key, player in ipairs ( playersInRange ) do
				triggerClientEvent ( player, "katjuschasound", getRootElement(), 12, 400, kx, ky, kz )
			end
			destroyElement ( soundSphere )
			
			fireKatjuschaRocket ( x, y, z, player, katjuscha, id, x2, y2, z2 )
			
			setTimer ( setElementFrozen, 5000, 1, katjuscha, false )
		else
			outputChatBox ( "Du kannst noch nicht wieder feuern!", player, 125, 0, 0 )
		end
	end
end

function fireKatjuschaRocket ( x, y, z, player, veh, id, x2, y2, z2 )

	triggerClientEvent ( getRootElement(), "fireKatjuschaRocketClient", getRootElement(), x, y, z, player, veh, id, x2, y2, z2, _G["katjuschaNo"..id.."SAM1"], _G["katjuschaNo"..id.."SAM2"], _G["katjuschaNo"..id.."SAM3"], _G["katjuschaNo"..id.."SAM4"] )
end

function katjuscha_func ( p )

	if isTerror ( p ) and vioGetElementData ( p, "rang" ) >= 4 then
		local x1, y1, z1 = getElementPosition ( p )
		if getDistanceBetweenPoints3D ( x1, y1, z1, -1998.3441162109, -1537.8443603516, 84.67 ) < 20 then
			createKatjuscha ( x1+1, y1+1, z1, 0, 0, 0 )
		end
	end
end
addCommandHandler ( "katjuscha", katjuscha_func )