local loehne_payday = {}

for i = 1, 9, 1 do
	loehne_payday[i] = {}
end
	
loehne_payday[1][0] = 750
loehne_payday[1][1] = 1500
loehne_payday[1][2] = 2250
loehne_payday[1][3] = 2750
loehne_payday[1][4] = 3250
loehne_payday[1][5] = 4000

loehne_payday[6][0] = 1000
loehne_payday[6][1] = 1750
loehne_payday[6][2] = 2500
loehne_payday[6][3] = 3000
loehne_payday[6][4] = 3500
loehne_payday[6][5] = 4500

loehne_payday[8][0] = 500
loehne_payday[8][1] = 2000
loehne_payday[8][2] = 2750
loehne_payday[8][3] = 3250
loehne_payday[8][4] = 3750
loehne_payday[8][5] = 4750

loehne_payday[5][0] = 500
loehne_payday[5][1] = 1200
loehne_payday[5][2] = 1800
loehne_payday[5][3] = 2300
loehne_payday[5][4] = 2700
loehne_payday[5][5] = 3200

local test_table = {}
test_table[1] = 2
test_table[2] = 3
test_table[3] = 7
test_table[4] = 9
test_table[5] = 4

for i = 1, 5, 1 do

	loehne_payday[test_table[i]][0] = 350
	loehne_payday[test_table[i]][1] = 750
	loehne_payday[test_table[i]][2] = 1200
	loehne_payday[test_table[i]][3] = 1700
	loehne_payday[test_table[i]][4] = 2300
	loehne_payday[test_table[i]][5] = 2800	

end

