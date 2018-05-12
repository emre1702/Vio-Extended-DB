﻿jobicons["farmer"] = createPickup ( -1058.36, -1195.6, 128.83, 3, 1239, 250 )

addEventHandler ( "onPickupHit", jobicons["farmer"],
	function ( player )
		if not vioGetElementData ( player, "isInFarmJob" ) and not getPedOccupiedVehicle ( player ) then
			if vioGetElementData ( player, "job" ) == "farmer" then
				triggerClientEvent ( player, "showFarmingWindow", player )
			else
				infobox ( player, "Hier kannst du\nals Farmer arbeiten -\ntippe /job, um den\nJob anzunehmen.", 5000, 200, 200, 0 )
			end
		end
	end
)

function farmerJobRecieve ( action )

	local player = client
	
	local sTime = getSecondTime ( 0 )
	vioSetElementData ( player, "lastTimeMarkerHit", sTime - 4 )
	
	local inFarmJob = vioGetElementData ( player, "isInFarmJob" ) == true
	local farmJobCounter = vioGetElementData ( player, "farmJobCounter" )
	if not farmJobCounter then
		vioSetElementData ( player, "farmJobCounter", 0 )
		farmJobCounter = 0
	end
	if action == "skin" then
		if vioGetElementData ( player, "farmerLVL" ) >= 500 then
			setElementModel ( player, 158 )
			vioSetElementData ( player, "skinid", 158 )
		else
			infobox ( player, "Dafuer brauchst du\nFarmer-Level 500!", 5000, 125, 0, 0 )
		end
	elseif action == "job1" then
		if not inFarmJob then
			vioSetElementData ( player, "farmJobCounter", 0 )
			showNextFarmerJobMarker ( player, farmJobCounter, 1 )
			infobox ( player, "Wenn du genug von\nder Arbeit hast, verlasse\neinfach die Farm oder\ntippe /cancel job.", 10000, 200, 200, 0 )
			vioSetElementData ( player, "isInFarmJob", true )
			
			triggerClientEvent ( player, "startFarmingJob", player )
		end
	elseif action == "job2" then
		if not inFarmJob then
			if vioGetElementData ( player, "farmerLVL" ) >= 100 then
				if vioGetElementData ( player, "carlicense" ) == 1 then
					vioSetElementData ( player, "farmJobCounter", 0 )
					showNextFarmerJobMarker ( player, farmJobCounter, 2 )
					infobox ( player, "Wenn du genug von\nder Arbeit hast, verlasse\neinfach die Farm oder\ntippe /cancel job.", 10000, 200, 200, 0 )
					vioSetElementData ( player, "isInFarmJob", true )
					
					local veh = createVehicle ( vehSpawns["id"][1], vehSpawns["x"][1], vehSpawns["y"][1], vehSpawns["z"][1], 0, 0, vehSpawns["rz"][1] )
					warpPedIntoVehicle ( player, veh )
					setVehicleLocked ( veh, true )
					activeCarGhostMode ( player, 5000 )
					addEventHandler ( "onPlayerQuit", player, farmingWorkerQuit )
					addEventHandler ( "onVehicleExit", veh,
						function ( player )
							triggerClientEvent ( player, "cancelFarming", player, "", "farming" )
						end
					)
					vioSetElementData ( player, "farmingJobVeh", veh )
					
					triggerClientEvent ( player, "startFarmingJob", player )
				else
					infobox ( player, "Du hast keinen\nFuehrerschein!", 5000, 200, 0, 0 )
				end
			else
				infobox ( player, "Dafuer brauchst du\nFarmer-Level 100!", 5000, 125, 0, 0 )
			end
		end
	elseif action == "job3" then
		if not inFarmJob then
			if vioGetElementData ( player, "farmerLVL" ) >= 250 then
				if vioGetElementData ( player, "lkwlicense" ) == 1 then
					vioSetElementData ( player, "farmJobCounter", 0 )
					showNextFarmerJobMarker ( player, farmJobCounter, 3 )
					infobox ( player, "Wenn du genug von\nder Arbeit hast, verlasse\neinfach die Farm oder\ntippe /cancel job.", 10000, 200, 200, 0 )
					vioSetElementData ( player, "isInFarmJob", true )
					
					local veh = createVehicle ( vehSpawns["id"][2], vehSpawns["x"][2], vehSpawns["y"][2], vehSpawns["z"][2], 0, 0, vehSpawns["rz"][2] )
					warpPedIntoVehicle ( player, veh )
					setVehicleLocked ( veh, true )
					activeCarGhostMode ( player, 5000 )
					addEventHandler ( "onPlayerQuit", player, farmingWorkerQuit )
					addEventHandler ( "onVehicleExit", veh,
						function ( player )
							triggerClientEvent ( player, "cancelFarming", player, "", "farming" )
						end
					)
					vioSetElementData ( player, "farmingJobVeh", veh )
					
					triggerClientEvent ( player, "startFarmingJob", player )
				else
					infobox ( player, "Du hast keinen\nLKW-Fuehrerschein!", 5000, 200, 0, 0 )
				end
			else
				infobox ( player, "Dafuer brauchst du\nFarmer-Level 250!", 5000, 125, 0, 0 )
			end
		end
	end
