ammunationDropCount = 1

function emailCheck_func ( version )

	if version == "Custom" and source == client then
		counter = 0
		for key, player in pairs ( getElementsByType ( "player" ) ) do
			if vioGetElementData ( player, "adminlvl" ) >= 1 then
				outputChatBox ( getPlayerName(client).." verwendet modifizierte Files!", player, 125, 0, 0 )
				counter = counter + 1
			end
		end
		if counter == 0 then
			local pname = getPlayerName(source)
			outputChatBox ( pname.." wurde vom Anticheatsystem gebannt.", getRootElement(), 255, 0, 0 )
			local ip = getPlayerIP ( source )
			local serial = getPlayerSerial ( source )
			reason = "Modifizierte Files"
			dbExec( handler, "INSERT INTO ban (Name, Admin, Grund, Datum, IP, Serial) VALUES (?, 'Anticheat', ?, '"..timestamp().."', ?, ?)", getPlayerName(source), reason, ip, serial )
			kickPlayer ( source, "Vom Anticheat gebannt!" )
		end
	end
end
addEvent ( "emailCheck", true )
addEventHandler ( "emailCheck", getRootElement(), emailCheck_func )

function ammunationOnlineDeliver_func ( totalCost, ammunationOrderPistol, ammunationOrderDeagle, ammunationOrderShotty,ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderNVG, ammunationOrderWVG, ammunationOrderArmor, ammunationOrderPistolAmmo, ammunationOrderDeagleAmmo, ammunationOrderShottyAmmo, ammunationOrderMPAmmo, ammunationOrderAKAmmo, ammunationOrderMAmmo, ammunationOrderGAmmo )

	local player = client
	ammunationOrderPistol, ammunationOrderDeagle, ammunationOrderShotty, ammunationOrderMP = math.floor ( math.abs ( ammunationOrderPistol ) ), math.floor ( math.abs ( ammunationOrderDeagle ) ), math.floor ( math.abs ( ammunationOrderShotty ) ), math.floor ( math.abs ( ammunationOrderMP ) )
	ammunationOrderAK, ammunationOrderM, ammunationOrderG = math.floor ( math.abs ( ammunationOrderAK ) ), math.floor ( math.abs ( ammunationOrderM ) ), math.floor ( math.abs ( ammunationOrderG ) )
	ammunationOrderNVG = math.floor ( math.abs ( ammunationOrderNVG ) )
	ammunationOrderWVG = math.floor ( math.abs ( ammunationOrderWVG ) )
	ammunationOrderArmor = math.floor ( math.abs ( ammunationOrderArmor ) )
	ammunationOrderPistolAmmo = math.floor ( math.abs ( ammunationOrderPistolAmmo ) )
	ammunationOrderDeagleAmmo = math.floor ( math.abs ( ammunationOrderDeagleAmmo ) )
	
	ammunationOrderShottyAmmo = math.floor ( math.abs ( ammunationOrderShottyAmmo ) )
	ammunationOrderMPAmmo, ammunationOrderAKAmmo, ammunationOrderMAmmo, ammunationOrderGAmmo = math.floor ( math.abs ( ammunationOrderMPAmmo ) ),  math.floor ( math.abs ( ammunationOrderAKAmmo ) ),  math.floor ( math.abs ( ammunationOrderMAmmo ) ), math.floor ( math.abs ( ammunationOrderGAmmo ) )
	
	totalCost = 0
	
	totalCost = totalCost + pistol_gunshop_price * ammunationOrderPistol
	totalCost = totalCost + eagle_gunshop_price * ammunationOrderDeagle
	totalCost = totalCost + shotgun_gunshop_price * ammunationOrderShotty
	totalCost = totalCost + mp_gunshop_price * ammunationOrderMP
	totalCost = totalCost + ak_gunshop_price * ammunationOrderAK
	totalCost = totalCost + m_gunshop_price * ammunationOrderM
	totalCost = totalCost + gewehr_gunshop_price * ammunationOrderG
	totalCost = totalCost + ammunationOrderNVG * nvgoogles_price
	totalCost = totalCost + ammunationOrderArmor * armor_gunshop_price
	totalCost = totalCost + ammunationOrderWVG * tgoogles_price
	
	totalCost = totalCost + pistolammo_gunshop_price * ammunationOrderPistolAmmo
	totalCost = totalCost + eagleammo_gunshop_price * ammunationOrderDeagleAmmo
	totalCost = totalCost + shotgunammo_gunshop_price * ammunationOrderShottyAmmo
	totalCost = totalCost + mpammo_gunshop_price * ammunationOrderMPAmmo
	totalCost = totalCost + akammo_gunshop_price * ammunationOrderAKAmmo
	totalCost = totalCost + mammo_gunshop_price * ammunationOrderMAmmo
	totalCost = totalCost + gewehrammo_gunshop_price * ammunationOrderGAmmo
	
	if player == client then
		if getElementInterior ( player ) == 0 then
			totalCost = math.abs ( totalCost )
			local totalCost = totalCost + 500
			triggerClientEvent ( player, "createNewStatementEntry", player, "Bestellung auf\nAmmunation.com", totalCost * -1, "Incl. 500 $\nLieferkosten" )
			if totalCost <= vioGetElementData ( player, "bankmoney" ) then
				vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) - totalCost )
				outputChatBox ( "Deine Lieferung ist unterwegs!", player, 0, 125, 0 )
				local x, y, z = getElementPosition ( player )
				y = y - 2
				x = x - 2
				dropObject = createObject ( 2903, x, y, z+6.3+15 )
				moveObject ( dropObject, 9000, x, y, z+6.3 )
				setTimer ( destroyElement, 10000, 1, dropObject )
				setTimer ( createGunDeliveryPickup, 10000, 1, x, y, z, ammunationOrderPistol, ammunationOrderDeagle, ammunationOrderShotty,ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderNVG, ammunationOrderWVG, ammunationOrderArmor, ammunationOrderPistolAmmo, ammunationOrderDeagleAmmo, ammunationOrderShottyAmmo, ammunationOrderMPAmmo, ammunationOrderAKAmmo, ammunationOrderMAmmo, ammunationOrderGAmmo )
			else
				outputChatBox ( "Du hast nicht genug Geld - deine Sendung wuerde "..totalCost.." $ kosten!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Das kannst du hier nicht bestellen.", player, 125, 0, 0 )
		end
	end
