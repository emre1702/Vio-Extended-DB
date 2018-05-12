local curFileSubject

function showPDComputer ()

	showCursor ( true )
	setElementData ( lp, "ElementClicked", true )
	guiSetInputEnabled ( false )
	
	if isElement ( gWindow["policeComputer"] ) then
		guiSetVisible ( gWindow["policeComputer"], true )
		
		refreshPDComputer ()
	else
		gWindow["policeComputer"] = guiCreateWindow(screenwidth/2-365/2,screenheight/2-(437+25)/2,365,437+25,"Polizeicomputer",false)
		guiSetAlpha(gWindow["policeComputer"],1)
		local img = guiCreateStaticImage(24,30,52,51,"images/gui/police.png",false,gWindow["policeComputer"])
		guiSetAlpha(img,1)
		gGrid["pdPlayers"] = guiCreateGridList(110,29+50,243,397-50,false,gWindow["policeComputer"])
		guiGridListSetSelectionMode(gGrid["pdPlayers"],0)
		gColumn["pdPlayer"] = guiGridListAddColumn(gGrid["pdPlayers"],"Spieler",0.425)
		gColumn["pdFaction"] = guiGridListAddColumn(gGrid["pdPlayers"],"Fraktion",0.2)
		gColumn["pdWanteds"] = guiGridListAddColumn(gGrid["pdPlayers"],"Wanteds",0.175)
		guiSetAlpha(gGrid["pdPlayers"],1)
		
		gEdit["pdReason"] = guiCreateEdit(110+50,29,243,30,"",false,gWindow["policeComputer"])
		guiSetAlpha(gEdit["pdReason"],1)
		gLabel[2] = guiCreateLabel(110,29,50,30,"Grund:",false,gWindow["policeComputer"])
		guiSetAlpha(gLabel[2],1)
		guiLabelSetColor(gLabel[2],200,200,0)
		guiLabelSetVerticalAlign(gLabel[2],"top")
		guiLabelSetHorizontalAlign(gLabel[2],"left",false)
		guiSetFont(gLabel[2],"default-bold-small")
		
		gEdit["pdCount"] = guiCreateNumberField(73-20,180,35,25,"1",false,gWindow["policeComputer"],true,true)
		guiSetAlpha(gEdit["pdCount"],1)
		gLabel[1] = guiCreateLabel(11,183,45,17,"Anzahl:",false,gWindow["policeComputer"])
		guiSetAlpha(gLabel[1],1)
		guiLabelSetColor(gLabel[1],200,200,0)
		guiLabelSetVerticalAlign(gLabel[1],"top")
		guiLabelSetHorizontalAlign(gLabel[1],"left",false)
		guiSetFont(gLabel[1],"default-bold-small")
		gGrid["pdCameras"] = guiCreateGridList(9,213,96,113,false,gWindow["policeComputer"])
		guiGridListSetSelectionMode(gGrid["pdCameras"],2)
		guiGridListAddColumn(gGrid["pdCameras"],"Kamera",0.8)
		guiSetAlpha(gGrid["pdCameras"],1)
		
		gEdit["pdName"] = guiCreateEdit(11,432+2,100,25,"Name",false,gWindow["policeComputer"])
		guiSetAlpha(gEdit["pdName"],1)
		gRadio["pdFromList"] = guiCreateRadioButton ( 111, 432, 50, 25, "Liste", false, gWindow["policeComputer"] )
		guiSetFont ( gRadio["pdFromList"], "default-bold-small" )
		gRadio["pdFromField"] = guiCreateRadioButton ( 111+50, 432, 100, 25, "Name", false, gWindow["policeComputer"] )
		guiSetFont ( gRadio["pdFromField"], "default-bold-small" )
		
		gButton["useDatabase"] = guiCreateButton(11,335,87,38,"Datenbank\nbenutzen",false,gWindow["policeComputer"])
		guiSetAlpha(gButton["useDatabase"],1)
		gButton["setWanteds"] = guiCreateButton(11,90,87,38,"Wanteds setzen",false,gWindow["policeComputer"])
		guiSetAlpha(gButton["setWanteds"],1)
		gButton["setStvo"] = guiCreateButton(11,135,87,38,"STVO-Punkte\ngeben",false,gWindow["policeComputer"])
		guiSetAlpha(gButton["setStvo"],1)
		gButton["pdClose"] = guiCreateButton(11,383,87,38,"Fenster\nschliessen",false,gWindow["policeComputer"])
		guiSetAlpha(gButton["pdClose"],1)
		gButton["pdTrace"] = guiCreateButton(365-90,432+2,87,38-20,"Orten",false,gWindow["policeComputer"])
		guiSetAlpha(gButton["pdTrace"],1)
		
		guiRadioButtonSetSelected ( gRadio["pdFromList"], true )
		
		addEventHandler ( "onClientGUIClick", gButton["useDatabase"],
			function ()
				showDatabase ()
				guiSetVisible ( gWindow["policeComputer"], false )
			end,
		false )
		addEventHandler ( "onClientGUIClick", gButton["setWanteds"],
			function ()
				local wanteds = tonumber ( guiGetText ( gEdit["pdCount"] ) )
				local reason = guiGetText ( gEdit["pdReason"] )
				if wanteds >= 0 and wanteds <= 6 then
					local row, column = guiGridListGetSelectedItem ( gGrid["pdPlayers"] )
					local name
					if guiRadioButtonGetSelected ( gRadio["pdFromList"] ) then
						name = guiGridListGetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"] )
					else
						name = guiGetText ( gEdit["pdName"] )
					end
					triggerServerEvent ( "pdComputerSetWanted", lp, wanteds, name, reason )
				else
					outputChatBox ( "Du kannst nur Wantedlevel 1-6 vergeben!", 125, 0, 0 )
				end
			end,
		false )
		addEventHandler ( "onClientGUIClick", gButton["setStvo"],
			function ()
				local row, column = guiGridListGetSelectedItem ( gGrid["pdPlayers"] )
				local stvo = tonumber ( guiGetText ( gEdit["pdCount"] ) )
				local reason = guiGetText ( gEdit["pdReason"] )
				if stvo <= 15 and stvo >= 0 then
					local name
					if guiRadioButtonGetSelected ( gRadio["pdFromList"] ) then
						name = guiGridListGetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"] )
					else
						name = guiGetText ( gEdit["pdName"] )
					end
					triggerServerEvent ( "pdComputerAddSTVO", lp, name, stvo, reason )
				else
					outputChatBox ( "Bitte waehle einen Wert zwischen 1 und 15!", 125, 0, 0 )
				end
			end,
		false )
		addEventHandler ( "onClientGUIClick", gButton["pdClose"],
			function ()
				showCursor ( false )
				setElementData ( lp, "ElementClicked", false )
				guiSetInputEnabled ( true )
				guiSetVisible ( gWindow["policeComputer"], false )
			end,
		false )
		addEventHandler ( "onClientGUIClick", gButton["pdTrace"],
			function ()
				SFPDTraceCitizen ()
			end,
		false )
		
		guiSetFont ( gGrid["pdPlayers"], "default-bold-small" )
		
		guiGridListClear ( gGrid["pdPlayers"] )
		for id, player in ipairs ( getElementsByType ( "player" ) ) do 
			if getElementData ( player, "loggedin" ) == 1 then
				local row = guiGridListAddRow ( gGrid["pdPlayers"] )
				guiGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"], getPlayerName ( player ), false, false )
				if tostring(getElementData ( player, "wanteds" )) == "false" then wanteds = "0" else wanteds = tostring(getElementData ( player, "wanteds" )) end
				guiGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdWanteds"], wanteds, false, false )
				local fraktion = getElementData ( player, "fraktion" )
				guiGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdFaction"], fraktionsNamen[fraktion], false, false )
				
				guiGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdPlayer"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
				guiGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdWanteds"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
				guiGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdFaction"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
				guiSetFont ( row, "default-bold-small" )
			end
		end
	end