end
addEvent ( "farmerJobRecieve", true )
addEventHandler ( "farmerJobRecieve", getRootElement(), farmerJobRecieve )

function showNextFarmerJobMarker ( player, farmJobCounter, i )

	local time = vioGetElementData ( player, "lastTimeMarkerHit" )
	local sTime = getSecondTime ( 0 )
	if true then--not time or time + 2 < sTime then
		farmJobCounter = farmJobCounter + 1
		if farmJobCounter > farmerJobCounter[i] then
			farmJobCounter = 1
			if i == 1 then
				infobox ( player, "Du erhaelst einen\n50 $ Bonus für\nden Acker!", 5000, 0, 200, 0 )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 50 )
			end
		end
		if farmJobCounter / 10 == math.floor ( farmJobCounter / 10 ) then
			if i == 2 then
				infobox ( player, "Du erhaelst 50 $\n10er-Bonus!", 5000, 0, 200, 0 )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 50 )
			elseif i == 3 then
				infobox ( player, "Du erhaelst 100 $\n10er-Bonus!", 5000, 0, 200, 0 )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 100 )
			end
		end
		vioSetElementData ( player, "farmJobCounter", farmJobCounter )
		if i == 2 or i == 3 then
			farmJobCounter = math.random ( 1, farmerJobCounter[i] )
		end
		local x, y, z = farmerJob["x"][i][farmJobCounter], farmerJob["y"][i][farmJobCounter], farmerJob["z"][i][farmJobCounter]
		triggerClientEvent ( player, "showNextFarmerJobMarker", player, x, y, z, i )
		vioSetElementData ( player, "lastTimeMarkerHit", sTime )
	else
		local ip = getPlayerIP ( player )
		local serial = getPlayerSerial ( player )
		local pname = getPlayerName ( player )
		mysql_vio_query ( "INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES ('"..pname.."', 'Anticheat', 'Teleport', '"..timestamp().."', '"..ip.."', '"..serial.."')")
		kickPlayer ( player, "Von: "..pname..", Grund: Teleport (Gebannt!)" )
	end
end

function farmerJobMarkerHit ( typ )

	local player = client
	local farmJobCounter = vioGetElementData ( player, "farmJobCounter" )
	if not farmJobCounter then
		vioSetElementData ( player, "farmJobCounter", 0 )
		farmJobCounter = 0
	end
	
	local player = client
	local farmerLVL = vioGetElementData ( player, "farmerLVL" )
	if typ == 1 then
		vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 7 )
		vioSetElementData ( player, "farmerLVL", farmerLVL + 1 )
		setElementFrozen ( player, true )
		
		setPedAnimation ( player, "BOMBER", "BOM_Plant_Crouch_In", 1500, false, false, false, true )
		setTimer ( setPedAnimation, 1500, 1, player, "BOMBER", "BOM_Plant_Loop", -1, true, false, false, true )
		
		setTimer (
			function ( player )
				if isElement ( player ) then
					setTimer ( setPedAnimation, 1500, 1, player, "BOMBER", "BOM_Plant_Crouch_Out", 1500, false, false, false, true )
					setTimer ( setPedAnimation, 1500, 1, player )
					setTimer ( setElementFrozen, 1500, 1, player, false )
				end
			end,
		3500, 1, player )
		showNextFarmerJobMarker ( player, farmJobCounter, 1 )
	elseif typ == 2 then
		vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 12 )
		vioSetElementData ( player, "farmerLVL", farmerLVL + 2 )
		showNextFarmerJobMarker ( player, farmJobCounter, 2 )
	elseif typ == 3 then
		vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 20 )
		vioSetElementData ( player, "farmerLVL", farmerLVL + 2 )
		showNextFarmerJobMarker ( player, farmJobCounter, 3 )
	end
	if farmerLVL == 100 then
		infobox ( player, "Du hast soeben\nFarmer-\nLevel 100 erreicht -\ndu kannst nun mit\ndem Traktor fahren.", 5000, 0, 200, 0 )
	elseif farmerLVL == 250 then
		infobox ( player, "Du hast soeben\nFarmer-\nLevel 250 erreicht -\ndu kannst nun mit\ndem Mähdrescher\nfahren.", 5000, 0, 200, 0 )
	elseif farmerLVL == 500 then
		infobox ( player, "Du hast soeben Farmer-\nLevel 500 erreicht -\ndu kannst nun das\nFarmeroutfit verwenden.", 5000, 0, 200, 0 )
	end
