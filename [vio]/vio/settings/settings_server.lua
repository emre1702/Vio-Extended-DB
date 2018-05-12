testmode = false
winterzeit = 0
maxplayers = 128
wctime = 20
speznr = { [911]=true, [333]=true, [400]=true, [666666]=true } -- 911=Polize, 333=Auskunft, 400=Taxi, 666666=Eskortservice
tramSpeed = 0.35

-- Cars
destcardim = 1
noobbikerespawn = 5
FCarIdleRespawn = 10
FCarDestroyRespawn = 0.1
noobrollerrespawntime = 5
noobrolleridlerespawntime = 600

-- Preise
nitroprice = 50
tuningpartprice = 75

paynsprayprice = 25
wantedprice = 30
jailtimeperwanted = 10
hospitalcosts = 30
autosteuerprice = 30
autosteuererh = 1.5
drugprice = 30
smsprice = 1
callprice = 2
adcosts = 3
adbasiscosts = 10
pm_price = 250

zinssatz = 0.15

-- Essen
salatprice = 5
smallpizzaprice = 3
normalpizzaprice = 7
bigpizzaprice = 10
salatheal = 25
smallpizzaheal = 15
normalpizzaheal = 35
bigpizzaheal = 50

-- SFPD

copcars = { [598]=true, [596]=true, [597]=true }
copbikes = { [523]=true }
copjeeps = { [599]=true }
cophelis = { [497]=true }
copvehs = { [598]=true, [596]=true, [597]=true, [523]=true, [599]=true, [497]=true }

validResources = { ["realdriveby"]=true, ["parachute"]=true, ["vio"]=true }
stopBadScripts = false

timeTillWeaponTruckDisapperas = 20 * 60 * 1000

function resourceStart ( resource )

	if not validResources [ getResourceName ( resource ) ] then
		if stopBadScripts then
			cancelEvent()
		end
	end
end
addEventHandler ( "onResourcePreStart", getRootElement(), resourceStart )