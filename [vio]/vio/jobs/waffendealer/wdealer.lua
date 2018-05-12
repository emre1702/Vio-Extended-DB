-- Old one: guncenterEntrance = createMarker ( 2361.1003417969,  2778.6115722656,  9.8219699859619,  "cylinder",  2,  getColorFromString ( "#FE000199" ) )
guncenterEntrance = createMarker ( 2773.3708496094, -2461.78125, 12.632966995239,  "cylinder",  2,  getColorFromString ( "#FE000199" ) )
local weaponsTruck = false

function guncenterEntrance_func ( player, dim )
   
	if dim then
		if getPedOccupiedVehicle ( player ) == false then
			if vioGetElementData ( player, "fraktion" ) == 2 or vioGetElementData ( player, "fraktion" ) == 3 or vioGetElementData ( player, "fraktion" ) == 7 or vioGetElementData ( player, "fraktion" ) == 9 then
				vioSetElementData ( player, "ElementClicked", true )
				triggerClientEvent ( player, "ShowGuncenterGui", getRootElement() )
				vioSetElementData ( player, "guiCreated", true )
				showCursor ( player, true )
			else
				outputChatBox ( "Nur fuer Fraktionen!", player, 125, 0, 0 )
			end
		end
	end
end
addEventHandler ( "onMarkerHit",  guncenterEntrance,  guncenterEntrance_func )

function hasenoughfactionmoney ( faction, preis )

	local Kasse = tonumber(MySQL_GetString("fraktionen", "DepotGeld", "ID = '"..faction.."'"))
	
	if Kasse >= preis then
		return true
	else
		return false
	end

end

