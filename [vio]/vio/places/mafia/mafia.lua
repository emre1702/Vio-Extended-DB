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

function MafiaDeliver_func ( player, dim )
   
	local veh = getPedOccupiedVehicle ( player )
	if getPedOccupiedVehicleSeat ( player ) == 0 then
		if getElementModel ( veh ) == 455 then
			if vioGetElementData ( veh, "guntruck" ) == 1 then
			
				mafiatransport = 0
				
				MafiaSchlagringe = MySQL_GetString("fraktionswaffen", "Schlagringe", "Fraktion LIKE 'Mafia'")
				MafiaBaseballschlaeger = MySQL_GetString("fraktionswaffen", "Baseballschlaeger", "Fraktion LIKE 'Mafia'")
				MafiaMesser = MySQL_GetString("fraktionswaffen", "Messer", "Fraktion LIKE 'Mafia'")
				MafiaSchaufeln = MySQL_GetString("fraktionswaffen", "Schaufeln", "Fraktion LIKE 'Mafia'")
				MafiaPistolen = MySQL_GetString("fraktionswaffen", "Pistolen", "Fraktion LIKE 'Mafia'")
				MafiaSDPistolen = MySQL_GetString("fraktionswaffen", "SDPistolen", "Fraktion LIKE 'Mafia'")
				MafiaPistolenMagazine = MySQL_GetString("fraktionswaffen", "PistolenMagazine", "Fraktion LIKE 'Mafia'")
				MafiaDesertEagles = MySQL_GetString("fraktionswaffen", "DesertEagles", "Fraktion LIKE 'Mafia'")
				MafiaDesertEagleMunition = MySQL_GetString("fraktionswaffen", "DesertEagleMunition", "Fraktion LIKE 'Mafia'")
				MafiaSchrotflinten = MySQL_GetString("fraktionswaffen", "Schrotflinten", "Fraktion LIKE 'Mafia'")
				MafiaSchrotflintenMunition = MySQL_GetString("fraktionswaffen", "SchrotflintenMunition", "Fraktion LIKE 'Mafia'")
				MafiaMP = MySQL_GetString("fraktionswaffen", "MP", "Fraktion LIKE 'Mafia'")
				MafiaMPMunition = MySQL_GetString("fraktionswaffen", "MPMunition", "Fraktion LIKE 'Mafia'")
				MafiaAK = MySQL_GetString("fraktionswaffen", "AK", "Fraktion LIKE 'Mafia'")
				MafiaAKMunition = MySQL_GetString("fraktionswaffen", "AKMunition", "Fraktion LIKE 'Mafia'")
				MafiaM = MySQL_GetString("fraktionswaffen", "M", "Fraktion LIKE 'Mafia'")
				MafiaMMunition = MySQL_GetString("fraktionswaffen", "MMunition", "Fraktion LIKE 'Mafia'")
				MafiaGewehre = MySQL_GetString("fraktionswaffen", "Gewehre", "Fraktion LIKE 'Mafia'")
				MafiaGewehrPatronen = MySQL_GetString("fraktionswaffen", "GewehrPatronen", "Fraktion LIKE 'Mafia'")
				MafiaSGewehr = MySQL_GetString("fraktionswaffen", "SGewehr", "Fraktion LIKE 'Mafia'")
				MafiaSGewehrMunition = MySQL_GetString("fraktionswaffen", "SGewehrMunition", "Fraktion LIKE 'Mafia'")
				MafiaRaketenwerfer = MySQL_GetString("fraktionswaffen", "Raketenwerfer", "Fraktion LIKE 'Mafia'")
				MafiaRaketen = MySQL_GetString("fraktionswaffen", "Raketen", "Fraktion LIKE 'Mafia'")
				MafiaSpezwaffen = MySQL_GetString("fraktionswaffen", "Spezwaffen", "Fraktion LIKE 'Mafia'")
				MafiaFamkasse = MafiaFamkasse - vioGetElementData ( veh, "costs" )
				
				MySQL_SetString("fraktionswaffen", "Schlagringe", vioGetElementData ( veh, "schlagringe" )+MafiaSchlagringe, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "Baseballschlaeger", vioGetElementData ( veh, "baseball" )+MafiaBaseballschlaeger, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "Messer", vioGetElementData ( veh, "knife" )+MafiaMesser, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "Schaufeln", vioGetElementData ( veh, "shovels" )+MafiaSchaufeln, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "Pistolen", vioGetElementData ( veh, "pistol" )+MafiaPistolen, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "SDPistolen", vioGetElementData ( veh, "sdpistol" )+MafiaSDPistolen, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "PistolenMagazine", vioGetElementData ( veh, "pistolammo" )+MafiaPistolenMagazine, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "DesertEagles", vioGetElementData ( veh, "eagle" )+MafiaDesertEagles, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "DesertEagleMunition", vioGetElementData ( veh, "eagleammo" )+MafiaDesertEagleMunition, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "Schrotflinten", vioGetElementData ( veh, "shotgun" )+MafiaSchrotflinten, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "SchrotflintenMunition", vioGetElementData ( veh, "shotgunammo" )+MafiaSchrotflintenMunition, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "MP", vioGetElementData ( veh, "mp" )+MafiaMP, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "MPMunition", vioGetElementData ( veh, "mpammo" )+MafiaMPMunition, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "AK", vioGetElementData ( veh, "ak" )+MafiaAK, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "AKMunition", vioGetElementData ( veh, "akammo" )+MafiaAKMunition, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "M", vioGetElementData ( veh, "m" )+MafiaM, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "MMunition", vioGetElementData ( veh, "mammo" )+MafiaMMunition, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "Gewehre", vioGetElementData ( veh, "gewehr" )+MafiaGewehre, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "GewehrPatronen", vioGetElementData ( veh, "gewehrammo" )+MafiaGewehrPatronen, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "SGewehr", vioGetElementData ( veh, "sgewehr" )+MafiaSGewehr, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "SgewehrMunition", vioGetElementData ( veh, "sgewehrammo" )+MafiaSGewehrMunition, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "Raketenwerfer", vioGetElementData ( veh, "rakwerfer" )+MafiaRaketenwerfer, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "Raketen", vioGetElementData ( veh, "rak" )+MafiaRaketen, "Fraktion LIKE 'Mafia'")
				MySQL_SetString("fraktionswaffen", "Spezwaffen", vioGetElementData ( veh, "spezgun" )+MafiaSpezwaffen, "Fraktion LIKE 'Mafia'")
				
				MafiaSchlagringe = MySQL_GetString("fraktionswaffen", "Schlagringe", "Fraktion LIKE 'Mafia'")
				MafiaBaseballschlaeger = MySQL_GetString("fraktionswaffen", "Baseballschlaeger", "Fraktion LIKE 'Mafia'")
				MafiaMesser = MySQL_GetString("fraktionswaffen", "Messer", "Fraktion LIKE 'Mafia'")
				MafiaSchaufeln = MySQL_GetString("fraktionswaffen", "Schaufeln", "Fraktion LIKE 'Mafia'")
				MafiaPistolen = MySQL_GetString("fraktionswaffen", "Pistolen", "Fraktion LIKE 'Mafia'")
				MafiaSDPistolen = MySQL_GetString("fraktionswaffen", "SDPistolen", "Fraktion LIKE 'Mafia'")
				MafiaPistolenMagazine = MySQL_GetString("fraktionswaffen", "PistolenMagazine", "Fraktion LIKE 'Mafia'")
				MafiaDesertEagles = MySQL_GetString("fraktionswaffen", "DesertEagles", "Fraktion LIKE 'Mafia'")
				MafiaDesertEagleMunition = MySQL_GetString("fraktionswaffen", "DesertEagleMunition", "Fraktion LIKE 'Mafia'")
				MafiaSchrotflinten = MySQL_GetString("fraktionswaffen", "Schrotflinten", "Fraktion LIKE 'Mafia'")
				MafiaSchrotflintenMunition = MySQL_GetString("fraktionswaffen", "SchrotflintenMunition", "Fraktion LIKE 'Mafia'")
				MafiaMP = MySQL_GetString("fraktionswaffen", "MP", "Fraktion LIKE 'Mafia'")
				MafiaMPMunition = MySQL_GetString("fraktionswaffen", "MPMunition", "Fraktion LIKE 'Mafia'")
				MafiaAK = MySQL_GetString("fraktionswaffen", "AK", "Fraktion LIKE 'Mafia'")
				MafiaAKMunition = MySQL_GetString("fraktionswaffen", "AKMunition", "Fraktion LIKE 'Mafia'")
				MafiaM = MySQL_GetString("fraktionswaffen", "M", "Fraktion LIKE 'Mafia'")
				MafiaMMunition = MySQL_GetString("fraktionswaffen", "MMunition", "Fraktion LIKE 'Mafia'")
				MafiaGewehre = MySQL_GetString("fraktionswaffen", "Gewehre", "Fraktion LIKE 'Mafia'")
				MafiaGewehrPatronen = MySQL_GetString("fraktionswaffen", "GewehrPatronen", "Fraktion LIKE 'Mafia'")
				MafiaSGewehr = MySQL_GetString("fraktionswaffen", "SGewehr", "Fraktion LIKE 'Mafia'")
				MafiaSGewehrMunition = MySQL_GetString("fraktionswaffen", "SGewehrMunition", "Fraktion LIKE 'Mafia'")
				MafiaRaketenwerfer = MySQL_GetString("fraktionswaffen", "Raketenwerfer", "Fraktion LIKE 'Mafia'")
				MafiaRaketen = MySQL_GetString("fraktionswaffen", "Raketen", "Fraktion LIKE 'Mafia'")
				MafiaSpezwaffen = MySQL_GetString("fraktionswaffen", "Spezwaffen", "Fraktion LIKE 'Mafia'")
				MafiaFamkasse = MafiaFamkasse - vioGetElementData ( veh, "costs" )
				
				MySQL_SetString("fraktionen", "DepotGeld", MafiaFamkasse, "Name LIKE 'Mafia'")
				outputChatBox ( "Lieferung abgegeben - Du erhaelst "..vioGetElementData ( veh, "costs" ).." $ aus der Familienkasse! zurueck!", player, 0, 125, 0 )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + vioGetElementData ( veh, "costs" ) )
				givePlayerMoney ( player, vioGetElementData ( veh, "costs" ) )
				if vioGetElementData ( player, "gunloads" ) ~= "done" then 																								-- Achiev: Waffenschieber
					vioSetElementData ( player, "gunloads", tonumber(vioGetElementData ( player, "gunloads" )) + tonumber(vioGetElementData ( veh, "costs" )) )					-- Achiev: Waffenschieber
					if vioGetElementData ( player, "gunloads" ) > 50000 then																								-- Achiev: Waffenschieber
						vioSetElementData ( player, "gunloads", "done" )																									-- Achiev: Waffenschieber
						triggerClientEvent ( player, "showAchievmentBox", player, "Waffenschieber", 50, 10000 )															-- Achiev: Waffenschieber
						vioSetElementData ( player, "bonuspoints", vioGetElementData ( player, "bonuspoints" ) + 50 )															-- Achiev: Waffenschieber
						MySQL_SetString("achievments", "Waffenschieber", vioGetElementData ( player, "gunloads" ), "Name LIKE '"..getPlayerName(player).."'")				-- Achiev: Waffenschieber
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