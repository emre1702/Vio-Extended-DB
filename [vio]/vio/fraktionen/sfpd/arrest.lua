LVJailArea = createColCuboid ( 2278.166015625, 2424.8486328125, 3.0, 6.799804685, 10.05, 4.08400478363 )

function isInLVJailArea ( player )

	local x1, y1, z1 = getElementPosition ( player )
	if getDistanceBetweenPoints3D ( x1, y1, z1, 198.08735656738, 174.32916259766, 1002.672668457 ) < 10 then
		return true
	else
		return false
	end
end
function isInSFJailArea ( player )

	local x, y, z = getElementPosition ( player )
	if x < 229 and x > 213 and y < 116 and y > 107 and z < 1002 and z > 950 then
		return true
	else
		return false
	end
end

function isInSFCarJailArea ( player )

	local x, y, z = getElementPosition ( player )
	if getDistanceBetweenPoints3D ( -1590, 716, 0, x, y, 0 ) < 6.5 then
		return true
	else
		return false
	end
end
function isInLVCarJailArea ( player )

	return isElementWithinColShape ( player, LVJailArea )
end

function arrest_func ( player, cmd, target, bail )
	
	if target ~= nil then
	
		target = findPlayerByName( target )
		local arrest_wanteds = tonumber(vioGetElementData( target, "wanteds" ))
		local time
		local fine
		local kaution
		
		if not bail then bail = 0 end
		-----------------------------------------------------
		if bail then
		
			bail = math.abs ( math.floor ( tonumber ( bail ) ) )
			
			if bail ~= 1 and bail ~= 0 then
			
				triggerClientEvent ( player, "infobox_start", getRootElement(), "/arrest [Name] [1/0]!", 5000, 125, 0, 0 )
				return
			
			end
			
			if bail == 0 then
			
				time = arrest_wanteds * 10
				fine = 100 * arrest_wanteds * arrest_wanteds
				kaution = 0
			
			elseif bail == 1 then
			
				time = arrest_wanteds * 7
				fine = 70 * arrest_wanteds * arrest_wanteds
				
				if arrest_wanteds <= 3 then 
				
					kaution = 200 * arrest_wanteds * arrest_wanteds
				
				elseif arrest_wanteds > 3 then 
				
					kaution = 2000 * arrest_wanteds * arrest_wanteds
				
				end
			
			end
				
		end
		----------------------------------------------------------------
		if isOnDuty ( player ) then
			
			local bool = isInLVJailArea ( player )
			
			if isInLVJailArea ( target ) and isInLVJailArea ( player ) then
			
				bool = true
				
			elseif isInSFJailArea ( target ) and isInSFJailArea ( player ) then
			
				bool = true
				
			elseif isInLVCarJailArea ( target ) and isInLVCarJailArea ( player ) then
			
				bool = true
				
			elseif isInSFCarJailArea ( target ) and isInSFCarJailArea ( player ) then
			
				bool = true
				
			else
			
				bool = false
				
			end
			
			if bool then
			
			-- Hier JAIL
							
				if arrest_wanteds >= 1 then
						
					if getPedOccupiedVehicle ( target ) ~= false then removePedFromVehicle ( target ) end
					
					local boolean = not vioGetElementData ( target, "tied" )
					
					if boolean then 
					
						fix = "ent" 
						
						vioSetElementData ( target, "tied", boolean )
						toggleAllControls ( target, boolean )
											
						if fix == "ent" then
							fadeCamera ( target, true, 0.5, 0, 0, 0 )
							removeEventHandler ( "onPlayerCommand", target, block_tie_cmds )
						end
					
					end
													
					arrestPlayer ( player, target, time, fine, kaution )
						
				else
				
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Buerger hat\nkeine Verbrechen\nbegangen!", 5000, 125, 0, 0 )
						
				end
					
			-------------------------------
			
			else
			
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nIhr muesst\nbei den Zellen sein!", 5000, 125, 0, 0 )
			
			end
						
		else
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist\nkein Polizist im\nDienst!", 5000, 125, 0, 0 )
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Gebrauch:\n/arrest [Name]\n[Kaution, 0/1]", 5000, 125, 0, 0 )
		
	end
	
end

addCommandHandler ( "arrest", arrest_func )

--[[function carrest_func ( player, cmd, target, time, fine, bail )
	
	if target ~= nil then
		target = getPlayerFromName(target)
		local x, y, z = getElementPosition ( player )
		local tx, ty, tz = getElementPosition ( target )
		fine = math.abs ( math.floor ( tonumber ( fine ) ) )
		bail = math.abs ( math.floor ( tonumber ( bail ) ) )
		time = math.abs ( math.floor ( tonumber ( time ) ) )
		if isOnDuty ( player ) or isArmy(player) then
			local bool = ( isInLVCarJailArea ( player ) and isInLVCarJailArea ( target ) )
			if getDistanceBetweenPoints3D ( -1590, 716, 0, x, y, 0 ) < 6.5 or bool then
				if getDistanceBetweenPoints3D ( -1590, 716, 0, tx, ty, 0 ) < 6.5 or bool then
					if vioGetElementData ( target, "wanteds" ) >= 1 then
						removePedFromVehicle ( target )
						arrestPlayer ( player, target, time, fine, bail )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Buerger hat\nkeine Verbrechen\nbegangen!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nZiel ist\nbeim Carport!", 7500, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist nicht\nam Carport!", 7500, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist\nkein Polizist im\nDienst!", 7500, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Gebrauch:\n/carrest [Name]\n[Zeit] [Bail\n 0=Nein]", 7500, 125, 0, 0 )
	end
end
addCommandHandler ( "carrest", carrest_func )]]

