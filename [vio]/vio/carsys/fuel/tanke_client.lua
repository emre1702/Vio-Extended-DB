TankeSFDowntown = createMarker ( -1681.7896728516, 407.72265625, 5.6796879768372, "cylinder", 5, getColorFromString ( "#FF000099" ) )
TankeSFJuniperHill = createMarker ( -2415.208984375, 976.42901611328, 43.807689666748, "cylinder", 5, getColorFromString ( "#FF000099" ) )
TankeBoat = createMarker ( -1108.8315429688, -136.8196105957, 0, "cylinder", 5, getColorFromString ( "#FF000099" ) )
AirportTanke = createMarker ( -1122.7724609375, -202.25073242188, 10.893966674805, "cylinder", 50, getColorFromString ( "#FF000099" ) )
Tanke1 = createMarker(-2244.2653808594, -2561.2934570313, 30.921875, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke2 = createMarker(658.52795410156, -565.03424072266, 15.3359375, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke3 = createMarker(1003.8759155273, -940.43975830078, 41.1796875, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke4 = createMarker(-92.113708496094, -1171.3128662109 ,1.3799414634705, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke5 = createMarker(1597.9239501953 ,2199.1923828125 ,9.8203125, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke6 = createMarker(2144.8181152344 ,2748.4426269531 ,9.8203125, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke7 = createMarker(2113.7553710938 ,920.28552246094 ,9.8203125, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke8 = createMarker(-736.88232421875 ,2741.0732421875 ,46.224239349365, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke9 = createMarker(-1326.2266845703 ,2688.9340820313 ,49.0625, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke10 = createMarker(1936.3382568359 ,-1772.1337890625 ,12.3828125, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke11 = createMarker(62.793960571289 ,1217.6678466797 ,17.835973739624, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke12 = createMarker(-1612.5341796875 ,-2723.4165039063 ,47.5390625, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke13 = createMarker(2638.4443359375 ,1106.2412109375 ,9.8203125, "cylinder", 5, getColorFromString ( "#FF000099" ))
Tanke14 = createMarker(2203.1423339844 ,2473.5385742188 ,9.8203125, "cylinder", 5, getColorFromString ( "#FF000099" ))

helicopters = { [548]=true, [425]=true, [417]=true, [487]=true, [488]=true, [497]=true, [563]=true, [447]=true, [469]=true }
planea = { [512]=true, [593]=true, [476]=true, [460]=true, [513]=true }
planeb = { [592]=true, [577]=true, [511]=true, [520]=true, [553]=true, [519]=true }

function showTankenGui ( player )

	if player == getLocalPlayer() then
		local veh = getPedOccupiedVehicle ( getLocalPlayer() )
		local model = getElementModel ( veh )
		local x, y, z = getElementPosition ( player )
		if not veh or ( not helicopters[model] and not planeb[model] and not planea[model] ) or ( source == TankeBoat and model == 460 and z <= 10 ) then
			setElementVelocity ( getPedOccupiedVehicle ( getLocalPlayer() ), 0, 0, 0 )
			showCursor ( true )
			setElementData ( getLocalPlayer(), "ElementClicked", true, true )
			toggleAllControls ( getLocalPlayer(), false )
			if gWindow["tankstelle"] then
				guiSetVisible ( gWindow["tankstelle"], true )
			else
				local screenwidth, screenheight = guiGetScreenSize ()
				
				gWindow["tankstelle"] = guiCreateWindow(screenwidth/2-378/2,screenheight/2-174/2,378,174,"Tankstelle",false)
				guiSetAlpha(gWindow["tankstelle"],1)
				guiWindowSetMovable(gWindow["tankstelle"],false)
				guiWindowSetSizable(gWindow["tankstelle"],false)
				gEdit["literFill"] = guiCreateEdit(0.3545,0.477,0.164,0.1609,"",true,gWindow["tankstelle"])
				guiSetAlpha(gEdit["literFill"],1)
				gLabel["literText"] = guiCreateLabel(0.5317,0.523,0.1005,0.1092,"Liter",true,gWindow["tankstelle"])
				guiSetAlpha(gLabel["literText"],1)
				guiLabelSetColor(gLabel["literText"],125,000,000)
				guiLabelSetVerticalAlign(gLabel["literText"],"top")
				guiLabelSetHorizontalAlign(gLabel["literText"],"left",false)
				guiSetFont(gLabel["literText"],"default-bold-small")
				gLabel["snackPrice"] = guiCreateLabel(0.7804,0.5115,0.0582,0.1092,"X $",true,gWindow["tankstelle"])
				guiSetAlpha(gLabel["snackPrice"],1)
				guiLabelSetColor(gLabel["snackPrice"],000,125,000)
				guiLabelSetVerticalAlign(gLabel["snackPrice"],"top")
				guiLabelSetHorizontalAlign(gLabel["snackPrice"],"left",false)
				guiSetFont(gLabel["snackPrice"],"default-bold-small")
				gLabel["pricePerLiter"] = guiCreateLabel(0.0767,0.5172,0.2011,0.1092,"X.XX $ / Liter",true,gWindow["tankstelle"])
				guiSetAlpha(gLabel["pricePerLiter"],1)
				guiLabelSetColor(gLabel["pricePerLiter"],000,125,000)
				guiLabelSetVerticalAlign(gLabel["pricePerLiter"],"top")
				guiLabelSetHorizontalAlign(gLabel["pricePerLiter"],"left",false)
				guiSetFont(gLabel["pricePerLiter"],"default-bold-small")
				gLabel["kannisterPrice"] = guiCreateLabel(0.3545,0.7069,0.1429,0.1897,"X Liter,\nX $",true,gWindow["tankstelle"])
				guiSetAlpha(gLabel["kannisterPrice"],1)
				guiLabelSetColor(gLabel["kannisterPrice"],200,050,020)
				guiLabelSetVerticalAlign(gLabel["kannisterPrice"],"top")
				guiLabelSetHorizontalAlign(gLabel["kannisterPrice"],"left",false)
				guiSetFont(gLabel["kannisterPrice"],"default-bold-small")
				
				gButton["buyKannister"] = guiCreateButton(0.0344,0.6724,0.291,0.2644,"Benzinkanister\nkaufen",true,gWindow["tankstelle"])
				guiSetAlpha(gButton["buyKannister"],1)
				gButton["volltanken"] = guiCreateButton(0.0344,0.1724,0.291,0.2644,"Volltanken",true,gWindow["tankstelle"])
				guiSetAlpha(gButton["volltanken"],1)
				gButton["ltanken"] = guiCreateButton(0.3519,0.1667,0.291,0.2644,"Liter tanken",true,gWindow["tankstelle"])
				guiSetAlpha(gButton["ltanken"],1)
				gButton["snack"] = guiCreateButton(0.6693,0.1667,0.291,0.2644,"Snack kaufen",true,gWindow["tankstelle"])
				guiSetAlpha(gButton["snack"],1)
				gButton["closeTanke"] = guiCreateButton(0.6825,0.6782,0.291,0.2644,"Fenster schliessen",true,gWindow["tankstelle"])
				guiSetAlpha(gButton["closeTanke"],1)
				
				addEventHandler("onClientGUIClick", gButton["closeTanke"],
					function()
						guiSetVisible ( gWindow["tankstelle"], false )
						showCursor(false)
						triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
					end
				)
				addEventHandler("onClientGUIClick", gButton["volltanken"],
					function()
						guiSetVisible ( gWindow["tankstelle"], false )
						showCursor(false)
						triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
						triggerServerEvent ( "fillComplete", getLocalPlayer(), getLocalPlayer() )
					end
				)
				addEventHandler("onClientGUIClick", gButton["ltanken"],
					function()
						guiSetVisible ( gWindow["tankstelle"], false )
						showCursor(false)
						triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
						triggerServerEvent ( "fillPart", getLocalPlayer(), getLocalPlayer(), guiGetText ( gEdit["literFill"] ) )
					end
				)
				addEventHandler("onClientGUIClick", gButton["snack"],
					function()
						triggerServerEvent ( "buySnack", getLocalPlayer(), getLocalPlayer() )
					end
				)
				addEventHandler("onClientGUIClick", gButton["buyKannister"],
					function()
						triggerServerEvent ( "buyKannister", getLocalPlayer(), getLocalPlayer() )
					end
				)
			end
			guiSetText ( gLabel["snackPrice"], snackPrice.." $" )
			guiSetText ( gLabel["pricePerLiter"], literPrice.." $ / Liter" )
			guiSetText ( gLabel["kannisterPrice"], "15 Liter,\n"..math.floor(literPrice*15)+kannisterPrice.." $" )
		end
	end
end
addEventHandler ( "onClientMarkerHit", TankeSFJuniperHill, showTankenGui )
addEventHandler ( "onClientMarkerHit", TankeSFDowntown, showTankenGui )
addEventHandler ( "onClientMarkerHit", TankeBoat, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke1, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke2, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke3, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke4, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke5, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke6, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke7, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke8, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke9, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke10, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke11, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke12, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke13, showTankenGui )
addEventHandler ( "onClientMarkerHit", Tanke14, showTankenGui )

function showAirportTanke ( player )

	if player == getLocalPlayer() then
		local veh = getPedOccupiedVehicle ( getLocalPlayer() )
		if not veh or helicopters[getElementModel ( veh )] or ( ( planeb[getElementModel ( veh )] or planea[getElementModel ( veh )] ) and isVehicleOnGround ( veh ) ) then
			setElementVelocity ( getPedOccupiedVehicle ( getLocalPlayer() ), 0, 0, 0 )
			showCursor ( true )
			setElementData ( getLocalPlayer(), "ElementClicked", true, true )
			toggleAllControls ( getLocalPlayer(), false )
			if gWindow["tankstelle"] then
				guiSetVisible ( gWindow["tankstelle"], true )
			else
				local screenwidth, screenheight = guiGetScreenSize ()
				
				gWindow["tankstelle"] = guiCreateWindow(screenwidth/2-378/2,screenheight/2-174/2,378,174,"Tankstelle",false)
				guiSetAlpha(gWindow["tankstelle"],1)
				guiWindowSetMovable(gWindow["tankstelle"],false)
				guiWindowSetSizable(gWindow["tankstelle"],false)
				gEdit["literFill"] = guiCreateEdit(0.3545,0.477,0.164,0.1609,"",true,gWindow["tankstelle"])
				guiSetAlpha(gEdit["literFill"],1)
				gLabel["literText"] = guiCreateLabel(0.5317,0.523,0.1005,0.1092,"Liter",true,gWindow["tankstelle"])
				guiSetAlpha(gLabel["literText"],1)
				guiLabelSetColor(gLabel["literText"],125,000,000)
				guiLabelSetVerticalAlign(gLabel["literText"],"top")
				guiLabelSetHorizontalAlign(gLabel["literText"],"left",false)
				guiSetFont(gLabel["literText"],"default-bold-small")
				gLabel["snackPrice"] = guiCreateLabel(0.7804,0.5115,0.0582,0.1092,"X $",true,gWindow["tankstelle"])
				guiSetAlpha(gLabel["snackPrice"],1)
				guiLabelSetColor(gLabel["snackPrice"],000,125,000)
				guiLabelSetVerticalAlign(gLabel["snackPrice"],"top")
				guiLabelSetHorizontalAlign(gLabel["snackPrice"],"left",false)
				guiSetFont(gLabel["snackPrice"],"default-bold-small")
				gLabel["pricePerLiter"] = guiCreateLabel(0.0767,0.5172,0.2011,0.1092,"X.XX $ / Liter",true,gWindow["tankstelle"])
				guiSetAlpha(gLabel["pricePerLiter"],1)
				guiLabelSetColor(gLabel["pricePerLiter"],000,125,000)
				guiLabelSetVerticalAlign(gLabel["pricePerLiter"],"top")
				guiLabelSetHorizontalAlign(gLabel["pricePerLiter"],"left",false)
				guiSetFont(gLabel["pricePerLiter"],"default-bold-small")
				gLabel["kannisterPrice"] = guiCreateLabel(0.3545,0.7069,0.1429,0.1897,"X Liter,\nX $",true,gWindow["tankstelle"])
				guiSetAlpha(gLabel["kannisterPrice"],1)
				guiLabelSetColor(gLabel["kannisterPrice"],200,050,020)
				guiLabelSetVerticalAlign(gLabel["kannisterPrice"],"top")
				guiLabelSetHorizontalAlign(gLabel["kannisterPrice"],"left",false)
				guiSetFont(gLabel["kannisterPrice"],"default-bold-small")
				
				gButton["buyKannister"] = guiCreateButton(0.0344,0.6724,0.291,0.2644,"Benzinkanister\nkaufen",true,gWindow["tankstelle"])
				guiSetAlpha(gButton["buyKannister"],1)
				gButton["volltanken"] = guiCreateButton(0.0344,0.1724,0.291,0.2644,"Volltanken",true,gWindow["tankstelle"])
				guiSetAlpha(gButton["volltanken"],1)
				gButton["ltanken"] = guiCreateButton(0.3519,0.1667,0.291,0.2644,"Liter tanken",true,gWindow["tankstelle"])
				guiSetAlpha(gButton["ltanken"],1)
				gButton["snack"] = guiCreateButton(0.6693,0.1667,0.291,0.2644,"Snack kaufen",true,gWindow["tankstelle"])
				guiSetAlpha(gButton["snack"],1)
				gButton["closeTanke"] = guiCreateButton(0.6825,0.6782,0.291,0.2644,"Fenster schliessen",true,gWindow["tankstelle"])
				guiSetAlpha(gButton["closeTanke"],1)
				
				addEventHandler("onClientGUIClick", gButton["closeTanke"],
					function()
						guiSetVisible ( gWindow["tankstelle"], false )
						showCursor(false)
						triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
					end
				)
				addEventHandler("onClientGUIClick", gButton["volltanken"],
					function()
						guiSetVisible ( gWindow["tankstelle"], false )
						showCursor(false)
						triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
						triggerServerEvent ( "fillComplete", getLocalPlayer(), getLocalPlayer(), true )
					end
				)
				addEventHandler("onClientGUIClick", gButton["ltanken"],
					function()
						guiSetVisible ( gWindow["tankstelle"], false )
						showCursor(false)
						triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
						triggerServerEvent ( "fillPart", getLocalPlayer(), getLocalPlayer(), guiGetText ( gEdit["literFill"] ), true )
					end
				)
				addEventHandler("onClientGUIClick", gButton["snack"],
					function()
						triggerServerEvent ( "buySnack", getLocalPlayer(), getLocalPlayer() )
					end
				)
				addEventHandler("onClientGUIClick", gButton["buyKannister"],
					function()
						triggerServerEvent ( "buyKannister", getLocalPlayer(), getLocalPlayer() )
					end
				)
			end
			guiSetText ( gLabel["snackPrice"], snackPrice.." $" )
			guiSetText ( gLabel["pricePerLiter"], (literPrice*3).." $ / Liter" )
			guiSetText ( gLabel["kannisterPrice"], "15 Liter,\n"..math.floor(literPrice*15)+kannisterPrice.." $" )
		end
	end
end
addEventHandler ( "onClientMarkerHit", AirportTanke, showAirportTanke )