factionColours = {}
factionRankNames = {}
	local i = 0
	
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 50, 50, 255
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Cadet"
		factionRankNames[i][1] = "Officer"
		factionRankNames[i][2] = "Sergeant"
		factionRankNames[i][3] = "Lieutenant"
		factionRankNames[i][4] = "Captain"
		factionRankNames[i][5] = "Chief of Police"
	
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 150, 0, 150
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Picciotto"
		factionRankNames[i][1] = "Button Man"
		factionRankNames[i][2] = "Capodecina"
		factionRankNames[i][3] = "Capo"
		factionRankNames[i][4] = "Consiglieri"
		factionRankNames[i][5] = "Don"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 100, 0, 0
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Tin"
		factionRankNames[i][1] = "Heung Chu"
		factionRankNames[i][2] = "Heung Kwan"
		factionRankNames[i][3] = "Sin Fung"
		factionRankNames[i][4] = "Fu Shan Chu"
		factionRankNames[i][5] = "Shan Chu"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 100, 0, 0
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Sympathisant"
		factionRankNames[i][1] = "Genosse"
		factionRankNames[i][2] = "Bombenleger"
		factionRankNames[i][3] = "Freiheitskaempfer"
		factionRankNames[i][4] = "Kommandant"
		factionRankNames[i][5] = "Revolutionsfuehrer"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 125, 50, 200
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Zeitungsjunge"
		factionRankNames[i][1] = "Klatschtante"
		factionRankNames[i][2] = "Zeitungsreporter"
		factionRankNames[i][3] = "Reporter"
		factionRankNames[i][4] = "Journalist"
		factionRankNames[i][5] = "Chefredakteur"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 50, 50, 255
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Trainee"
		factionRankNames[i][1] = "Agent"
		factionRankNames[i][2] = "Special Agent Trainee"
		factionRankNames[i][3] = "Special Agent"
		factionRankNames[i][4] = "Assistant Director"
		factionRankNames[i][5] = "Director"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 125, 125, 0
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Novato"
		factionRankNames[i][1] = "Principiante"
		factionRankNames[i][2] = "Socia"
		factionRankNames[i][3] = "Veterano"
		factionRankNames[i][4] = "Interino"
		factionRankNames[i][5] = "Jefa"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 0, 125, 0
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Private"
		factionRankNames[i][1] = "Corporal"
		factionRankNames[i][2] = "Staff Sergeant"
		factionRankNames[i][3] = "Major"
		factionRankNames[i][4] = "Colonel"
		factionRankNames[i][5] = "Commander"
	i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 100, 50, 100
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Associate"
		factionRankNames[i][1] = "Member"
		factionRankNames[i][2] = "Sergeant at Arms"
		factionRankNames[i][3] = "Road Captain"
		factionRankNames[i][4] = "Vice-President"
		factionRankNames[i][5] = "President"

function teamchat_func ( player, cmd, ... )	

	local parametersTable = {...}
	local text = table.concat( parametersTable, " " )
	local Fraktion = tonumber(vioGetElementData ( player, "fraktion" ))
	local FRank = tonumber(vioGetElementData ( player, "rang" ))
	if Fraktion >= 1 then
		if not text then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nBitte einen\nText eingeben!", 5000, 125, 0, 0 )
		else
			local red = 0
			local green = 0
			local blue = 0
			local title = "intern"
			if factionRankNames[Fraktion][FRank] then
				title = factionRankNames[Fraktion][FRank]
				red, green, blue = factionColours[Fraktion][1], factionColours[Fraktion][2], factionColours[Fraktion][3]
			end
			
			for playeritem, index in pairs(fraktionMembers[Fraktion]) do 
				outputChatBox ( "[ "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem, red, green, blue )
			end
			for playeritem, index in pairs(adminsIngame) do 
				if vioGetElementData ( playeritem, "adminlvl" ) then
					if tonumber(vioGetElementData ( playeritem, "adminlvl" )) >= 4 then
						outputConsole ( "Fraktion "..Fraktion..":", playeritem )
						outputConsole ( " [ "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem )
						outputConsole ( "----------------------------", playeritem )
					end
				end
			end
		end
	elseif isInGang ( getPlayerName ( player ) ) then
		sendMessageToGangMembers ( getPlayerGang ( player ), getPlayerRankNameInGang ( player ).." "..getPlayerName ( player )..": "..text )
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist in\nkeiner Fraktion!", 5000, 125, 0, 0 )
	end
end
addCommandHandler ( "t", teamchat_func )

function gteamchat_func ( player, cmd, ... )	
	
	local parametersTable = {...}
	local text = table.concat( parametersTable, " " )
	local Fraktion = tonumber(vioGetElementData ( player, "fraktion" ))
	local FRank = tonumber(vioGetElementData ( player, "rang" ))
	if Fraktion == 1 or Fraktion == 6 or Fraktion == 8 then
		if text == nil then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nBitte einen\nText eingeben!", 5000, 125, 0, 0 )
		else
			red = 140
			green = 10
			blue = 10
			local title = "intern"
			
			if factionRankNames[Fraktion][FRank] then
				title = factionRankNames[Fraktion][FRank]
			end
			
			if Fraktion == 1 then
				red = 140
				green = 10
				blue = 10
			end
			if Fraktion == 6 then
				red = 140
				green = 10
				blue = 10
			end
			if Fraktion == 8 then
				red = 140
				green = 10
				blue = 10
			end
			for playeritem, key in pairs(fraktionMembers[1]) do
				outputChatBox ( "[ "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem, red, green, blue )
			end
			for playeritem, key in pairs(fraktionMembers[6]) do
				outputChatBox ( "[ "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem, red, green, blue )
			end
			for playeritem, key in pairs(fraktionMembers[8]) do
				outputChatBox ( "[ "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem, red, green, blue )
			end
			for playeritem, index in pairs(adminsIngame) do 
				if vioGetElementData ( playeritem, "adminlvl" ) then
					if tonumber(vioGetElementData ( playeritem, "adminlvl" )) >= 4 then
						outputConsole ( "G-Chat:", playeritem )
						outputConsole ( " [ "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem )
						outputConsole ( "----------------------------", playeritem )
					end
				end
			end
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist in\nkeiner Fraktion!", 5000, 125, 0, 0 )
	end
end
addCommandHandler ("g", gteamchat_func )