function giveTruck_func ( schlagringe, baseball, knife, shovels, pistol, sdpistol, pistolammo, eagle, eagleammo, shotgun, shotgunammo, mp, mpammo, ak, akammo, m, mammo, gewehr, gewehrammo, sgewehr, sgewehrammo, rakwerfer, rak, spezgun )
	
	local schlagringe, baseball, knife, shovels, pistol, sdpistol, pistolammo, eagle, eagleammo, shotgun, shotgunammo, mp, mpammo, ak, akammo, m, mammo, gewehr, gewehrammo, sgewehr, sgewehrammo, rakwerfer, rak, spezgun = math.abs(schlagringe), math.abs(baseball), math.abs(knife), math.abs(shovels), math.abs(pistol), math.abs(sdpistol), math.abs(pistolammo), math.abs(eagle), math.abs(eagleammo), math.abs(shotgun), math.abs(shotgunammo), math.abs(mp), math.abs(mpammo), math.abs(ak), math.abs(akammo), math.abs(m), math.abs(mammo), math.abs(gewehr), math.abs(gewehrammo), math.abs(sgewehr), math.abs(sgewehrammo), math.abs(rakwerfer), math.abs(rak), math.abs(spezgun)
	local preis = math.abs(schlagringe)*schlagringe_price + math.abs(baseball)*baseball_price + math.abs(knife)*knife_price + math.abs(shovels)*shovels_price + math.abs(pistol)*pistol_price + math.abs(sdpistol)*sdpistol_price + math.abs(pistolammo)*pistolammo_price + math.abs(eagle)*eagle_price + math.abs(eagleammo)*eagleammo_price + math.abs(shotgun)*shotgun_price + math.abs(shotgunammo)*shotgunammo_price + mp*mp_price + mpammo*mpammo_price + ak*ak_price + akammo*akammo_price + m*m_price + mammo*mammo_price + gewehr*gewehr_price + gewehrammo*gewehrammo_price + sgewehr*sgewehr_price + sgewehrammo*sgewehrammo_price + math.abs(rakwerfer)*rakwerfer_price + math.abs(rak)*rak_price + math.abs(spezgun)*spezgun_price
	if preis then
		if preis > 300 and preis < 15000 then
		
			if not hasenoughfactionmoney( vioGetElementData( source, "fraktion" ), preis ) then
			
				outputChatBox ( "Nicht genug Geld in der Fkasse!", source, 125, 0, 0 )
				return
			
			end
		
			if vioGetElementData ( source, "money" ) >= preis then
				--if mafiatransport == nil then mafiatransport = 0 end
				--if mafiatransport == 1 then
				--outputChatBox ( "Es ist bereits ein Waffentransport unterwegs!", source, 125, 0, 0 )
				--else
				if not weaponsTruck then
					if math.floor(math.abs(schlagringe))==schlagringe and math.floor(math.abs( baseball ) ) == baseball and math.floor(math.abs( knife ) ) == knife and math.floor(math.abs( shovels ) ) == shovels and math.floor(math.abs( pistol ) ) == pistol and math.floor(math.abs( sdpistol ) ) == sdpistol and math.floor(math.abs( pistolammo ) ) == pistolammo and math.floor(math.abs( eagle ) ) == eagle and math.floor(math.abs( eagleammo ) ) == eagleammo and math.floor(math.abs( shotgun ) ) == shotgun and math.floor(math.abs( shotgunammo ) ) == shotgunammo and math.floor(math.abs( mp ) ) == mp and math.floor(math.abs( mpammo ) ) == mpammo and math.floor(math.abs( ak ) ) == ak and math.floor(math.abs( akammo ) ) == akammo and math.floor(math.abs( m ) ) == m and math.floor(math.abs( mammo ) ) == mammo and math.floor(math.abs( gewehr ) ) == gewehr and math.floor(math.abs( gewehrammo ) ) == gewehrammo and math.floor(math.abs( sgewehr ) ) == sgewehr and math.floor(math.abs( sgewehrammo ) ) == sgewehrammo and math.floor(math.abs( rakwerfer ) ) == rakwerfer and math.floor(math.abs( rak ) ) == rak and math.floor(math.abs( spezgun ) ) == spezgun then
						if vioGetElementData ( source, "fraktion" ) == 2 then
							if 
							tonumber(MafiaSchlagringe)+math.abs(tonumber(schlagringe)) <= schlagringcap and 
							tonumber(MafiaBaseballschlaeger)+math.abs(tonumber(baseball)) <= baseballcap and 
							tonumber(MafiaMesser)+math.abs(tonumber(knife)) <= knifecap and 
							tonumber(MafiaSchaufeln)+math.abs(tonumber(shovels)) <= shovelscap and 
							tonumber(MafiaPistolen)+math.abs(tonumber(pistol)) <= pistolcap and 
							tonumber(MafiaSDPistolen)+math.abs(tonumber(sdpistol)) <= sdpistolcap and 
							tonumber(MafiaPistolenMagazine)+math.abs(tonumber(pistolammo)) <= pistolammocap and 
							tonumber(MafiaDesertEagles)+math.abs(tonumber(eagle)) <= eaglecap and 
							tonumber(MafiaDesertEagleMunition)+math.abs(tonumber(eagleammo)) <= eagleammocap and 
							tonumber(MafiaSchrotflinten)+math.abs(tonumber(shotgun)) <= shotguncap and 
							tonumber(MafiaSchrotflintenMunition)+math.abs(tonumber(shotgunammo)) <= shotgunammocap and 
							tonumber(MafiaMP)+math.abs(tonumber(mp)) <= mpcap and 
							tonumber(MafiaMPMunition)+math.abs(tonumber(mpammo)) <= mpammocap and 
							tonumber(MafiaAK)+math.abs(tonumber(ak)) <= akcap and 
							tonumber(MafiaAKMunition)+math.abs(tonumber(akammo)) <= akammocap and 
							tonumber(MafiaM)+math.abs(tonumber(m)) <= mcap and 
							tonumber(MafiaMMunition)+math.abs(tonumber(mammo)) <= mammocap and 
							tonumber(MafiaGewehre)+math.abs(tonumber(gewehr)) <= gewehrcap and 
							tonumber(MafiaGewehrPatronen)+math.abs(tonumber(gewehrammo)) <= gewehrammocap and 
							tonumber(MafiaSGewehr)+math.abs(tonumber(sgewehr)) <= sgewehrcap and 
							tonumber(MafiaSGewehrMunition)+math.abs(tonumber(sgewehrammo)) <= sgewehrammocap and 
							tonumber(MafiaRaketenwerfer)+math.abs(tonumber(rakwerfer)) <= raketenwerfercap and 
							tonumber(MafiaRaketen)+math.abs(tonumber(rak)) <= raketencap and 
							tonumber(MafiaSpezwaffen)+math.abs(tonumber(spezgun)) <= spezguncap then
								loadTruck ( source, schlagringe, baseball, knife, shovels, pistol, sdpistol, pistolammo, eagle, eagleammo, shotgun, shotgunammo, mp, mpammo, ak, akammo, m, mammo, gewehr, gewehrammo, sgewehr, sgewehrammo, rakwerfer, rak, spezgun, preis )
							else
								outputChatBox ( "Bestand:", source, 0, 0, 125 )
								outputChatBox ( "Schlagringe: "..MafiaSchlagringe.." von "..baseballcap, source, 0, 125, 0 )
								outputChatBox ( "Baseballschlaeger: "..MafiaBaseballschlaeger.." von "..baseballcap, source, 0, 125, 0 )
								outputChatBox ( "Messer: "..MafiaMesser.." von "..knifecap, source, 0, 125, 0 )
								outputChatBox ( "Schaufeln: "..MafiaSchaufeln.." von "..shovelscap, source, 0, 125, 0 )
								outputChatBox ( "Pistolen: "..MafiaPistolen.." von "..pistolcap, source, 0, 125, 0 )
								outputChatBox ( "SD-Pistolen: "..MafiaSDPistolen.." von "..sdpistolcap, source, 0, 125, 0 )
								outputChatBox ( "9mm Magazine: "..MafiaPistolenMagazine.." von "..pistolammocap, source, 0, 125, 0 )
								outputChatBox ( "Desert Eagles: "..MafiaDesertEagles.." von "..eaglecap, source, 0, 125, 0 )
								outputChatBox ( "Desert Eagle Magazine: "..MafiaDesertEagleMunition.." von "..eagleammocap, source, 0, 125, 0 )
								outputChatBox ( "Schrotflinten: "..MafiaSchrotflinten.." von "..shotguncap, source, 0, 125, 0 )
								outputChatBox ( "Schrotkugeln: "..MafiaSchrotflintenMunition.." von "..shotgunammocap, source, 0, 125, 0 )
								outputChatBox ( "MP5: "..MafiaMP.." von "..mpcap, source, 0, 125, 0 )
								outputChatBox ( "MP5 Magazine: "..MafiaMPMunition.." von "..mpammocap, source, 0, 125, 0 )
								outputChatBox ( "AK-47: "..MafiaAK.." von "..akcap, source, 0, 125, 0 )
								outputChatBox ( "Ak-47 Magazine "..MafiaAKMunition.." von "..akammocap, source, 0, 125, 0 )
								outputChatBox ( "M4: "..MafiaM.." von "..mcap, source, 0, 125, 0 )
								outputChatBox ( "M4 Magazine "..MafiaMMunition.." von "..mammocap, source, 0, 125, 0 )
								outputChatBox ( "Gewehre: "..MafiaGewehre.." von "..gewehrcap, source, 0, 125, 0 )
								outputChatBox ( "Gewehr Patronen: "..MafiaGewehrPatronen.." von "..gewehrammocap, source, 0, 125, 0 )
								outputChatBox ( "Scharfschuetzengewehre: "..MafiaSGewehr.." von "..sgewehrcap, source, 0, 125, 0 )
								outputChatBox ( "Scharfschuetzengewehr Patronen: "..MafiaSGewehrMunition.." von "..sgewehrammocap, source, 0, 125, 0 )
								outputChatBox ( "Raketenwerfer: "..MafiaRaketenwerfer.." von "..raketenwerfercap, source, 0, 125, 0 )
								outputChatBox ( "Raketen: "..MafiaRaketen.." von "..raketencap, source, 0, 125, 0 )
								outputChatBox ( "Luparas: "..MafiaSpezwaffen.." von "..spezguncap, source, 0, 125, 0 )
								outputChatBox ( "Das Lager ist zu voll, um deine Lieferung aufzunehmen!", source, 125, 0, 0 )
							end
						elseif vioGetElementData ( source, "fraktion" ) == 3 then
							if 
							tonumber(TriadenSchlagringe)+math.abs(tonumber(schlagringe)) <= schlagringcap and 
							tonumber(TriadenBaseballschlaeger)+math.abs(tonumber(baseball)) <= baseballcap and 
							tonumber(TriadenMesser)+math.abs(tonumber(knife)) <= knifecap and 
							tonumber(TriadenSchaufeln)+math.abs(tonumber(shovels)) <= shovelscap and 
							tonumber(TriadenPistolen)+math.abs(tonumber(pistol)) <= pistolcap and 
							tonumber(TriadenSDPistolen)+math.abs(tonumber(sdpistol)) <= sdpistolcap and 
							tonumber(TriadenPistolenMagazine)+math.abs(tonumber(pistolammo)) <= pistolammocap and 
							tonumber(TriadenDesertEagles)+math.abs(tonumber(eagle)) <= eaglecap and 
							tonumber(TriadenDesertEagleMunition)+math.abs(tonumber(eagleammo)) <= eagleammocap and 
							tonumber(TriadenSchrotflinten)+math.abs(tonumber(shotgun)) <= shotguncap and 
							tonumber(TriadenSchrotflintenMunition)+math.abs(tonumber(shotgunammo)) <= shotgunammocap and 
							tonumber(TriadenMP)+math.abs(tonumber(mp)) <= mpcap and 
							tonumber(TriadenMPMunition)+math.abs(tonumber(mpammo)) <= mpammocap and 
							tonumber(TriadenAK)+math.abs(tonumber(ak)) <= akcap and 
							tonumber(TriadenAKMunition)+math.abs(tonumber(akammo)) <= akammocap and 
							tonumber(TriadenM)+math.abs(tonumber(m)) <= mcap and 
							tonumber(TriadenMMunition)+math.abs(tonumber(mammo)) <= mammocap and 
							tonumber(TriadenGewehre)+math.abs(tonumber(gewehr)) <= gewehrcap and 
							tonumber(TriadenGewehrPatronen)+math.abs(tonumber(gewehrammo)) <= gewehrammocap and 
							tonumber(TriadenSGewehr)+math.abs(tonumber(sgewehr)) <= sgewehrcap and 
							tonumber(TriadenSGewehrMunition)+math.abs(tonumber(sgewehrammo)) <= sgewehrammocap and 
							tonumber(TriadenRaketenwerfer)+math.abs(tonumber(rakwerfer)) <= raketenwerfercap and 
							tonumber(TriadenRaketen)+math.abs(tonumber(rak)) <= raketencap and 
							tonumber(TriadenSpezwaffen)+math.abs(tonumber(spezgun)) <= spezguncap then
								loadTruck ( source, schlagringe, baseball, knife, shovels, pistol, sdpistol, pistolammo, eagle, eagleammo, shotgun, shotgunammo, mp, mpammo, ak, akammo, m, mammo, gewehr, gewehrammo, sgewehr, sgewehrammo, rakwerfer, rak, spezgun, preis )
							else
								outputChatBox ( "Bestand:", source, 0, 0, 125 )
								outputChatBox ( "Schlagringe: "..TriadenSchlagringe.." von "..baseballcap, source, 0, 125, 0 )
								outputChatBox ( "Baseballschlaeger: "..TriadenBaseballschlaeger.." von "..baseballcap, source, 0, 125, 0 )
								outputChatBox ( "Messer: "..TriadenMesser.." von "..knifecap, source, 0, 125, 0 )
								outputChatBox ( "Schaufeln: "..TriadenSchaufeln.." von "..shovelscap, source, 0, 125, 0 )
								outputChatBox ( "Pistolen: "..TriadenPistolen.." von "..pistolcap, source, 0, 125, 0 )
								outputChatBox ( "SD-Pistolen: "..TriadenSDPistolen.." von "..sdpistolcap, source, 0, 125, 0 )
								outputChatBox ( "9mm Magazine: "..TriadenPistolenMagazine.." von "..pistolammocap, source, 0, 125, 0 )
								outputChatBox ( "Desert Eagles: "..TriadenDesertEagles.." von "..eaglecap, source, 0, 125, 0 )
								outputChatBox ( "Desert Eagle Magazine: "..TriadenDesertEagleMunition.." von "..eagleammocap, source, 0, 125, 0 )
								outputChatBox ( "Schrotflinten: "..TriadenSchrotflinten.." von "..shotguncap, source, 0, 125, 0 )
								outputChatBox ( "Schrotkugeln: "..TriadenSchrotflintenMunition.." von "..shotgunammocap, source, 0, 125, 0 )
								outputChatBox ( "MP5: "..TriadenMP.." von "..mpcap, source, 0, 125, 0 )
								outputChatBox ( "MP5 Magazine: "..TriadenMPMunition.." von "..mpammocap, source, 0, 125, 0 )
								outputChatBox ( "AK-47: "..TriadenAK.." von "..akcap, source, 0, 125, 0 )
								outputChatBox ( "Ak-47 Magazine "..TriadenAKMunition.." von "..akammocap, source, 0, 125, 0 )
								outputChatBox ( "M4: "..TriadenM.." von "..mcap, source, 0, 125, 0 )
								outputChatBox ( "M4 Magazine "..TriadenMMunition.." von "..mammocap, source, 0, 125, 0 )
								outputChatBox ( "Gewehre: "..TriadenGewehre.." von "..gewehrcap, source, 0, 125, 0 )
								outputChatBox ( "Gewehr Patronen: "..TriadenGewehrPatronen.." von "..gewehrammocap, source, 0, 125, 0 )
								outputChatBox ( "Scharfschuetzengewehre: "..TriadenSGewehr.." von "..sgewehrcap, source, 0, 125, 0 )
								outputChatBox ( "Scharfschuetzengewehr Patronen: "..TriadenSGewehrMunition.." von "..sgewehrammocap, source, 0, 125, 0 )
								outputChatBox ( "Raketenwerfer: "..TriadenRaketenwerfer.." von "..raketenwerfercap, source, 0, 125, 0 )
								outputChatBox ( "Raketen: "..TriadenRaketen.." von "..raketencap, source, 0, 125, 0 )
								outputChatBox ( "Katanas: "..TriadenSpezwaffen.." von "..spezguncap, source, 0, 125, 0 )
								outputChatBox ( "Das Lager ist zu voll, um deine Lieferung aufzunehmen!", source, 125, 0, 0 )
							end
						elseif vioGetElementData ( source, "fraktion" ) == 9 then
							if 
							tonumber(BikerSchlagringe)+math.abs(tonumber(schlagringe)) <= schlagringcap and 
							tonumber(BikerBaseballschlaeger)+math.abs(tonumber(baseball)) <= baseballcap and 
							tonumber(BikerMesser)+math.abs(tonumber(knife)) <= knifecap and 
							tonumber(BikerSchaufeln)+math.abs(tonumber(shovels)) <= shovelscap and 
							tonumber(BikerPistolen)+math.abs(tonumber(pistol)) <= pistolcap and 
							tonumber(BikerSDPistolen)+math.abs(tonumber(sdpistol)) <= sdpistolcap and 
							tonumber(BikerPistolenMagazine)+math.abs(tonumber(pistolammo)) <= pistolammocap and 
							tonumber(BikerDesertEagles)+math.abs(tonumber(eagle)) <= eaglecap and 
							tonumber(BikerDesertEagleMunition)+math.abs(tonumber(eagleammo)) <= eagleammocap and 
							tonumber(BikerSchrotflinten)+math.abs(tonumber(shotgun)) <= shotguncap and 
							tonumber(BikerSchrotflintenMunition)+math.abs(tonumber(shotgunammo)) <= shotgunammocap and 
							tonumber(BikerMP)+math.abs(tonumber(mp)) <= mpcap and 
							tonumber(BikerMPMunition)+math.abs(tonumber(mpammo)) <= mpammocap and 
							tonumber(BikerAK)+math.abs(tonumber(ak)) <= akcap and 
							tonumber(BikerAKMunition)+math.abs(tonumber(akammo)) <= akammocap and 
							tonumber(BikerM)+math.abs(tonumber(m)) <= mcap and 
							tonumber(BikerMMunition)+math.abs(tonumber(mammo)) <= mammocap and 
							tonumber(BikerGewehre)+math.abs(tonumber(gewehr)) <= gewehrcap and 
							tonumber(BikerGewehrPatronen)+math.abs(tonumber(gewehrammo)) <= gewehrammocap and 
							tonumber(BikerSGewehr)+math.abs(tonumber(sgewehr)) <= sgewehrcap and 
							tonumber(BikerSGewehrMunition)+math.abs(tonumber(sgewehrammo)) <= sgewehrammocap and 
							tonumber(BikerRaketenwerfer)+math.abs(tonumber(rakwerfer)) <= raketenwerfercap and 
							tonumber(BikerRaketen)+math.abs(tonumber(rak)) <= raketencap and 
							tonumber(BikerSpezwaffen)+math.abs(tonumber(spezgun)) <= spezguncap then
								loadTruck ( source, schlagringe, baseball, knife, shovels, pistol, sdpistol, pistolammo, eagle, eagleammo, shotgun, shotgunammo, mp, mpammo, ak, akammo, m, mammo, gewehr, gewehrammo, sgewehr, sgewehrammo, rakwerfer, rak, spezgun, preis )
							else
								outputChatBox ( "Bestand:", source, 0, 0, 125 )
								outputChatBox ( "Schlagringe: "..BikerSchlagringe.." von "..baseballcap, source, 0, 125, 0 )
								outputChatBox ( "Baseballschlaeger: "..BikerBaseballschlaeger.." von "..baseballcap, source, 0, 125, 0 )
								outputChatBox ( "Messer: "..BikerMesser.." von "..knifecap, source, 0, 125, 0 )
								outputChatBox ( "Schaufeln: "..BikerSchaufeln.." von "..shovelscap, source, 0, 125, 0 )
								outputChatBox ( "Pistolen: "..BikerPistolen.." von "..pistolcap, source, 0, 125, 0 )
								outputChatBox ( "SD-Pistolen: "..BikerSDPistolen.." von "..sdpistolcap, source, 0, 125, 0 )
								outputChatBox ( "9mm Magazine: "..BikerPistolenMagazine.." von "..pistolammocap, source, 0, 125, 0 )
								outputChatBox ( "Desert Eagles: "..BikerDesertEagles.." von "..eaglecap, source, 0, 125, 0 )
								outputChatBox ( "Desert Eagle Magazine: "..BikerDesertEagleMunition.." von "..eagleammocap, source, 0, 125, 0 )
								outputChatBox ( "Schrotflinten: "..BikerSchrotflinten.." von "..shotguncap, source, 0, 125, 0 )
								outputChatBox ( "Schrotkugeln: "..BikerSchrotflintenMunition.." von "..shotgunammocap, source, 0, 125, 0 )
								outputChatBox ( "MP5: "..BikerMP.." von "..mpcap, source, 0, 125, 0 )
								outputChatBox ( "MP5 Magazine: "..BikerMPMunition.." von "..mpammocap, source, 0, 125, 0 )
								outputChatBox ( "AK-47: "..BikerAK.." von "..akcap, source, 0, 125, 0 )
								outputChatBox ( "Ak-47 Magazine "..BikerAKMunition.." von "..akammocap, source, 0, 125, 0 )
								outputChatBox ( "M4: "..BikerM.." von "..mcap, source, 0, 125, 0 )
								outputChatBox ( "M4 Magazine "..BikerMMunition.." von "..mammocap, source, 0, 125, 0 )
								outputChatBox ( "Gewehre: "..BikerGewehre.." von "..gewehrcap, source, 0, 125, 0 )
								outputChatBox ( "Gewehr Patronen: "..BikerGewehrPatronen.." von "..gewehrammocap, source, 0, 125, 0 )
								outputChatBox ( "Scharfschuetzengewehre: "..BikerSGewehr.." von "..sgewehrcap, source, 0, 125, 0 )
								outputChatBox ( "Scharfschuetzengewehr Patronen: "..BikerSGewehrMunition.." von "..sgewehrammocap, source, 0, 125, 0 )
								outputChatBox ( "Raketenwerfer: "..BikerRaketenwerfer.." von "..raketenwerfercap, source, 0, 125, 0 )
								outputChatBox ( "Raketen: "..BikerRaketen.." von "..raketencap, source, 0, 125, 0 )
								outputChatBox ( "Katanas: "..BikerSpezwaffen.." von "..spezguncap, source, 0, 125, 0 )
								outputChatBox ( "Das Lager ist zu voll, um deine Lieferung aufzunehmen!", source, 125, 0, 0 )
							end
						elseif vioGetElementData ( source, "fraktion" ) == 7 then
							if 
							tonumber(AztecasSchlagringe)+math.abs(tonumber(schlagringe)) <= schlagringcap and 
							tonumber(AztecasBaseballschlaeger)+math.abs(tonumber(baseball)) <= baseballcap and 
							tonumber(AztecasMesser)+math.abs(tonumber(knife)) <= knifecap and 
							tonumber(AztecasSchaufeln)+math.abs(tonumber(shovels)) <= shovelscap and 
							tonumber(AztecasPistolen)+math.abs(tonumber(pistol)) <= pistolcap and 
							tonumber(AztecasSDPistolen)+math.abs(tonumber(sdpistol)) <= sdpistolcap and 
							tonumber(AztecasPistolenMagazine)+math.abs(tonumber(pistolammo)) <= pistolammocap and 
							tonumber(AztecasDesertEagles)+math.abs(tonumber(eagle)) <= eaglecap and 
							tonumber(AztecasDesertEagleMunition)+math.abs(tonumber(eagleammo)) <= eagleammocap and 
							tonumber(AztecasSchrotflinten)+math.abs(tonumber(shotgun)) <= shotguncap and 
							tonumber(AztecasSchrotflintenMunition)+math.abs(tonumber(shotgunammo)) <= shotgunammocap and 
							tonumber(AztecasMP)+math.abs(tonumber(mp)) <= mpcap and 
							tonumber(AztecasMPMunition)+math.abs(tonumber(mpammo)) <= mpammocap and 
							tonumber(AztecasAK)+math.abs(tonumber(ak)) <= akcap and 
							tonumber(AztecasAKMunition)+math.abs(tonumber(akammo)) <= akammocap and 
							tonumber(AztecasM)+math.abs(tonumber(m)) <= mcap and 
							tonumber(AztecasMMunition)+math.abs(tonumber(mammo)) <= mammocap and 
							tonumber(AztecasGewehre)+math.abs(tonumber(gewehr)) <= gewehrcap and 
							tonumber(AztecasGewehrPatronen)+math.abs(tonumber(gewehrammo)) <= gewehrammocap and 
							tonumber(AztecasSGewehr)+math.abs(tonumber(sgewehr)) <= sgewehrcap and 
							tonumber(AztecasSGewehrMunition)+math.abs(tonumber(sgewehrammo)) <= sgewehrammocap and 
							tonumber(AztecasRaketenwerfer)+math.abs(tonumber(rakwerfer)) <= raketenwerfercap and 
							tonumber(AztecasRaketen)+math.abs(tonumber(rak)) <= raketencap and 
							tonumber(AztecasSpezwaffen)+math.abs(tonumber(spezgun)) <= spezguncap then
								loadTruck ( source, schlagringe, baseball, knife, shovels, pistol, sdpistol, pistolammo, eagle, eagleammo, shotgun, shotgunammo, mp, mpammo, ak, akammo, m, mammo, gewehr, gewehrammo, sgewehr, sgewehrammo, rakwerfer, rak, spezgun, preis )
							else
								outputChatBox ( "Bestand:", source, 0, 0, 125 )
								outputChatBox ( "Schlagringe: "..AztecasSchlagringe.." von "..baseballcap, source, 0, 125, 0 )
								outputChatBox ( "Baseballschlaeger: "..AztecasBaseballschlaeger.." von "..baseballcap, source, 0, 125, 0 )
								outputChatBox ( "Messer: "..AztecasMesser.." von "..knifecap, source, 0, 125, 0 )
								outputChatBox ( "Schaufeln: "..AztecasSchaufeln.." von "..shovelscap, source, 0, 125, 0 )
								outputChatBox ( "Pistolen: "..AztecasPistolen.." von "..pistolcap, source, 0, 125, 0 )
								outputChatBox ( "SD-Pistolen: "..AztecasSDPistolen.." von "..sdpistolcap, source, 0, 125, 0 )
								outputChatBox ( "9mm Magazine: "..AztecasPistolenMagazine.." von "..pistolammocap, source, 0, 125, 0 )
								outputChatBox ( "Desert Eagles: "..AztecasDesertEagles.." von "..eaglecap, source, 0, 125, 0 )
								outputChatBox ( "Desert Eagle Magazine: "..AztecasDesertEagleMunition.." von "..eagleammocap, source, 0, 125, 0 )
								outputChatBox ( "Schrotflinten: "..AztecasSchrotflinten.." von "..shotguncap, source, 0, 125, 0 )
								outputChatBox ( "Schrotkugeln: "..AztecasSchrotflintenMunition.." von "..shotgunammocap, source, 0, 125, 0 )
								outputChatBox ( "MP5: "..AztecasMP.." von "..mpcap, source, 0, 125, 0 )
								outputChatBox ( "MP5 Magazine: "..AztecasMPMunition.." von "..mpammocap, source, 0, 125, 0 )
								outputChatBox ( "AK-47: "..AztecasAK.." von "..akcap, source, 0, 125, 0 )
								outputChatBox ( "Ak-47 Magazine "..AztecasAKMunition.." von "..akammocap, source, 0, 125, 0 )
								outputChatBox ( "M4: "..AztecasM.." von "..mcap, source, 0, 125, 0 )
								outputChatBox ( "M4 Magazine "..AztecasMMunition.." von "..mammocap, source, 0, 125, 0 )
								outputChatBox ( "Gewehre: "..AztecasGewehre.." von "..gewehrcap, source, 0, 125, 0 )
								outputChatBox ( "Gewehr Patronen: "..AztecasGewehrPatronen.." von "..gewehrammocap, source, 0, 125, 0 )
								outputChatBox ( "Scharfschuetzengewehre: "..AztecasSGewehr.." von "..sgewehrcap, source, 0, 125, 0 )
								outputChatBox ( "Scharfschuetzengewehr Patronen: "..AztecasSGewehrMunition.." von "..sgewehrammocap, source, 0, 125, 0 )
								outputChatBox ( "Raketenwerfer: "..AztecasRaketenwerfer.." von "..raketenwerfercap, source, 0, 125, 0 )
								outputChatBox ( "Raketen: "..AztecasRaketen.." von "..raketencap, source, 0, 125, 0 )
								outputChatBox ( "Katanas: "..AztecasSpezwaffen.." von "..spezguncap, source, 0, 125, 0 )
								outputChatBox ( "Das Lager ist zu voll, um deine Lieferung aufzunehmen!", source, 125, 0, 0 )
							end
						end
					else
						outputChatBox ( "Ungueltige Auswahl!" )
					end
				else
					outputChatBox ( "Es ist bereits ein Truck unterwegs!", source, 125, 0, 0 )
				end
			else
				outputChatBox ( "Du hast nicht genug Geld!", source, 125, 0, 0 )
			end
		else
			outputChatBox ( "Bitte waehle Waren zwischen 300 und 15.000$ aus!", source, 125, 0, 0 )
		end
	else
		outputChatBox ( "Ungueltige Auswahl!" )
	end
