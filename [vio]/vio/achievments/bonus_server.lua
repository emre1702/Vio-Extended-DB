carslotUpgradePrices = { [3]=50, [5]=60, [7]=75 }

local function bonusLoad_DB ( qh, player, alreadytried ) 
	local result, errorcode, errormsg = dbPoll( qh, 0 )
	if not result or not result[1] then
		if alreadytried then
			if not result then
				outputDebugString("bonusLoad_DB couldn't work (1): ("		.. errorcode .. ") " .. errormsg)
			end
			return
		end
		dbExec( handler, "INSERT INTO bonustable (Name, Lungenvolumen, Muskeln, Kondition, Boxen, KungFu, Streetfighting, CurStyle, PistolenSkill, DeagleSkill, ShotgunSkill, AssaultSkill) VALUES (?, 'none', 'none', 'none', 'none', 'none', 'none', '4', 'none', 'none', 'none', 'none' )", pname)
		dbQuery( bonusLoad_DB, { player, true }, handler, "SELECT * FROM bonustable WHERE Name LIKE ?", pname )
		return
	end

	local dsatz = result[1]
	local Lungenvolumen = dsatz["Lungenvolumen"]
	vioSetElementData ( player, "lungenvol", Lungenvolumen )
	if Lungenvolumen ~= "none" then
		setPedStat ( player, 225, 500 )
	end
	local Muskeln = dsatz["Muskeln"]
	vioSetElementData ( player, "muscle", Muskeln )
	if Muskeln ~= "none" then
		setPedStat ( player, 23, 500 )
	end
	local Kondition = dsatz["Kondition"]
	vioSetElementData ( player, "stamina", Kondition )
	if Kondition ~= "none" then
		setPedStat ( player, 22, 500 )
	end
	local PistolenSkill = dsatz["PistolenSkill"]
	vioSetElementData ( player, "pistolskill", PistolenSkill )
	if PistolenSkill ~= "none" then
		setPedStat ( player, 69, 900 )
		setPedStat ( player, 70, 999 )
	end
	local DeagleSkill = dsatz["DeagleSkill"]
	vioSetElementData ( player, "deagleskill", DeagleSkill )
	if DeagleSkill ~= "none" then
		setPedStat ( player, 71, 999 )
	end
	local ShotgunSkill = dsatz["ShotgunSkill"]
	vioSetElementData ( player, "shotgunskill", ShotgunSkill )
	if ShotgunSkill ~= "none" then
		setPedStat ( player, 72, 999 )
		setPedStat ( player, 74, 999 )
	end
	local AssaultSkill = dsatz["AssaultSkill"]
	vioSetElementData ( player, "assaultskill", AssaultSkill )
	if AssaultSkill ~= "none" then
		setPedStat ( player, 77, 999 )
		setPedStat ( player, 78, 999 )
	end
	local MP5Skill = dsatz["MP5Skills"]
	vioSetElementData ( player, "mp5skill", MP5Skill )
	if MP5Skill ~= "none" then
		setPedStat ( player, 76, 999 )
	end
	
	vioSetElementData ( player, "boxen", dsatz["Boxen"] )
	vioSetElementData ( player, "kungfu", dsatz["KungFu"] )
	vioSetElementData ( player, "streetfighting", dsatz["Streetfighting"] )
	setPedFightingStyle ( player, tonumber ( dsatz["CurStyle"] ) )
	vioSetElementData ( player, "vortex", dsatz["Vortex"] )
	vioSetElementData ( player, "quad", dsatz["Quad"] )
	vioSetElementData ( player, "skimmer", tonumber ( dsatz["Skimmer"] ) )
	vioSetElementData ( player, "romero", tonumber ( dsatz["Leichenwagen"] ) )
	vioSetElementData ( player, "carslotupgrade", dsatz["CarslotUpgrades"] )
	vioSetElementData ( player, "bonusskin1", dsatz["BonusSkin1"] )
	vioSetElementData ( player, "chess", ( tonumber ( dsatz["Schach"] ) == 1 ) )
	vioSetElementData ( player, "golfcart", ( tonumber ( dsatz["Caddy"] ) == 1 ) )
	vioSetElementData ( player, "fglass", tonumber ( dsatz["fglass"] ) == 1 )
	vioSetElementData ( player, "doubleSMG", tonumber ( dsatz["uzi"] ) == 1 )
	if vioGetElementData ( player, "doubleSMG" ) then
		setPedStat ( player, 75, 999 )
	else
		setPedStat ( player, 75, 600 )
	end