end
addEvent ( "showPDComputer", true)
addEventHandler ( "showPDComputer", getRootElement(), showPDComputer )

function refreshPDComputer ()

	guiGridListClear ( gGrid["pdPlayers"] )
	guiGridListSetSortingEnabled ( gGrid["pdPlayers"], false )
	for id, player in ipairs ( getElementsByType ( "player" ) ) do 
		if getElementData ( player, "loggedin" ) == 1 then
			local row = guiGridListAddRow ( gGrid["pdPlayers"] )
			guiGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"], getPlayerName ( player ), false, false )
			if tostring(getElementData ( player, "wanteds" )) == "false" then wanteds = "0" else wanteds = tostring(getElementData ( player, "wanteds" )) end
			guiGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdWanteds"], wanteds, false, false )
			local fraktion = getElementData ( player, "fraktion" )
			guiGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdFaction"], fraktionsNamen[fraktion], false, false )
			
			guiGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdPlayer"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
			guiGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdWanteds"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
			guiGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdFaction"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
			guiSetFont ( row, "default-bold-small" )
		end
	end
	guiGridListSetSortingEnabled ( gGrid["pdPlayers"], true )
end

function SFPDTraceCitizen ()

	local name
	if guiRadioButtonGetSelected ( gRadio["pdFromList"] ) then
		local row, column = guiGridListGetSelectedItem ( gGrid["pdPlayers"] )
		name = guiGridListGetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"] )
	else
		name = guiGetText ( gEdit["pdName"] )
	end
	local target = getPlayerFromName ( name )
	if tonumber(getElementData ( lp, "rang" )) >= 2 then
		if getElementData ( target, "handystate" ) == "off" then
			outputChatBox ( "Das Handy des Buergers ist ausgeschaltet!", 125, 0, 0 )
		else
			local x, y, z = getElementPosition ( target )
			if tonumber ( getElementInterior ( target ) ) ~= 0 or tonumber ( getElementDimension ( target ) ) ~= 0 then
				outputChatBox ( "Der Buerger befindet sich in einem Gebaeude - Ortung nicht moeglich!", 125, 0, 0 )
			else
				if wantedBlip then
					destroyElement ( wantedBlip )
					wantedBlip = nil
					if deletetWantedBlipTimer then
						killTimer ( deletetWantedBlipTimer )
					end
					wantedBlip = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999.0 )
					deletetWantedBlipTimer = setTimer ( deletetWantedBlip, 5000, 1 )
				else
					destroyElement ( wantedBlip )
					wantedBlip = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999.0 )
					deletetWantedBlipTimer = setTimer ( deletetWantedBlip, 5000, 1 )
				end
			end
		end
	else
		outputChatBox ( "Du bist nicht befugt!", 125, 0, 0 )
	end
