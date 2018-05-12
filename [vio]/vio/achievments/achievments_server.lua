function loadPlayingTimeForSleeplessAchiev ( player, pname )

	local result = mysql_query ( handler, "SELECT Time from playingtime WHERE Name LIKE '"..pname.."'" )
	if mysql_num_rows ( result ) > 0 then
		dsatz = mysql_fetch_assoc ( result )
		time = dsatz["Time"]
	else
		result = mysql_query ( handler, "INSERT INTO playingtime ( Name ) VALUES ( '"..pname.."' )" )
		time = 0
	end
	mysql_free_result ( result )
	vioSetElementData ( player, "timePlayedToday", time )
end

function savePlayingTimeForSleeplessAchiev ( player, pname )

	local time = vioGetElementData ( player, "timePlayedToday" )
	mysql_vio_query ( "UPDATE playingtime SET Time = '"..time.."' WHERE Name LIKE '"..pname.."'" )
end

function playingTimeResetAtMidnight ()

	local result = mysql_query ( handler, "TRUNCATE TABLE playingtime" )
	mysql_free_result ( result )
	for key, index in pairs ( getElementsByType ( "player" ) ) do
		if vioGetElementData ( key, "loggedin" ) then
			loadPlayingTimeForSleeplessAchiev ( key, getPlayerName ( key ) )
		end
	end
end

function lookoutFound_func ( id )

	local player = client
	local pname = getPlayerName ( player )
	local dataString = MySQL_GetString ( "achievments", "LookoutsA", "Name LIKE '"..pname.."' " )
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
		MySQL_SetString ( "achievments", "LookoutsA", newstring, "Name LIKE '"..pname.."' " )
	end
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
			MySQL_SetString ( "achievments", "ChickenDinner", 1, "Name LIKE '"..pname.."'" )
		end
	elseif amount <= -100000 then
		if vioGetElementData ( player, "nichtsgehtmehr_achiev" ) == 0 then
			vioSetElementData ( player, "bonuspoints", vioGetElementData ( player, "bonuspoints" ) + 15 )
			triggerClientEvent ( player, "showAchievmentBox", player, " Nichts geht\n mehr!", 15, 10000 )
			vioSetElementData ( player, "nichtsgehtmehr_achiev", 1 )
			MySQL_SetString ( "achievments", "NichtGehtMehr", 1, "Name LIKE '"..pname.."'" )
		end
	end
end

function ReallifeAchievCheck ( player )

	if tonumber ( vioGetElementData ( player, "playingtime" ) ) >= 10000 and vioGetElementData ( player, "rl_achiev" ) ~= "done" then							-- Achiev: Collector
		vioSetElementData ( player, "rl_achiev", "done" )																									-- Achiev: Collector
		triggerClientEvent ( player, "showAchievmentBox", player, " Reallife -\n WTF?!", 50, 10000 )													-- Achiev: Collector
		vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 50 )												-- Achiev: Collector
		MySQL_SetString("achievments", "ReallifeWTF", vioGetElementData ( player, "rl_achiev" ), "Name LIKE '"..getPlayerName(player).."'")
	end																																					-- Achiev: Collector
end

function OwnFootCheck ( player )

	if vioGetElementData ( player, "own_foots" ) ~= "done" then
		vioSetElementData ( player, "own_foots", "done" )																									-- Achiev: Own Foots
		triggerClientEvent ( player, "showAchievmentBox", player, " Eigene\n Fueße!", 15, 10000 )														-- Achiev: Own Foots
		vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 15 )												-- Achiev: Own Foots
		MySQL_SetString("achievments", "EigeneFuesse", vioGetElementData ( player, "own_foots" ), "Name LIKE '"..getPlayerName(player).."'")
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
			MySQL_SetString("achievments", "KingOfTheHill", vioGetElementData ( player, "kingofthehill_achiev" ), "Name LIKE '"..getPlayerName(player).."'")
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
				MySQL_SetString("achievments", "HighwayToHell", vioGetElementData ( player, "highwaytohell_achiev" ), "Name LIKE '"..getPlayerName(player).."'")
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), HighwayToHellCheck )