end
addEvent ( "farmerJobMarkerHit", true )
addEventHandler ( "farmerJobMarkerHit", getRootElement(), farmerJobMarkerHit )

function cancelFarmingJob ( player )

	if isElement ( vioGetElementData ( player, "farmingJobVeh" ) ) then
		destroyElement ( vioGetElementData ( player, "farmingJobVeh" ) )
	end
	vioSetElementData ( player, "farmingJobVeh", false )
	vioSetElementData ( player, "isInFarmJob", false )
	removeEventHandler ( "onPlayerQuit", player, farmingWorkerQuit )
end
addEvent ( "cancelFarmingJob", true )
addEventHandler ( "cancelFarmingJob", getRootElement(),
	function ()
		cancelFarmingJob ( client )
	end
)

function farmingWorkerQuit ()

	cancelFarmingJob ( source )
end

farmerJobCounter = {}
farmerJob = {}
	farmerJob["x"] = {}
	farmerJob["y"] = {}
	farmerJob["z"] = {}
	for i = 1, 3 do
		farmerJob["x"][i] = {}
		farmerJob["y"][i] = {}
		farmerJob["z"][i] = {}
		farmerJobCounter[i] = {}
	end
	vehSpawns = {}
	vehSpawns["id"] = {}
	vehSpawns["x"] = {}
	vehSpawns["y"] = {}
	vehSpawns["z"] = {}
	vehSpawns["rz"] = {}

vehSpawns["id"][1], vehSpawns["x"][1], vehSpawns["y"][1], vehSpawns["z"][1], vehSpawns["rz"][1] = 531, -1209.66, -1074.46, 128.27, 0
vehSpawns["id"][2], vehSpawns["x"][2], vehSpawns["y"][2], vehSpawns["z"][2], vehSpawns["rz"][2] = 532, -1208.90, -1077, 129.3, 0

local i = 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1076.8267822266, -1095.8028564453, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1081.0767822266, -1095.8111572266, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1086.3267822266, -1095.8214111328, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1090.8267822266, -1095.8302001953, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1095.5767822266, -1095.8394775391, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1124.4161376953, -1095.8912353516, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1129.6661376953, -1095.9014892578, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1135.1661376953, -1095.9122314453, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1140.4161376953, -1095.9224853516, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1140.4381103516, -1084.6724853516, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1135.6881103516, -1084.6632080078, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1131.1881103516, -1084.6544189453, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1125.4381103516, -1084.6431884766, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1093.9588623047, -1084.5870361328, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1089.7088623047, -1084.5787353516, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1084.7088623047, -1084.5689697266, 129.21875
i = i + 1
farmerJob["x"][1][i], farmerJob["y"][1][i], farmerJob["z"][1][i] = -1079.2088623047, -1084.5582275391, 129.21875
farmerJobCounter[1] = i


for k = 2, 3 do
	i = 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1186.4422607422, -1048.7531738281, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1141.2381591797, -1040.4450683594, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1170.4658203125, -1014.4703369141, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1124.9495849609, -1003.7154541016, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1077.8615722656, -1044.5467529297, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1029.6094970703, -1014.9261474609, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1069.0817871094, -993.11120605469, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1098.5445556641, -966.50317382813, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1067.2901611328, -945.86016845703, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1025.5504150391, -974.57757568359, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1023.8848876953, -932.43048095703, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1132.4178466797, -934.33734130859, 129.21875
	i = i + 1
	farmerJob["x"][k][i], farmerJob["y"][k][i], farmerJob["z"][k][i] = -1161.5794677734, -962.927734375, 129.21875
	farmerJobCounter[k] = i
end