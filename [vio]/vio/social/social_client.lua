-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

--socialStateCount = 24
availableSocialStates = {}
reachableSocialStates = {}
socialStateGroups = {}
-- Anfaengerraenge --
socialStateGroups[1] = { [1]=true, [2]=true, [3]=true, [4]=true, [5]=true }
-- Fraktionsraenge --
socialStateGroups[2] = { [6]=true, [7]=true, [14]=true }
-- Job Raenge --
socialStateGroups[3] = { [8]=true }
-- Achievment Raenge --
socialStateGroups[4] = { [9]=true, [19]=true, [23]=true, [24]=true }
-- Geld Raenge --
socialStateGroups[5] = { [11]=true, [12]=true, [13]=true }
-- Besitz Raenge --
socialStateGroups[6] = { [10]=true, [15]=true, [16]=true, [17]=true, [18]=true }
-- Sucht Raenge --
socialStateGroups[7] = { [20]=true, [21]=true, [22]=true }
-- Hobby Raenge --
socialStateGroups[8] = { [25]=true, [26]=true }

socialStates = {
 [1]="Obdachloser",
 [2]="Illegaler Immigrant",
 [3]="Immigrant",
 [4]="Buerger",
 [5]="Arbeiter",
 [6]="Neuling",
 [7]="Aufsteiger",
 [8]="Dealer",
 [9]="Waffenschieber",
 [10]="Hausbesitzer",
 [11]="Finanzhai",
 [12]="Millionaer",
 [13]="Multimillionaer",
 [14]="Faedenzieher",
 [15]="Geschaeftsmann",
 [16]="Wirtschaftsboss",
 [17]="Reich & Schoen",
 [18]="God of Vio",
 [19]="Rentner",
 [20]="Kettenraucher",
 [21]="Saufbruder",
 [22]="Junkie",
 [23]="Gluecksschmied",
 [24]="Hasadeur",
 [25]="Blumenkind",
 [26]="Ferngesteuert"
}

socialStateCount = 0
for key, index in pairs ( socialStates ) do
	socialStateCount = socialStateCount + 1
end

socialNeeds = {
 ["Obdachloser"]="-",
 ["Illegaler Immigrant"]="\nNeuer Skin\n30 Spielminuten",
 ["Immigrant"]="Personalausweiss\n45 Spielminuten",
 ["Buerger"]="Neue Spawnpunkt\n3 Spielstunden",
 ["Arbeiter"]="Job\neigenes Fahrzeug\n5 Spielstunden",
 ["Neuling"]="Fraktion\n30 Spielstunden",
 ["Aufsteiger"]="Fraktion Rang 2\n75 Spielstunden",
 ["Dealer"]="Dealer als Job",
 ["Waffenschieber"]="Waffenschieber-\nAchievment",
 ["Hausbesitzer"]="Eigenes Haus",
 ["Finanzhai"]="500.000 $",
 ["Millionaer"]="1.000.000 $",
 ["Multimillionaer"]="3.000.000 $",
 ["Faedenzieher"]="Fraktion Rang 4\n250 Spielstunden",
 ["Geschaeftsmann"]="Eigenes Biz",
 ["Wirtschaftsboss"]="Finanzhai\nEigenes Biz\n400 Spielstunden",
 ["Reich & Schoen"]="Eigenes Haus\nYacht\n200 Spielstunden",
 ["God of Vio"]="30 Stunden Spielzeit\nAlle 25 Paeckchen\nEigene Yacht\n250.000 $\nEigenes Auto",
 ["Rentner"]="750 Spielstunden\nKeinen Job\nKeine Fraktion",
 ["Kettenraucher"]="Zigaretten-\nsucht LVL 3",
 ["Saufbruder"]="Alkohol-\nsucht LVL 3",
 ["Junkie"]="Drogensucht\nLVL 3",
 ["Gluecksschmied"]="\nAlle 25 Hufeisen",
 ["Hasadeur"]="\nJe 100.000 $\nim Casino gewinnen\nund verlieren",
 ["Blumenkind"]="\n\nMitglied im\nGartenclub",
 ["Ferngesteuert"]="\n\nMitglied im\nRC-Club"
}