function payday ( player )

	if math.floor ( vioGetElementData ( player, "playingtime" ) / 60 ) == ( vioGetElementData ( player, "playingtime" ) / 60 ) then
	
		local player_payday = {}
		
		local faction = getPlayerFaction ( player )
		local rank = getPlayerRank ( player )
		player_payday["Boni"] = tonumber(vioGetElementData( player, "boni" )) 
		
		if isEvil ( player ) then
		
			player_payday["Zuschuesse"] = loehne_payday[faction][rank]
			
		else
		
			player_payday["Zuschuesse"] = 0
			
		end
		
		if isStateFaction ( player ) then
		
			local incoming = tonumber(vioGetElementData( player, "pdayincome" ))
			local multiplikator
			
			if incoming > 50 then
				multiplikator = 1
			elseif incoming > 40 then
				multiplikator = 5/6
			elseif incoming > 30 then
				multiplikator = 4/6
			elseif incoming > 20 then
				multiplikator = 3/6
			elseif incoming > 10 then
				multiplikator = 2/6
			else
				multiplikator = 1/6
			end
			
			local var = math.floor(loehne_payday[faction][rank] * multiplikator)
		
			player_payday["Lohn"] = var
			
		elseif faction == 5 then
		
			player_payday["Lohn"] = loehne_payday[faction][rank]
			
		else
		
			player_payday["Lohn"] = 0
		
		end
		
		local grund 
		local costs
		
		if vioGetElementData ( player, "handyType" ) == 1 then
			grund = 10
			costs = tonumber(vioGetElementData( player, "handyCosts" ))
		elseif vioGetElementData ( player, "handyType" ) == 2 then
			grund = 0
			costs = 0
		else
			grund = 50
			costs = 0
		end
		
		player_payday["Handykosten"] = grund + costs
		
		local club = vioGetElementData ( player, "club" )
		
		if club == "gartenverein" then
			player_payday["Clubkosten"] = 30
			outputChatBox ( "Um deine Clubmitgliedschaft zu kuendigen, tippe /leaveclub", player, 125, 0, 0 )
		elseif club == "biker" then
			player_payday["Clubkosten"] = 50
			mystiesBarKasse = mystiesBarKasse + 50
			outputChatBox ( "Um deine Clubmitgliedschaft zu kuendigen, tippe /leaveclub", player, 125, 0, 0 )
		elseif club == "rc" then
			player_payday["Clubkosten"] = 50
			outputChatBox ( "Um deine Clubmitgliedschaft zu kuendigen, tippe /leaveclub", player, 125, 0, 0 )
		else
			player_payday["Clubkosten"] = 0
		end
		local var_zinsen = vioGetElementData( player, "bankmoney" ) * 0.01
		local Zinsen = math.floor(var_zinsen)
		
		if Zinsen > 1500 then
			player_payday["Zinsen"] = 1500
		else
			player_payday["Zinsen"] = Zinsen
		end
		
		local new_steuern = player_payday["Lohn"] + player_payday["Zuschuesse"] + player_payday["Boni"]
		player_payday["Steuern"] = math.floor ( new_steuern * 0.1 )
		
		player_payday["Fahrzeugsteuer"] = math.floor( vioGetElementData(player, "curcars") * 100 )
		
		rent = 0
		
		if vioGetElementData ( player, "housekey" ) < 0 then
			local ID = math.abs(vioGetElementData ( player, "housekey" ))
			local haus = houses["pickup"][ID]
			rent = vioGetElementData ( haus, "miete" )
			local Kasse = MySQL_GetString("houses", "Kasse", "ID LIKE '"..ID.."'")
			local Kasse = Kasse + rent
			MySQL_SetString("houses", "Kasse", Kasse, "ID LIKE '"..ID.."'")
		end
		
		player_payday["Miete"] = rent
		
		if getElementData ( player, "socialState" ) == "Rentner" then
			player_payday["Zuschuesse"] = player_payday["Zuschuesse"] + 1000
		end
		
		local amount = MySQL_ExistAmount ( "gangs", "BesitzerFraktion = '"..faction.."'" )
						
		if vioGetElementData ( player, "stvo_punkte" ) >= 1 then
			vioSetElementData ( player, "stvo_punkte", vioGetElementData ( player, "stvo_punkte" ) - 1 )
			outputChatBox ( "Dir wurde soeben 1 STVO Punkt erlassen!", player, 125, 0, 0 )
		end
		
		if math.floor ( tonumber ( vioGetElementData ( player, "playingtime" ) ) / 120 ) == ( tonumber ( vioGetElementData ( player, "playingtime" ) ) / 120 ) and tonumber ( vioGetElementData ( player, "wanteds" ) ) >= 1 then
			vioSetElementData ( player, "wanteds", vioGetElementData ( player, "wanteds" ) - 1 )
			setPlayerWantedLevel ( player, vioGetElementData ( player, "wanteds" ) )
			outputChatBox ( "Dir wurde soeben 1 Wantedpunkt erlassen!", player, 125, 0, 0 )
		end
						
		outputChatBox ( "|___Zahltag___|", player, 0, 200, 0 )
		outputChatBox ( "Einkommen:", player, 200, 200, 0 )
		outputChatBox ( "Job: "..player_payday["Lohn"].."$; Boni: "..player_payday["Boni"].."$; Zuschuesse: "..player_payday["Zuschuesse"].."$;", player, 200, 200, 0 )
		outputChatBox ( "Kosten:", player, 200, 200, 0 )
		outputChatBox ( "Handykosten: "..player_payday["Handykosten"].."$;", player, 200, 200, 0 )
		outputChatBox ( "Club: "..player_payday["Clubkosten"].."$; Steuern: "..player_payday["Steuern"].."$; Fahrzeugsteuer: "..player_payday["Fahrzeugsteuer"].."$; Miete: "..player_payday["Miete"].."$;", player, 200, 200, 0 )
		outputChatBox ( "Zinsen: "..player_payday["Zinsen"].." $", player, 200, 200, 0 )
		
		if amount > 0 then
			player_payday["Gangarea"] = amount * 100
			outputChatBox ( "Einnahmen durch Ganggebiete: "..player_payday["Gangarea"].."$", player, 0, 200, 0 )
		else
			player_payday["Gangarea"] = 0
		end
		
		player_payday["Gesamt"] = player_payday["Lohn"] + player_payday["Boni"] + player_payday["Zuschuesse"] - player_payday["Handykosten"] - player_payday["Clubkosten"] - player_payday["Steuern"] - player_payday["Fahrzeugsteuer"] - player_payday["Miete"] + player_payday["Zinsen"] + player_payday["Gangarea"]
		
		outputChatBox ( "_______________", player, 125, 0, 0 )
		outputChatBox ( "Einnahmen: "..player_payday["Gesamt"].."$ ", player, 0, 200, 0 )
		outputChatBox ( "Die Einnahmen wurden auf dein Konto ueberwiesen!", player, 125, 0, 125 )
		
		if isHalloween then
			local eggs = vioGetElementData ( player, "easterEggs" )
			vioSetElementData ( player, "easterEggs", eggs + 1 )
			outputChatBox ( "Ausserdem hast du einen Kuerbis bekommen. Loese ihn mit /halloween ein!", player, 0, 125, 0 )
		end
		
		triggerClientEvent ( player, "createNewStatementEntry", player, "Abrechnung\n", player_payday["Gesamt"], "\n" )

		vioSetElementData ( player, "pdayincome", 0 )
		vioSetElementData ( player, "boni", 0 )

		triggerClientEvent ( player, "achievsound", player )

		vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) + player_payday["Gesamt"] )
		datasave_remote ( player )
		
	end
	