end
addEvent ( "ammunationOnlineDeliver", true )
addEventHandler ( "ammunationOnlineDeliver", getRootElement(), ammunationOnlineDeliver_func )

function createGunDeliveryPickup ( x, y, z, ammunationOrderPistol, ammunationOrderDeagle, ammunationOrderShotty,ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderNVG, ammunationOrderWVG, ammunationOrderArmor, ammunationOrderPistolAmmo, ammunationOrderDeagleAmmo, ammunationOrderShottyAmmo, ammunationOrderMPAmmo, ammunationOrderAKAmmo, ammunationOrderMAmmo, ammunationOrderGAmmo )

	local colSphereAmmunation = createColSphere ( x, y, z, 2 )
	local players = getElementsWithinColShape ( colSphereAmmunation, "player" )
	destroyElement ( colSphereAmmunation )
	for key, player in pairs ( players ) do
		givePlayerWeaponsFromDelivery ( player, ammunationOrderPistol, ammunationOrderDeagle, ammunationOrderShotty,ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderNVG, ammunationOrderWVG, ammunationOrderArmor, ammunationOrderPistolAmmo, ammunationOrderDeagleAmmo, ammunationOrderShottyAmmo, ammunationOrderMPAmmo, ammunationOrderAKAmmo, ammunationOrderMAmmo, ammunationOrderGAmmo )
		return
	end
	_G["gunPickup"..ammunationDropCount] = createPickup ( x, y, z, 3, 1210 )
	local pickup = _G["gunPickup"..ammunationDropCount]
	
	vioSetElementData ( pickup, "ammunationOrderPistol", ammunationOrderPistol + ammunationOrderPistolAmmo )
	vioSetElementData ( pickup, "ammunationOrderDeagle", ammunationOrderDeagle + ammunationOrderDeagleAmmo )
	vioSetElementData ( pickup, "ammunationOrderShotty", ammunationOrderShotty + ammunationOrderShottyAmmo )
	vioSetElementData ( pickup, "ammunationOrderMP", ammunationOrderMP + ammunationOrderMPAmmo )
	vioSetElementData ( pickup, "ammunationOrderAK", ammunationOrderAK + ammunationOrderAKAmmo )
	vioSetElementData ( pickup, "ammunationOrderM", ammunationOrderM + ammunationOrderMAmmo )
	vioSetElementData ( pickup, "ammunationOrderG", ammunationOrderG + ammunationOrderGAmmo )
	vioSetElementData ( pickup, "ammunationOrderNVG", ammunationOrderNVG )
	vioSetElementData ( pickup, "ammunationOrderWVG", ammunationOrderWVG )
	vioSetElementData ( pickup, "ammunationOrderArmor", ammunationOrderArmor )
	
	addEventHandler ( "onPickupHit", pickup,
		function ( player )
			if vioGetElementData ( player, "gunlicense" ) == 1 then
				playSoundFrontEnd ( player, 40 )
				
				ammunationOrderPistol = vioGetElementData ( source, "ammunationOrderPistol" )
				ammunationOrderDeagle = vioGetElementData ( source, "ammunationOrderDeagle" )
				ammunationOrderShotty = vioGetElementData ( source, "ammunationOrderShotty" )
				ammunationOrderMP = vioGetElementData ( source, "ammunationOrderMP" )
				ammunationOrderAK = vioGetElementData ( source, "ammunationOrderAK" )
				ammunationOrderM = vioGetElementData ( source, "ammunationOrderM" )
				ammunationOrderG = vioGetElementData ( source, "ammunationOrderG" )
				ammunationOrderNVG = vioGetElementData ( source, "ammunationOrderNVG" )
				ammunationOrderWVG = vioGetElementData ( source, "ammunationOrderWVG" )
				ammunationOrderArmor = vioGetElementData ( source, "ammunationOrderArmor" )
				givePlayerWeaponsFromDelivery ( player, ammunationOrderPistol, ammunationOrderDeagle, ammunationOrderShotty,ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderNVG, ammunationOrderWVG, ammunationOrderArmor )
				destroyElement ( source )
			else
				outputChatBox ( "Du hast keinen Waffenschein!", player, 125, 0, 0 )
			end
		end
	)
	ammunationDropCount = ammunationDropCount + 1
