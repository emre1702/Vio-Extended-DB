serverRestartedAMinuteAgo = true
setTimer (
	function ()
		serverRestartedAMinuteAgo = false
	end,
5000, 1 )

setTimer ( 
	function ()
		client = nil
	end,
1000, -1 )

function joinHandler ()

	setElementDimension ( source, 5 )
    fadeCamera( source, true)
    setCameraTarget( source, source )
	
	if isWithinNightTime () then
		setCameraMatrix ( source, 2100.9990234375, 1003.1977539063, 56.554607391357, 2021.591796875, 1007.6619873047, 17.013711929321, 0, 70 )
	else
		setCameraMatrix ( source, -2681.7158203125, 1934.0498046875, 216.9231262207, -2681.8959960938, 1834.5554199219, 204.25393676758, 0, 70 )
	end
	syncInvulnerablePedsWithPlayer ( source )
end
addEventHandler ( "onPlayerJoin", getRootElement(), joinHandler )

function getServerSlotCount ()

	triggerClientEvent ( client, "recieveServerSlotCount", client, getMaxPlayers () )
end
addEvent ( "getServerSlotCount", true )
addEventHandler ( "getServerSlotCount", getRootElement(), getServerSlotCount )

invalidChars = {}
for i = 33, 39 do
invalidChars[i] = true
end
for i = 40, 43 do
invalidChars[i] = true
end
invalidChars[47] = true
for i = 58, 64 do
invalidChars[i] = true
end
invalidChars[92] = true
invalidChars[94] = true
invalidChars[96] = true
for i = 123, 126 do
invalidChars[i] = true
end

function hasInvalidChar ( player )

	name = getPlayerName ( player )
	for i, index in pairs ( invalidChars ) do
		if not gettok ( name, 1, i ) or gettok ( name, 1, i ) ~= name then
			return true
		end
	end
	return false
end

function serverstart ()

	setGameType ( "Vio Extended" )
	setMapName ( "San Andreas" )
	lastadtime = 0
	for i = 1, 14 do
		_G["arenaSlot"..i.."Occupied"] = false
	end
	setTimer ( mainTimer, 50000, -1 )
	deleteAllFromLoggedIn ()
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource() ), serverstart )

function mainTimer ()

	local curtime = getRealTime()
	local hour = curtime.hour
	local minute = curtime.minute
	local weekday = curtime.weekday
	
	if weekday == 3 or weekday == 6 then
		if hour == 19 and math.floor ( minute / 10 ) == minute / 10 then
			outputChatBox ( "Heute um 20:00 findet die Lottoziehung statt! Falls du noch kein Los hast,", getRootElement(), 200, 200, 0 )
			outputChatBox ( "kannst du noch eins bei der Liberty-Tree-Redaktion erstehen - Aktueller Jackpot: "..lottoJackpot, getRootElement(), 200, 200, 0 )
		elseif hour == 20 and minute == 0 then
			drawLottoWinners ()
		end
	end
	
	if hour == 4 and minute == 0 then
		if weekday == 6 then
			mysql_vio_query ( "UPDATE racing SET Name = 'none', MilliSekunden = '0', Sekunden = '0', Minuten = '3'" )
		end
		mysql_vio_query ( "DELETE FROM warns WHERE extends <= '"..curtime.timestamp.."'" )
		restartServer()
	elseif hour == 3 and minute == 55 then
		outputChatBox ( "ACHTUNG: Server startet neu in 5 Minuten!", getRootElement(), 200, 20, 20 )
		local time = getRealTime()
		if time.weekday == 6 then
			local result = mysql_query ( handler, "TRUNCATE TABLE weed" )
			mysql_free_result ( result )
		end
	elseif hour == 0 and minute == 0 then
		playingTimeResetAtMidnight ()
	end
end
setFPSLimit ( 50 )

function output ()

	print ( getSecondTime ( 0 ) )
end
addCommandHandler ( "output", output )



-- Vehicle-Handling-File-Creation --
--[[local veh, fileData, handlingData, handlingDataNames, file
handlingDataNames = {}
	handlingDataNames["mass"] = true
	handlingDataNames["turnMass"] = true
	handlingDataNames["numberOfGears"] = true
	handlingDataNames["maxVelocity"] = true
	handlingDataNames["engineAcceleration"] = true
	handlingDataNames["engineInertia"] = true
	handlingDataNames["engineType"] = true
	handlingDataNames["brakeDeceleration"] = true
	handlingDataNames["collisionDamageMultiplier"] = true

fileData = "defaultVehicleHandlingData = {}"
file = fileCreate ( "handling_settings.lua" )
for i = 400, 611 do
	veh = createVehicle ( i, 0, 0, 0 )
	if isElement ( veh ) then
		handlingData = getVehicleHandling ( veh )
		
		fileData = fileData.."\n\tdefaultVehicleHandlingData["..i.."] = {}"
		
		for prop, index in pairs ( handlingDataNames ) do
			fileData = fileData.."\n\t\tdefaultVehicleHandlingData["..i.."][\""..prop.."\"] = "
			if type ( handlingData[prop] ) == "number" then
				fileData = fileData..handlingData[prop]
			else
				fileData = fileData.."\""..handlingData[prop].."\""
			end
		end
		
		fileData = fileData.."\n"
		
		destroyElement ( veh )
	end
end
fileWrite ( file, fileData )
fileClose ( file )]]