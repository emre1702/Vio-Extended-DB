﻿FbiGate1 = createObject ( 971, -2431.8154296875, 497.42578125, 30.50421333313, 0, 0, 23.8 )
FbiGate2 = createObject ( 971, -2439.884765625, 493.8688659668, 30.50421333313, 0, 0, 23.8 )

FBIGateMoving = false
FBIGateMoved = false

function mv_func ( player )

	if isFBI(player) or isArmy(player) then
		if getDistanceBetweenPoints3D ( -2431.8154296875, 497.42578125, 30.50421333313, getElementPosition ( player ) ) < 17 then
			if FBIGateMoving == false then
				FBIGateMoving = true
				if FBIGateMoved == false then
					moveObject ( FbiGate1, 3000, -2431.8154296875, 497.42578125, 21, 0, 0, 0 )
					moveObject ( FbiGate2, 3000, -2439.884765625, 493.8688659668, 21, 0, 0, 0 )
					setTimer ( triggerFBIGateVarb, 3000, 1 )
					FBIGateMoved = true
				else
					moveObject ( FbiGate1, 3000, -2431.8154296875, 497.42578125, 30.50421333313, 0, 0, 0 )
					moveObject ( FbiGate2, 3000, -2439.884765625, 493.8688659668, 30.50421333313, 0, 0, 0 )
					setTimer ( triggerFBIGateVarb, 3000, 1 )
					FBIGateMoved = false
				end
			end
		end
	end
end
addCommandHandler ( "mv", mv_func )

function triggerFBIGateVarb ()

	FBIGateMoving = false
end