function stringToSocID ( id )

	for key, index in pairs ( socialStates ) do
		if index == id then
			return key
		end
	end
end

function getPlayerSocialAvailableStates ()

	local spielzeit = getElementData ( lp, "playingtime" )
	local totalMoney = getElementData ( lp, "money" ) + getElementData ( lp, "bankmoney" )
	availableSocialStates = nil
	availableSocialStates = {}
	reachableSocialStates = nil
	reachableSocialStates = {}
	for i = 1, socialStateCount do
		reachableSocialStates[i] = false
		availableSocialStates[i] = false
	end
	
	-- **Gruppe 1 - Anfaengerraenge ** --
		if malehomeless [ getElementModel ( lp ) ] or femalehomeless [ getElementModel ( lp ) ] then
			-- Obdachloser
			availableSocialStates[1] = true
			reachableSocialStates[2] = true
		elseif spielzeit >= 300 and getElementData ( lp, "curcars" ) >= 1 and getElementData ( lp, "job" ) ~= "none" then
			-- Arbeiter
			availableSocialStates[5] = true
			reachableSocialStates[6] = true
			reachableSocialStates[8] = true
			reachableSocialStates[10] = true
			reachableSocialStates[11] = true
			reachableSocialStates[15] = true
		elseif spielzeit >= 180 and getElementData ( lp, "spawnpos_y" ) ~= -2458.288085 then
			-- Buerger
			availableSocialStates[4] = true
			reachableSocialStates[5] = true
		elseif spielzeit >= 45 and getElementData ( lp, "perso" ) == 1 then
			-- Immigrant
			availableSocialStates[3] = true
			reachableSocialStates[4] = true
		else
			-- Illegaler Immigrant
			availableSocialStates[2] = true
			reachableSocialStates[3] = true
		end
	-- **Gruppe 2 - Fraktionsbasiert** --
		if getElementData ( lp, "fraktion" ) >= 1 then
			if getElementData ( lp, "rang" ) >= 4 and spielzeit >= 15000 then
				-- Faedenzieher --
				availableSocialStates[14] = true
			elseif getElementData ( lp, "rang" ) >= 2 and spielzeit >= 4500 then
				-- Aufsteiger --
				availableSocialStates[7] = true
				reachableSocialStates[14] = true
			elseif spielzeit >= 1200 then
				-- Neuling --
				availableSocialStates[6] = true
				reachableSocialStates[7] = true
			else
				reachableSocialStates[6] = true
			end
		end
	-- **Gruppe 3 - Jobbasiert** --
		if getElementData ( lp, "job" ) == "dealer" then
			-- Dealer --
			availableSocialStates[8] = true
		end
	-- **Gruppe 4 - Achievmentbasiert** --
		if getElementData ( lp, "gunloads" ) == "done" then
			availableSocialStates[9] = true
		end
		if getElementData ( lp, "totalHorseShoes" ) == 25 then
			availableSocialStates[23] = true
		end
		if getElementData ( lp, "chickendinner_achiev" ) == 1 and getElementData ( lp, "nichtsgehtmehr_achiev" ) == 1 then
			availableSocialStates[24] = true
		end
		if getElementData ( lp, "job" ) == "none" then
			if getElementData ( lp, "fraktion" ) == 0 then
				if getElementData ( lp, "playingtime" ) >= 45000 then
					availableSocialStates[19] = true
				end
			end
		else
			reachableSocialStates[19] = true
		end
	-- **Gruppe 5 - Geldbasiert** --
		if totalMoney >= 3000000 then
			availableSocialStates[13] = true
		elseif totalMoney >= 1000000 then
			availableSocialStates[12] = true
			reachableSocialStates[13] = true
		elseif totalMoney >= 500000 then
			availableSocialStates[11] = true
			reachableSocialStates[12] = true
		else
			reachableSocialStates[11] = true
		end
	-- **Gruppe 6 - Besitzbasiert** --
		if spielzeit >= 30000 and getElementData ( lp, "housekey" ) > 0 and getElementData ( lp, "collectr_achiev" ) == "done" and getElementData ( lp, "yachtImBesitz" ) then
			availableSocialStates[18] = true
		elseif spielzeit >= 30000 and getElementData ( lp, "housekey" ) > 0 and getElementData ( lp, "yachtImBesitz" ) then
			availableSocialStates[17] = true
			reachableSocialStates[18] = true
		elseif spielzeit >= 30000 and totalMoney >= 500000 and getElementData ( lp, "bizkey" ) >= 1 then
			availableSocialStates[16] = true
			reachableSocialStates[17] = true
		elseif getElementData ( lp, "bizkey" ) >= 1 then
			availableSocialStates[15] = true
			reachableSocialStates[16] = true
		elseif getElementData ( lp, "housekey" ) > 0 then
			availableSocialStates[10] = true
			reachableSocialStates[15] = true
		else
			reachableSocialStates[10] = true
		end
	-- **Gruppe 7 - Suchtbasiert** --
		if vioGetElementData ( player, "drugAddictPoints" ) and vioGetElementData ( player, "alcoholAddictPoints" ) and vioGetElementData ( player, "cigarettAddictPoints" ) then
			if math.floor ( vioGetElementData ( player, "cigarettAddictPoints" ) / addictLevelDivisors[1] ) >= 3 then
				availableSocialStates[20] = true
			elseif math.floor ( vioGetElementData ( player, "alcoholAddictPoints" ) / addictLevelDivisors[2] ) >= 3 then
				availableSocialStates[21] = true
			elseif math.floor ( vioGetElementData ( player, "drugAddictPoints" ) / addictLevelDivisors[3] ) >= 3 then
				availableSocialStates[22] = true
			end
		end
	-- **Gruppe 8 - Hobbybasiert** --
		if vioGetElementData ( player, "club" ) == "rc" then
			availableSocialStates[26] = true
		elseif vioGetElementData ( player, "club" ) == "gartenverein" then
			availableSocialStates[25] = true
		end
	return nil