end

function bonusLoad ( player )
	local pname = getPlayerName ( player )
	dbQuery( bonusLoad_DB, { player, false }, handler, "SELECT * FROM bonustable WHERE Name LIKE ?", pname )	
end

function bonusSave ( player )

	
end


local function setMaximumCarsForPlayer_DB ( qh, player )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local pname = getPlayerName ( player )
	
		local carslotUpdate3 = tonumber ( result[1]["CarslotUpdate3"] )
		local carslotUpdate2 = tonumber ( result[1]["CarslotUpdate2"] )
		local carslotUpdate1 = result[1]["CarslotUpgrades"]

		vioSetElementData ( player, "carslotupgrade", carslotUpdate1 )
		vioSetElementData ( player, "carslotupgrade2", carslotUpdate2 )
		vioSetElementData ( player, "carslotupgrade3", carslotUpdate3 )
		
		if carslotUpdate3 == 1 then
			max = 10
		elseif carslotUpdate2 == 1 then
			max = 7
		elseif carslotUpdate1 == "buyed" then
			max = 5
		else
			max = 3
		end
		
		vioSetElementData ( player, "maxcars", max )
	end
end

function setMaximumCarsForPlayer ( player )
	dbQuery( setMaximumCarsForPlayer_DB, { player }, handler, "SELECT CarslotUpgrades, CarslotUpdate2, CarslotUpdate3 FROM bonustable WHERE Name LIKE ?", pname )
end

