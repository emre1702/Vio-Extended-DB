﻿MySQLCarhouseNames = {}
 MySQLCarhouseNames[1] = "San Fierro\nAirport"
 MySQLCarhouseNames[2] = "Wang Cars"
 MySQLCarhouseNames[3] = "Otto's Autos"
 MySQLCarhouseNames[4] = "Bayside Boats"
 MySQLCarhouseNames[5] = "Las Venturas\nAirport"
 MySQLCarhouseNames[6] = "$HODY USED AUTOS"
 MySQLCarhouseNames[7] = "Auto Bahn"
 MySQLCarhouseNames[8] = "Bonusfahrzeuge\n( See )"
 MySQLCarhouseNames[9] = "Bonusfahrzeuge\n( Land )"
 MySQLCarhouseNames[10] = "Auto Bahn"
 MySQLCarhouseNames[11] = "Kleinstadt-\nhaendler"

MySQLCarhouseBlips = {}
 MySQLCarhouseBlips["Otto's Autos"] = 55
 MySQLCarhouseBlips["Wang Cars"] = 55
 MySQLCarhouseBlips["San Fierro\nAirport"] = 5
 MySQLCarhouseBlips["Bayside Boats"] = 9
 MySQLCarhouseBlips["Las Venturas\nAirport"] = 5
 MySQLCarhouseBlips["$HODY USED AUTOS"] = 55
 MySQLCarhouseBlips["Auto Bahn"] = 55
 MySQLCarhouseBlips["Bonusfahrzeuge\n( See )"] = 51
 MySQLCarhouseBlips["Bonusfahrzeuge\n( Land )"] = 99
 MySQLCarhouseBlips["Auto Bahn"] = 55
 MySQLCarhouseBlips["Kleinstadt-\nhaendler"] = 55

MySQLCarhouseBlipRanges = {}
 MySQLCarhouseBlipRanges["Otto's Autos"] = 200
 MySQLCarhouseBlipRanges["Wang Cars"] = 999999
 MySQLCarhouseBlipRanges["San Fierro\nAirport"] = 200
 MySQLCarhouseBlipRanges["Bayside Boats"] = 200
 MySQLCarhouseBlipRanges["Las Venturas\nAirport"] = 200
 MySQLCarhouseBlipRanges["$HODY USED AUTOS"] = 200
 MySQLCarhouseBlipRanges["Auto Bahn"] = 200
 MySQLCarhouseBlipRanges["Bonusfahrzeuge\n( See )"] = 200
 MySQLCarhouseBlipRanges["Bonusfahrzeuge\n( Land )"] = -1
 MySQLCarhouseBlipRanges["Auto Bahn"] = 200
 MySQLCarhouseBlipRanges["Kleinstadt-\nhaendler"] = 200

badMySQLCarHouseXSpawns = {}
badMySQLCarHouseYSpawns = {}
MySQLCarhouses = {}
MySQLCarInfos = {}
MySQLCarHousesCars = {}

function createCarhouses ()

	result = mysql_query ( handler, "SELECT * FROM carhouses_icons" )
	if ( mysql_num_rows ( result ) > 0 ) then
		carHousesData = mysql_fetch_assoc ( result )
		mySQLCarhouseCreate ()
	else
		mysql_free_result ( result )
		outputServerLog ( "Es wurden keine Autohaeuser gefunden" )
	end
end

function createVehiclesForCarhouses ()

	result = mysql_query ( handler, "SELECT * FROM carhouses_vehicles" )
	if ( mysql_num_rows ( result ) > 0 ) then
		carHouseVehicleData = mysql_fetch_assoc ( result )
		mySQLCarhouseVehicleCreate ()
	else
		mysql_free_result ( result )
		outputServerLog ( "Es wurden keine Autohaus-Fahrzeuge gefunden" )
	end
end

