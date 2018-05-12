-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

function isWithinNightTime ()

	local time = getRealTime()
	local hour = time.hour
	if hour >= 20 or hour <= 8 then
		return true
	else
		return false
	end
end

gButtons = {}
gEdit = {}
gImage = {}

function showVersionInfo ()

	dxDrawText ( "Vio Extended  v. "..curVersion.." ", screenwidth-375-3, screenheight-275+155-3, 375, screenheight, tocolor ( 0, 0, 0 ), 2, "pricedown", "left", "top" )
	if isHalloween then
		dxDrawText ( "Vio Extended  v. "..curVersion.." ", screenwidth-375, screenheight-275+155, 375, screenheight, tocolor ( 210, 105, 30 ), 2, "pricedown", "left", "top" )
	else
		dxDrawText ( "Vio Extended  v. "..curVersion.." ", screenwidth-375, screenheight-275+155, 375, screenheight, tocolor ( 160, 160, 220 ), 2, "pricedown", "left", "top" )
	end
end

function SubmitPasswortLoginEdit(button)
	if button == "left" then
		if guiGetText ( gEdit["passwort_login"] ) == "******" then
			guiSetText ( gEdit["passwort_login"], "" )
		end
	end
end

function guiShowLoginAgain_func ()
	guiSetVisible ( LoginWindow, true )
	guiSetText ( gEdit["passwort_login"], "" )
end
addEvent ( "guiShowLoginAgain", true )
addEventHandler ( "guiShowLoginAgain", getRootElement(), guiShowLoginAgain_func )

function SubmitEinloggenBtn()

	if guiGetVisible ( LoginWindow ) then
		guiSetVisible ( LoginWindow, false )
		local passwort = guiGetText ( gEdit["passwort_login"] )
		triggerServerEvent ( "einloggen", lp, lp, passwort )
		unbindKey ( "enter", "down", SubmitEinloggenBtn )
	end
end