end
addEvent ( "giveTruck", true )
addEventHandler ( "giveTruck", getRootElement(), giveTruck_func )

function vehicleEnterMafiaTruck (veh)

	if vioGetElementData ( source, "fraktion" ) == 2 then
		if vioGetElementData ( veh, "guntruck" ) == 1 then
			setElementVisibleTo ( MafiaDeliver, source, true )
			setElementVisibleTo ( DeliverBlip, source, true )
		end
	end
	if vioGetElementData ( source, "fraktion" ) == 3 then
		if vioGetElementData ( veh, "guntruck" ) == 1 then
			setElementVisibleTo ( TriadenDeliver, source, true )
			setElementVisibleTo ( TriadenDeliverBlip, source, true )
		end
	end
	if vioGetElementData ( source, "fraktion" ) == 7 then
		if vioGetElementData ( veh, "guntruck" ) == 1 then
			setElementVisibleTo ( AztecasDeliver, source, true )
			setElementVisibleTo ( AztecasDeliverBlip, source, true )
		end
	end
	if vioGetElementData ( source, "fraktion" ) == 9 then
		if vioGetElementData ( veh, "guntruck" ) == 1 then
			setElementVisibleTo ( BikerDeliver, source, true )
			setElementVisibleTo ( BikerDeliverBlip, source, true )
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), vehicleEnterMafiaTruck )

