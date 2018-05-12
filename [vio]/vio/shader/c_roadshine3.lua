--
-- c_roadshine3.lua
--

local maxEffectDistance = 250		-- To speed up the shader, don't use it for objects further away than this
local lightDirection = {0,0,1}		-- This gets updated by updateShineDirection()

-- List of world texture name matches and how much of the effect to apply to each match.
-- (The ones later in the list will take priority) 
local applyList = {
						{ 1.0, "*" },				-- Everything!

						{ 2.0, "*road*" },			-- Roads
						{ 2.0, "*tar*" },
						{ 2.0, "*asphalt*" },
						{ 2.0, "*freeway*" },
						{ 2.0, "*hiway*" },
						{ 2.0, "*cross*" },
						{ 2.0, "*junction*" },
						{ 2.0, "snpedtest*" },

						{ 1.8, "*walk*" },			-- Sidewalks
						{ 1.8, "*pave*" },

						{ 2.0, "*wall*" },			-- Other road related
						{ 2.0, "*floor*" },
						{ 2.0, "*bridge*" },
						{ 2.0, "*conc*" },
						{ 2.0, "*drain*" },
						{ 2.0, "*carpark*" },
				}

-- List of world textures to exclude from this effect
local removeList = {
						"",												-- unnamed
						"vehicle*", "remap*",							-- vehicles
						"shad*",										-- shadows
						"coronastar",									-- coronas
						"tx*",											-- grass effect
						"lod*",											-- lod models
						"cj_w_grad",									-- checkpoint texture
						"*cloud*",										-- clouds
						"water*", "sw_sand", "coral",					-- sea
						"sm_des_bush*", "*tree*", "*ivy*", "*pine*",	-- trees and shrubs
						"veg_*", "*largefur*", "hazelbr*", "weeelm",
						"*branch*", "cypress*", "plant*", "sm_josh_leaf",
						"trunk3", "*bark*", "gen_log", "trunk5",
					}

--------------------------------
-- Shader info list
--		List of created shaders
--------------------------------
ShaderInfoList = {}
ShaderInfoList.items = {}

