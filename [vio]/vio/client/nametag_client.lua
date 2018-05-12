﻿nameTagRange = 20
nameSphere = createColSphere ( 0, 0, 0, nameTagRange )

nameTagPlayers = {}
nameTagVisible = {}
nameTagHP = {}
nameTagImages = {}
nameTagAimTarget = lp

local players = getElementsByType ( "player" )
for key, index in pairs ( players ) do
	setPlayerNametagShowing ( index, false )
end
addEventHandler ( "onClientPlayerJoin", getRootElement(),
	function ()
		setPlayerNametagShowing ( source, false )
	end
)

function nameTagSpawn ()

	detachElements ( nameSphere )
	if isElement ( lp ) then
		attachElements ( nameSphere, lp )
	end
end
setTimer ( nameTagSpawn, 500, -1 )

function nameTagSphereHit ( element, dim )

	if getElementType ( element ) == "player" and not ( element == lp ) then
		nameTagPlayers[element] = true
		nameTagImages[element] = {}
		nameTagCheckPlayerSight ( element )
	end
end
addEventHandler ( "onClientColShapeHit", nameSphere, nameTagSphereHit )

function nameTagCheckPlayerSight ( player )

	if isElement ( player ) then
		local x1, y1, z1 = getPedBonePosition ( player, 8 )
		local x2, y2, z2 = getPedBonePosition ( lp, 8 )
		local hit = processLineOfSight ( x1, y1, z1, x2, y2, z2, true, false, false, true, false )
		nameTagVisible[player] = not hit
		if nameTagVisible[player] then
			nameTagHP[player] = getElementHealth ( lp )
		end
		
		faction = getElementData ( player, "fraktion" )
		
		if not nameTagImages[player] then
			nameTagImages[player] = {}
		end
		nameTagImages[player]["wanted.png"] = false
		nameTagImages[player]["armor.png"] = false
		nameTagImages[player]["police.png"] = false
		nameTagImages[player]["protected.png"] = false
		nameTagImages[player]["armed.png"] = false
		
		if getElementData ( player, "wanteds" ) > 3 then
			nameTagImages[player]["wanted.png"] = true
		end
		if getPedArmor ( player ) > 0 then
			nameTagImages[player]["armor.png"] = true
		end
		local r, g, b = getPlayerNametagColor ( player )
		if r == 200 and g == 0 and b == 0 then
			nameTagImages[player]["armed.png"] = true
		end
		if faction then
			if faction == 1 then
				nameTagImages[player]["police.png"] = true
			end
		end
		if getElementData ( player, "playingtime" ) then
			if getElementData ( player, "playingtime" ) <= 180 then
				nameTagImages[player]["protected.png"] = true
			end
		end
	else
		nameTagPlayers[player] = nil
		nameTagVisible[player] = nil
		nameTagHP[player] = nil
	end
end

function nameTagSphereLeave ( element )

	nameTagPlayers[element] = nil
	nameTagVisible[element] = nil
	nameTagHP[element] = nil
end
addEventHandler ( "onClientColShapeLeave", nameSphere, nameTagSphereLeave )

function nameTagRender ()

	local x, y, z, sx, sy
	local name, social
	local r, g, b, armor
	local images, drawn
	for key, index in pairs ( nameTagVisible ) do
		if isElement ( key ) then
			if nameTagVisible[key] then
				x, y, z = getElementPosition ( key )
				if x and y and z then
					sx, sy = getScreenFromWorldPosition ( x, y, z + 1.1, 1000, true )
					if sx and sy then
						r, g, b = calcRGBByHP ( key )
						name = getPlayerName ( key )
						social = "Spieler"
						if getElementData ( key, "socialState" ) then
							social = getElementData ( key, "socialState" )
						end
						dxDrawText ( name, sx, sy, sx, sy, tocolor ( 0, 0, 0, 255 ), 1.5, "sans", "center", "center" )
						dxDrawText ( name, sx - 2, sy - 2, sx, sy, tocolor ( r, g, b, 255 ), 1.5, "sans", "center", "center" )
						dxDrawText ( social, sx, sy + 30, sx, sy, tocolor ( 0, 0, 0, 255 ), .8, "sans", "center", "center" )
						dxDrawText ( social, sx - 2, sy - 1 + 30, sx, sy, tocolor ( 200, 200, 50, 255 ), .8, "sans", "center", "center" )
						
						images, drawn = 0, 0
						for img, bool in pairs ( nameTagImages[key] ) do
							if bool then
								images = images + 1
							end
						end
						for img, bool in pairs ( nameTagImages[key] ) do
							if bool then
								if images / 2 == math.floor ( images / 2 ) then
									dxDrawImage ( sx + 24 * ( drawn ) - images * 24 + 24, sy + 25, 24, 24, "images/nametag/"..img )
									drawn = drawn + 1
								else
									dxDrawImage ( sx + 24 * ( drawn ) - images * 24 / 2, sy + 25, 24, 24, "images/nametag/"..img )
									drawn = drawn + 1
								end
							end
						end
					end
				end
			end
		else
			nameTagCheckPlayerSight ( key )
		end
	end
end
addEventHandler ( "onClientRender", getRootElement(), nameTagRender )

function calcRGBByHP ( player )

	local hp = getElementHealth ( player )
	if hp <= 0 then
		return 0, 0, 0
	else
		hp = math.abs ( hp - 0.01 )
		return ( 100 - hp ) * 2.55 / 2, ( hp * 2.55 ), 0
	end
end

function reCheckNameTag ()

	if ( isElement ( getCameraTarget () ) ) then
		detachElements ( nameSphere )
		attachElements ( nameSphere, getCameraTarget () )
	end
	setElementInterior ( nameSphere, getElementInterior ( lp ) )
	setElementDimension ( nameSphere, getElementDimension ( lp ) )
	nameTagPlayers[nameTagAimTarget] = nil
	nameTagVisible[nameTagAimTarget] = nil
	if isPedAiming ( lp ) and getPedWeaponSlot ( lp ) == 6 then
		local x1, y1, z1 = getPedTargetStart ( lp )
		local x2, y2, z2 = getPedTargetEnd ( lp )
		local boolean, x, y, z, hit = processLineOfSight ( x1, y1, z1, x2, y2, z2 )
		if boolean then
			if isElement ( hit ) then
				if getElementType ( hit ) == "player" then
					nameTagAimTarget = hit
					nameTagPlayers[nameTagAimTarget] = nameTagAimTarget
				end
			end
		end
	end
	for key, index in pairs ( nameTagPlayers ) do
		nameTagCheckPlayerSight ( key )
	end
end
setTimer ( reCheckNameTag, 500, -1 )