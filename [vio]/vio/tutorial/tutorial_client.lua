tutorialElements = {}

function startIntro_func ( bot1, bot2 )

	showPlayerHudComponent ( "radar", false )
	showChat ( false )
	
	fadeScreen ( false )
	tutorialElements["guard"] = bot1
	tutorialElements["player"] = bot2
	tutorialElements["car"] = createVehicle ( 405, -754.28, 508.03 + 1 + 0.2, 1371.80, 0, 0, 0 )
	setElementInterior ( tutorialElements["car"], 1 )
	
	local ex, ey, ez = getElementPosition ( bot2 )
	setTimer ( setCameraMatrix, 1000, 1, -772.75, 504.88 - 1, 1376.21, ex, ey, ez )
	
	setTimer ( followElement, 3000, 1, -723.95 - 20, 507.06, 1376.12, tutorialElements["player"] )
	setTimer ( setCameraInterior, 3000, 1, 1 )
	
	setTimer ( scene1Text, 5000, 1 )
end
addEvent ( "startIntro", true )
addEventHandler ( "startIntro", getRootElement(), startIntro_func )

function scene1Text ()

	local time = getRealTime()
	local day = time.monthday
	local month = time.month + 1
	local year = time.year + 1900
	setTimer ( slowDrawText, 2000, 1, "Saint Marcs Bistro,  \nLiberty City,  \n"..day.."."..month.."."..year.."" )
	setTimer ( fadeScreen, 7000, 1, true )
	setTimer ( scene1, 7300, 1 )
end

function scene1 ()

	local rot = findRotation ( -772.75, 504.88, -723.95, 507.06 )
	
	setElementPosition ( tutorialElements["player"], -772.75, 504.88 - 1, 1376.21 )
	setPedRotation ( tutorialElements["player"], rot )
	setElementModel ( tutorialElements["player"], getElementData ( lp, "skinid" ) )
	
	setElementPosition ( tutorialElements["guard"], -777.48, 504.88 - 1, 1376.21 )
	setPedRotation ( tutorialElements["guard"], rot )
	setElementModel ( tutorialElements["guard"], 124 )
	
	playerRoute1 ( tutorialElements["player"], tutorialElements["car"] )
	setTimer ( guardRoute1Step1, 750, 1, tutorialElements["guard"] )
	
	setTimer ( fadeScreen, 7000, 1 )
	setTimer ( scene2, 9000, 1 )
end

function scene2 ()

	clearScene ()
	
	tutorialElements["object"] = createObject ( 1337, -438.64, 368.93, 150 )
	tutorialElements["plane"] = createVehicle ( 577, -438.64, 368.93, 150 - 75, 0, 0, 90 )
	attachElements ( tutorialElements["plane"], tutorialElements["object"] )
	setVehicleEngineState ( tutorialElements["plane"], true )
	slowDrawText ( "Einen Tag spaeter..." )
	setTimer ( moveObject, 4000, 1, tutorialElements["object"], 10000, -438.64, 368.93 + 500, 150 - 75 )
	followElement ( -438.64, 368.93, 160 - 75 + 30 + 15, tutorialElements["plane"] )
	setTimer ( fadeScreen, 4000, 1, true )
	setTimer ( fadeScreen, 8000, 1, false )
	setTimer ( setCameraMatrix, 9000, 1, -1339.39, -224.66, 14.04, 0, 0, 135 )
	setTimer ( setElementInterior, 9000, 1, lp, 0 )
	setTimer ( slowDrawText, 10000, 1, "San Fierro\nInternational Airport" )
	setTimer ( scene3, 15000, 1, false )
end

