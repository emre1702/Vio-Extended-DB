SFPDgateMoving = false
SFPDgateMoved = false
SFPDGate1 = createObject ( 980, -1634.3143310547, 688.29608154297, 8.9608917236328, 0, 0, 0 )
SFPDGate2 = createObject ( 980, -1622.7777099609, 688.29217529297, 8.96089, 0, 0, 0 )

function mv_func ( player )

	if isCop(player) or isFBI(player) or isArmy(player) then
		if getDistanceBetweenPoints3D ( -1634.3143310547, 688.29608154297, 8.9608917236328, getElementPosition ( player ) ) < 17 then
			if SFPDgateMoving == false then
				SFPDgateMoving = true
				if SFPDgateMoved == false then
					moveObject ( SFPDGate1, 3000, -1646.1239013672, 688.70806884766, 8.9608917236328, 0, 0, 0 )
					moveObject ( SFPDGate2, 3000, -1612.7661132813, 688.50366210938, 8.9608917236328, 0, 0, 0 )
					setTimer ( triggerSFPDGateVarb, 3000, 1 )
					SFPDgateMoved = true
				else
					moveObject ( SFPDGate1, 3000, -1634.3143310547, 688.29608154297, 8.9608917236328, 0, 0, 0 )
					moveObject ( SFPDGate2, 3000, -1622.7777099609, 688.29217529297, 8.96089, 0, 0, 0 )
					setTimer ( triggerSFPDGateVarb, 3000, 1 )
					SFPDgateMoved = false
				end
			end
		end
	end
end
addCommandHandler ( "mv", mv_func )

function triggerSFPDGateVarb ()

	SFPDgateMoving = false
end