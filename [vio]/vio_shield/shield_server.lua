vio = getResourceFromName ( "vio" )
root = getRootElement()

function vioShieldBanPlayer ( reason )

	local player = client
	if not reason then
		reason = "Vio Shield"
	end
	call ( vio, "banVioShieldPlayer", player, reason )
end
addEvent ( "vioShieldBanPlayer", true )
addEventHandler ( "vioShieldBanPlayer", getRootElement(), vioShieldBanPlayer )