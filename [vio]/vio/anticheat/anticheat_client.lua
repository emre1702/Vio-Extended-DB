-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

function vioSetElementData ( element, field, value )
	return setElementData ( element, field, value )
end
function vioGetElementData ( element, field )
	return getElementData ( element, field )
end

validGunCheatProofs = { [1]=true, [2]=true, [3]=true, [4]=true, [5]=true, [6]=true, [7]=true, [8]=true, [9]=true, [10]=true }

player = lp

function start_anticheat ()

	aCheatRun = 0
	
	setTimer ( anticheat, 10000, -1 )
end
addEventHandler ( "onClientResourceStart", getRootElement(), start_anticheat )

function anticheat ()

	if getElementData ( lp, "isInHighNoon" ) or isPedDead ( lp ) then
		showChat ( false )
		if isElement ( gLabels["InfoTextForum"] ) then
			guiSetVisible ( gLabels["InfoTextForum"], false )
			guiSetVisible ( gLabels["InfoTextForumShadow"], false )
		end
		showPlayerHudComponent ( "radar", false )
	else
		if not guiGetVisible ( gLabels["InfoTextForum"] ) then
			if isElement ( gLabels["InfoTextForum"] ) then
				guiSetVisible ( gLabels["InfoTextForumShadow"], true )
				guiSetVisible ( gLabels["InfoTextForum"], true )
			end
		end
	end
end

function sec_gun_give ( weapon, ammo )

	
end
addEvent( "sec_gun_give", true )
addEventHandler( "sec_gun_give", getRootElement(), sec_gun_give )

function sec_health_give ( health )

	
end
addEvent( "sec_health_give", true )
addEventHandler( "sec_health_give", getRootElement(), sec_health_give )

function sec_armor_give ( armor )

	
end
addEvent( "sec_armor_give", true )
addEventHandler( "sec_armor_give", getRootElement(), sec_armor_give )

function hasPlayerLicense ( player, id )
	if cars[id] then
		if tonumber ( getElementData ( player, "carlicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif lkws[id] then
		if tonumber ( getElementData ( player, "lkwlicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif bikes[id] then
		if tonumber ( getElementData ( player, "bikelicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif helicopters[id] then
		if tonumber ( getElementData ( player, "helilicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif planea[id] then
		if tonumber ( getElementData ( player, "planelicensea" ) ) == 1 then
			return true
		else
			return false
		end
	elseif planeb[id] then
		if tonumber ( getElementData ( player, "planelicenseb" ) ) == 1 then
			return true
		else
			return false
		end
	elseif motorboats[id] then
		if tonumber ( getElementData ( player, "motorbootlicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif raftboats[id] then
		if tonumber ( getElementData ( player, "segellicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif nolicense[id] then
		return true
	else
		return true
	end
end