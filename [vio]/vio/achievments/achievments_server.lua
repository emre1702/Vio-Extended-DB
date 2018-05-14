local function loadPlayingTimeForSleeplessAchiev_DB ( qh, player, name )
	local result = dbPoll( qh, 0 )
	local time = 0
	if result and result[1] then
		time = result[1]["Time"]
	else
		dbExec( handler, "INSERT INTO playingtime ( Name ) VALUES ( ? )", pname )
	end
	vioSetElementData ( player, "timePlayedToday", time )
end

function loadPlayingTimeForSleeplessAchiev ( player, pname )
	dbQuery( loadPlayingTimeForSleeplessAchiev_DB, { player, name }, handler, "SELECT Time FROM playingtime WHERE Name LIKE ?", pname )
end

function savePlayingTimeForSleeplessAchiev ( player, pname )

	local time = vioGetElementData ( player, "timePlayedToday" )
	dbExec ( handler, "UPDATE playingtime SET Time = ? WHERE Name LIKE ?", time, pname )
end

function playingTimeResetAtMidnight ()

	dbExec ( handler, "TRUNCATE TABLE playingtime" )
	for key, index in pairs ( getElementsByType ( "player" ) ) do
		if vioGetElementData ( key, "loggedin" ) then
			loadPlayingTimeForSleeplessAchiev ( key, getPlayerName ( key ) )
		end
	end
end

local function lookoutFound_func_DB ( qh, id ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local dataString = result[1]["LookoutsA"]
		if tonumber ( gettok ( dataString, id, string.byte ( '|' ) ) ) == 0 then
			local newstring = ""
			for i = 1, 10 do
				if i == id then
					newstring = newstring.."1".."|"
				else
					newstring = newstring..gettok ( dataString, i, string.byte ( '|' ) ).."|"
				end
			end
			local count = 0
			for i = 1, 10 do
				if tonumber ( gettok ( newstring, i, string.byte ( '|' ) ) ) == 1 then
					count = count + 1
				end
			end
			vioSetElementData ( player, "bonuspoints", vioGetElementData ( player, "bonuspoints" ) + 10 )
			vioSetElementData ( player, "viewpoints", count )
			triggerClientEvent ( player, "showAchievmentBox", player, " Aussichts-\n punkt\n gefunden!", 10, 10000 )
			dbExec( handler, "UPDATE achievments SET LookoutsA = ? WHERE Name LIKE ?", newstring, pname )
		end
	end
end

function lookoutFound_func ( id )

	local player = client
	local pname = getPlayerName ( player )
	dbQuery( lookoutFound_func, { id }, handler, "SELECT LookoutsA FROM achievments WHERE Name LIKE ?", pname )
end
addEvent ( "lookoutFound", true )
addEventHandler ( "lookoutFound", getRootElement(), lookoutFound_func )

function casinoAchievCheck ( player, amount )

	local pname = getPlayerName ( player )
	if amount >= 100000 then
		if vioGetElementData ( player, "chickendinner_achiev" ) == 0 then
			vioSetElementData ( player, "bonuspoints", vioGetElementData ( player, "bonuspoints" ) + 15 )
			triggerClientEvent ( player, "showAchievmentBox", player, " Chicken\n Dinner!", 15, 10000 )
			vioSetElementData ( player, "chickendinner_achiev", 1 )
			dbExec( handler, "UPDATE achievments SET ChickenDinner = '1' WHERE Name LIKE ?", pname )
		end
	elseif amount <= -100000 then
		if vioGetElementData ( player, "nichtsgehtmehr_achiev" ) == 0 then
			vioSetElementData ( player, "bonuspoints", vioGetElementData ( player, "bonuspoints" ) + 15 )
			triggerClientEvent ( player, "showAchievmentBox", player, " Nichts geht\n mehr!", 15, 10000 )
			vioSetElementData ( player, "nichtsgehtmehr_achiev", 1 )
			dbExec( handler, "UPDATE achievments SET NichtGehtMehr = '1' WHERE Name LIKE ?", pname )
		end
	end
end

function ReallifeAchievCheck ( player )

	if tonumber ( vioGetElementData ( player, "playingtime" ) ) >= 10000 and vioGetElementData ( player, "rl_achiev" ) ~= "done" then							-- Achiev: Collector
		vioSetElementData ( player, "rl_achiev", "done" )																									-- Achiev: Collector
		triggerClientEvent ( player, "showAchievmentBox", player, " Reallife -\n WTF?!", 50, 10000 )													-- Achiev: Collector
		vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 50 )												-- Achiev: Collector
		dbExec( handler, "UPDATE achievments SET ReallifeWTF = ? WHERE Name LIKE ?", vioGetElementData ( player, "rl_achiev" ), getPlayerName( player ) )
	end																																					-- Achiev: Collector
end

function OwnFootCheck ( player )

	if vioGetElementData ( player, "own_foots" ) ~= "done" then
		vioSetElementData ( player, "own_foots", "done" )																									-- Achiev: Own Foots
		triggerClientEvent ( player, "showAchievmentBox", player, " Eigene\n Fueße!", 15, 10000 )														-- Achiev: Own Foots
		vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 15 )												-- Achiev: Own Foots
		dbExec( handler, "UPDATE achievments SET EigeneFuesse = ? WHERE Name LIKE ?", vioGetElementData ( player, "own_foots" ), getPlayerName( player ) )
	end
end

KingofTheHill = createMarker ( -2316.7216796875, -1661.7271728516, 483.32159423828, "corona", 200, 0, 0, 0, 0, getRootElement() )
function KingofTheHillCheck ( hitElement )

	if getElementType ( hitElement ) == "vehicle" then 
		player = getVehicleOccupant ( hitElement, 0 ) 
	else
		if getElementType ( hitElement ) == "player" then 
			player = hitElement
		else
			player = nil
		end
	end
	if player then
		if vioGetElementData ( player, "kingofthehill_achiev" ) ~= "done" then
			vioSetElementData ( player, "kingofthehill_achiev", "done" )																						-- Achiev: King of the Hill
			triggerClientEvent ( player, "showAchievmentBox", player, " King of\n the Hill!", 15, 10000 )													-- Achiev: King of the Hill
			vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 15 )												-- Achiev: King of the Hill
			dbExec( handler, "UPDATE achievments SET KingOfTheHill = ? WHERE Name LIKE ?", vioGetElementData ( player, "kingofthehill_achiev" ), getPlayerName( player ) )
		end
	end
end
addEventHandler ( "onMarkerHit", KingofTheHill, KingofTheHillCheck )

function checkCarWahnAchiev ()

	
end

function HighwayToHellCheck ( veh )

	local player = source
	if vioGetElementData ( player, "highwaytohell_achiev" ) ~= "done" then
		if veh then
			if bikerskins[getElementModel(player)] and getElementModel ( veh ) == 463 then
				triggerClientEvent ( player, "showAchievmentBox", player, " Born to\n be Wild!", 10, 10000 )													-- Achiev: Born to be Wild!
				vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 10 )
				vioSetElementData ( player, "highwaytohell_achiev", "done" )
				dbExec( handler, "UPDATE achievments SET HighwayToHell = ? WHERE Name LIKE ?", vioGetElementData ( player, "highwaytohell_achiev" ), getPlayerName( player ) )
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), HighwayToHellCheck )