function _CreateLoginWindow()
	
	if LoginWindow then
		guiSetVisible ( LoginWindow, true )
	else
		local screenwidth, screenheight = guiGetScreenSize ()
		
		LoginWindow = guiCreateWindow(screenwidth/2-318/2,screenheight/2-188/2,318,188,"Loginfenster",false)
		guiSetAlpha(LoginWindow,1)
		guiWindowSetSizable ( LoginWindow, false )
		guiWindowSetMovable ( LoginWindow, false )
		if isHalloween then
			img = "header_halloween.png"
		elseif isWithinNightTime () then
			img = "header_night.png"
		else
			img = "header.jpg"
		end
		gImage["header"] = guiCreateStaticImage(0.0283,0.1223,0.9434,0.3989,"images/"..img,true,LoginWindow)
		guiSetAlpha(gImage["header"],1)
		gLabel["infoTextLogin"] = guiCreateLabel(0.0314,0.5266,0.9528,0.2713,"Deine Accountdaten wurden gefunden -\nFalls du neu bist, waehle bitte einen anderen Namen!",true,LoginWindow)
		guiSetAlpha(gLabel["infoTextLogin"],1)
		guiLabelSetColor(gLabel["infoTextLogin"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["infoTextLogin"],"top")
		guiLabelSetHorizontalAlign(gLabel["infoTextLogin"],"left",false)
		guiSetFont(gLabel["infoTextLogin"],"default-bold-small")
		gButtons["Einloggen"] = guiCreateButton(0.6132,0.7128,0.3491,0.2287,"Einloggen",true,LoginWindow)
		guiSetAlpha(gButtons["Einloggen"],1)
		gLabel["infoTextPasswort"] = guiCreateLabel(0.0252,0.7819,0.2013,0.0798,"Passwort:",true,LoginWindow)
		guiSetAlpha(gLabel["infoTextPasswort"],1)
		guiLabelSetColor(gLabel["infoTextPasswort"],125,125,200)
		guiLabelSetVerticalAlign(gLabel["infoTextPasswort"],"top")
		guiLabelSetHorizontalAlign(gLabel["infoTextPasswort"],"left",false)
		guiSetFont(gLabel["infoTextPasswort"],"default-bold-small")
		gEdit["passwort_login"] = guiCreateEdit(0.2327,0.7447,0.3302,0.1596,"******",true,LoginWindow)
		guiSetAlpha(gEdit["passwort_login"],1)
		guiSetVisible ( LoginWindow, false )
		guiEditSetMasked ( gEdit["passwort_login"], true )
		addEventHandler("onClientGUIClick", gEdit["passwort_login"], SubmitPasswortLoginEdit, false)
		addEventHandler("onClientGUIClick", gButtons["Einloggen"], SubmitEinloggenBtn, false)
	end
	addEventHandler ( "onClientRender", getRootElement(), showVersionInfo )
	gImage["versionInfoDraw1"] = guiCreateStaticImage(0,screenheight-45,screenwidth+1,4,"images/colors/c_white.jpg",false)
	gImage["versionInfoDraw2"] = guiCreateStaticImage(0,screenheight-45+4,screenwidth+1,1,"images/colors/c_black.jpg",false)
end

function GUI_ShowLoginWindow()

	guiSetVisible(LoginWindow, true)
	showCursor(true)
	bindKey ( "enter", "down", SubmitEinloggenBtn )
end
addEvent ( "ShowLoginWindow", true)
addEventHandler ( "ShowLoginWindow", getRootElement(), GUI_ShowLoginWindow)

function GUI_DisableLoginWindow()

	cancelCameraIntro ()
	guiSetVisible(LoginWindow, false)
	showCursor(false)
	removeEventHandler ( "onClientRender", getRootElement(), showVersionInfo )
	destroyElement ( gImage["versionInfoDraw1"] )
	destroyElement ( gImage["versionInfoDraw2"] )
	setTimer ( checkForSocialStateChanges, 10000, -1 )
	setTimer ( getPlayerSocialAvailableStates, 1000, 1 )
	if isTimer ( LVCamFlightTimer ) then
		killTimer ( LVCamFlightTimer )
	end
end
addEvent ( "DisableLoginWindow", true )
addEventHandler ( "DisableLoginWindow", getRootElement(), GUI_DisableLoginWindow)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
	function ()
		local player = getLocalPlayer()
		_CreateLoginWindow()
		for i = 1, 100 do
			outputChatBox (" ")
		end
		setTimer ( ShowInfoWindow, 1000, 1 )
		triggerServerEvent ( "regcheck", getLocalPlayer(), player )
	end
)

function ShowInfoWindow ()

	infobox_start_func("Herzlich Willkommen\nbei Vio Reallife!\nBitte fuelle das mittig\nangezeigte Formular\naus!", 7500 )
end

-- Kameraflug --
function loginCamDrive1 () -- 1 & 2

	local x1, y1, z1 = -2681.7158203125, 1934.0498046875, 216.9231262207
	local x2, y2, z2 = -2682.2709960938, 1825.5369873047, 152.13279724121
	local x1t, y1t, z1t = -2681.8959960938, 1834.5554199219, 204.25393676758
	local x2t, y2t, z2t = -2682.4833984375, 1726.5500488281, 142.3770904541
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive2, time + 5, 1 )
end

function loginCamDrive2 () -- 2 & 3

	local x1, y1, z1 = -2682.2709960938, 1825.5369873047, 152.13279724121
	local x2, y2, z2 = -2681.4150390625, 1594.8540039063, 110.92800140381
	local x1t, y1t, z1t = -2682.4833984375, 1726.5500488281, 142.3770904541
	local x2t, y2t, z2t = -2681.6276855469, 1495.1013183594, 99.998870849609
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor
	
	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive3, time + 5, 1 )
end