function mySQLCarhouseVehicleCreate ()

	local ID = tonumber ( carHouseVehicleData["AutohausID"] )
	local x = tonumber ( carHouseVehicleData["X"] )
	local y = tonumber ( carHouseVehicleData["Y"] )
	local z = tonumber ( carHouseVehicleData["Z"] )
	local rx = tonumber ( carHouseVehicleData["RX"] )
	local ry = tonumber ( carHouseVehicleData["RY"] )
	local rz = tonumber ( carHouseVehicleData["RZ"] )
	local price = tonumber ( carHouseVehicleData["Preis"] )
	local typ = tonumber ( carHouseVehicleData["Typ"] )
	local info = carHouseVehicleData["Info"]
	
	if not carprices[typ] then
		carprices[typ] = price
	end
	MySQLCarInfos[typ] = info
	
	MySQLCarhouses[ID]["counter"] = MySQLCarhouses[ID]["counter"] + 1
	local i = MySQLCarhouses[ID]["counter"]
	MySQLCarhouses[ID]["vehicles"][i] = createVehicle ( typ, x, y, z, rx, ry, rz )
	setVehicleStatic ( MySQLCarhouses[ID]["vehicles"][i], true )
	
	addEventHandler ( "onVehicleRespawn", MySQLCarhouses[ID]["vehicles"][i], 
		function ()
			setVehicleStatic ( source, true )
		end )
	
	MySQLCarHousesCars[typ] = true
	
	carHouseVehicleData = mysql_fetch_assoc ( result )
	if carHouseVehicleData then
		mySQLCarhouseVehicleCreate ()
	else
		mysql_free_result ( result )
	end
end