function vehicleExitMafiaTruck (veh)

	if vioGetElementData ( source, "fraktion" ) == 2 then
		if vioGetElementData ( veh, "guntruck" ) == 1 then
			setElementVisibleTo ( MafiaDeliver, source, false )
			setElementVisibleTo ( DeliverBlip, source, false )
		end
	end
	if vioGetElementData ( source, "fraktion" ) == 3 then
		if vioGetElementData ( veh, "guntruck" ) == 1 then
			setElementVisibleTo ( TriadenDeliver, source, false )
			setElementVisibleTo ( TriadenDeliverBlip, source, false )
		end
	end
	if vioGetElementData ( source, "fraktion" ) == 7 then
		if vioGetElementData ( veh, "guntruck" ) == 1 then
			setElementVisibleTo ( AztecasDeliver, source, false )
			setElementVisibleTo ( AztecasDeliverBlip, source, false )
		end
	end
	if vioGetElementData ( source, "fraktion" ) == 9 then
		if vioGetElementData ( veh, "guntruck" ) == 1 then
			setElementVisibleTo ( BikerDeliver, source, false )
			setElementVisibleTo ( BikerDeliverBlip, source, false )
		end
	end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), vehicleExitMafiaTruck )

function vehicleDestroyedMafiaTruck ()

	if vioGetElementData ( source, "guntruck" ) == 1 then
		mafiatransport = 0
	end
