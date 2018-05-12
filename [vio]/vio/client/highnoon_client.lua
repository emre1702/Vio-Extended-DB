function startHighNoon_func ( rnd )

	toggleControl ( "fire", false )
	toggleControl ( "aim_weapon", false )
	toggleControl ( "sprint", false )
	toggleControl ( "jump", false )
	toggleControl ( "walk", false )
	toggleControl ( "next_weapon", false )
	toggleControl ( "previous_weapon", false )
	setPedWeaponSlot ( lp, 2 )
	setControlState ( "walk", true )
	highnoonsound_func ( rnd )
	setTimer ( enableFire, rnd*1000, 1 )
	if blackDown then
		guiSetVisible ( blackDown, true )
		guiSetVisible ( blackTop, true )
	else
		blackDown = guiCreateStaticImage(0, 0, screenwidth, screenheight/9*1, "images/black.bmp", false)
		blackTop = guiCreateStaticImage(0, screenheight-screenheight/9*1, screenwidth, screenheight/9*1, "images/black.bmp", false)
	end
end
addEvent ( "startHighNoon", true )
addEventHandler ( "startHighNoon", getRootElement(), startHighNoon_func )

function enableFire ()

	toggleControl ( "fire", true )
	toggleControl ( "aim_weapon", true )
	toggleControl ( "next_weapon", true )
	toggleControl ( "previous_weapon", true )
end

function highNoonKill ( killer )

	if killer then
		if getElementData ( killer, "isInHighNoon" ) and killer == lp then
			setGameSpeed ( 0.15 )
			setTimer ( setSpeedBackToNormal, 5000, 1, killer, source, false )
		elseif source == lp and getElementData ( lp, "isInHighNoon" ) then
			setGameSpeed ( 0.15 )
			setTimer ( setSpeedBackToNormal, 5000, 1, killer, source, true )
		end
	end
end
addEventHandler ( "onClientPlayerWasted", getRootElement(), highNoonKill )

function setSpeedBackToNormal ( killer, victim, bool )

	setGameSpeed ( 1 )
	if bool then
		triggerServerEvent ( "duellHasEnd", getRootElement(), killer, victim, getElementData ( lp, "highNoonSumme" ) )
	end
end

function endHighNoon_func ()

	setGameSpeed ( 1 )
	toggleControl ( "fire", true )
	toggleControl ( "aim_weapon", true )
	toggleControl ( "sprint", true )
	toggleControl ( "jump", true )
	toggleControl ( "walk", true )
	toggleControl ( "next_weapon", true )
	toggleControl ( "previous_weapon", true )
	setControlState ( "walk", false )
	guiSetVisible ( blackDown, false )
	guiSetVisible ( blackTop, false )
end
addEvent ( "endHighNoon", true )
addEventHandler ( "endHighNoon", getRootElement(), endHighNoon_func )