AztecasGate1 = createObject ( 3049, -800.15844726563, 2381.9562988281, 154.86936950684, 358, 0,346)
AztecasGate2 = createObject ( 3049, -804.57672119141, 2383.1350097656, 154.85768127441, 357.98583984375, 357.9912109375, 346.31317138672)

AztecasGateMoving = false
AztecasGateMoved = false

function mv_func ( player )

	if isAztecas(player) or isOnDuty(player) then
		if getDistanceBetweenPoints3D ( -804.15563964844, 2383.7221679688, 154.94166564941, getElementPosition ( player ) ) < 17 then
			if AztecasGateMoving == false then
				AztecasGateMoving = true
				if AztecasGateMoved == false then
					moveObject ( AztecasGate1, 3000, -800.15844726563, 2381.9562988281, 149.89590454102, 0, 0, 0 )
					moveObject ( AztecasGate2, 3000, -804.57672119141, 2383.1350097656, 149.89590454102, 0, 0, 0 )
					setTimer ( triggerAztecasGateVarb, 3000, 1 )
					AztecasGateMoved = true
				else
					moveObject ( AztecasGate1, 3000, -800.15844726563, 2381.9562988281, 154.86936950684, 0, 0, 0 )
					moveObject ( AztecasGate2, 3000, -804.57672119141, 2383.1350097656, 154.85768127441, 0, 0, 0 )
					setTimer ( triggerAztecasGateVarb, 3000, 1 )
					AztecasGateMoved = false
				end
			end
		end
	end
end
addCommandHandler ( "mv", mv_func )

function triggerAztecasGateVarb ()

	AztecasGateMoving = false
end