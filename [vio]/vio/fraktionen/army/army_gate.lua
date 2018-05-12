-- Army-Marker

armyTeleporterA = createMarker ( 281.34356689453, 1858.0793457031, 16.590633392334, "cylinder", 5, 255, 0, 0, 125 ) 
armyTeleporterB = createMarker ( 290.01748657227, 1857.9688720703, 16.590633392334, "cylinder", 5, 255, 0, 0, 125 ) 
----------------
-- Army-Tore Area51
local area51_haupttor = createObject( 988, 96.8212890625, 1920.44140625, 17.635732650757, 0, 0, 270 )
local area51_haupttor_state = "zu" 
local area51_bunker = createObject( 976, 209.962890625, 1875.6591796875, 12.14695930481, 0, 0, 0 )
local area51_bunker_state = "zu" 

----------------------------------------------------

local area51_hangar11 = createObject( 16775, 286.5498046875, 1953.8681640625, 19.04842376709, 0, 0, 270 )
local area51_hangar12 = createObject( 16775, 286.5322265625, 1958.802734375, 19.04842376709, 0, 0, 270 )
local area51_hangar1_state = "zu"

local area51_hangar21 = createObject( 16775, 286.5498046875, 1987.6591796875, 19.04842376709, 0, 0, 270 )
local area51_hangar22 = createObject( 16775, 286.5322265625, 1992.5458984375, 19.04842376709, 0, 0, 270 )
local area51_hangar2_state = "zu"

local area51_hangar31 = createObject( 16775, 286.5498046875, 2021.87109375, 19.04842376709, 0, 0, 270 )
local area51_hangar32 = createObject( 16775, 286.5322265625, 2026.6669921875, 19.04842376709, 0, 0, 270 )
local area51_hangar3_state = "zu"

----------------
-- Army Tore SF
sfarmyzaun = createObject(986, -1522.8876953125,482.0810546875,6.8689527511597,0,0,352.05688476)
sfarmygate = createObject(986, -1530.7382,482.61816,6.87969017,359.7473144,0,0)
sfarmygatestate = true
----------------

-----------------------

function mv_func ( player )

	local x, y, z = getElementPosition ( player )
	
	if isArmy ( player ) then
	
		if getDistanceBetweenPoints3D ( x, y, z, 96.8212890625, 1920.44140625, 17.635732650757 ) <= 10 then -- Haupttor
		
			if ( area51_haupttor_state == "zu" ) then 
		
				moveObject( area51_haupttor, 2500, 96.7998046875, 1924.69921875, 17.60000038147 )
				area51_haupttor_state = "auf"
				return
			
			else
			
				moveObject( area51_haupttor, 2500, 96.8212890625, 1920.44140625, 17.635732650757 )
				area51_haupttor_state = "zu"
				return
			
			end
			
		elseif getDistanceBetweenPoints3D ( x, y, z, 209.962890625, 1875.6591796875, 12.14695930481 ) <= 10 then -- Bunker
		
			if ( area51_bunker_state == "zu" ) then 
		
				moveObject( area51_bunker, 2500, 218.962890625, 1875.6591796875, 12.14695930481 )
				area51_bunker_state = "auf"
				return
			
			else
			
				moveObject( area51_bunker, 2500, 209.962890625, 1875.6591796875, 12.14695930481 )
				area51_bunker_state = "zu"
				return
			
			end
			
		elseif getDistanceBetweenPoints3D ( x, y, z, 286.5498046875, 1953.8681640625, 19.04842376709 ) <= 15 then -- Halle1
		
			if ( area51_hangar1_state == "zu" ) then 
		
				moveObject( area51_hangar11, 2500, 286.5498046875, 1953.8681640625, 10.04842376709 )
				moveObject( area51_hangar12, 2500, 286.5322265625, 1958.802734375, 10.04842376709 )
				area51_hangar1_state = "auf"
				return
			
			else
			
				moveObject( area51_hangar11, 2500, 286.5498046875, 1953.8681640625, 19.04842376709 )
				moveObject( area51_hangar12, 2500, 286.5322265625, 1958.802734375, 19.04842376709 )
				area51_hangar1_state = "zu"
				return
			
			end
			
		elseif getDistanceBetweenPoints3D ( x, y, z, 286.5498046875, 1987.6591796875, 19.04842376709 ) <= 15 then -- Halle2
		
			if ( area51_hangar2_state == "zu" ) then 
		
				moveObject( area51_hangar21, 2500, 286.5498046875, 1987.6591796875, 10.04842376709 )
				moveObject( area51_hangar22, 2500, 286.5322265625, 1992.5458984375, 10.04842376709 )
				area51_hangar2_state = "auf"
				return
			
			else
			
				moveObject( area51_hangar21, 2500, 286.5498046875, 1987.6591796875, 19.04842376709 )
				moveObject( area51_hangar22, 2500, 286.5322265625, 1992.5458984375, 19.04842376709 )
				area51_hangar2_state = "zu"
				return
			end
				
		elseif getDistanceBetweenPoints3D ( x, y, z, 286.5498046875, 2021.87109375, 19.04842376709 ) <= 15 then -- Halle3
		
			if ( area51_hangar3_state == "zu" ) then 
		
				moveObject( area51_hangar31, 2500, 286.5498046875, 2021.87109375, 10.04842376709 )
				moveObject( area51_hangar32, 2500, 286.5322265625, 2026.6669921875, 10.04842376709 )
				area51_hangar3_state = "auf"
				return
			
			else
			
				moveObject( area51_hangar31, 2500, 286.5498046875, 2021.87109375, 19.04842376709 )
				moveObject( area51_hangar32, 2500, 286.5322265625, 2026.6669921875, 19.04842376709 )
				area51_hangar3_state = "zu"
				return
			
			end
			
		end
		
	end
	
