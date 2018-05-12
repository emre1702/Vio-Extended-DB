function vehicleHelpEnter ()

	if lp == source then
		if getElementData ( lp, "playingtime" ) <= 240 then
			infobox_start_func ( "Druecke \"X\" und\n\"L\", um den\nMotor bzw. das\nLicht ein/aus\nzu schalten.", 7500, 255, 255, 255 )
		end
	end
end
addEventHandler ( "onClientPlayerVehicleEnter", getRootElement(), vehicleHelpEnter )

function createTutorialBubble ( x, y, z, text, maxTime, r, g, b, range )

	if not b then
		r, g, b = 255, 255, 255
	end
	if not text then
		text = ""
	end
	if not maxTime then
		maxTime = 3
	end
	if not range then
		range = 3
	end
	local tutColshape = createColSphere ( x, y, z, range )
	setElementData ( tutColshape, "text", text )
	setElementData ( tutColshape, "r", r )
	setElementData ( tutColshape, "g", g )
	setElementData ( tutColshape, "b", b )
	setElementData ( tutColshape, "max", maxTime )
	addEventHandler ( "onClientColShapeHit", tutColshape,
		function ( element, dim )
			if dim and element == lp then
				local text = getElementData ( source, "text" )
				local r = getElementData ( source, "r" )
				local g = getElementData ( source, "g" )
				local b = getElementData ( source, "b" )
				local max = getElementData ( source, "max" ) * 60
				if max >= getElementData ( lp, "playingtime" ) then
					infobox ( text, 10000, r, g, b )
				end
			end
		end
	)
end

createTutorialBubble ( -1980.5427246094, 145.16845703125, 27.32200050354, "An diesem Automaten\nkannst du dein\nGeld von der Bank\nabheben. Druecke\ndazu ALT-GR ( neben\nder Leertaste )\nund klicke ihn an.", 5, 200, 200, 0 )
createTutorialBubble ( -2765.4018554688, 372.29138183594, 5.9826860427856, "An diesem Automaten\nkannst du dein\nGeld von der Bank\nabheben. Druecke\ndazu ALT-GR ( neben\nder Leertaste )\nund klicke ihn an.", 5, 200, 200, 0 )
createTutorialBubble ( -2456.9841308594, 783.24542236328, 34.81477355957, "An diesem Automaten\nkannst du dein\nGeld von der Bank\nabheben. Druecke\ndazu ALT-GR ( neben\nder Leertaste )\nund klicke ihn an.", 5, 200, 200, 0 )

createTutorialBubble ( -2633.6958007813, 211.23025512695, 3.4143309593201, "\nIn diesen Kisten\nkannst du Waffen\nLagern, klicke sie\ndazu mittels ALT-GR\n( neben der Leertaste ) an.", 5, 200, 200, 0 )
createTutorialBubble ( -2172.8569335938, 710.32220458984, 52.89062, "\nIn diesen Kisten\nkannst du Waffen\nLagern, klicke sie\ndazu mittels ALT-GR\n( neben der Leertaste ) an.", 5, 200, 200, 0 )
createTutorialBubble ( -700.05700683594, 943.8525390625, 11.3368101, "\nIn diesen Kisten\nkannst du Waffen\nLagern, klicke sie\ndazu mittels ALT-GR\n( neben der Leertaste ) an.", 5, 200, 200, 0 )
createTutorialBubble ( -1970.5015869141, -1585.2413330078, 86.7981414794, "\nIn diesen Kisten\nkannst du Waffen\nLagern, klicke sie\ndazu mittels ALT-GR\n( neben der Leertaste ) an.", 5, 200, 200, 0 )
createTutorialBubble ( -767.6689453125, 2419.4206542969, 156.05166625977, "\nIn diesen Kisten\nkannst du Waffen\nLagern, klicke sie\ndazu mittels ALT-GR\n( neben der Leertaste ) an.", 5, 200, 200, 0 )