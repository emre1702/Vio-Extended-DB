MafiaExit = createMarker ( -42.649452209473, 1405.7553710938, 1084.0788574219, "corona", 1, getColorFromString ( "#FF000099" ) )
setElementInterior (MafiaExit, 8)

vincenzo = createPed ( 46, -50.07, 1403.25, 1084.42 )
setElementInterior (vincenzo, 8)
setPedRotation(vincenzo, 0)
local x, y, z = getElementPosition ( vincenzo )
vioSetElementData ( vincenzo, "bot", true )
vioSetElementData ( vincenzo, "sx", x )
vioSetElementData ( vincenzo, "sy", y )
vioSetElementData ( vincenzo, "sz", z )
vioSetElementData ( vincenzo, "dim", 0 )
vioSetElementData ( vincenzo, "int", 8 )
vioSetElementData ( vincenzo, "rot", getPedRotation ( vincenzo ) )
vioSetElementData ( vincenzo, "botname", "vincenzo" )

MafiaEnter = createMarker ( -777.915, 883.9804, 11.98, "corona", 1, getColorFromString ( "#FF000099" ) )

MafiaDeliver = createMarker ( -703.47137451172, 950.21221923828, 12.39155960083, "checkpoint", 7, 0, 125, 0, getRootElement() )
DeliverBlip = createBlip ( -703.47137451172, 950.21221923828, 12.39155960083, 19, 2, 255, 0, 0, 255, 0, 99999.0, getRootElement() )
setElementVisibleTo ( MafiaDeliver, getRootElement(), false )
setElementVisibleTo ( DeliverBlip, getRootElement(), false )

function MafiaExit_func ( player, dim )
   
	if dim then
		fadeElementInterior ( player, 0, -777.915, 881.9804, 11.98 )
		toggleControl ( player, "fire", true )
		toggleControl ( player, "enter_exit", true )
		toggleControl ( player, "action", true )
		vioSetElementData ( player,"nodmzone", 0)
	end
end
addEventHandler ( "onMarkerHit", MafiaExit, MafiaExit_func )


