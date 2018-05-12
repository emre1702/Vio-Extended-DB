formationActive = false
formationCount = 0
formations = {}
	formations["members"] = {}
	formations["leader"] = {}

function formation ( player )

	if not formationActive then
		if isBiker ( player ) then
			if vioGetElementData ( player, "rang" ) >= 3 then
				local veh = getPedOccupiedVehicle ( player )
				if veh and getElementModel ( veh ) == 463 then
					formationActive = true
					
					local x, y, z = getElementPosition ( veh )
					local marker = createMarker ( x, y, z - ( 30.085750579834 - 29.032991409302 ), "cylinder", 15, 127, 127, 127, 150 )
					setElementVisibleTo ( marker, getRootElement(), false )
					
					attachElements ( marker, veh )
					
					formationCount = formationCount + 1
					formations["leader"][formationCount] = player
					formations["members"] = {}
					
					vioSetElementData ( veh, "formationCount", formationCount )
					vioSetElementData ( veh, "formationMarker", marker )
					
					addEventHandler ( "onPlayerVehicleExit", player,
						function ( veh )
							deleteFormation ( veh )
						end
					)
					addEventHandler ( "onPlayerQuit", player,
						function ()
							deleteFormation ( getPedOccupiedVehicle ( source ) )
						end
					)
					
					vioSetElementData ( player, "formationID", formationCount )
					vioSetElementData ( marker, "formationID", formationCount )
					vioSetElementData ( marker, "formationVeh", veh )
					vioSetElementData ( player, "formationMarker", marker )
					
					addEventHandler ( "onMarkerHit", marker, formationMarkerHit )
					
					triggerClientEvent ( player, "formationFound", player )
					
					infobox ( player, "Formation erstellt!\nWenn deine Brüder nun\nmit dir fahren, wirst\ndu schneller!", 5000, 200, 0, 0 )
					
					for key, index in pairs ( fraktionMembers[9] ) do
						if key ~= player then
							setElementVisibleTo ( marker, key, true )
						end
					end
				else
					infobox ( player, "Nur auf einer Freeway\nmöglich!", 5000, 200, 0, 0 )
				end
			else
				infobox ( player, "Nur für Roadcaptain\noder höher!", 5000, 200, 0, 0 )
			end
		else
			infobox ( player, "Du bist kein Mitglied\nder Angels of Death!", 5000, 200, 0, 0 )
		end
	else
		infobox ( player, "Es kann immer nur\neine Formation geben!", 5000, 200, 0, 0 )
	end
end
addCommandHandler ( "formation", formation )

function formationMarkerHit ( player, dim )

	if getElementType ( player ) == "player" and dim and getElementInterior ( source ) == getElementInterior ( player ) then
		local veh = getPedOccupiedVehicle ( player )
		local leaderVeh = vioGetElementData ( marker, "formationVeh" )
		if veh and isBiker ( player ) and getElementModel ( veh ) == 463 and veh ~= leaderVeh then
			if getPedOccupiedVehicleSeat ( player ) == 0 then
				vioSetElementData ( veh, "formationID", vioGetElementData ( source, "formationID" ) )
				vioSetElementData ( veh, "formationMarker", source )
				formations["members"][player] = true
				triggerClientEvent ( player, "joinFormation", player )
			end
		end
	end
end

function deleteFormation ( veh )

	local id = vioGetElementData ( veh, "formationCount" )
	local marker = vioGetElementData ( veh, "formationMarker" )
	destroyElement ( marker )
	for key, index in pairs ( formations["members"] ) do
		infobox ( key, "Deine Formation wurde\naufgelöst!", 5000, 200, 0, 0 )
		vioSetElementData ( key, "formationID", false )
		vioSetElementData ( key, "formationMarker", false )
		triggerClientEvent ( key, "leavaeFormation", key )
	end
	formationActive = false
	
	vioGetElementData ( veh, "formationMarker", false )
	vioGetElementData ( veh, "formationCount", false )
end
--[[
    <vehicle id="vehicle (Freeway) (9)" paintjob="3" model="463" plate="9OLI79B" interior="0" dimension="0" color="113,113,0,0" posX="-2182.9116210938" posY="-2381.3762207031" posZ="30.085750579834" rotX="0" rotY="0" rotZ="233.99230957031" />
    <marker id="formation" type="cylinder" color="" size="15" interior="0" dimension="0" posX="-2182.9116210938" posY="-2381.3762207031" posZ="29.032991409302" rotX="0" rotY="0" rotZ="0" />
]]