end
addEventHandler ( "onVehicleExplode", getRootElement(), vehicleDestroyedMafiaTruck )

function loadTruck ( player, schlagringe, baseball, knife, shovels, pistol, sdpistol, pistolammo, eagle, eagleammo, shotgun, shotgunammo, mp, mpammo, ak, akammo, m, mammo, gewehr, gewehrammo, sgewehr, sgewehrammo, rakwerfer, rak, spezgun, preis )

	outputChatBox ( "Ein Waffentruck wurde beladen!", getRootElement(), 125, 0, 0 )
	vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - preis )
	takePlayerMoney ( player, preis )
	triggerClientEvent ( player, "SubmitBeladenAbbrechen", getRootElement() )
	triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
	if truckcount == nil then truckcount = 1 else truckcount = truckcount + 1 end
	mafiatransport = 1
	_G["truck"..truckcount] = createVehicle ( 455, 2765.6179199219, -2455.2485351563, 14.051976203918, 0, 0, 0, "GUNS" )
	weaponTruck = _G["truck"..truckcount]
	setVehiclePaintjob ( _G["truck"..truckcount], 2 )
	setVehicleColor ( _G["truck"..truckcount], 40, 1, 0, 0 )
	vioSetElementData ( _G["truck"..truckcount], "schlagringe", schlagringe )
	vioSetElementData ( _G["truck"..truckcount], "baseball", baseball )
	vioSetElementData ( _G["truck"..truckcount], "knife", knife )
	vioSetElementData ( _G["truck"..truckcount], "shovels", shovels )
	vioSetElementData ( _G["truck"..truckcount], "pistol", pistol )
	vioSetElementData ( _G["truck"..truckcount], "sdpistol", sdpistol )
	vioSetElementData ( _G["truck"..truckcount], "pistolammo", pistolammo )
	vioSetElementData ( _G["truck"..truckcount], "eagle", eagle )
	vioSetElementData ( _G["truck"..truckcount], "eagleammo", eagleammo )
	vioSetElementData ( _G["truck"..truckcount], "shotgun", shotgun )
	vioSetElementData ( _G["truck"..truckcount], "shotgunammo", shotgunammo )
	vioSetElementData ( _G["truck"..truckcount], "mp", mp )
	vioSetElementData ( _G["truck"..truckcount], "mpammo", mpammo )
	vioSetElementData ( _G["truck"..truckcount], "ak", ak )
	vioSetElementData ( _G["truck"..truckcount], "akammo", akammo )
	vioSetElementData ( _G["truck"..truckcount], "m", m )
	vioSetElementData ( _G["truck"..truckcount], "mammo", mammo )
	vioSetElementData ( _G["truck"..truckcount], "gewehr", gewehr )
	vioSetElementData ( _G["truck"..truckcount], "gewehrammo", gewehrammo )
	vioSetElementData ( _G["truck"..truckcount], "sgewehr", sgewehr )
	vioSetElementData ( _G["truck"..truckcount], "sgewehrammo", sgewehrammo )
	vioSetElementData ( _G["truck"..truckcount], "rakwerfer", rakwerfer )
	vioSetElementData ( _G["truck"..truckcount], "rak", rak )
	vioSetElementData ( _G["truck"..truckcount], "spezgun", spezgun )
	vioSetElementData ( _G["truck"..truckcount], "guntruck", 1 )
	vioSetElementData ( _G["truck"..truckcount], "costs", preis )
	triggerClientEvent ( player,"SubmitBeladenAbbrechen", getRootElement())
	warpPedIntoVehicle ( player, _G["truck"..truckcount] )
	outputChatBox ( "Bringe nun den Truck zurueck zur Basis!", player, 0, 125, 0 )
	setElementHealth ( _G["truck"..truckcount], 1500 )
	if vioGetElementData ( player, "fraktion" ) == 2 then
		setElementVisibleTo ( MafiaDeliver, player, true )
		setElementVisibleTo ( DeliverBlip, player, true )
	elseif vioGetElementData ( player, "fraktion" ) == 3 then
		setElementVisibleTo ( TriadDeliver, player, true )
		setElementVisibleTo ( TriadDeliverBlip, player, true )
	elseif vioGetElementData ( player, "fraktion" ) == 7 then
		setElementVisibleTo ( AztecasDeliver, player, true )
		setElementVisibleTo ( AztecasDeliverBlip, player, true )
	elseif vioGetElementData ( player, "fraktion" ) == 9 then
		setElementVisibleTo ( BikerDeliver, player, true )
		setElementVisibleTo ( BikerDeliverBlip, player, true )
	end
	
	weaponsTruck = true
	setTimer (
		function ( truck )
			weaponsTruck = false
			if isElement ( truck ) then
				destroyElement ( truck )
			end
		end,
	timeTillWeaponTruckDisapperas, 1, _G["truck"..truckcount] )
end