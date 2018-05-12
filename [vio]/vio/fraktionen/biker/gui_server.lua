function bikerGarageRecieve ( typ )

	local player = client
	if getElementData ( player, "fraktion" ) ~= 9 then
		return false
	end
	if typ == 1 then
		local money = vioGetElementData ( player, "money" )
		if money >= 125 then
			vioSetElementData ( player, "money", money - 125 )
			giveWeapon ( player, 5, 1 )
			if vioGetElementData ( player, "rang" ) < 3 then
				giveWeapon ( player, 22, 17 * 5 )
			else
				giveWeapon ( player, 24, 7 * 3 )
			end
			giveWeapon ( player, 25, 10 )
			giveWeapon ( player, 28, 100 )
			playSoundFrontEnd ( player, 40 )
		else
			infobox ( player, "Du hast nicht\ngenug Geld!", 5000, 125, 0, 0 )
		end
	elseif typ == 2 then
		local money = vioGetElementData ( player, "money" )
		if money >= 10 then
			local veh = getPedOccupiedVehicle ( player )
			if veh then
				vioSetElementData ( player, "money", money - 10 )
				playSoundFrontEnd ( player, 40 )
				fixVehicle ( veh )
				setElementHealth ( veh, 1000 )
			else
				infobox ( player, "Du bist nicht in\neinem Fahrzeug!", 5000, 125, 0, 0 )
			end
		else
			infobox ( player, "Du hast nicht\ngenug Geld!", 5000, 125, 0, 0 )
		end
	elseif typ == 3 then
		local money = vioGetElementData ( player, "money" )
		if money >= 50 then
			vioSetElementData ( player, "money", money - 50 )
			playSoundFrontEnd ( player, 40 )
			setPedArmor ( player, 100 )
		else
			infobox ( player, "Du hast nicht\ngenug Geld!", 5000, 125, 0, 0 )
		end
	elseif typ == 4 then
		local money = vioGetElementData ( player, "money" )
		if money >= 100 then
			local veh = getPedOccupiedVehicle ( player )
			if veh then
				if factionVehicles[9][veh] and getElementModel ( veh ) == 413 then
					vioSetElementData ( player, "money", money - 100 )
					playSoundFrontEnd ( player, 40 )
					infobox ( player, "Van beladen!\nDu kannst jetzt mit\n/sellgun Waffen verkaufen,\nausserdem mit /matstat\ndeine Materialien\nanzeigen lassen", 5000, 125, 0, 0 )
					local mats = 0
					if vioGetElementData ( veh, "mats" ) then
						mats = vioGetElementData ( veh, "mats" )
					end
					vioSetElementData ( veh, "mats", mats + 15 )
				else
					infobox ( player, "Du kannst nur\neinen Van beladen!", 5000, 125, 0, 0 )
				end
			else
				infobox ( player, "Du bist nicht in\neinem Fahrzeug!", 5000, 125, 0, 0 )
			end
		else
			infobox ( player, "Du hast nicht\ngenug Geld!", 5000, 125, 0, 0 )
		end
	end
end
addEvent ( "bikerGarageRecieve", true )
addEventHandler ( "bikerGarageRecieve", getRootElement(), bikerGarageRecieve )

function matstat ( player )

	if isBiker ( player ) then
		local veh = getPedOccupiedVehicle ( player )
		local mats = 0
		if vioGetElementData ( veh, "mats" ) then
			mats = vioGetElementData ( veh, "mats" )
		end
		outputChatBox ( "Materialien im Fahrzeug: "..mats, player, 200, 0, 0 )
	end
end
addCommandHandler ( "matstat", matstat )