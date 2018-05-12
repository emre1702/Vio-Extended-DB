function onPlayerSpawn_func ()

	setPedSkin ( source, vioGetElementData ( source, "skinid") )
	showPlayerHudComponent ( source, "radar", true )
	setTimer ( ShowWanteds_func, 250, 1, source )
end
addEventHandler("onPlayerSpawn", getRootElement(), onPlayerSpawn_func )

function ShowWanteds_func ( player )
	
	setPlayerWantedLevel ( player, tonumber(vioGetElementData ( player, "wanteds" )) )
end