function mySQLCarhouseCreate ()

	local Name = carHousesData["Name"]
	local ID = carHousesData["ID"]
	local x, y, z = carHousesData["X"], carHousesData["Y"], carHousesData["Z"]
	local sx, sy, sz, srx, sry, srz = carHousesData["SpawnX"], carHousesData["SpawnY"], carHousesData["SpawnZ"], carHousesData["SpawnRX"], carHousesData["SpawnRY"], carHousesData["SpawnRZ"]
	ID = tonumber ( ID )
	x, y, z = tonumber ( x ), tonumber ( y ), tonumber ( z )
	sx, sy, sz, srx, sry, srz = tonumber ( sx ), tonumber ( sy ), tonumber ( sz ), tonumber ( srx ), tonumber ( sry ), tonumber ( srz )
	
	MySQLCarhouses[ID] = {}
	MySQLCarhouses[ID]["pickup"] = createPickup ( x, y, z, 3, 1274, 0 )
	MySQLCarhouses[ID]["vehicles"] = {}
	MySQLCarhouses[ID]["counter"] = 0
	MySQLCarhouses[ID]["Name"] = Name
	MySQLCarhouses[ID]["sx"] = sx
	MySQLCarhouses[ID]["sy"] = sy
	MySQLCarhouses[ID]["sz"] = sz
	MySQLCarhouses[ID]["srx"] = srx
	MySQLCarhouses[ID]["sry"] = sry
	MySQLCarhouses[ID]["srz"] = srz
	
	badMySQLCarHouseXSpawns[math.floor ( sx )] = true
	badMySQLCarHouseYSpawns[math.floor ( sy )] = true
	
	if MySQLCarhouseBlipRanges[MySQLCarhouseNames[ID]] > 0 then
		createBlip ( x, y, z, MySQLCarhouseBlips[MySQLCarhouseNames[ID]], 1, 0, 0, 0, 255, 0, MySQLCarhouseBlipRanges[MySQLCarhouseNames[ID]] )
	end
	
	vioSetElementData ( MySQLCarhouses[ID]["pickup"], "ID", ID )
	
	addEventHandler ( "onPickupHit", MySQLCarhouses[ID]["pickup"],
		function ( player )
			if getElementType ( player ) == "player" then
				if not vioGetElementData ( player, "isInCarHouse" ) then
					if not getPedOccupiedVehicle ( player ) then
						vioSetElementData ( player, "isInCarHouse", true )
						MySQLCarhouseEnter ( player, vioGetElementData ( source, "ID" ) )
					end
				end
			end
		end
	)
	
	carHousesData = mysql_fetch_assoc ( result )
	if carHousesData then
		mySQLCarhouseCreate ()
	else
		mysql_free_result ( result )
		outputServerLog ( "Es wurden "..( #MySQLCarhouses ).." Autohaeuser gefunden!")
		createVehiclesForCarhouses ()
	end
end

function MySQLCarhouseEnter ( player, ID )

	triggerClientEvent ( player, "showCarhouseInfo", player, MySQLCarhouses[ID]["Name"] )
	vioSetElementData ( player, "lookingAtCar", 1 )
	vioSetElementData ( player, "carHouse", ID )
	
	setElementFrozen ( player, true )
	
	bindMySQLCarKeys ( player )
	
	setTimer ( setCarhouseCamSight, 2000, 1, player )
end

function bindMySQLCarKeys ( player )

	bindKey ( player, "enter", "down", buyMySQLCarhouseCar )
	bindKey ( player, "space", "down", leaveMySQLCarhouseCar )
	
	bindKey ( player, "arrow_r", "down", MySQLCarhouseRight )
	bindKey ( player, "arrow_l", "down", MySQLCarhouseLeft )
	
	toggleControl ( player, "enter_exit", false )
end
function unbindMySQLCarKeys ( player )

	unbindKey ( player, "enter", "down", buyMySQLCarhouseCar )
	unbindKey ( player, "space", "down", leaveMySQLCarhouseCar )
	
	unbindKey ( player, "arrow_r", "down", MySQLCarhouseRight )
	unbindKey ( player, "arrow_l", "down", MySQLCarhouseLeft )
	
	setTimer ( toggleControl, 1000, 1, player, "enter_exit", true )
end

function MySQLCarhouseLeft ( player )

	local car = vioGetElementData ( player, "lookingAtCar" )
	local id = vioGetElementData ( player, "carHouse" )
	local count = MySQLCarhouses[id]["counter"]

	if car == 1 then
		vioSetElementData ( player, "lookingAtCar", count )
	else
		vioSetElementData ( player, "lookingAtCar", vioGetElementData ( player, "lookingAtCar" ) - 1 )
	end
	setCarhouseCamSight ( player )
end
function MySQLCarhouseRight ( player )

	local car = vioGetElementData ( player, "lookingAtCar" )
	local id = vioGetElementData ( player, "carHouse" )
	local count = MySQLCarhouses[id]["counter"]
	
	if count > car then
		vioSetElementData ( player, "lookingAtCar", vioGetElementData ( player, "lookingAtCar" ) + 1 )
	else
		vioSetElementData ( player, "lookingAtCar", 1 )
	end
	setCarhouseCamSight ( player )
end

function leaveMySQLCarhouseCar ( player )

	setElementFrozen ( player, false )
	vioSetElementData ( player, "isInCarHouse", false )
	triggerClientEvent ( player, "leaveCarhouse", player )
	unbindMySQLCarKeys ( player )
	setTimer ( setCameraTarget, 1000, 1, player, player )
end

function buyMySQLCarhouseCar ( player )

	setElementFrozen ( player, false )
	local x, y, z = getElementPosition ( player )
	
	vioSetElementData ( player, "isInCarHouse", false )
	setCameraTarget ( player, player )
	triggerClientEvent ( player, "leaveCarhouse", player )
	unbindMySQLCarKeys ( player )

	local car = vioGetElementData ( player, "lookingAtCar" )
	local id = vioGetElementData ( player, "carHouse" )
	local veh = MySQLCarhouses[id]["vehicles"][car]
	
	local typ = getElementModel ( veh )
	local sx, sy, sz, rx, ry, rz = MySQLCarhouses[id]["sx"], MySQLCarhouses[id]["sy"], MySQLCarhouses[id]["sz"], MySQLCarhouses[id]["srx"], MySQLCarhouses[id]["sry"], MySQLCarhouses[id]["srz"]
	
	carbuy ( player, 0, typ, sx, sy, sz, rx, ry, rz )
end

function setCarhouseCamSight ( player )

	local x, y, z = getElementPosition ( player )
	local car = vioGetElementData ( player, "lookingAtCar" )
	local id = vioGetElementData ( player, "carHouse" )
	local veh = MySQLCarhouses[id]["vehicles"][car]
	local typ = getElementModel ( veh )
	local x, y, z = getElementPosition ( veh )
	local addx, addy, addz = 2, 4, 2
	local model = getElementModel ( veh )
	if motorboats[model] or raftboats[model] or planea[model] or planeb[model] or helicopters[model] then
		addx, addy, addz = 4, 6, 10
	end
	setCameraMatrix ( player, x + addx, y + addy, z + addz, x, y, z )
	
	local name = tostring ( getVehicleName ( veh ) )
	local price = carprices[typ]
	local info = MySQLCarInfos[typ]
	
	triggerClientEvent ( player, "displayCarData", player, name, price, info )
end

createCarhouses ()