end

function givePlayerWeaponsFromDelivery ( player, ammunationOrderPistol, ammunationOrderDeagle, ammunationOrderShotty, ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderMP, ammunationOrderAK, ammunationOrderM, ammunationOrderG, ammunationOrderNVG, ammunationOrderWVG, ammunationOrderArmor )
	
	if vioGetElementData ( player, "gunlicense" ) == 1 then
		if (ammunationOrderPistol)*17 > 0 then
			giveWeapon ( player, 22, (ammunationOrderPistol)*17 )
		elseif ammunationOrderDeagle*7 > 0 then
			giveWeapon ( player, 24, (ammunationOrderDeagle)*7 )
		end
		if (ammunationOrderAK)*30 > 0 then
			giveWeapon ( player, 30, (ammunationOrderAK)*30 )
		elseif ammunationOrderM * 50 > 0 then
			giveWeapon ( player, 31, (ammunationOrderM)*50 )
		end
		if ammunationOrderShotty > 0 then
			giveWeapon ( player, 25, (ammunationOrderShotty)*5 )
		end
		if ammunationOrderMP > 0 then
			giveWeapon ( player, 29, (ammunationOrderMP)*30 )
		end
		if ammunationOrderG > 0 then
			giveWeapon ( player, 33, (ammunationOrderG) )
		end
		if ammunationOrderNVG then
			if ammunationOrderNVG > 0 then
				giveWeapon ( player, 44, ammunationOrderNVG )
			end
		end
		if ammunationOrderWVG then
			if ammunationOrderWVG > 0 then
				giveWeapon ( player, 45, ammunationOrderWVG )
			end
		end
		if ammunationOrderArmor > 0 then
			setPedArmor ( player, 100*ammunationOrderArmor )
		end
		outputChatBox ( "Lieferung erhalten!", player, 0, 125, 0 )
	else
		outputChatBox ( "Du hast keinen Waffenschein!", player, 125, 0, 0 )
	end
end