function loginCamDrive3 () -- 3 & 4

	local x1, y1, z1 = -2681.4150390625, 1594.8540039063, 110.92800140381
	local x2, y2, z2 = -2681.6447753906, 1422.8494873047, 67.56616973877
	local x1t, y1t, z1t = -2681.6276855469, 1495.1013183594, 99.998870849609
	local x2t, y2t, z2t = -2681.5173339844, 1352.2436523438, 66.19132232666
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive4, time + 5, 1 )
end

function loginCamDrive4 () -- 4 & 5

	local x1, y1, z1 = -2681.6447753906, 1422.8494873047, 67.56616973877
	local x2, y2, z2 = -2676.8818359375, 1286.3806152344, 56.828914642334
	local x1t, y1t, z1t = -2681.5173339844, 1352.2436523438, 66.19132232666
	local x2t, y2t, z2t = -2677.1591796875, 1271.5997314453, 55.728954315186
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive5, time + 5, 1 )
end

function loginCamDrive5 () -- 5 & 6

	local x1, y1, z1 = -2676.8818359375, 1286.3806152344, 56.828914642334
	local x2, y2, z2 = -2678.3664550781, 1233.8521728516, 64
	local x1t, y1t, z1t = -2677.1591796875, 1271.5997314453, 55.728954315186
	local x2t, y2t, z2t = -2660.7592773438, 1188.1033935547, 65.842964172363
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive6, time + 5, 1 )
end

function loginCamDrive6 () -- 6 & 7

	local x1, y1, z1 = -2678.3664550781, 1233.8521728516, 66.589385986328
	local x2, y2, z2 = -2622.5700683594, 1189.6419677734, 61.302570343018
	local x1t, y1t, z1t = -2660.7592773438, 1188.1033935547, 65.842964172363
	local x2t, y2t, z2t = -2600.3303222656, 1200.1820068359, 34.821102142334
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive7, time + 5, 1 )
end

function loginCamDrive7 () -- 7 & 8

	local x1, y1, z1 = -2622.5700683594, 1189.6419677734, 61.302570343018
	local x2, y2, z2 = -2608.8449707031, 1199.6995849609, 39.6725730896
	local x1t, y1t, z1t = -2600.3303222656, 1200.1820068359, 34.821102142334
	local x2t, y2t, z2t = -2538.4426269531, 1269.5288085938, 35.954319000244
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive8, time + 5, 1 )
end

function loginCamDrive8 () -- 8 & 9

	local x1, y1, z1 = -2608.8449707031, 1199.6995849609, 39.6725730896
	local x2, y2, z2 = -2583.2880859375, 1229.4835205078, 39.4225730896
	local x1t, y1t, z1t = -2538.4426269531, 1269.5288085938, 35.954319000244
	local x2t, y2t, z2t = -2553.7490234375, 1324.2071533203, 30.522205352783
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive9, time + 5, 1 )
end

function loginCamDrive9 () -- 9 & 10

	local x1, y1, z1 = -2583.2880859375, 1229.4835205078, 39.4225730896
	local x2, y2, z2 = -2569.6552734375, 1311.4398193359, 18.645280838013
	local x1t, y1t, z1t = -2553.7490234375, 1324.2071533203, 30.522205352783
	local x2t, y2t, z2t = -2574.12890625, 1410.6734619141, 19.313352584839
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive10, time + 5, 1 )
end

function loginCamDrive10 () -- 10 & 11

	local x1, y1, z1 = -2569.6552734375, 1311.4398193359, 18.645280838013
	local x2, y2, z2 = -2653.9934082031, 1448.3275146484, 67.121849060059
	local x1t, y1t, z1t = -2574.12890625, 1410.6734619141, 19.313352584839
	local x2t, y2t, z2t = -2713.8569335938, 1503.0798339844, 104.99078369141
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive11, time + 5, 1 )
end

