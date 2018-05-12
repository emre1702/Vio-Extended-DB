eventObjects = {}

function createNewRandomEvent ()

	for key, index in pairs ( eventObjects ) do
		if isElement ( key ) then
			vanishElement ( key )
		elseif isElement ( index ) then
			vanishElement ( index )
		end
	end
	eventObjects = {}
	
	if math.random ( 1, 2 ) == 1 then
		local rnd = math.random ( 1, 3 )
	
		if rnd == 1 then
			-- damaged tree
			eventObjects[createObject ( 848, -1796.3931884766, -373.7770690918, 19.132633209229, 0, 0, 0 )] = true
			eventObjects[createObject ( 844, -1804.8850097656, -371.28677368164, 19.721632003784, 0, 0, 200 )] = true
		elseif rnd == 2 then
			-- car accident
			local veh1 = createVehicle ( 567, -2002.5560302734, 612.99621582031, 34.993965148926, 0, 0, 150 )
			local veh2 = createVehicle ( 412, -2005.6926269531, 607.90869140625, 34.97216796875, 0, 0, 0 )
			local ped1 = 
			local ped2 = 
			
			eventObjects[veh1] = true
			eventObjects[veh2] = true
			eventObjects[ped1] = true
			eventObjects[ped2] = true
		else
			-- feuer ( docks )
			eventObjects[createObject ( 844, -1804.8850097656, -371.28677368164, 19.721632003784, 0, 0, 200 )] = true
		end
	end
end

setTimer ( createNewRandomEvent, 60 * 60 * 1000, 1 )

567, -2002.5560302734, 612.99621582031, 34.993965148926, 0, 0, 150
412, -2005.6926269531, 607.90869140625, 34.97216796875, 0, 0, 0

-2005.3403320313, 612.623046875, 34.671394348145
-2002.2641601563, 608.07019042969, 34.664852142334