function arrestPlayer ( officer, player, time, fine, bail )

	local money = vioGetElementData ( player, "money" )
	if fine > money then		
		vioSetElementData ( player, "money", 0 )
	else
		vioSetElementData ( player, "money", money - fine )
	end
	if vioGetElementData ( player, "tied" ) then
		fadeCamera ( player, true, 0.5, 0, 0, 0 )
		toggleAllControls ( player, true )
	end
	vioSetElementData ( player, "jailtime", time )
	vioSetElementData ( officer, "boni", vioGetElementData ( officer, "boni" ) + vioGetElementData ( player, "wanteds" ) * wantedprice )
	if bail == nil then bail = 0 end
	if bail == 0 then
		vioSetElementData ( player, "bail", 0 )
		outputChatBox ( "Du hast den Spieler "..getPlayerName ( player ).." ohne Kaution fuer "..fine.." $ und "..time.." Minuten eingesperrt!", officer, 0, 125, 0 )
		outputChatBox ( "Du wurdest von Polizist "..getPlayerName ( officer ).." ohne Kaution fuer "..fine.." $ und "..time.." Minuten eingesperrt!", player, 0, 125, 0 )
	else
		vioSetElementData ( player, "bail", bail )
		outputChatBox ( "Du wurdest von Polizist "..getPlayerName ( officer ).." mit "..bail.." $ Kaution fuer "..fine.." $ und "..time.." Minuten eingesperrt!", player, 0, 125, 0 )
		outputChatBox ( "Du hast den Spieler "..getPlayerName ( player ).." mit "..bail.." $ Kaution fuer "..fine.." $ und "..time.." Minuten eingesperrt!", officer, 0, 125, 0 )
	end
	outputChatBox ( getPlayerRankName ( officer ).." "..getPlayerName ( officer ).." hat "..getPlayerName ( player ).." eingesperrt!", getRootElement(), 0, 0, 150 )
	
	putPlayerInJail ( player )
end

function putPlayerInJail ( player )

	takeAllWeapons ( player )
	vioSetElementData ( player, "wanteds", 0 )
	setPlayerWantedLevel ( player, 0 )
	triggerClientEvent ( player, "jailKeyDisable", player )
	if not isInLVJailArea ( player ) or isInLVCarJailArea ( player ) then
		local rnd = math.floor ( math.random ( 1, 4 ) )
		if rnd == 1 then
			setElementPosition ( player, 215.61360168457, 110.61786651611, 998.66485595703 )
		elseif rnd == 2 then
			setElementPosition ( player, 219.60717773438, 110.39416503906, 998.66485595703 )
		elseif rnd == 3 then
			setElementPosition ( player, 223.60034179688, 110.17053222656, 998.66485595703 )
		else
			setElementPosition ( player, 227.34938049316, 110.19967651367, 998.66485595703 )
		end
		setElementInterior ( player, 10 )
	else
		local x, y, z, r, int = getRandomCellKoordinates ( false )
		setElementInterior ( player, int )
		setElementPosition ( player, x, y, z )
		setPedRotation ( player, r )
	end
	setElementDimension ( player, 0 )
end

function bail_func ( player )

	if vioGetElementData ( player, "jailtime" ) == 0 then
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nim Gefaengnis!", 5000, 125, 0, 0 )
	else
		if vioGetElementData ( player, "bail" ) == 0 then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast\nkeine Kaution!", 5000, 125, 0, 0 )
		else
			local bail = vioGetElementData ( player, "bail" )
			local money = vioGetElementData ( player, "money" )
			if bail <= money then
				vioSetElementData ( player, "money", money - bail )
				freePlayerFromJail ( player )
			else
				infobox ( player, "Du hast\nzu wenig Geld!\nKosten:\n"..bail, 5000, 125, 0, 0 )
			end
		end
	end
end
addCommandHandler ( "bail", bail_func )

function freePlayerFromJail ( player )

	vioSetElementData ( player, "jailtime", 0 )
	vioSetElementData ( player, "bail", 0 )
	vioSetElementData ( player, "jailtime", 0 )
	toggleControl ( player, "enter_exit", true )
	toggleControl ( player, "fire", true )
	toggleControl ( player, "jump", true )
	toggleControl ( player, "action", true )
	if vioGetElementData ( player, "heaventime" ) == 0 then
		infobox ( player, "Du bist wieder\nfrei! Benimm dich\nin Zukunft besser!", 5000, 0, 200, 0 )
		setElementInterior ( player, 0 )
		if getElementData ( player, "jail" ) == "lv" then
			setElementPosition ( player, 2340.1567382813, 2451.8452148438, 14.62340164 )
			setPedRotation ( player, 180 )
		else
			setElementPosition ( player, -1605.675, 717.516, 12.006 )
		end
	end
end

function jailtime_func ( player )

	local jailtime = vioGetElementData ( player, "jailtime" )
	if jailtime == 0 then
		infobox ( player, "\nDu bist nicht\nim Gefaengnis!", 5000, 125, 0, 0 )
	else
		outputChatBox ("Du bist noch fuer "..jailtime.." Minuten im Gefaengnis!", player, 0, 125, 0 )
	end
end
addCommandHandler ( "jailtime", jailtime_func )