function scene3 ()

	clearScene ()
	
	fadeScreen ( true )
	
	tutorialElements["plane"] = createVehicle ( 577, -1339.39, -224.66, 14.04, 0, 0, 135 )
	tutorialElements["stairs"] = createVehicle ( 608, -1349.4572753906, -241.16963195801, 14.721450805664, 0, 0, 40 )
	tutorialElements["bus"] = createVehicle ( 431, -1335.4351806641, -255.80674743652, 14.3984375, 0, 0, 136 )
	
	tutorialElements["baggage"] = createVehicle ( 485, -1331.7799072266, -240.2734375, 13.848437309265, 0, 0, 30 )
	tutorialElements["baggage1"] = createVehicle ( 606, -1327.5131835938, -240.70295715332, 14.242143630981, 0, 0, 0 )
	tutorialElements["baggage2"] = createVehicle ( 606, -1330.6516113281, -247.7098236084, 14.242143630981, 0, 0, 357 )
	tutorialElements["baggage3"] = createVehicle ( 607, -1330.7696533203, -243.96444702148, 14.24843788147, 0, 0, 357 )
	
	tutorialElements["tanker"] = createVehicle ( 514, -1318.4530029297, -227.91925048828, 14.848112106323, 0, 0, 38 )
	tutorialElements["tanker1"] = createVehicle ( 584, -1313.2371826172, -236.26127624512, 14.802620887756, 0, 0, 30 )
	attachTrailerToVehicle ( tutorialElements["tanker"], tutorialElements["tanker1"] )
	
	local rot = findRotation ( -1350.30, -240.11, -1335.43, -255.80 )
	tutorialElements["player"] = createPed ( getElementData ( lp, "skinid" ), -1350.30, -240.11, 17.79, rot )
	setPedRotation ( tutorialElements["player"], rot )
	
	tutorialElements["ped1"] = createPed ( 16, -1340.16, -242.37, 13.79 )
	tutorialElements["ped2"] = createPed ( 16, -1340.00, -244.12, 13.79 )
	
	followElement ( -1350.59, -243.96, 13.79, tutorialElements["player"] )
	
	setTimer ( setPedControlState, 400, 1, tutorialElements["player"], "forwards", true )
	setPedControlState ( tutorialElements["player"], "walk", true )
	
	chatPeds ( tutorialElements["ped1"], tutorialElements["ped2"] )
	
	setTimer ( fadeScreen, 9000, 1, false )
	setTimer ( triggerServerEvent, 10000, 1, "intfix", lp )
	setTimer ( 
		function ()
			showPlayerHudComponent ( "radar", true )
			showChat ( true )
		end,
	12000, 1 )
	setTimer ( setCameraTarget, 10000, 1, lp )
	--setTimer ( setElementAlpha, 10000, 1, lp, 255 )
	setTimer ( fadeScreen, 12000, 1, true )
	setTimer ( setPlayerInTutorial_func, 12000, 1 )
end

function clearScene ()

	for key, index in pairs ( tutorialElements ) do
		if isElement ( key ) then
			destroyElement ( key )
		end
	end
	setCameraInterior ( 0 )
	tutorialElements = {}
end

--[[

----SZENE 3----" doublesided="false" model="1337" interior="0" dimension="0                 -1328.9291992188, -209.07664489746, 13.797662734985, 0, 0, 0
AT-400" paintjob="3" model="577" plate="6HS7AFS" interior="0" dimension="0                 -1339.3935546875, -224.6630859375, 14.04842376709, 0, 0, 135
stairs" paintjob="3" model="608" plate="NJP1IF1" interior="0" dimension="0                 -1349.4572753906, -241.16963195801, 14.721450805664, 0, 0, 40
Campos3" doublesided="false" model="1337" interior="0" dimension="0                 -1350.5985107422, -243.96589660645, 13.797662734985, 0, 0, 0
PlayerPos4" doublesided="false" model="1337" interior="0" dimension="0                 -1350.3068847656, -240.11486816406, 17.797662734985, 0, 0, 0
PlayerPos5" doublesided="false" model="1337" interior="0" dimension="0                 -1330.5009765625, -262.693359375, 13.797662734985, 0, 0, 0
Bus" paintjob="3" model="431" plate="4G5U89F" interior="0" dimension="0                 -1335.4351806641, -255.80674743652, 14.3984375, 0, 0, 136

Baggage" paintjob="3" model="485" plate="HYHL756" interior="0" dimension="0                 -1331.7799072266, -240.2734375, 13.848437309265, 0, 0, 30
BaggageTrailer3" paintjob="3" model="606" plate="QB0FS0D" interior="0" dimension="0                 -1327.5131835938, -240.70295715332, 14.242143630981, 0, 0, 0
BaggageTrailer2" paintjob="3" model="606" plate="AE7N4YA" interior="0" dimension="0                 -1330.6516113281, -247.7098236084, 14.242143630981, 0, 0, 357
BaggageTrailer1" paintjob="3" model="607" plate="9O4YS0V" interior="0" dimension="0                 -1330.7696533203, -243.96444702148, 14.24843788147, 0, 0, 357

Tanker" paintjob="3" model="514" plate="THSU0EY" interior="0" dimension="0                 -1318.4530029297, -227.91925048828, 14.848112106323, 0, 0, 38
TankerTrailer" paintjob="3" model="584" plate="MQF38HG" interior="0" dimension="0                 -1313.2371826172, -236.26127624512, 14.802620887756, 0, 0, 30

Civ1" doublesided="false" model="1337" interior="0" dimension="0                 -1340.1655273438, -242.3727722168, 13.797662734985, 0, 0, 0
Civ2" doublesided="false" model="1337" interior="0" dimension="0                 -1340.0096435547, -244.12837219238, 13.797662734985, 0, 0, 0

Security1" doublesided="false" model="1337" interior="14" dimension="0                 -1875.6363525391, 52.43042755127, 1054.8409423828, 0, 0, 0
Security2" doublesided="false" model="1337" interior="14" dimension="0                 -1847.2290039063, 53.007934570313, 1054.8409423828, 0, 0, 0
ChatterIndoor2" doublesided="false" model="1337" interior="14" dimension="0                 -1881.2846679688, 56.253040313721, 1054.8409423828, 0, 0, 0
ChatterIndoor1" doublesided="false" model="1337" interior="14" dimension="0                 -1882.8354492188, 54.725475311279, 1054.8409423828, 0, 0, 0

]]