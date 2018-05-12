lastMisfireLongAgo = true

function rocketLauncherMisfire ()

	if getPedWeapon ( lp ) == 35 then
		if math.random ( 1, 20 ) == 1 and lastMisfireLongAgo then
			triggerServerEvent ( "misfire", lp )
			lastMisfireLongAgo = false
			setTimer (
				function ()
					lastMisfireLongAgo = true
				end,
			60000, 1 )
		end
	end
end
addEvent ( "onClientPlayerAimWeapon", true )
addEventHandler ( "onClientPlayerAimWeapon", getRootElement(), rocketLauncherMisfire )