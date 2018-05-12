weatherNames = {}
weatherNames = { [1]="Bewoelkt",
[2]="Bewoelkt",
[3]="Bewoelkt",
[4]="Bewoelkt",
[5]="Bewoelkt",
[6]="Bewoelkt",
[7]="Bewoelkt",
[8]="Sturm",
[9]="Neblig und Bewoelkt",
[10]="Blauer Himmel",
[11]="Hitzewelle",
[12]="Grau und trist",
[13]="Grau und trist",
[14]="Grau und trist",
[15]="Grau und trist",
[16]="Bewoelkt und verregnet",
[17]="Leichte Hitze",
[18]="Leichte Hitze",
[19]="Sandsturm",
[20]="Neblig und Bewoelkt" }

local w_timer
local u_timer
s = 1000
duration = 1200*s

function weather_func ()

	weather = 19
	outputDebugString ( "Weatherchange" )
	while weather == 19 do
		weather = math.floor ( math.random ( 1, 20 ) )
	end
	if weather >= 1 and weather <= 7 then						--- leicht Bewölkt, kein Regen
		waves = 1 + ( math.random ( -1, 1 ) )
	end
	if weather == 8 then										--- Sturm
		waves = 3.5 + ( math.random ( -3, 3 ) )
	end
	if weather == 9 or weather == 20 then						--- Bewölkt / neblig
		waves = 1.5 + ( math.random ( -0.5, 0.5 ) )
	end
	if weather == 10 then										--- Blauer Himmel, wolkenlos
		waves = 0.5 + ( math.random ( -0.5, 0.5 ) )
	end
	if weather == 11 then										--- Hitzewelle
		waves = 0.5 + ( math.random ( -0.5, 1 ) )
	end
	if weather >= 12 and weather <= 15 then						--- Grau, Farblos usw.
		waves = 1 + ( math.random ( -0.75, 0.5 ) )
	end
	if weather == 16 then										--- Bewölkt, verregnet
		if math.random ( 1, 2 ) == 2 then
			weather_func ()
		else
			waves = 2 + ( math.random ( -0.5, 1.5 ) )
		end
	end
	if weather == 17 or weather == 18 then						--- Leichte Hitze
		waves = 0.5 + ( math.random ( -0.5, 0.5 ) )
	end
	if weather == 8 and math.random ( 1, 9 ) == 9 then
		outputChatBox ( "Unwetterwarnung: Eine starke Unwetterfront erreicht die Stadt in wenigen Minuten.", getRootElement(), 200, 0, 0 )
		outputChatBox ( "Es kann zu extremem Seegang, Blitzschlag sowie Ueberschwemmungen kommen.", getRootElement(), 200, 0, 0 )
		u_timer = setTimer ( changeWeatherUnwetter, 180*s, 1 )
	elseif weather == 8 and math.random ( 1, 2 ) == 2 then
		weather_func ()
	else
		sendMSGForFaction ( "Wetterbericht: In ca. 5 Minuten wird das Wetter sich wie folgt aendern: "..weatherNames[weather].." und Wellenhoehe von bis zu "..waves.." Metern!", 5, 200, 200, 0 )
		w_timer = setTimer ( changeWeather, 300*s, 1, weather, waves )
	end
end
setTimer ( weather_func, wctime*60*s, 1 )

function changeWeather ( weather, waves )

	setWeatherBlended ( weather )
	setWaveHeight ( waves )
	setTimer ( weather_func, wctime*60*s, 1 )
end

function changeWeatherUnwetter ()

	setWeatherBlended ( 8 )
	setWaveHeight ( math.random ( 5, 9 ) )
	
	local height = 0
	
	local southWest_X = -2998
	local southWest_Y = -2998
	local southEast_X = 2998
	local southEast_Y = -2998
	local northWest_X = -2998
	local northWest_Y = 2998
	local northEast_X = 2998
	local northEast_Y = 2998

	water = createWater ( -2998, -2998, height, southEast_X, southEast_Y, height, northWest_X, northWest_Y, height, northEast_X, northEast_Y, height )
	setWaterLevel ( 0 )
	setWaterLevel ( water, 0 )
	
	setTimer ( setWaterLVLHigher, (10*s), 18, water )
	setTimer ( setWaterLVLLowerStart, (10*s)*18+duration, 1, water )
end

function setWaterLVLHigher ( water )

	if isElement ( water ) then
		local x, y, z = getElementPosition ( water )
		local waterlevel = z
		outputDebugString ( x.."|"..y.."|"..z )
		local waterlevel = z + 1
		setWaterLevel ( water, waterlevel )
		setWaterLevel ( waterlevel )
	end
end

function setWaterLVLLowerStart ( water )

	setWaterLVLLowerTimer = setTimer ( setWaterLVLLower, (10*s), 18, water )
end

function setWaterLVLLower ( water )

	if isElement ( water ) then
		local x, y, z = getElementPosition ( water )
		local waterlevel = z
		local waterlevel = z - 1
		if waterlevel <= 0 then
			setWaterLevel ( water, 0 )
			setWaterLevel ( 0 )
			destroyElement ( water )
			setTimer ( weather_func, 20*s, 1 )
			killTimer ( setWaterLVLLowerTimer )
		else
			setWaterLevel ( water, waterlevel )
			setWaterLevel ( waterlevel )
		end
	end
end

function aweather_function ( player )

	if vioGetElementData ( player, "adminlvl" ) >= 4 then
	
		if isTimer( w_timer ) then
			killTimer(w_timer)
		end
		
		if isTimer ( u_timer ) then
			killTimer(u_timer)
		end
	
		weather_func()
		outputChatBox ( "Wetteraenderung ausgeloest!", player, 0, 139, 0 )
		
	else
	
		outputChatBox ( "Nur fuer Adminlevel 4!", player, 250, 0, 0 )
		
	end

end

addCommandHandler ( "aweather", aweather_function )