function loginCamDrive11 () -- 11 & 12

	local x1, y1, z1 = -2653.9934082031, 1448.3275146484, 67.121849060059
	local x2, y2, z2 = -2672.4709472656, 1593.65625, 183.23147583008
	local x1t, y1t, z1t = -2713.8569335938, 1503.0798339844, 104.99078369141
	local x2t, y2t, z2t = -2673.0710449219, 1677.3735351563, 222.607421875
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive12, time + 5, 1 )
end

function loginCamDrive12 () -- 12 & 13

	local x1, y1, z1 = -2672.4709472656, 1593.65625, 183.23147583008
	local x2, y2, z2 = -2681.8708496094, 1933.7674560547, 181.23147583008
	local x1t, y1t, z1t = -2673.0710449219, 1677.3735351563, 222.607421875
	local x2t, y2t, z2t = -2741.1096191406, 2007.708984375, 179.04406738281
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive13, time + 5, 1 )
end

function loginCamDrive13 () -- 13 & 14

	local x1, y1, z1 = -2681.8708496094, 1933.7674560547, 181.23147583008
	local x2, y2, z2 = -2704.6545410156+5, 1964.7253417969, 238.45220947266
	local x1t, y1t, z1t = -2741.1096191406, 2007.708984375, 179.04406738281
	local x2t, y2t, z2t = -2682.2709960938, 1825.5369873047, 152.13279724121
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive14, time + 5, 1 )
end

function loginCamDrive14 () -- 14 & 1

	local x1, y1, z1 = -2704.6545410156+5, 1964.7253417969, 238.45220947266
	local x2, y2, z2 = -2681.7158203125, 1934.0498046875, 216.9231262207
	local x1t, y1t, z1t = -2682.2709960938, 1825.5369873047, 152.13279724121
	local x2t, y2t, z2t = -2681.8959960938, 1834.5554199219, 204.25393676758
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive1, time + 5, 1 )
end

function smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )

	object1 = createObject ( 1337, x1, y1, z1 )
	object2 = createObject ( 1337, x1t, y1t, z1t )
	setElementAlpha ( object1, 0 )
	setElementAlpha ( object2, 0 )
	moveObject ( object1, time, x2, y2, z2 )
	moveObject ( object2, time, x2t, y2t, z2t )
	
	addEventHandler ( "onClientRender", getRootElement(), camRender )
	setTimer ( removeCamHandler, time, 1 )
	setTimer ( destroyElement, time, 1, object1 )
	setTimer ( destroyElement, time, 1, object2 )
end

function removeCamHandler ()

	removeEventHandler ( "onClientRender", getRootElement(), camRender )
end

function camRender ()

	if not isHalloween then
		if not getCameraTarget ( lp ) then
			local x1, y1, z1 = getElementPosition ( object1 )
			local x2, y2, z2 = getElementPosition ( object2 )
			setCameraMatrix ( x1, y1, z1, x2, y2, z2 )
		else
			removeCamHandler ()
			if isTimer ( LVCamFlightTimer ) then
				killTimer ( LVCamFlightTimer )
			end
		end
	end
end

function cancelCameraIntro ()

	removeEventHandler ( "onClientRender", getRootElement(), camRender )
	if not isHalloween then
		destroyElement ( object1 )
		destroyElement ( object2 )
		if isTimer ( cameraTimer ) then
			killTimer ( cameraTimer )
		end
	else
		stopHalloweenCamFlight ()
	end
end

function loginCamDrive ()

	if not isHalloween then
		speedfactor = getDistanceBetweenPoints3D ( -2681.7158203125, 1934.0498046875, 216.9231262207, -2682.2709960938, 1825.5369873047, 152.13279724121 ) / 10000
		if isWithinNightTime () then
			startLVCameraFlight ( speedfactor )
		else
			loginCamDrive1 ()
		end
	else
		startHalloweenCamFlight ()
	end
end
loginCamDrive ()