end

addCommandHandler ( "mv", mv_func )

-----------------

-- SF Army Base /mv

function sfarmybase_func(player)

	tx,ty,tz = getElementPosition(sfarmygate)
	px, py, pz = getElementPosition(player)
	
	local dis = getDistanceBetweenPoints3D ( tx, ty, tz, px, py, pz )
	if isArmy (player) then
		if (dis <= 30) then
			if (sfarmygatestate == true) then
				moveObject( sfarmygate, 2500, -1538.997436, 482.7531127, 6.293198)
				sfarmygatestate = false
			else
				moveObject( sfarmygate, 2500, -1530.7382,482.618164,6.879690)
				sfarmygatestate = true
			end
		end
	end
	
end

addCommandHandler("mv", sfarmybase_func)

--------------------------------------------------------------

-- Teleporter Funktionen

function armyTeleportA ( hit )

	if isArmy ( hit ) then
		
	elseif getElementType ( hit ) == "vehicle" and isArmy ( getVehicleOccupant ( hit ) ) then
		setElementFrozen ( hit, true )
		setTimer ( setElementFrozen, 500, 1, hit, false )
	else
		return nil
	end
	setElementPosition ( hit, 301.18362426758, 1858.2447509766, 17.289850234985 )
end

addEventHandler ( "onMarkerHit", armyTeleporterA, armyTeleportA )

function armyTeleportB ( hit )

	if isArmy ( hit ) then
		
	elseif getElementType ( hit ) == "vehicle" and isArmy ( getVehicleOccupant ( hit ) ) then
		setElementFrozen ( hit, true )
		setTimer ( setElementFrozen, 500, 1, hit, false )
	else
		return nil
	end
	setElementPosition ( hit, 271.25347900391, 1857.4809570313, 17.289850234985 )
	
end

addEventHandler ( "onMarkerHit", armyTeleporterB, armyTeleportB )

--------------------------------------------------------------------------------

--[[armyGate1 = createObject ( 988, 96.8125, 1921.62, 17.9788, 0, 0, 90 )
armyGate2 = createObject ( 7657, 217.9140625, 1875.8994140625, 13.863801956177, 0, 0, 180 )
	
armyGate1Moving = false
armyGate2Moving = false

armyGate1Moved = false
armyGate2Moved = false

function mv_func ( player )

	local x1, y1, z1 = getElementPosition ( player )
	local x2, y2, z2 = getElementPosition ( armyGate1 )
	local x3, y3, z3 = getElementPosition ( armyGate2 )
	if isArmy ( player ) then
		if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 10 then
			if not armyGate1Moving then
				if armyGate1Moved then
					setTimer ( armyGateMoveSwitch, 1500, 1, 1 )
					moveObject ( armyGate1, 1500, 96.8125, 1921.62, 17.9788 )
					armyGate1Moved = false
					armyGate1Moving = true
				else
					setTimer ( armyGateMoveSwitch, 1500, 1, 1 )
					moveObject ( armyGate1, 1500, 96.8125, 1925.62, 17.9788 )
					armyGate1Moved = true 
					armyGate1Moving = true
				end
			end
		elseif getDistanceBetweenPoints3D ( x1, y1, z1, x3, y3, z3 ) <= 20 then
			if not armyGate2Moving then
				if armyGate2Moved then
					setTimer ( armyGateMoveSwitch, 1500, 1, 2 )
					moveObject ( armyGate2, 1500, 217.9140625, 1875.8994140625, 13.863801956177 )
					armyGate2Moved = false
					armyGate2Moving = true
				else
					setTimer ( armyGateMoveSwitch, 1500, 1, 2 )
					moveObject ( armyGate2, 1500, 200, 1875.8994140625, 13.863801956177 )
					armyGate2Moved = true
					armyGate2Moving = true
				end
			end
		end
	end
end
addCommandHandler ( "mv", mv_func )

function armyGateMoveSwitch ( i )
	_G["armyGate"..i.."Moving"] = false
end--]]