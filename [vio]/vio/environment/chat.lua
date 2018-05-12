allTeam = createTeam ( "ChatTeam", 255, 255, 255 )

function playerJoinTeam ()

	setPlayerTeam ( source, allTeam )
end
addEventHandler ( "onPlayerJoin", getRootElement(), playerJoinTeam )

function chatAble ( player )
	
	if vioGetElementData ( player, "loggedin" ) == 1 and not isPedDead ( player ) then
		return true
	end
	return false
end

function sendMessageToNearbyPlayers ( message, messageType )

	local pname = getPlayerName ( source )
	
	if messageType == 0 and chatAble ( source ) then
		if tonumber(vioGetElementData ( source, "muted" )) == 0 then
			local posX, posY, posZ = getElementPosition( source )
			local chatSphere = createColSphere( posX, posY, posZ, 10 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			if vioGetElementData ( source, "isLive" ) then
				if isReporter ( source ) then name = "Reporter "..getPlayerName(source).." : " else name = "Gast "..getPlayerName(source).." : " end
				outputChatBox ( name..message, getRootElement(), 200, 150, 0 )
			else
				local x1, y1, z1 = getElementPosition ( source)
				for i = 1, 3 do
					if _G["Wanze"..i] then
						local x2, y2, z2 = getElementPosition ( _G["Wanze"..i] )
						local x3, y3, z3 = getElementPosition ( FederalBoxville )
						local distance = getDistanceBetweenPoints3D ( x1,y1,z1,x2,y2,z2 )
						if distance then
							if distance <= 10 then
								if getDistanceBetweenPoints3D ( x3, y3, z3, x2, y2, z2 ) <= wanzenrange then
									local msg = "Wanze "..i.." - "..getPlayerName(source)..": "..message
									sendMSGToBoxville ( msg )
								end
							end
						end
					end
				end
				for index, nearbyPlayer in ipairs( nearbyPlayers ) do
					local x2, y2, z2 = getElementPosition ( nearbyPlayer )
					local distance = getDistanceBetweenPoints3D ( x1,y1,z1,x2,y2,z2 )
					local rgb = 15 * distance - 125
					local rgb = math.abs ( rgb - 255 ) + 125
					if getElementDimension ( source ) == getElementDimension ( nearbyPlayer ) then
						if vioGetElementData ( source, "call" ) == true then
							if isElement ( nearbyPlayer ) then
								outputChatBox ( pname.. " (Handy) sagt: " ..message, nearbyPlayer, rgb, rgb, rgb )
							end
						else
							if vioGetElementData ( source, "callswithpolice" ) == true then
								local taeter = getPlayerFromName ( message )
								if taeter then
									outputChatBox ( "Wir werden der Sache nachgehen.", source, 0, 0, 200 )
									crime = "none"
									if vioGetElementData ( taeter, "lastcrime" ) == "mord" then
										crime = "Mord"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "drogen" then
										crime = "Drogennehmen"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "drugdealing" then
										crime = "Drogenhandel"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "mats" then
										crime = "Waffenhandel"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "violance" then
										crime = "Koerperverletzung"
									end
									if crime ~= "none" then
										outputChatBox ( "Du hast ein Verbrechen begangen: "..crime..", gemeldet von: "..getPlayerName(source), taeter, 0, 0, 150 )
										if vioGetElementData ( taeter, "wanteds" ) <= 5 then
											vioSetElementData ( taeter, "wanteds", vioGetElementData ( taeter, "wanteds" ) + 1 )
											setPlayerWantedLevel ( taeter, vioGetElementData ( taeter, "wanteds" ) )
										end
										vioSetElementData ( taeter, "lastcrime", "none" )
									end
								else
									outputChatBox ( "Es tut uns leid Sir, der Taeter ist uns unbekannt.", source, 0, 0, 200 )
								end
								vioSetElementData ( source, "callswithpolice", false )
							else
								outputChatBox ( pname.. " sagt: " ..message, nearbyPlayer, rgb, rgb, rgb )
							end
						end
					end
				end
			end
			if vioGetElementData ( source, "call" ) == true then
				local target = getPlayerFromName(vioGetElementData(source,"callswith"))
				outputChatBox ( pname.." am Handy: "..message, target, 200, 200, 50 )
			end
		else
			outputChatBox ( "Du bist gemuted und kannst deshalb nicht sprechen!", source, 125, 0, 0 )
		end
	else
		if messageType == 2 then
			executeCommandHandler ( "t", source, message )
		elseif messageType == 1 then
			if tonumber(vioGetElementData ( source, "muted" )) == 0 then
				local posX, posY, posZ = getElementPosition( source )
				local chatSphere = createColSphere( posX, posY, posZ, 20 )
				local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
				destroyElement( chatSphere )
				for index, nearbyPlayer in ipairs( nearbyPlayers ) do
					local pname = getPlayerName ( source )
					outputChatBox ( pname.." "..message, nearbyPlayer, 100, 0, 200 )
				end
			else
				outputChatBox ( "Du bist gemuted und kannst deshalb nicht sprechen!", source, 125, 0, 0 )
			end
		end
	end
end
if not isThisTheBetaServer () then
	addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )
end

function meCMD_func ( player, cmd, ... )

	local tb = {...}
	local msg = table.concat ( tb, " " )
	
	local pname = getPlayerName ( player )
	local posX, posY, posZ = getElementPosition ( player )
	local chatSphere = createColSphere( posX, posY, posZ, 20 )
	local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
	destroyElement( chatSphere )
	for index, nearbyPlayer in pairs ( nearbyPlayers ) do
		local pname = getPlayerName ( player )
		outputChatBox ( pname.." "..msg, nearbyPlayer, 200, 0, 200 )
	end
end
addCommandHandler ( "meCMD", meCMD_func )

function blockmsg ( message, messageType )
	cancelEvent()
end
if not isThisTheBetaServer() then
	addEventHandler( "onPlayerChat", getRootElement(), blockmsg )
end

function s_func ( player, cmd, ... )

	if chatAble ( player ) then
		local posX, posY, posZ = getElementPosition( player )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		local parametersTable = {...}
		local stringWithAllParameters = table.concat( parametersTable, " " )
		local pname = getPlayerName ( player )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			outputChatBox ( pname.." schreit: "..stringWithAllParameters.."!!!", nearbyPlayer, 255, 255, 255 )
		end
	end
end
addCommandHandler ( "s", s_func )

function l_func ( player, cmd, ... )

	if chatAble ( player ) then
		local posX, posY, posZ = getElementPosition( player )
		local chatSphere = createColSphere( posX, posY, posZ, 3 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		local parametersTable = {...}
		local stringWithAllParameters = table.concat( parametersTable, " " )
		local pname = getPlayerName ( player )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			outputChatBox ( pname.." fluestert: "..stringWithAllParameters.."...", nearbyPlayer, 150, 150, 150 )
		end
	end
end
addCommandHandler ( "l", l_func )