end

function deletetWantedBlip ()

	destroyElement ( wantedBlip )
	wantedBlip = nil
end

function showDatabase ()

	curFileSubject = ""
	gWindow["dataBase"] = guiCreateWindow(screenwidth/2-320/2,screenheight/2-327/2,320,327,"Datenbank",false)
	guiSetAlpha(gWindow["dataBase"],1)
	gLabel[1] = guiCreateLabel(12,34,113,15,"Name des Buergers:",false,gWindow["dataBase"])
	guiSetAlpha(gLabel[1],1)
	guiLabelSetColor(gLabel[1],255,255,255)
	guiLabelSetVerticalAlign(gLabel[1],"top")
	guiLabelSetHorizontalAlign(gLabel[1],"left",false)
	guiSetFont(gLabel[1],"default-bold-small")
	gEdit["suspectName"] = guiCreateEdit(132,29,93,27,"[Vio]Zipper",false,gWindow["dataBase"])
	guiSetAlpha(gEdit["suspectName"],1)
	gButton["searchFile"] = guiCreateButton(230,26,73,32,"Suchen",false,gWindow["dataBase"])
	guiSetAlpha(gButton["searchFile"],1)
	guiSetFont(gButton["searchFile"],"default-bold-small")
	gMemo["fileText"] = guiCreateMemo(10,62,296,213,"",false,gWindow["dataBase"])
	guiSetAlpha(gMemo["fileText"],1)
	gImage[1] = guiCreateStaticImage(93,53,103,101,"images/gui/police.png",false,gMemo["fileText"])
	guiSetAlpha(gImage[1],0.5)
	gButton["saveFile"] = guiCreateButton(142,284,79,33,"Speichern",false,gWindow["dataBase"])
	guiSetAlpha(gButton["saveFile"],1)
	guiSetFont(gButton["saveFile"],"default-bold-small")
	gLabel[2] = guiCreateLabel(12,281,115,15,"Zuletzt editiert von:",false,gWindow["dataBase"])
	guiSetAlpha(gLabel[2],1)
	guiLabelSetColor(gLabel[2],255,255,255)
	guiLabelSetVerticalAlign(gLabel[2],"top")
	guiLabelSetHorizontalAlign(gLabel[2],"left",false)
	guiSetFont(gLabel[2],"default-bold-small")
	gLabel["lastEditor"] = guiCreateLabel(13,300,120,16,"",false,gWindow["dataBase"])
	guiSetAlpha(gLabel["lastEditor"],1)
	guiLabelSetColor(gLabel["lastEditor"],50,50,255)
	guiLabelSetVerticalAlign(gLabel["lastEditor"],"top")
	guiLabelSetHorizontalAlign(gLabel["lastEditor"],"left",false)
	guiSetFont(gLabel["lastEditor"],"default-bold-small")
	gButton["closeFile"] = guiCreateButton(228,284,79,33,"Schliessen",false,gWindow["dataBase"])
	guiSetAlpha(gButton["closeFile"],1)
	guiSetFont(gButton["closeFile"],"default-bold-small")
	
	addEventHandler ( "onClientGUIClick", gButton["closeFile"],
		function ()
			showCursor ( false )
			setElementData ( lp, "ElementClicked", false )
			guiSetInputEnabled ( true )
			destroyElement ( gWindow["dataBase"] )
		end,
	false )
	addEventHandler ( "onClientGUIClick", gButton["searchFile"],
		function ()
			triggerServerEvent ( "getDatabaseFile", lp, guiGetText ( gEdit["suspectName"] ) )
		end,
	false )
	addEventHandler ( "onClientGUIClick", gButton["saveFile"],
		function ()
			if curFileSubject == "" then
				infobox ( "Du hast im Moment\nkeine Akte geöffnet!", 5000, 255, 0, 0 )
			else
				triggerServerEvent ( "saveDatabaseFile", lp, curFileSubject, guiGetText ( gMemo["fileText"] ) )
			end
		end,
	false )
end

function recieveDatabaseFile ( name, text, editor, faction )

	if isElement ( gWindow["dataBase"] ) then
		curFileSubject = name
		guiSetText ( gEdit["suspectName"], name )
		guiSetText ( gMemo["fileText"], text )
		guiSetText ( gLabel["lastEditor"], editor )
		if faction == 1 then
			guiLabelSetColor ( gLabel["lastEditor"], 50, 50, 255 )
		elseif faction == 6 then
			guiLabelSetColor ( gLabel["lastEditor"], 200, 0, 0 )
		elseif faction == 8 then
			guiLabelSetColor ( gLabel["lastEditor"], 50, 255, 50 )
		end
	end
end
addEvent ( "recieveDatabaseFile", true )
addEventHandler ( "recieveDatabaseFile", getRootElement(), recieveDatabaseFile )