local function MafiaDeliver_func_DB2 ( qh, veh ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local d = result[1]
		MafiaFamkasse = tonumber( d["DepotGeld"] ) - vioGetElementData ( veh, "costs" )
		dbExec( handler, "UPDATE fraktionen SET DepotGeld = ? WHERE Name LIKE 'Mafia'", MafiaFamkasse )
	end
end

local function MafiaDeliver_func_DB1 ( qh, player, dim, veh ) 
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local d = result[1]
		MafiaSchlagringe = d["Schlagringe"] + vioGetElementData( veh, "schlagringe" )
		MafiaBaseballschlaeger = d["Baseballschlaeger"] + vioGetElementData( veh, "baseball" )
		MafiaMesser = d["Messer"] + vioGetElementData( veh, "knife" )
		MafiaSchaufeln = d["Schaufeln"] + vioGetElementData( veh, "shovels" )
		MafiaPistolen = d["Pistolen"] + vioGetElementData( veh, "pistol" )
		MafiaSDPistolen = d["SDPistolen"] + vioGetElementData( veh, "sdpistol" )
		MafiaPistolenMagazine = d["PistolenMagazine"] + vioGetElementData( veh, "pistolammo" )
		MafiaDesertEagles = d["DesertEagles"] + vioGetElementData( veh, "eagle" )
		MafiaDesertEagleMunition = d["DesertEagleMunition"] + vioGetElementData( veh, "eagleammo" )
		MafiaSchrotflinten = d["Schrotflinten"] + vioGetElementData( veh, "shotgun" )
		MafiaSchrotflintenMunition = d["SchrotflintenMunition"] + vioGetElementData( veh, "shotgunammo" )
		MafiaMP = d["MP"] + vioGetElementData( veh, "mp" )
		MafiaMPMunition = d["MPMunition"] + vioGetElementData( veh, "mpammo" )
		MafiaAK = d["AK"] + vioGetElementData( veh, "ak" )
		MafiaAKMunition = d["AKMunition"] + vioGetElementData( veh, "akammo" )
		MafiaM = d["M"] + vioGetElementData( veh, "m" )
		MafiaMMunition = d["MMunition"] + vioGetElementData( veh, "mammo" )
		MafiaGewehre = d["Gewehre"] + vioGetElementData( veh, "gewehr" )
		MafiaGewehrPatronen = d["GewehrPatronen"] + vioGetElementData( veh, "gewehrammo" )
		MafiaSGewehr = d["SGewehr"] + vioGetElementData( veh, "sgewehr" )
		MafiaSGewehrMunition = d["SGewehrMunition"] + vioGetElementData( veh, "sgewehrammo" )
		MafiaRaketenwerfer = d["Raketenwerfer"] + vioGetElementData( veh, "rakwerfer" )
		MafiaRaketen = d["Raketen"] + vioGetElementData( veh, "rak" )
		MafiaSpezwaffen = d["Spezwaffen"] + vioGetElementData( veh, "spezgun" )
		
		local querystr = dbPrepareString( handler, "UPDATE fraktionswaffen SET Schlagringe = ?, ", MafiaSchlagringe )
		querystr = querystr .. dbPrepareString( handler, "Baseballschlaeger = ?, ", MafiaBaseballschlaeger )
		querystr = querystr .. dbPrepareString( handler, "Messer = ?, ", MafiaMesser )
		querystr = querystr .. dbPrepareString( handler, "Schaufeln = ?, ", MafiaSchaufeln )
		querystr = querystr .. dbPrepareString( handler, "Pistolen = ?, ", MafiaPistolen )
		querystr = querystr .. dbPrepareString( handler, "SDPistolen = ?, ", MafiaSDPistolen )
		querystr = querystr .. dbPrepareString( handler, "PistolenMagazine = ?, ", MafiaPistolenMagazine )
		querystr = querystr .. dbPrepareString( handler, "DesertEagles = ?, ", MafiaDesertEagles )
		querystr = querystr .. dbPrepareString( handler, "DesertEagleMunition = ?, ", MafiaDesertEagleMunition )
		querystr = querystr .. dbPrepareString( handler, "Schrotflinten = ?, ", MafiaSchrotflinten )
		querystr = querystr .. dbPrepareString( handler, "SchrotflintenMunition = ?, ", MafiaSchrotflintenMunition )
		querystr = querystr .. dbPrepareString( handler, "MP = ?, ", MafiaMP )
		querystr = querystr .. dbPrepareString( handler, "MPMunition = ?, ", MafiaMPMunition )
		querystr = querystr .. dbPrepareString( handler, "AK = ?, ", MafiaAK )
		querystr = querystr .. dbPrepareString( handler, "M = ?, ", MafiaM )
		querystr = querystr .. dbPrepareString( handler, "MMunition = ?, ", MafiaMMunition )
		querystr = querystr .. dbPrepareString( handler, "Gewehre = ?, ", MafiaGewehre )
		querystr = querystr .. dbPrepareString( handler, "GewehrPatronen = ?, ", MafiaGewehrPatronen )
		querystr = querystr .. dbPrepareString( handler, "SGewehr = ?, ", MafiaSGewehr )
		querystr = querystr .. dbPrepareString( handler, "SgewehrMunition = ?, ", MafiaSGewehrMunition )
		querystr = querystr .. dbPrepareString( handler, "Raketenwerfer = ?, ", MafiaRaketenwerfer )
		querystr = querystr .. dbPrepareString( handler, "Raketen = ?, ", MafiaRaketen )
		querystr = querystr .. dbPrepareString( handler, "Spezwaffen = ? ", MafiaSpezwaffen )
		querystr = querystr .. dbPrepareString( handler, "WHERE Fraktion LIKE 'Mafia'" )
		dbExec( handler, querystr )

		dbQuery( MafiaDeliver_func_DB2, { veh }, handler, "SELECT DepotGeld FROM fraktionen WHERE Name LIKE 'Mafia'" )
	end
end

function MafiaDeliver_func ( player, dim )
   
	local veh = getPedOccupiedVehicle ( player )
	if getPedOccupiedVehicleSeat ( player ) == 0 then
		if getElementModel ( veh ) == 455 then
			if vioGetElementData ( veh, "guntruck" ) == 1 then
			
				mafiatransport = 0

				dbQuery( MafiaDeliver_func_DB1, { player, dim, veh }, handler, "SELECT * FROM fraktionswaffen WHERE Fraktion LIKE 'Mafia'" )
				
				outputChatBox ( "Lieferung abgegeben - Du erhaelst "..vioGetElementData ( veh, "costs" ).." $ aus der Familienkasse! zurueck!", player, 0, 125, 0 )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + vioGetElementData ( veh, "costs" ) )
				givePlayerMoney ( player, vioGetElementData ( veh, "costs" ) )
				if vioGetElementData ( player, "gunloads" ) ~= "done" then 																								-- Achiev: Waffenschieber
					vioSetElementData ( player, "gunloads", tonumber(vioGetElementData ( player, "gunloads" )) + tonumber(vioGetElementData ( veh, "costs" )) )					-- Achiev: Waffenschieber
					if vioGetElementData ( player, "gunloads" ) > 50000 then																								-- Achiev: Waffenschieber
						vioSetElementData ( player, "gunloads", "done" )																									-- Achiev: Waffenschieber
						triggerClientEvent ( player, "showAchievmentBox", player, "Waffenschieber", 50, 10000 )															-- Achiev: Waffenschieber
						vioSetElementData ( player, "bonuspoints", vioGetElementData ( player, "bonuspoints" ) + 50 )															-- Achiev: Waffenschieber
						MySQL_SetString("achievments", "Waffenschieber", vioGetElementData ( player, "gunloads" ), dbPrepareString( handler, "Name LIKE ?", getPlayerName(player) ) )				-- Achiev: Waffenschieber
					end																																					-- Achiev: Waffenschieber
				end																																						-- Achiev: Waffenschieber
				triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				removePedFromVehicle ( player )
				removePedFromVehicle ( getVehicleOccupant ( veh, 1 ) )
				setElementPosition ( veh, 0, 0, -500 )
				destroyElement ( veh )
			end
		end
	end
end
addEventHandler ( "onMarkerHit", MafiaDeliver, MafiaDeliver_func )

function MafiaEnter_func ( player, dim )

	if dim then
		if not getPedOccupiedVehicle ( player ) then
			if vioGetElementData ( player, "fraktion" ) == 2 then
				fadeElementInterior ( player, 8, -42.649452209473, 1407.25, 1084.078 )
				toggleControl ( player, "fire", false )
				toggleControl ( player, "enter_exit", false )
				toggleControl ( player, "action", false )
				vioSetElementData( player,"nodmzone", 1)
			end
		end
	end
end
addEventHandler ( "onMarkerHit", MafiaEnter, MafiaEnter_func )