-- Return info for a shader that uses the same strength setting
function ShaderInfoList.getShaderInfoForStrength(strength)
	-- Find exsiting
	for _,info in ipairs(ShaderInfoList.items) do
		if info.strength == strength then
			return info
		end
	end

	-- Create a new shader
	local shader = dxCreateShader ( "shader/roadshine3.fx", 0, maxEffectDistance )
	if not shader then
		outputChatBox( "Could not create shader. Please use debugscript 3" )
		return
	end

	-- Setup shader
	dxSetShaderValue( shader, "sStrength", strength )
	dxSetShaderValue( shader, "sFadeEnd", maxEffectDistance )
	dxSetShaderValue( shader, "sFadeStart", maxEffectDistance/2 )
	-- Add info to list
	table.insert(ShaderInfoList.items, { shader=shader, strength=strength } )
	return ShaderInfoList.items[#ShaderInfoList.items]
end


--------------------------------
-- onClientResourceStart
--------------------------------
addEvent ( "triggerVioShader4", true )
addEventHandler( "triggerVioShader4", getRootElement(),
	function()

		-- Version check
		if getVersion ().sortable < "1.1.1" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		-- Process apply list
		for _,apply in ipairs(applyList) do
			local strength = apply[1]
			local nameMatch = apply[2]
			-- Find or create shader which handles this strength
			local info = ShaderInfoList.getShaderInfoForStrength(strength)
			-- Add this texture name match to the shader
			engineApplyShaderToWorldTexture ( info.shader, nameMatch )
		end

		-- Process remove list
		for _,removeMatch in ipairs(removeList) do
			-- Remove for each shader
			for _,info in ipairs(ShaderInfoList.items) do
				engineRemoveShaderFromWorldTexture ( info.shader, removeMatch )
			end
		end

		-- Update direction all the time
		setTimer( updateShineDirection, 100, 0 )
	end
)



--------------------------------
-- Light source visiblility detector
--		Prevent road shine when in tunnels etc.
--------------------------------
local dectectorPos = 1
local dectectorScore = 0
local detectorList = {
					{ x = -1, y = -1, status = 0 },
					{ x =  0, y = -1, status = 0 },
					{ x =  1, y = -1, status = 0 },

					{ x = -1, y =  0, status = 0 },
					{ x =  0, y =  0, status = 0 },
					{ x =  1, y =  0, status = 0 },

					{ x = -1, y =  1, status = 0 },
					{ x =  0, y =  1, status = 0 },
					{ x =  1, y =  1, status = 0 },
				}

function detectNext ()
	dectectorPos = ( dectectorPos + 1 ) % #detectorList
	dectector = detectorList[dectectorPos+1]

	local lightDirX, lightDirY, lightDirZ = unpack(lightDirection)
	local x, y, z = getElementPosition(localPlayer)

	x = x + dectector.x
	y = y + dectector.y

	local endX = x - lightDirX * 200
	local endY = y - lightDirY * 200
	local endZ = z - lightDirZ * 200

	if dectector.status == 1 then
		dectectorScore = dectectorScore - 1
	end

	dectector.status = isLineOfSightClear ( x,y,z, endX, endY, endZ, true, false, false ) and 1 or 0

	if dectector.status == 1 then
		dectectorScore = dectectorScore + 1
	end

	if dectectorScore < 0 or dectectorScore > 9 then
		outputDebugString ( "dectectorScore: " .. tostring(dectectorScore) )
	end

	-- Enable this to see the 'line of sight' checks
	if false then
		local color = tocolor(255,255,0)
		if dectector.status == 1 then
			color = tocolor(255,0,255)
		end
		dxDrawLine3D ( x,y,z, endX, endY, endZ, color )
	end
end


--------------------------------
-- updateVisibility
--		Handle fading of the effect when the light source is not visible
--------------------------------
local fadeTarget = 1
local fadeCurrent = 1
function updateVisibility ( deltaTicks )
	if not lightDirection then return end

	detectNext ()

	if dectectorScore > 0 then
		fadeTarget = 1
	else
		fadeTarget = 0
	end

	local dif = fadeTarget - fadeCurrent
	local maxChange = deltaTicks / 1000
	dif = math.clamp(-maxChange,dif,maxChange)
	fadeCurrent = fadeCurrent + dif

	-- Update shaders
	for _,info in ipairs(ShaderInfoList.items) do
		dxSetShaderValue( info.shader, "sVisibility", fadeCurrent )
	end

end

addEventHandler( "onClientPreRender", root, updateVisibility )



----------------------------------------------------------------
-- updateShineDirection
--		Tracks the strongest light source
----------------------------------------------------------------

-- Big list describing light direction at a particular game time
shineDirectionList = {
			-- H   M    Direction x, y, z,                  sharpness,	brightness
			{  0,  0,	-0.019183,	0.994869,	-0.099336,	4,			0.0 },			-- Moon fade in start
			{  0, 30,	-0.019183,	0.994869,	-0.099336,	4,			0.25 },			-- Moon fade in end
			{  3, 00,	-0.019183,	0.994869,	-0.099336,	4,			1.0 },			-- Moon bright
			{  6, 30,	-0.019183,	0.994869,	-0.099336,	4,			0.5 },			-- Moon fade out start
			{  6, 39,	-0.019183,	0.994869,	-0.099336,	4,			0.0 },			-- Moon fade out end

			{  6, 40,	-0.914400,	0.377530,	-0.146093,	16,			0.0 },			-- Sun fade in start
			{  6, 50,	-0.914400,	0.377530,	-0.146093,	16,			1.0 },			-- Sun fade in end
			{  7,  0,	-0.891344,	0.377265,	-0.251386,	16,			1.0 },			-- Sun
			{ 10,  0,	-0.678627,	0.405156,	-0.612628,	16,			0.5 },			-- Sun
			{ 13,  0,	-0.303948,	0.490790,	-0.816542,	16,			0.5 },			-- Sun
			{ 16,  0,	 0.169642,	0.707262,	-0.686296,	16,			0.5 },			-- Sun
			{ 18,  0,	 0.380167,	0.893543,	-0.238859,	16,			0.5 },			-- Sun
			{ 18, 30,	 0.398043,	0.911378,	-0.238859,	4,			1.0 },			-- Sun
			{ 18, 53,	 0.360288,	0.932817,	-0.238859,	1,			1.5 },			-- Sun fade out start
			{ 19, 00,	 0.360288,	0.932817,	-0.238859,	1,			0.0 },			-- Sun fade out end

			{ 19, 01,	 0.360288,	0.932817,	-0.612628,	4,			0.0 },			-- General fade in start
			{ 19, 30,	 0.360288,	0.932817,	-0.612628,	4,			0.5 },			-- General fade in end
			{ 21, 00,	 0.360288,	0.932817,	-0.612628,	4,			0.5 },			-- General fade out start
			{ 22, 09,	 0.360288,	0.932817,	-0.612628,	4,			0.0 },			-- General fade out end

			{ 22, 10,	-0.744331,	0.663288,	-0.077591,	32,			0.0 },			-- Star fade in start
			{ 22, 30,	-0.744331,	0.663288,	-0.077591,	32,			0.5 },			-- Star fade in end
			{ 23, 50,	-0.744331,	0.663288,	-0.077591,	32,			0.5 },			-- Star fade out start
			{ 23, 59,	-0.744331,	0.663288,	-0.077591,	32,			0.0 },			-- Star fade out end
			}

function updateShineDirection ()

	-- Get game time
	local h, m, s = getTimeHMS ()
	local fhoursNow = h + m / 60 + s / 3600

	-- Find which two lines in the shineDirectionList to blend between
	for idx,v in ipairs( shineDirectionList ) do
		local fhoursTo = v[1] + v[2] / 60
		if fhoursNow <= fhoursTo then

			-- Work out blend from line
			local vFrom = shineDirectionList[ math.max( idx-1, 1 ) ]
			local fhoursFrom = vFrom[1] + vFrom[2] / 60

			-- Calc blend factor
			local f = math.unlerp( fhoursFrom, fhoursNow, fhoursTo )

			-- Calc final direction, sharpness and brightness
			local x = math.lerp( vFrom[3], f, v[3] )
			local y = math.lerp( vFrom[4], f, v[4] )
			local z = math.lerp( vFrom[5], f, v[5] )
			local sharpness  = math.lerp( vFrom[6], f, v[6] )
			local brightness = math.lerp( vFrom[7], f, v[7] )

			-- Half z component when it gets low
			local thresh = -0.128859
			if z < thresh then
				z = (z - thresh) / 2 + thresh
			end

			lightDirection = { x, y, z }

			-- Update shaders
			for _,info in ipairs(ShaderInfoList.items) do
				dxSetShaderValue( info.shader, "sLightDir", x, y, z )
				dxSetShaderValue( info.shader, "sSpecularPower", sharpness )
				dxSetShaderValue( info.shader, "sSpecularBrightness", brightness )
			end

			break
		end
	end
end



----------------------------------------------------------------
-- getTimeHMS
--		Returns game time including seconds
----------------------------------------------------------------
local timeHMS = {0,0,0}
local minuteStartTickCount
local minuteEndTickCount

function getTimeHMS()
	return unpack(timeHMS)
end

addEventHandler( "onClientRender", root,
	function ()
		local h, m = getTime ()
		local s = 0
		if m ~= timeHMS[2] then
			minuteStartTickCount = getTickCount ()
			local gameSpeed = math.clamp( 0.01, getGameSpeed(), 10 )
			minuteEndTickCount = minuteStartTickCount + 1000 / gameSpeed
		end
		if minuteStartTickCount then
			local minFraction = math.unlerpclamped( minuteStartTickCount, getTickCount(), minuteEndTickCount )
			s = math.min ( 59, math.floor ( minFraction * 60 ) )
		end
		timeHMS = {h, m, s}
		--dxDrawText( string.format("%02d:%02d:%02d",h,m,s), 200, 200 )
	end
)



----------------------------------------------------------------
-- Math helper functions
----------------------------------------------------------------
function math.lerp(from,alpha,to)
    return from + (to-from) * alpha
end

function math.unlerp(from,pos,to)
	if ( to == from ) then
		return 1
	end
	return ( pos - from ) / ( to - from )
end


function math.clamp(low,value,high)
    return math.max(low,math.min(value,high))
end

function math.unlerpclamped(from,pos,to)
	return math.clamp(0,math.unlerp(from,pos,to),1)
end



----------------------------------------------------------------
-- Unhealthy hacks
----------------------------------------------------------------
_dxCreateShader = dxCreateShader
function dxCreateShader( filepath, priority, maxDistance, bDebug )
	priority = priority or 0
	maxDistance = maxDistance or 0
	bDebug = bDebug or false

	-- Slight hack - maxEffectDistance doesn't work properly before build 3236 if fullscreen
	local build = getVersion ().sortable:sub(9)
	local fullscreen = not dxGetStatus ().SettingWindowed
	if build < "03236" and fullscreen then
		maxDistance = 0
	end

	return _dxCreateShader ( filepath, priority, maxDistance, bDebug )
end