function bonusBuy_func ( player, bonus )

	if player == client then
		local pname = getPlayerName ( player )
		local bonuspoints = tonumber ( vioGetElementData ( player, "bonuspoints" ) )
		if bonus == " Lungenvolumen" then
			if vioGetElementData ( player, "lungenvol" ) ~= "none" then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 35 then
					outputChatBox ( "Du hast den Bonus gekauft!", player, 0, 125, 0 )
					setPedStat ( player, 225, 500 )
					vioSetElementData ( player, "lungenvol", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 35 )
					dbExec( handler, "UPDATE bonustable SET Lungenvolumen = ? WHERE Name LIKE ?", vioGetElementData ( player, "lungenvol" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Muskeln" then
			if vioGetElementData ( player, "muscle" ) ~= "none" then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 40 then
					outputChatBox ( "Du hast den Bonus gekauft!", player, 0, 125, 0 )
					setPedStat ( player, 23, 500 )
					vioSetElementData ( player, "muscle", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 40 )
					dbExec( handler, "UPDATE bonustable SET Muskeln = ? WHERE Name LIKE ?", vioGetElementData ( player, "muscle" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Kondition" then
			if vioGetElementData ( player, "stamina" ) ~= "none" then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 25 then
					outputChatBox ( "Du hast den Bonus gekauft!", player, 0, 125, 0 )
					setPedStat ( player, 22, 500 )
					vioSetElementData ( player, "stamina", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 25 )
					dbExec( handler, "UPDATE bonustable SET Kondition = ? WHERE Name LIKE ?", vioGetElementData ( player, "stamina" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Boxen" then
			if vioGetElementData ( player, "boxen" ) ~= "none" then
				setPedFightingStyle ( player, 5 )
				outputChatBox ( "Aktueller Stil: Boxen", player, 175, 175, 20 )
				dbExec( handler, "UPDATE bonustable SET CurStyle = '5' WHERE Name LIKE ?", pname )
			else
				if bonuspoints >= 25 then
					outputChatBox ( "Du hast den Bonus gekauft - vergiss nicht, ihn zu aktivieren!", player, 0, 125, 0 )
					vioSetElementData ( player, "boxen", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 25 )
					dbExec( handler, "UPDATE bonustable SET Boxen = ? WHERE Name LIKE ?", vioGetElementData ( player, "boxen" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "Verwenden" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Kung-Fu" then
			if vioGetElementData ( player, "kungfu" ) ~= "none" then
				setPedFightingStyle ( player, 6 )
				outputChatBox ( "Aktueller Stil: Kung-Fu", player, 175, 175, 20 )
				dbExec( handler, "UPDATE bonustable SET CurStyle = '6' WHERE Name LIKE ?", pname )
			else
				if bonuspoints >= 35 then
					outputChatBox ( "Du hast den Bonus gekauft - vergiss nicht, ihn zu aktivieren!", player, 0, 125, 0 )
					vioSetElementData ( player, "kungfu", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 35 )
					dbExec( handler, "UPDATE bonustable SET KungFu = ? WHERE Name LIKE ?", vioGetElementData ( player, "kungfu" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "Verwenden" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Streetfighting" then
			if vioGetElementData ( player, "streetfighting" ) ~= "none" then
				setPedFightingStyle ( player, 7 )
				outputChatBox ( "Aktueller Stil: Streetfighting", player, 175, 175, 20 )
				dbExec( handler, "UPDATE bonustable SET CurStyle = '7' WHERE Name LIKE ?", pname )
			else
				if bonuspoints >= 40 then
					outputChatBox ( "Du hast den Bonus gekauft - vergiss nicht, ihn zu aktivieren!", player, 0, 125, 0 )
					vioSetElementData ( player, "streetfighting", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 40 )
					dbExec( handler, "UPDATE bonustable SET Streetfighting = ? WHERE Name LIKE ?", vioGetElementData ( player, "streetfighting" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "Verwenden" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Pistole" then
			if vioGetElementData ( player, "pistolskill" ) ~= "none" then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 20 then
					outputChatBox ( "Du hast den Bonus gekauft!", player, 0, 125, 0 )
					setPedStat ( player, 69, 900 )
					setPedStat ( player, 70, 999 )
					vioSetElementData ( player, "pistolskill", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 20 )
					dbExec( handler, "UPDATE bonustable SET PistolenSkill = ? WHERE Name LIKE ?", vioGetElementData ( player, "pistolskill" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Deagle" then
			if vioGetElementData ( player, "deagleskill" ) ~= "none" then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 30 then
					outputChatBox ( "Du hast den Bonus gekauft!", player, 0, 125, 0 )
					setPedStat ( player, 71, 999 )
					vioSetElementData ( player, "deagleskill", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 30 )
					dbExec( handler, "UPDATE bonustable SET DeagleSkill = ? WHERE Name LIKE ?", vioGetElementData ( player, "deagleskill" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Sturmgewehr" then
			if vioGetElementData ( player, "assaultskill" ) ~= "none" then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 30 then
					outputChatBox ( "Du hast den Bonus gekauft!", player, 0, 125, 0 )
					setPedStat ( player, 77, 999 )
					setPedStat ( player, 78, 999 )
					vioSetElementData ( player, "assaultskill", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 30 )
					dbExec( handler, "UPDATE bonustable SET AssaultSkill = ? WHERE Name LIKE ?", vioGetElementData ( player, "assaultskill" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Schrotflinten" then
			if vioGetElementData ( player, "shotgunskill" ) ~= "none" then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 20 then
					outputChatBox ( "Du hast den Bonus gekauft!", player, 0, 125, 0 )
					setPedStat ( player, 72, 999 )
					setPedStat ( player, 74, 999 )
					vioSetElementData ( player, "shotgunskill", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 20 )
					dbExec( handler, "UPDATE bonustable SET ShotgunSkill = ? WHERE Name LIKE ?", vioGetElementData ( player, "shotgunskill" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " MP5" then
			if vioGetElementData ( player, "mp5skill" ) ~= "none" then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 35 then
					outputChatBox ( "Du hast den Bonus gekauft!", player, 0, 125, 0 )
					setPedStat ( player, 76, 999 )
					vioSetElementData ( player, "mp5skill", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 35 )
					dbExec( handler, "UPDATE bonustable SET MP5Skills = ? WHERE Name LIKE ?", vioGetElementData ( player, "mp5skill" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Vortex" then
			if vioGetElementData ( player, "vortex" ) ~= "none" then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 30 then
					outputChatBox ( "Du hast den Bonus gekauft und kannst das Vortex nun an der Bonushalle erwerben!", player, 0, 125, 0 )
					outputChatBox ( "( LKW-Icon )", player, 0, 125, 0 )
					vioSetElementData ( player, "vortex", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 30 )
					dbExec( handler, "UPDATE bonustable SET Vortex = ? WHERE Name LIKE ?", vioGetElementData ( player, "vortex" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Quad" then
			if vioGetElementData ( player, "quad" ) ~= "none" then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 30 then
					outputChatBox ( "Du hast den Bonus gekauft und kannst das Quad nun an der Bonushalle erwerben!", player, 0, 125, 0 )
					outputChatBox ( "( LKW-Icon )", player, 0, 125, 0 )
					vioSetElementData ( player, "quad", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 30 )
					dbExec( handler, "UPDATE bonustable SET Quad = ? WHERE Name LIKE ?", vioGetElementData ( player, "quad" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Leichenwagen" then
			if vioGetElementData ( player, "romero" ) == 1 then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 50 then
					outputChatBox ( "Du hast den Bonus gekauft und kannst den Leichenwagen nun an der Bonushalle erwerben!", player, 0, 125, 0 )
					outputChatBox ( "( LKW-Icon )", player, 0, 125, 0 )
					vioSetElementData ( player, "romero", 1 )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 50 )
					dbExec( handler, "UPDATE bonustable SET Leichenwagen = ? WHERE Name LIKE ?", vioGetElementData ( player, "romero" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Caddy" then
			if vioGetElementData ( player, "golfcart" ) then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 25 then
					outputChatBox ( "Du hast den Bonus gekauft und kannst das Caddy nun an der Bonushalle erwerben!", player, 0, 125, 0 )
					outputChatBox ( "( LKW-Icon )", player, 0, 125, 0 )
					vioSetElementData ( player, "golfcart", true )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 25 )
					dbExec( handler, "UPDATE bonustable SET Caddy = '1' WHERE Name LIKE ?", pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Skimmer" then
			if vioGetElementData ( player, "skimmer" ) == 1 then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				if bonuspoints >= 50 then
					outputChatBox ( "Du hast den Bonus gekauft und kannst den Skimmer nun an der Bonushalle erwerben!", player, 0, 125, 0 )
					outputChatBox ( "( LKW-Icon )", player, 0, 125, 0 )
					vioSetElementData ( player, "skimmer", 1 )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 50 )
					dbExec( handler, "UPDATE bonustable SET Skimmer = ? WHERE Name LIKE ?", vioGetElementData ( player, "skimmer" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Fahrzeugslots" then
			if vioGetElementData ( player, "carslotupgrade3" ) == 1 then
				outputChatBox ( "Diesen Bonus hast du bereits gekauft!", player, 125, 0, 0 )
			else
				local points = vioGetElementData ( player, "bonuspoints" )
				if vioGetElementData ( player, "carslotupgrade" ) == "none" then
					if points >= 50 then
						outputChatBox ( "Du hast den Bonus gekauft und kannst nun maximal 5 Fahrzeuge besitzen.", player, 0, 125, 0 )
						vioSetElementData ( player, "carslotupgrade", "buyed" )
						vioSetElementData ( player, "bonuspoints", bonuspoints - 50 )
						dbExec( handler, "UPDATE bonustable SET CarslotUpgrades = 'buyed' WHERE Name LIKE ?", pname )
						vioSetElementData ( player, "maxcars", 5 )
					else
						outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
					end
				elseif vioGetElementData ( player, "carslotupgrade2" ) == 0 then
					if points >= 60 then
						outputChatBox ( "Du hast den Bonus gekauft und kannst nun maximal 7 Fahrzeuge besitzen.", player, 0, 125, 0 )
						vioSetElementData ( player, "carslotupgrade2", 1 )
						vioSetElementData ( player, "bonuspoints", bonuspoints - 60 )
						dbExec( handler, "UPDATE bonustable SET CarslotUpdate2 = '1' WHERE Name LIKE ?", pname )
						vioSetElementData ( player, "maxcars", 7 )
					else
						outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
					end
				elseif vioGetElementData ( player, "carslotupgrade3" ) == 0 then
					if points >= 75 then
						outputChatBox ( "Du hast den Bonus gekauft und kannst nun maximal 10 Fahrzeuge besitzen.", player, 0, 125, 0 )
						vioSetElementData ( player, "carslotupgrade3", 1 )
						vioSetElementData ( player, "bonuspoints", bonuspoints - 75 )
						dbExec( handler, "UPDATE bonustable SET CarslotUpdate3 = '1' WHERE Name LIKE ?", pname )
						vioSetElementData ( player, "maxcars", 10 )
					else
						outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
					end
				end
				triggerClientEvent ( player, "refreshBonus", player )
			end
		elseif bonus == " Cluckin Bell" then
			if vioGetElementData ( player, "bonusskin1" ) ~= "none" then
				if not getPedOccupiedVehicle ( player ) then
					setElementModel ( player, 167 )
					vioSetElementData ( player, "skinid", 167 )
				else
					outputChatBox ( "Du kannst deinen Skin nicht in Fahrzeugen verwenden!", player, 125, 0, 0 )
				end
			else
				if bonuspoints >= 25 then
					outputChatBox ( "Du hast den Skin gekauft! Waehle ihn jetzt aus, um ihn zu aktivieren!", player, 0, 125, 0 )
					vioSetElementData ( player, "bonusskin1", "buyed" )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 25 )
					dbExec( handler, "UPDATE bonustable SET BonusSkin1 = ? WHERE Name LIKE ?", vioGetElementData ( player, "bonusskin1" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Notebook" then
			if vioGetElementData ( player, "fruitNotebook" ) >= 1 then
				outputChatBox ( "Du hast dein Notebook bereits! Waehle es im Inventar aus!", player, 125, 0, 0 )
			else
				if bonuspoints >= 25 then
					outputChatBox ( "Du hast dein Notebook gekauft und kannst es jetzt im Inventar verwenden!", player, 0, 125, 0 )
					vioSetElementData ( player, "fruitNotebook", 1 )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 25 )
					dbExec( handler, "UPDATE bonustable SET FruitNotebook = ? WHERE Name LIKE ?", vioGetElementData ( player, "fruitNotebook" ), pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Spielekonsole" then
			if vioGetElementData ( player, "gameboy" ) >= 1 then
				ouputChatBox ( "Du hast bereits einen Gameboy!", player, 125, 0, 0 )
			else
				if bonuspoints >= 25 then
					vioSetElementData ( player, "gameboy", 1 )
					outputChatBox ( "Du hast dir eine Spielekonsole gekauft und kannst sie nun im Inventar verwenden!", player, 0, 125, 0 )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 25 )
					dbExec( handler, "UPDATE bonustable SET Gameboy = '1' WHERE Name LIKE ?", pname )
					triggerClientEvent ( player, "refreshBonus", player, "" )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Schachspiel" then
			if vioGetElementData ( player, "chess" ) then
				outputChatBox ( "Du hast bereits ein Schachspiel in deinem Inventar!", player, 125, 0, 0 )
			else
				if bonuspoints >= 15 then
					outputChatBox ( "Schachspiel gekauft - schau in deinem Inventar nach!", player, 0, 125, 0 )
					vioSetElementData ( player, "chess", true )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 15 )
					triggerClientEvent ( player, "refreshBonus", player, "" )
					dbExec( handler, "UPDATE bonustable SET Schach = '1' WHERE Name LIKE ?", pname )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Fernglas" then
			if vioGetElementData ( player, "fglass" ) then
				outputChatBox ( "Du hast bereits ein Fernglas in deinem Inventar!", player, 125, 0, 0 )
			else
				if bonuspoints >= 10 then
					outputChatBox ( "Fernglas gekauft - schau in deinem Inventar nach!", player, 0, 125, 0 )
					vioSetElementData ( player, "fglass", true )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 10 )
					triggerClientEvent ( player, "refreshBonus", player, "" )
					dbExec( handler, "UPDATE bonustable SET fglass = '1' WHERE Name LIKE ?", pname )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		elseif bonus == " Doppel SMG" then
			if vioGetElementData ( player, "doubleSMG" ) then
				if getPedStat ( player, 75 ) == 999 then
					setPedStat ( player, 75, 600 )
					outputChatBox ( "Es wird eine Waffe verwendet.", player, 200, 200, 0 )
				else
					setPedStat ( player, 75, 999 )
					outputChatBox ( "Es werdem zwei Waffen verwendet.", player, 200, 200, 0 )
				end
			else
				if bonuspoints >= 50 then
					outputChatBox ( "Skill gekauft!", player, 0, 125, 0 )
					setPedStat ( player, 75, 999 )
					vioSetElementData ( player, "doubleSMG", true )
					vioSetElementData ( player, "bonuspoints", bonuspoints - 50 )
					triggerClientEvent ( player, "refreshBonus", player, "" )
					dbExec( handler, "UPDATE bonustable SET uzi = '1' WHERE Name LIKE ?", pname )
				else
					outputChatBox ( "Du hast nicht genug Bonuspunkte!", player, 125, 0, 0 )
				end
			end
		end
		dbExec( handler, "UPDATE bonustable SET Bonuspunkte = ? WHERE Name LIKE ?", vioGetElementData ( player, "bonuspoints" ), pname )
	end
end
addEvent ( "bonusBuy", true )
addEventHandler ( "bonusBuy", getRootElement(), bonusBuy_func )