end

function getNextBestState ()

	for key, state in pairs ( availableSocialStates ) do
		if availableSocialStates[key] then
			return socialStates[key]
		end
	end
end

function checkForSocialStateChanges ()

	if getElementData ( lp, "loggedin" ) == 1 then
		local oldAvailableSocialStates = table.copy ( availableSocialStates )
		local debug = getPlayerSocialAvailableStates ()
		for key, state in pairs ( availableSocialStates ) do
			if not oldAvailableSocialStates[key] and availableSocialStates[key] then
				outputChatBox ( "Du hast einen neuen sozialen Status freigeschaltet: "..socialStates[key].."!", 0, 125, 0 )
				outputChatBox ( "Vergiss nicht, ihn im Optionsmenue zu aktivieren!", 0, 125, 0 )
			end
		end
		for key, state in pairs ( oldAvailableSocialStates ) do
			if not availableSocialStates[key] and oldAvailableSocialStates[key] then
				if socialNeeds[getElementData ( lp, "socialState" )] then
					if not availableSocialStates[stringToSocID(getElementData ( lp, "socialState" ))] then
						local newState = getNextBestState ()
						setElementData ( lp, "socialState", newState, true )
						outputChatBox ( "Du hast deinen sozialen Status verloren - dein Status wurde auf "..newState.." gesetzt!", 125, 0, 0 )
					else
						outputChatBox ( "Du hast einen sozialen Status verloren: "..socialStates[key].."!", 125, 0, 0 )
					end
				end
			end
		end
	end
end