﻿-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

function _createBonusmenue_func()

	if gWindow["bonusmenue"] then
		guiSetVisible ( gWindow["bonusmenue"], true )
	else
		gWindow["bonusmenue"] = guiCreateWindow ( screenwidth/2-370/2, 120, 370, 424, "Bonusmenue", false )
		guiSetAlpha(gWindow["bonusmenue"],1)
		gGrid["bonusliste"] = guiCreateGridList(0.027,0.0637,0.4649,0.9104,true,gWindow["bonusmenue"])
		guiGridListSetSelectionMode(gGrid["bonusliste"],2)
		gColumn["bonusName"] = guiGridListAddColumn(gGrid["bonusliste"],"Bonus",0.6)
		gColumn["bonusKosten"] = guiGridListAddColumn(gGrid["bonusliste"],"Kosten",0.2)
		guiSetAlpha(gGrid["bonusliste"],1)
		gButton["buyBonus"] = guiCreateButton(0.5054,0.8797,0.2216,0.0896,"",true,gWindow["bonusmenue"])
		guiSetAlpha(gButton["buyBonus"],1)
		gButton["cancelBonus"] = guiCreateButton(0.7405,0.8797,0.2216,0.0896,"Menue schliessen",true,gWindow["bonusmenue"])
		guiSetAlpha(gButton["cancelBonus"],1)
		gLabel["Bonusname"] = guiCreateLabel(0.5027,0.0637,0.4838,0.0542,"",true,gWindow["bonusmenue"])
		guiSetAlpha(gLabel["Bonusname"],1)
		guiLabelSetColor(gLabel["Bonusname"],125,000,000)
		guiLabelSetVerticalAlign(gLabel["Bonusname"],"top")
		guiLabelSetHorizontalAlign(gLabel["Bonusname"],"left",false)
		guiSetFont(gLabel["Bonusname"],"default-bold-small")
		gLabel["Description"] = guiCreateLabel(0.5,0.1179,0.4784,0.592,"Herzlich Willkommen im\n\"Bonusmenue\"\nHier kannst du deine\nBonuspunkte, die durch\nAchievments und dem\nsammeln von versteckten\nPaeckchen erhalten kannst,\nfuer besondere Belohnungen\nausgeben.",true,gWindow["bonusmenue"])
		guiSetAlpha(gLabel["Description"],1)
		guiLabelSetColor(gLabel["Description"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["Description"],"top")
		guiLabelSetHorizontalAlign(gLabel["Description"],"left",false)
		gLabel["yourPoints"] = guiCreateLabel(0.5108,0.7382,0.3081,0.0566,"Deine Bonuspunkte:",true,gWindow["bonusmenue"])
		guiSetAlpha(gLabel["yourPoints"],1)
		guiLabelSetColor(gLabel["yourPoints"],200,200,000)
		guiLabelSetVerticalAlign(gLabel["yourPoints"],"top")
		guiLabelSetHorizontalAlign(gLabel["yourPoints"],"left",false)
		gLabel["bonusPoints"] = guiCreateLabel(0.5324,0.7854,0.2351,0.059,"0 Punkte",true,gWindow["bonusmenue"])
		guiSetAlpha(gLabel["bonusPoints"],1)
		guiLabelSetColor(gLabel["bonusPoints"],000,125,020)
		guiLabelSetVerticalAlign(gLabel["bonusPoints"],"top")
		guiLabelSetHorizontalAlign(gLabel["bonusPoints"],"left",false)
		addEventHandler("onClientGUIClick", gButton["cancelBonus"],
			function()
				guiSetVisible ( gWindow["bonusmenue"], false )
			end
		)
		addEventHandler("onClientGUIClick", getRootElement(),
			function()
				local row = guiGridListGetItemText ( gGrid["bonusliste"], guiGridListGetSelectedItem ( gGrid["bonusliste"] ), 1 )
				local state = guiGridListGetItemText ( gGrid["bonusliste"], guiGridListGetSelectedItem ( gGrid["bonusliste"] ), 2 )
				if row then
					if state == " [x]" then 
						state = "Gekauft"
						if row == " Boxen" or row == " Kung-Fu" or row == " Streetfighting" or row == " Cluckin Bell" or row == " Doppel SMG" then
							guiSetText ( gButton["buyBonus"], "Verwenden" )
							if row == " Doppel SMG" then
								if getPedStat ( lp, 75 ) == 999 then
									guiSetText ( gButton["buyBonus"], "Deaktivieren" )
								else
									guiSetText ( gButton["buyBonus"], "Aktivieren" )
								end
							end
						else
							guiSetText ( gButton["buyBonus"], "" )
						end
					else
						state = "NICHT gekauft"
						guiSetText ( gButton["buyBonus"], "Bonus kaufen" )
					end
					if row == " Lungenvolumen" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Lungenvolumen - 35 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus steigert\ndein Lungenvolumen, so dass\ndu in der Lage bist,\ndeutlich laenger zu tauchen,\nohne zu ertrinken.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Muskeln" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Muskeln - 40 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus steigert\ndeine Muskeln, so dass\ndu in der Lage bist,\ndeutlich staeker zu zu-\nschlagen und somit mehr\nSchaden verursachst.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Kondition" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Kondition - 25 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus erlaubt es\ndir, laenger zu sprinten\nohne zu erschoepfen.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Boxen" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Boxen - 25 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus erlaubt es\ndir, Boxhiebe zu verteilen.\n\nInfo: Muss erst\naktiviert werden und kann\nnicht mit anderen\nKampfkuensten kombiniert\nwerden, Status: "..state )
					elseif row == " Kung-Fu" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Kung-Fu - 35 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus lasst dich\nzu einem Meister des Kong-Fu\nwerden.\n\nInfo: Muss erst\naktiviert werden und kann\nnicht mit anderen\nKampfkuensten kombiniert\nwerden, Status: "..state )
					elseif row == " Streetfighting" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Streetfighting - 40 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus laesst dich\nunfair kaempfen.\n\nInfo: Muss erst\naktiviert werden und kann\nnicht mit anderen\nKampfkuensten kombiniert\nwerden, Status: "..state )
					elseif row == " Pistole" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Pistolenskills - 20 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus erhoeht deine\nFaehigkeiten mit der\nnormalen und der Schallge-\ndaempften Pistole.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Deagle" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Desertskills - 30 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus erhoeht deine\nFaehigkeiten mit der\nDesert Eagle.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Sturmgewehr" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Sturmgewehrskills - 30 P." )
						guiSetText ( gLabel["Description"], "Dieser Bonus erhoehen deine\nFaehigkeiten mit der\n AK-47 und der M4.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Schrotflinten" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Schrotflintenskills - 20 P." )
						guiSetText ( gLabel["Description"], "Dieser Bonus erhoehen deine\nFaehigkeiten mit allen Schrot-\nflinten.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " MP5" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "MP5-skills - 35 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus erhoehen deine\nFaehigkeiten mit der\nMP5.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Doppel SMG" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Doppel SMG - 50 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus erlaubt es dir,\nzwei SMGs wie die Tec9 oder\ndie Uzi gleichzeitig zu tragen.\n\nInfo: Automatisch aktiv,\nkann umgestellt werden,\nStatus: "..state )
					elseif row == " Fahrzeugslots" then
						selectedBonus = row
						
						if getElementData ( player, "carslotupgrade2" ) == 1 then
							cost = 75
							maxCars = 10
						elseif getElementData ( player, "carslotupgrade" ) == "done" then
							cost = 60
							maxCars = 7
						else
							cost = 50
							maxCars = 5
						end
						
						guiSetText ( gLabel["Bonusname"], "Carsloterhoehung - "..cost.." P." )
						guiSetText ( gLabel["Description"], "Dieser Bonus erhoeht deine\nFahrzeugslots auf maximal\n"..maxCars.." moegliche Fahrzeuge.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Vortex" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Vortex - 30 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus schaltet\ndas Vortex-Luftkissenboot\nzum Kauf an den\nBonushallen frei.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Quad" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Quadbike - 30 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus schaltet\ndas Quadbike\nzum Kauf an den\nBonushallen frei.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Caddy" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Caddy - 25 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus schaltet\ndas Golfcaddy\nzum Kauf an den\nBonushallen frei.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Skimmer" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Skimmer - 50 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus schaltet\nden Skimmer\nzum Kauf an den\nBonushallen frei.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Leichenwagen" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Leichenwagen - 50 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus schaltet\nden Leichenwagen\nzum Kauf an den\nBonushallen frei.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
					elseif row == " Cluckin Bell" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Cluckin Bell - 25 Punkte" )
						guiSetText ( gLabel["Description"], "Dieser Bonus schaltet\nden Huehnchenskin\nfrei." )
					elseif row == " Notebook" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Notebook - 25 Punkte" )
						guiSetText ( gLabel["Description"], "Immer und ueberall\nins Internet!" )
					elseif row == " Spielekonsole" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Spielekonsole - 25 Punkte" )
						guiSetText ( gLabel["Description"], "Immer und ueberall\nspielen! Ideal\nim Knast!" )
					elseif row == " Schachspiel" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Schachspiel - 15 Punkte" )
						guiSetText ( gLabel["Description"], "Mit jedem und\nueberall spielen! Ideal\nim Knast!" )
					elseif row == " Fernglas" then
						selectedBonus = row
						guiSetText ( gLabel["Bonusname"], "Fernglas - 10 Punkte" )
						guiSetText ( gLabel["Description"], "Auch ueber grosse\nEntfernungen den Ueber-\nblick behalten." )
					end
				end
			end
		)
		addEventHandler("onClientGUIClick", gButton["buyBonus"],
			function()
				triggerServerEvent ( "bonusBuy", getLocalPlayer(), getLocalPlayer(), guiGridListGetItemText ( gGrid["bonusliste"], guiGridListGetSelectedItem ( gGrid["bonusliste"] ), 1 ) )
			end
		)
	end
	guiGridListSetSelectionMode ( gGrid["bonusliste"], 1 )
	fillBonusList ()
end
addEvent ( "_createBonusmenue", true )
addEventHandler ( "_createBonusmenue", getRootElement(), _createBonusmenue_func )

function refreshBonus_func ( newText )

	if not newText then
		newText = ""
	end
	
	guiSetText ( gLabel["bonusPoints"], getElementData(lp,"bonuspoints").." Punkte" )
	guiSetText ( gButton["buyBonus"], newText )
	local row, column = guiGridListGetSelectedItem ( gGrid["bonusliste"] )
	if guiGridListGetItemText ( gGrid["bonusliste"], guiGridListGetSelectedItem ( gGrid["bonusliste"] ), 1 ) == " Fahrzeugslots" then
		if getElementData ( player, "carslotupgrade2" ) == 1 then
			cost = 75
			maxCars = 10
		elseif getElementData ( player, "carslotupgrade" ) == "done" then
			cost = 60
			maxCars = 7
		else
			cost = 50
			maxCars = 5
		end
		
		guiSetText ( gLabel["Bonusname"], "Carsloterhoehung - "..cost.." P." )
		guiSetText ( gLabel["Description"], "Dieser Bonus erhoeht deine\nFahrzeugslots auf maximal\n"..maxCars.." moegliche Fahrzeuge.\n\nInfo: Automatisch u. dauerhaft\naktiv, Status: "..state )
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, 2, " [x]", false, false )
	guiGridListSetSelectedItem ( gGrid["bonusliste"], row, 1 )
end
addEvent ( "refreshBonus", true )
addEventHandler ( "refreshBonus", getRootElement(), refreshBonus_func )

function fillBonusList ()

	guiSetText ( gButton["buyBonus"], "" )
	local player = lp
	guiGridListClear ( gGrid["bonusliste"] )
	selectedBonus = "none"
	guiSetText ( gLabel["bonusPoints"], getElementData(lp,"bonuspoints").." Punkte" )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], "Koerperlich", true, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Lungenvolumen", false, false )
	if getElementData ( player, "lungenvol" ) ~= "none" then
		fix = " [x]"
	else
		fix = "35 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Muskeln", false, false )
	if getElementData ( player, "muscle" ) ~= "none" then
		fix = " [x]"
	else
		fix = "40 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Kondition", false, false )
	if getElementData ( player, "stamina" ) ~= "none" then
		fix = " [x]"
	else
		fix = "25 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], "Kampfstile", true, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Boxen", false, false )
	if getElementData ( player, "boxen" ) ~= "none" then
		fix = " [x]"
	else
		fix = "25 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Kung-Fu", false, false )
	if getElementData ( player, "kungfu" ) ~= "none" then
		fix = " [x]"
	else
		fix = "35 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Streetfighting", false, false )
	if getElementData ( player, "streetfighting" ) ~= "none" then
		fix = " [x]"
	else
		fix = "40 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], "Waffenskills", true, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Pistole", false, false )
	if getElementData ( player, "pistolskill" ) ~= "none" then
		fix = " [x]"
	else
		fix = "20 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Deagle", false, false )
	if getElementData ( player, "deagleskill" ) ~= "none" then
		fix = " [x]"
	else
		fix = "30 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Sturmgewehr", false, false )
	if getElementData ( player, "assaultskill" ) ~= "none" then
		fix = " [x]"
	else
		fix = "30 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Schrotflinten", false, false )
	if getElementData ( player, "shotgunskill" ) ~= "none" then
		fix = " [x]"
	else
		fix = "20 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " MP5", false, false )
	if getElementData ( player, "mp5skill" ) ~= "none" then
		fix = " [x]"
	else
		fix = "35 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Doppel SMG", false, false )
	if getElementData ( player, "doubleSMG" ) then
		fix = " [x]"
	else
		fix = "50 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], "Fahrzeuge", true, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Fahrzeugslots", false, false )
	if getElementData ( player, "carslotupgrade3" ) == 1 then
		fix = " [x]"
	elseif getElementData ( player, "carslotupgrade2" ) == 1 then
		fix = " 75 P"
	elseif getElementData ( player, "carslotupgrade" ) ~= "none" then
		fix = " 60 P"
	else
		fix = " 50 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Vortex", false, false )
	if getElementData ( player, "vortex" ) ~= "none" then
		fix = " [x]"
	else
		fix = "30 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	-- New Boni --
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Skimmer", false, false )
	if getElementData ( player, "skimmer" ) > 0 then
		fix = " [x]"
	else
		fix = "50 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Caddy", false, false )
	if getElementData ( player, "golfcart" ) then
		fix = " [x]"
	else
		fix = "25 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Leichenwagen", false, false )
	if getElementData ( player, "romero" ) > 0 then
		fix = " [x]"
	else
		fix = "50 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Quad", false, false )
	if getElementData ( player, "quad" ) ~= "none" then
		fix = " [x]"
	else
		fix = "30 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], "Skins", true, false )
	
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Cluckin Bell", false, false )
	if getElementData ( player, "bonusskin1" ) ~= "none" then
		fix = " [x]"
	else
		fix = "25 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], "Items", true, false )
	
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Notebook", false, false )
	if getElementData ( player, "fruitNotebook" ) >= 1 then
		fix = " [x]"
	else
		fix = "25 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Spielekonsole", false, false )
	if getElementData ( player, "gameboy" ) >= 1 then
		fix = " [x]"
	else
		fix = "25 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Schachspiel", false, false )
	if getElementData ( player, "chess" ) then
		fix = " [x]"
	else
		fix = "15 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
	
	local row = guiGridListAddRow(gGrid["bonusliste"])
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusName"], " Fernglas", false, false )
	if getElementData ( player, "fglass" ) then
		fix = " [x]"
	else
		fix = "10 P"
	end
	guiGridListSetItemText ( gGrid["bonusliste"], row, gColumn["bonusKosten"], fix, false, false )
end