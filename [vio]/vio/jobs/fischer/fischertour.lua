-------------------------
------- (c) 2009 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

function startfishing_func ()

	fische = 0
	finalmarker = createMarker ( -1713.13, 1453.08, 0, "checkpoint", 7, 0, 200, 0, 255, getLocalPlayer() )
	finalmarkerblip = createBlip ( -1713.13, 1453.08, 0, 0, 1.5, 0, 255, 0, 255, 0, 99999.0, getLocalPlayer() )
	for a = 1, 3 do
		local i = 2
		while (i > 1) do
			local rnd = math.random ( 1, 16 )
			if _G["fischmarker"..rnd] == nil then
				if rnd == 1 then 
					fischmarker1 = createMarker ( -1587.2761230469, 1612.5944824219, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() )
					fischmarker1blip = createBlip ( -1587.2761230469, 1612.5944824219, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 2 then 
					fischmarker2 = createMarker ( -1286.3483886719, 1472.4879150391, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker2blip = createBlip ( -1286.3483886719, 1472.4879150391, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 3 then 
					fischmarker3 = createMarker ( -1217.1864013672, 984.06463623047, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker3blip = createBlip ( -1217.1864013672, 984.06463623047, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 4 then 
					fischmarker4 = createMarker ( -1422.9135742188, 1157.8354492188, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker4blip = createBlip ( -1422.9135742188, 1157.8354492188, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 5 then 
					fischmarker5 = createMarker ( -1278.3187255859, 801.39245605469, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker5blip = createBlip ( -1278.3187255859, 801.39245605469, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 6 then 
					fischmarker6 = createMarker ( -1001.3262939453, 797.20697021484, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() )
					fischmarker6blip = createBlip ( -1001.3262939453, 797.20697021484, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 7 then 
					fischmarker7 = createMarker ( -1115.03515625, 701.140625, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker7blip = createBlip ( -1115.03515625, 701.140625, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 8 then 
					fischmarker8 = createMarker ( -1148.3835449219, 470.44064331055, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker8blip = createBlip ( -1148.3835449219, 470.44064331055, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 9 then 
					fischmarker9 = createMarker ( -892.72381591797, 530.1328125, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker9blip = createBlip ( -892.72381591797, 530.1328125, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 10 then 
					fischmarker10 = createMarker ( -677.67651367188, 489.87966918945, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker10blip = createBlip ( -677.67651367188, 489.87966918945, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 11 then 
					fischmarker11 = createMarker ( -1073.26171875, 161.7254486084, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker11blip = createBlip ( -1073.26171875, 161.7254486084, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 12 then 
					fischmarker12 = createMarker ( -1809.0780029297, 1752.9664306641, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() )
					fischmarker12blip = createBlip ( -1809.0780029297, 1752.9664306641, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 13 then 
					fischmarker13 = createMarker ( -1904.6411132813, 2109.8564453125, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker13blip = createBlip ( -1904.6411132813, 2109.8564453125, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 14 then 
					fischmarker14 = createMarker ( -2449.1669921875, 1474.4860839844, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker14blip = createBlip ( -2449.1669921875, 1474.4860839844, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 15 then 
					fischmarker15 = createMarker ( -2469.5495605469, 1850.9063720703, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker15blip = createBlip ( -2469.5495605469, 1850.9063720703, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				if rnd == 16 then 
					fischmarker16 = createMarker ( -2040.4636230469, 1705.9348144531, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) 
					fischmarker16blip = createBlip ( -2040.4636230469, 1705.9348144531, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
				end
				local i = 1
				break
			end
		end
	end
	outputChatBox ( "Fahre die Checkpoints ab, um Fisch zu fangen - Wenn du genug hast, fahre zum gruenen Checkpoint um den Fisch abzuliefern!", 200, 200, 0 )
end
addEvent ( "startfishing", true )
addEventHandler ( "startfishing", getRootElement(), startfishing_func )

function cancelfishing_func ()

	for i = 1, 17 do
		if _G["fischmarker"..i] then destroyElement (_G["fischmarker"..i]) end
		if _G["fischmarker"..i.."blip"] then destroyElement(_G["fischmarker"..i.."blip"]) end
		_G["fischmarker"..i] = nil
		_G["fischmarker"..i.."blip"] = nil
	end
	destroyElement ( finalmarker )
	destroyElement ( finalmarkerblip )
	outputChatBox ( "Du hast das Fischen beendet!", 125, 0, 0 )
end
addEvent ( "cancelfishing", true )
addEventHandler ( "cancelfishing", getRootElement(), cancelfishing_func )

function fischMarkerHit ( player )

	if player == getLocalPlayer() then
		markerhit = 0
		for i = 1, 16 do
			if source == _G["fischmarker"..i] then
				markerhit = 1
				break
			end
		end
		if source == finalmarker then
			markerhit = 0
		end
		if markerhit == 1 then
			local rnd = math.random ( 0, 5 )
			if fische == nil then fische = 0 end
			if rnd == 0 then 
				if math.random ( 1, 3 ) == 1 then
					rnd = 0
				else
					rnd = 1
				end
			end
			fische = fische + rnd
			if rnd == 1 then grammafisch = "Fisch" else grammafisch = "Fische" end
			if fische == 1 then grammafisch2 = "Fisch" else grammafisch2 = "Fische" end
			triggerEvent ( "infobox_start", getLocalPlayer(),"Du hast soeben\n"..rnd.." "..grammafisch.." gefangen!\nInsgesammt hast du\nschon "..fische.." "..grammafisch2.."!", 10000, 125, 0, 0 )
			local i = 2
			while (i > 1) do
				local rnd = math.random ( 1, 16 )
				local mtr, mtg, mtb, mta = getMarkerColor ( _G["fischmarker"..rnd] )
				if mtr == false then
					if rnd == 1 then fischmarker1 = createMarker ( -1587.2761230469, 1612.5944824219, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 1 then fischmarker1blip = createBlip ( -1587.2761230469, 1612.5944824219, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 2 then fischmarker2 = createMarker ( -1286.3483886719, 1472.4879150391, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 2 then fischmarker2blip = createBlip ( -1286.3483886719, 1472.4879150391, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 3 then fischmarker3 = createMarker ( -1217.1864013672, 984.06463623047, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 3 then fischmarker3blip = createBlip ( -1217.1864013672, 984.06463623047, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 4 then fischmarker4 = createMarker ( -1422.9135742188, 1157.8354492188, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 4 then fischmarker4blip = createBlip ( -1422.9135742188, 1157.8354492188, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 5 then fischmarker5 = createMarker ( -1278.3187255859, 801.39245605469, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 5 then fischmarker5blip = createBlip ( -1278.3187255859, 801.39245605469, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 6 then fischmarker6 = createMarker ( -1001.3262939453, 797.20697021484, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 6 then fischmarker6blip = createBlip ( -1001.3262939453, 797.20697021484, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 7 then fischmarker7 = createMarker ( -1115.03515625, 701.140625, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 7 then fischmarker7blip = createBlip ( -1115.03515625, 701.140625, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 8 then fischmarker8 = createMarker ( -1148.3835449219, 470.44064331055, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 8 then fischmarker8blip = createBlip ( -1148.3835449219, 470.44064331055, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 9 then fischmarker9 = createMarker ( -892.72381591797, 530.1328125, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 9 then fischmarker9blip = createBlip ( -892.72381591797, 530.1328125, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 10 then fischmarker10 = createMarker ( -677.67651367188, 489.87966918945, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 10 then fischmarker10blip = createBlip ( -677.67651367188, 489.87966918945, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 11 then fischmarker11 = createMarker ( -1073.26171875, 161.7254486084, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 11 then fischmarker11blip = createBlip ( -1073.26171875, 161.7254486084, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 12 then fischmarker12 = createMarker ( -1809.0780029297, 1752.9664306641, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 12 then fischmarker12blip = createBlip ( -1809.0780029297, 1752.9664306641, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 13 then fischmarker13 = createMarker ( -1904.6411132813, 2109.8564453125, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 13 then fischmarker13blip = createBlip ( -1904.6411132813, 2109.8564453125, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 14 then fischmarker14 = createMarker ( -2449.1669921875, 1474.4860839844, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 14 then fischmarker14blip = createBlip ( -2449.1669921875, 1474.4860839844, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 15 then fischmarker15 = createMarker ( -2469.5495605469, 1850.9063720703, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 15 then fischmarker15blip = createBlip ( -2469.5495605469, 1850.9063720703, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					if rnd == 16 then fischmarker16 = createMarker ( -2040.4636230469, 1705.9348144531, 0, "checkpoint", 7, 200,0,0, 255, getLocalPlayer() ) end
					if rnd == 16 then fischmarker16blip = createBlip ( -2040.4636230469, 1705.9348144531, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() ) end
					local i = 1
					break
				end
			end
			for i = 1, 16 do
				if source == _G["fischmarker"..i] then
					destroyElement ( _G["fischmarker"..i.."blip"] )
				end
			end
			destroyElement ( source )
		end
		if source == finalmarker and fische > 0 then
			triggerServerEvent ( "endfishing", getLocalPlayer(), fische )
		end
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), fischMarkerHit )

function fischPlayerDeath ()

	if source == getLocalPlayer() then
		if getElementData ( source, "job" ) == "fischer" then
			for i = 1, 17 do
				if _G["fischmarker"..i] then destroyElement (_G["fischmarker"..i]) end
				if _G["fischmarker"..i.."blip"] then destroyElement(_G["fischmarker"..i.."blip"]) end
			end
			destroyElement ( finalmarker )
			destroyElement ( finalmarkerblip )
		end
	end
end
addEventHandler ( "onClientPlayerWasted", getRootElement(), fischPlayerDeath )