end

function pingCheck ( player )

	if not isElement(player) then
		return
	end

	local ping = getPlayerPing ( player )
	
	if ping >= 400 then
		local x, y, z = getElementPosition ( player )
		triggerEvent ( "logoutPlayer", player, x, y, z, getElementInterior ( player ), getElementDimension ( player ), player )
	end
	
	setTimer ( pingCheck, 5000, 1, player )

end

addCommandHandler( "noobtest", 
	function ( player )
	
		local x, y, z = getElementPosition ( player )
		triggerEvent ( "logoutPlayer", player, x, y, z, getElementInterior ( player ), getElementDimension ( player ) )
	
	end, false, false )

function playingtime ( player )

	if isElement ( player ) then
	
		if vioGetElementData ( player, "loggedin" ) == 1 then
		
			setPlayerWantedLevel ( player, tonumber( vioGetElementData ( player, "wanteds" ) ))
			local pname = getPlayerName ( player )
			vioSetElementData ( player, "curplayingtime", vioGetElementData ( player, "curplayingtime" ) + 1 )						-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
				
			if math.random ( 1, 10 ) == 1 then
				checkForSymptoms ( player )
			end
				
			if math.floor ( vioGetElementData ( player, "curplayingtime" ) / 3 ) == vioGetElementData ( player, "curplayingtime" ) / 3 then
				lowerFlush ( player )
			elseif math.floor ( vioGetElementData ( player, "curplayingtime" ) / 20 ) == vioGetElementData ( player, "curplayingtime" ) / 20 then
				lowerAddict ( player )
			end
				
			vioSetElementData ( player, "playingtime", vioGetElementData ( player, "playingtime" ) + 1 )								-- Spielzeit
			
			local jailed = tonumber( vioGetElementData ( player, "jailtime" ) )
			
			if jailed > 1 then
			
				vioSetElementData ( player, "jailtime", jailed - 1 )
				
			elseif jailed == 1 then
			
				freePlayerFromJail ( player )
					
			end
				
			if tonumber ( vioGetElementData ( player, "jobtime" ) ) ~= 0 then
				vioSetElementData ( player, "jobtime", tonumber ( vioGetElementData ( player, "jobtime" ) ) - 1 )
			end
			
			_G[pname.."paydaytime"] = setTimer ( playingtime, 60000, 1, player )
			vioSetElementData ( player, "lastcrime", "none" )
			
			if isOnDuty ( player ) or isArmy ( player ) then	
			
				if isFBI(player) then
					bonus = 1.2
				else
					bonus = 1
				end
				
				local income = tonumber(vioGetElementData( player, "pdayincome" ))
				vioSetElementData ( player, "pdayincome", income+1 )

			end
			
			payday ( player )
			MySQL_SetString("userdata", "Bankgeld", MySQL_Save ( vioGetElementData ( player, "bankmoney") ), "Name LIKE '"..pname.."'")
			MySQL_SetString("userdata", "Geld", MySQL_Save ( vioGetElementData ( player, "money" ) ), "Name LIKE '"..pname.."'")
			ReallifeAchievCheck ( player )
			
			if getPlayerPing ( player ) >= 350 then
				setTimer ( pingCheck, 5000, 1, player )
			end

			vioSetElementData ( player, "timePlayedToday", vioGetElementData ( player, "timePlayedToday" ) + 1 )
			
			if vioGetElementData ( player, "timePlayedToday" ) >= 720 and vioGetElementData ( player, "schlaflosinsa" ) ~= "done" then						-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
				triggerClientEvent ( player, "showAchievmentBox", player, "Schlaflos in SA", 50, 10000 )													-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
				vioSetElementData ( player, "bonuspoints", vioGetElementData ( player, "bonuspoints" ) + 50 )												-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
				vioSetElementData ( player, "schlaflosinsa", "done" )																						-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
				MySQL_SetString("achievments", "SchlaflosInSA", "done", "Name LIKE '"..getPlayerName(player).."'")											-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
			end	
				
		end
			
	end
	
end