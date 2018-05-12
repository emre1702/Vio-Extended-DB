-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

createMarker ( -2667.78, -5.39, 5.05, "cylinder", 3, 255, 0, 0, 150 )
baumarktSphere = createColSphere ( -2667.78, -5.39, 5.05, 3 )
createBlip ( -2667.78, -5.39, 5.05, 11, 2, 255, 0, 0, 255, 0, 200 )

function showBaumarktMenue ( hit )

	if hit == lp then
		showCursor ( true )
		setElementData ( lp, "ElementClicked", true )
		if gWindow["baumarkt"] then
			guiSetVisible ( gWindow["baumarkt"], true )
		else
			gWindow["baumarkt"] = guiCreateWindow(screenwidth/2-445/2,screenheight/2-294/2,445,294,"Baumarkt",false)
			guiSetAlpha(gWindow["baumarkt"],1)
			
			gLabel[1] = guiCreateLabel(10,26,418,32,"Herzlich wilkommen!\nHier kannst du Objekte erwerben, die du anschliessend platzieren kannst.",false,gWindow["baumarkt"])
			guiSetAlpha(gLabel[1],1)
			guiLabelSetColor(gLabel[1],255,255,255)
			guiLabelSetVerticalAlign(gLabel[1],"top")
			guiLabelSetHorizontalAlign(gLabel[1],"left",false)
			guiSetFont(gLabel[1],"default-bold-small")
			
			gButton["closeBaumarkt"] = guiCreateButton(419,23,16,17,"x",false,gWindow["baumarkt"])
			guiSetAlpha(gButton["closeBaumarkt"],1)
			addEventHandler ( "onClientGUIClick", gButton["closeBaumarkt"], hideBaumarktMenue, false )
			
			gButton[1] = guiCreateButton(9,58,133,67,"",false,gWindow["baumarkt"])
			guiSetAlpha(gButton[1],1)
			local btn = gButton[1]
			local model = 841
			setElementData ( btn, "model", model )
			local img = guiCreateStaticImage(8,6,50,50,"images/inventory/placeable/campfire.png",false,btn)
			guiSetAlpha(img,1)
			local label = guiCreateLabel(63,10,65,52,"Lagerfeuer\n\n"..placeablePrices[model].." $",false,btn)
			guiSetAlpha(label,1)
			guiLabelSetColor(label,255,255,255)
			guiLabelSetVerticalAlign(label,"top")
			guiLabelSetHorizontalAlign(label,"left",false)
			guiSetFont(label,"default-bold-small")
			
			gButton[2] = guiCreateButton(157,58,133,67,"",false,gWindow["baumarkt"])
			guiSetAlpha(gButton[2],1)
			local btn = gButton[2]
			local model = 3461
			setElementData ( btn, "model", model )
			local img = guiCreateStaticImage(8,6,50,50,"images/inventory/placeable/torch.png",false,btn)
			guiSetAlpha(img,1)
			local label = guiCreateLabel(63,10,65,52,"Fackel\n\n"..placeablePrices[model].." $",false,btn)
			guiSetAlpha(label,1)
			guiLabelSetColor(label,255,255,255)
			guiLabelSetVerticalAlign(label,"top")
			guiLabelSetHorizontalAlign(label,"left",false)
			guiSetFont(label,"default-bold-small")
			
			gButton[3] = guiCreateButton(9,140,133,67,"",false,gWindow["baumarkt"])
			guiSetAlpha(gButton[3],1)
			local btn = gButton[3]
			local model = 1946
			setElementData ( btn, "model", model )
			local img = guiCreateStaticImage(8,6,50,50,"images/inventory/placeable/ball_a.png",false,btn)
			guiSetAlpha(img,1)
			local label = guiCreateLabel(63,10,65,52,"Basketball\n\n"..placeablePrices[model].." $",false,btn)
			guiSetAlpha(label,1)
			guiLabelSetColor(label,255,255,255)
			guiLabelSetVerticalAlign(label,"top")
			guiLabelSetHorizontalAlign(label,"left",false)
			guiSetFont(label,"default-bold-small")
			
			gButton[4] = guiCreateButton(157,140,133,67,"",false,gWindow["baumarkt"])
			guiSetAlpha(gButton[4],1)
			local btn = gButton[4]
			local model = 1598
			setElementData ( btn, "model", model )
			local img = guiCreateStaticImage(8,6,50,50,"images/inventory/placeable/ball_b.png",false,btn)
			guiSetAlpha(img,1)
			local label = guiCreateLabel(63,10,65,52,"Strandball\n\n"..placeablePrices[model].." $",false,btn)
			guiSetAlpha(label,1)
			guiLabelSetColor(label,255,255,255)
			guiLabelSetVerticalAlign(label,"top")
			guiLabelSetHorizontalAlign(label,"left",false)
			guiSetFont(label,"default-bold-small")
			
			gButton[5] = guiCreateButton(303,58,133,67,"",false,gWindow["baumarkt"])
			guiSetAlpha(gButton[5],1)
			local btn = gButton[5]
			local model = 1481
			setElementData ( btn, "model", model )
			local img = guiCreateStaticImage(8,6,50,50,"images/inventory/placeable/grill.png",false,btn)
			guiSetAlpha(img,1)
			local label = guiCreateLabel(63,10,65,52,"Grill\n\n"..placeablePrices[model].." $",false,btn)
			guiSetAlpha(label,1)
			guiLabelSetColor(label,255,255,255)
			guiLabelSetVerticalAlign(label,"top")
			guiLabelSetHorizontalAlign(label,"left",false)
			guiSetFont(label,"default-bold-small")
			
			gButton[6] = guiCreateButton(303,140,133,67,"",false,gWindow["baumarkt"])
			guiSetAlpha(gButton[6],1)
			local btn = gButton[6]
			local model = 1255
			setElementData ( btn, "model", model )
			local img = guiCreateStaticImage(8,6,50,50,"images/inventory/placeable/liege.png",false,btn)
			guiSetAlpha(img,1)
			local label = guiCreateLabel(63,10,65,52,"Liege\n\n"..placeablePrices[model].." $",false,btn)
			guiSetAlpha(label,1)
			guiLabelSetColor(label,255,255,255)
			guiLabelSetVerticalAlign(label,"top")
			guiLabelSetHorizontalAlign(label,"left",false)
			guiSetFont(label,"default-bold-small")
			
			gButton[7] = guiCreateButton(10,214,133,67,"",false,gWindow["baumarkt"])
			guiSetAlpha(gButton[7],1)
			local btn = gButton[7]
			local model = 1640
			setElementData ( btn, "model", model )
			local img = guiCreateStaticImage(8,6,50,50,"images/inventory/placeable/towel.png",false,btn)
			guiSetAlpha(img,1)
			local label = guiCreateLabel(63,10,65,52,"Handtuch\n\n"..placeablePrices[model].." $",false,btn)
			guiSetAlpha(label,1)
			guiLabelSetColor(label,255,255,255)
			guiLabelSetVerticalAlign(label,"top")
			guiLabelSetHorizontalAlign(label,"left",false)
			guiSetFont(label,"default-bold-small")
			
			gButton[8] = guiCreateButton(303,214,133,67,"",false,gWindow["baumarkt"])
			guiSetAlpha(gButton[8],1)
			local btn = gButton[8]
			local model = 2103
			setElementData ( btn, "model", model )
			local img = guiCreateStaticImage(8,6,50,50,"images/inventory/placeable/hi_fi.png",false,btn)
			guiSetAlpha(img,1)
			local label = guiCreateLabel(63,10,65,52,"Stereo-\nanlage\n\n"..placeablePrices[model].." $",false,btn)
			guiSetAlpha(label,1)
			guiLabelSetColor(label,255,255,255)
			guiLabelSetVerticalAlign(label,"top")
			guiLabelSetHorizontalAlign(label,"left",false)
			guiSetFont(label,"default-bold-small")
			
			gRadio["colorSelect1"] = guiCreateRadioButton(151,237,73,23,"Gruen",false,gWindow["baumarkt"])
			guiSetAlpha(gRadio["colorSelect1"],1)
			guiSetFont(gRadio["colorSelect1"],"default-bold-small")
			gRadio["colorSelect2"] = guiCreateRadioButton(151,215,73,23,"Lila",false,gWindow["baumarkt"])
			guiSetAlpha(gRadio["colorSelect2"],1)
			guiSetFont(gRadio["colorSelect2"],"default-bold-small")
			gRadio["colorSelect3"] = guiCreateRadioButton(229,238,73,23,"Rot",false,gWindow["baumarkt"])
			guiSetAlpha(gRadio["colorSelect3"],1)
			guiSetFont(gRadio["colorSelect3"],"default-bold-small")
			gRadio["colorSelect4"] = guiCreateRadioButton(151,259,73,23,"Gelb",false,gWindow["baumarkt"])
			guiSetAlpha(gRadio["colorSelect4"],1)
			guiRadioButtonSetSelected(gRadio["colorSelect4"],true)
			guiSetFont(gRadio["colorSelect4"],"default-bold-small")
			
			addEventHandler( "onClientGUIClick", gWindow["baumarkt"], purchaseItem )
		end
	end
end
addEventHandler ( "onClientColShapeHit", baumarktSphere, showBaumarktMenue )

function hideBaumarktMenue ()

	guiSetVisible ( gWindow["baumarkt"], false )
	showCursor ( false )
	setElementData ( lp, "ElementClicked", false )
end

function purchaseItem ()

	local model = getElementData ( source, "model" )
	if model then
		if model == 1640 then
			-- Radio Buttons
			if guiRadioButtonGetSelected ( gRadio["colorSelect2"] ) then
				model = 1641
			elseif guiRadioButtonGetSelected ( gRadio["colorSelect3"] ) then
				model = 1642
			elseif guiRadioButtonGetSelected ( gRadio["colorSelect4"] ) then
				model = 1643
			end
		end
		triggerServerEvent ( "purchaseItem", lp, model )
	end
end