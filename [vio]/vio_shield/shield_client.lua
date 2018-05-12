function checkForCheats ()

	if isWorldSpecialPropertyEnabled ( "hovercars" ) then
		triggerServerEvent ( "vioShieldBanPlayer", lp, "Schwimmfahrzeuge" )
	elseif isWorldSpecialPropertyEnabled ( "aircars" ) then
		triggerServerEvent ( "vioShieldBanPlayer", lp, "Fliegende Autos" )
	elseif isWorldSpecialPropertyEnabled ( "extrajump" ) or isWorldSpecialPropertyEnabled ( "extrabunny" ) then
		triggerServerEvent ( "vioShieldBanPlayer", lp, "Extrasprung" )
	elseif getGameSpeed() >= 1.1 then
		triggerServerEvent ( "vioShieldBanPlayer", lp, "Speedhack" )
	end
end
setTimer ( checkForCheats, 1000, -1 )

function antiCheatWeaponFire ( a, ammo, clip )

	outputChatBox ( "Function: Ammo total: "..tostring ( ammo )..", Clip: "..tostring ( clip ) )
	outputChatBox ( "Given: Ammo total: "..getPedTotalAmmo ( lp )..", Clip: "..getPedAmmoInClip( lp ) )
end
addEventHandler ( "onClientPedWeaponFire", getRootElement(), antiCheatWeaponFire )

outputChatBox ( "GNARF!" )