function setBizData ()

	pnsDohertyIcon = createPickup ( -1908.7257080078, 276.80416870117, 40.696102142334, 3, 1239, 1, 0 )
	vioSetElementData ( pnsDohertyIcon, "biz", "pnsDoherty" )
	pnsJuniperIcon = createPickup ( -2431.1665039063, 1028.9090576172, 50.039852142334, 3, 1239, 1, 0 )
	vioSetElementData ( pnsJuniperIcon, "biz", "pnsJuniper" )
	pizzaStackIcon = createPickup ( -1720.0610351563, 1356.5998535156, 6.8367257118225, 3, 1239, 1, 0 )
	vioSetElementData ( pizzaStackIcon, "biz", "pizzaStack" )
	mystiesBarIcon = createPickup ( -2242.4169921875, -89.888648986816, 34.969539642334, 3, 1239, 1, 0 )
	vioSetElementData ( mystiesBarIcon, "biz", "mystiesBar" )
	sprunkIcon = createPickup ( -1752.3122558594, -144.58361816406, 3.2039132118225, 3, 1239, 1, 0 )
	vioSetElementData ( sprunkIcon, "biz", "sprunk" )
	
	visageHotelIcon = createPickup ( 2110.69, 1870.49, 10.47, 3, 1239, 1, 0 )
	vioSetElementData ( visageHotelIcon, "biz", "visageHotel" )
	vankHoffIcon = createPickup ( -2405.16, 325.73, 34.82, 3, 1239, 1, 0 )
	vioSetElementData ( vankHoffIcon, "biz", "vankHoff" )
	
	------------------------------------------------------
	
	tankstelleNordIcon = createPickup ( -2420.09765625, 969.890625, 45.296875, 3, 1239, 1, 0 )
	vioSetElementData ( tankstelleNordIcon, "biz", "tankstelleNord" )
	
	tankstelleSuedIcon = createPickup ( -1675.880859375, 431.7705078125, 7.1796875, 3, 1239, 1, 0 )
	vioSetElementData ( tankstelleSuedIcon, "biz", "tankstelleSued" )
	
	tankstellePineIcon = createPickup ( -2231.6591796875, -2558.095703125, 31.921875, 3, 1239, 1, 0 )
	vioSetElementData ( tankstellePineIcon, "biz", "tankstellePine" )
	
	---------------------------------------------

	bizIcons = { [pnsDohertyIcon]=true, [pnsJuniperIcon]=true, [pizzaStackIcon]=true, [mystiesBarIcon]=true, [sprunkIcon]=true, [visageHotelIcon]=true, [vankHoffIcon]=true, [tankstelleNordIcon]=true, [tankstelleSuedIcon]=true, [tankstellePineIcon]=true }

	OttosAutosIcon = createPickup ( -1639.7821044922, 1202.6267089844, 6.879873752594, 3, 1239, 1, 0 )

	TraeumeUndHoffnungen = createPickup ( -127.10718536377, 2258.1259765625, 28.063650131226, 3, 1239, 1, 0 )

	pnsDohertyName = MySQL_GetString("biz", "Name", "Biz LIKE 'PaynSprayWangcars'")
	pnsJuniperName = MySQL_GetString("biz", "Name", "Biz LIKE 'PaynSprayJuniper'")
	sprunkName = MySQL_GetString("biz", "Name", "Biz LIKE 'Sprunk'")
	pizzaStackName = MySQL_GetString("biz", "Name", "Biz LIKE 'WellStackedPizza'")
	mystiesBarName = MySQL_GetString("biz", "Name", "Biz LIKE 'MistysBar'")
	visageHotelName = MySQL_GetString("biz", "Name", "Biz LIKE 'Visage'")
	vankHoffName = MySQL_GetString("biz", "Name", "Biz LIKE 'VankHoff'")
	
	tankstelleNordName = MySQL_GetString("biz", "Name", "Biz LIKE 'TankstelleNord'")
	tankstelleSuedName = MySQL_GetString("biz", "Name", "Biz LIKE 'TankstelleSued'")
	tankstellePineName = MySQL_GetString("biz", "Name", "Biz LIKE 'TankstellePine'")

	pnsDohertyKasse = tonumber ( MySQL_GetString("biz", "Kasse", "Biz LIKE 'PaynSprayWangcars'") )
	pnsJuniperKasse = tonumber ( MySQL_GetString("biz", "Kasse", "Biz LIKE 'PaynSprayJuniper'") )
	sprunkKasse = tonumber ( MySQL_GetString("biz", "Kasse", "Biz LIKE 'Sprunk'") )
	pizzaStackKasse = tonumber ( MySQL_GetString("biz", "Kasse", "Biz LIKE 'WellStackedPizza'") )
	mystiesBarKasse = tonumber ( MySQL_GetString("biz", "Kasse", "Biz LIKE 'MistysBar'") )
	visageHotelKasse = tonumber ( MySQL_GetString("biz", "Kasse", "Biz LIKE 'Visage'") )
	vankHoffKasse = tonumber ( MySQL_GetString("biz", "Kasse", "Biz LIKE 'VankHoff'") )
	
	tankstelleNordKasse = tonumber ( MySQL_GetString("biz", "Kasse", "Biz LIKE 'TankstelleNord'") )
	tankstelleSuedKasse = tonumber ( MySQL_GetString("biz", "Kasse", "Biz LIKE 'TankstelleSued'") )
	tankstellePineKasse = tonumber ( MySQL_GetString("biz", "Kasse", "Biz LIKE 'TankstellePine'") )

	pnsDohertyInhaber = MySQL_GetString("biz", "Inhaber", "Biz LIKE 'PaynSprayWangcars'")
	pnsJuniperInhaber = MySQL_GetString("biz", "Inhaber", "Biz LIKE 'PaynSprayJuniper'")
	sprunkInhaber = MySQL_GetString("biz", "Inhaber", "Biz LIKE 'Sprunk'")
	pizzaStackInhaber = MySQL_GetString("biz", "Inhaber", "Biz LIKE 'WellStackedPizza'")
	mystiesBarInhaber = MySQL_GetString("biz", "Inhaber", "Biz LIKE 'MistysBar'")
	visageHotelInhaber = MySQL_GetString("biz", "Inhaber", "Biz LIKE 'Visage'")
	vankHoffInhaber = MySQL_GetString("biz", "Inhaber", "Biz LIKE 'VankHoff'")
	
	tankstelleNordInhaber = MySQL_GetString("biz", "Inhaber", "Biz LIKE 'TankstelleNord'")
	tankstelleSuedInhaber = MySQL_GetString("biz", "Inhaber", "Biz LIKE 'TankstelleSued'")
	tankstellePineInhaber = MySQL_GetString("biz", "Inhaber", "Biz LIKE 'TankstellePine'")
	
	pnsDohertyPrice = tonumber ( MySQL_GetString("biz", "Preis", "Biz LIKE 'PaynSprayWangcars'") )
	pnsJuniperPrice = tonumber ( MySQL_GetString("biz", "Preis", "Biz LIKE 'PaynSprayJuniper'") )
	sprunkPrice = tonumber ( MySQL_GetString("biz", "Preis", "Biz LIKE 'Sprunk'") )
	pizzaStackPrice = tonumber ( MySQL_GetString("biz", "Preis", "Biz LIKE 'WellStackedPizza'") )
	mystiesBarPrice = tonumber ( MySQL_GetString("biz", "Preis", "Biz LIKE 'MistysBar'") )
	visageHotelPrice = tonumber ( MySQL_GetString("biz", "Preis", "Biz LIKE 'Visage'") )
	vankHoffPrice = tonumber ( MySQL_GetString("biz", "Preis", "Biz LIKE 'VankHoff'") )
	
	tankstelleNordPrice = tonumber ( MySQL_GetString("biz", "Preis", "Biz LIKE 'TankstelleNord'") )
	tankstelleSuedPrice = tonumber ( MySQL_GetString("biz", "Preis", "Biz LIKE 'TankstelleSued'") )
	tankstellePinePrice = tonumber ( MySQL_GetString("biz", "Preis", "Biz LIKE 'TankstellePine'") )
	
	bizkeys = { [1]="pnsDoherty", [2]="pnsJuniper", [3]="sprunk", [4]="pizzaStack", [5]="mystiesBar", [6]="visageHotel", [7]="vankHoff", [8]="tankstelleNord", [9]="tankstelleSued", [10]="tankstellePine" }
	
	addEventHandler ( "onPickupHit", getRootElement(), onBizPickupHit )
	
	setTimer ( updateBizKasse, 300000, 1 )
end
setTimer ( setBizData, 1000, 1 )

function updateBizKasse ()

	MySQL_SetString("biz", "Kasse", pnsDohertyKasse, "Name LIKE '"..pnsDohertyName.."'")
	MySQL_SetString("biz", "Kasse", pnsJuniperKasse, "Name LIKE '"..pnsJuniperName.."'")
	MySQL_SetString("biz", "Kasse", sprunkKasse, "Name LIKE '"..sprunkName.."'")
	MySQL_SetString("biz", "Kasse", pizzaStackKasse, "Name LIKE '"..pizzaStackName.."'")
	MySQL_SetString("biz", "Kasse", mystiesBarKasse, "Name LIKE '"..mystiesBarName.."'")
	MySQL_SetString("biz", "Kasse", visageHotelKasse, "Name LIKE '"..visageHotelName.."'")
	MySQL_SetString("biz", "Kasse", vankHoffKasse, "Name LIKE '"..vankHoffName.."'")
	
	MySQL_SetString("biz", "Kasse", tankstelleNordKasse, "Name LIKE '"..tankstelleNordName.."'")
	MySQL_SetString("biz", "Kasse", tankstelleSuedKasse, "Name LIKE '"..tankstelleSuedName.."'")
	MySQL_SetString("biz", "Kasse", tankstellePineKasse, "Name LIKE '"..tankstellePineName.."'")
	
	outputDebugString ( "Bizkassen wurden gespeichert!" )
	setTimer ( updateBizKasse, 300000, 1 )
end

function onBizPickupHit ( hit )

	if source == TraeumeUndHoffnungen then
		outputChatBox ( "Hier ruhen Geramys Traeume und Hoffnungen.", hit, 125, 125, 200 )
	elseif bizIcons[source] then
		local biz = vioGetElementData ( source, "biz" )
		local besitzer = _G[biz.."Inhaber"]
		if besitzer == "none" then
			besitzer = "Niemandem"
		end
		local bizname = _G[biz.."Name"]
		local bizprice = _G[biz.."Price"]
		outputChatBox ( bizname..", gehoert: "..besitzer.." - Preis: "..bizprice.." $ und 50 Stunden Mindestspielzeit!", hit, 125, 0, 0 )
		if besitzer == "Niemandem" then
			triggerClientEvent ( hit, "infobox_start", getRootElement(), "Tippe /buybiz\n[bar/bank], um\ndas Geschaeft zu\nkaufen! Bei\nbank fallen 2 %\nmehr Kosten an!", 7500, 0, 125, 0 )
		end
	elseif OttosAutosIcon == source then
		outputChatBox ( "Tippe /givecar [Name] [Eigener Slot] [Slot beim neuen Besitzer], um das Auto an jemanden zu geben.", hit, 200, 200, 0 )
	end
end

function sellcarto_func ( player, cmd, name, slot )

	--outputChatBox ( "Momentan deaktiviert. Bitte nutze statt dessen /sellcar", player, 125, 0, 0 )
end
addCommandHandler ( "sellcarto", sellcarto_func )

function buybiz_func ( player, cmd, typ )

	if typ == "bar" then
		cash = vioGetElementData ( player, "money" )
		local cmd = true
	elseif typ == "bank" then
		cash = vioGetElementData ( player, "bankmoney" )		
		local cmd = true	
		if not cash then
			cmd = false
		end
	else
		local cmd = false
	end
	if cmd then
		local biz, bizkey = getNearestBiz ( player )
		if biz then
			local bizprice = false
			if typ == "bar" then
				bizprice = tonumber(_G[biz.."Price"])
			else
				bizprice = tonumber(_G[biz.."Price"]) * 1.02
			end
			if not bizprice then
				return
			end
			if bizprice > cash then
				return
			end
			if bizprice <= cash then
				if _G[biz.."Inhaber"] == "none" then
					if vioGetElementData ( player, "bizkey" ) == 0 then
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\nGeschaeft gekauft!\nTippe /bizhelp\nfuer mehr\nInformationen!", 7500, 0, 125, 0 )
						vioSetElementData ( player, "bizkey", bizkey )
						local pname = getPlayerName ( player )
						MySQL_SetString("userdata", "Bizschluessel", vioGetElementData ( player, "bizkey" ), "Name LIKE '"..pname.."'")
						MySQL_SetString("biz", "Inhaber", pname, "Name LIKE '".._G[biz.."Name"].."'")
						_G[biz.."Inhaber"] = pname
						if typ == "bar" then
							takePlayerMoney ( player, bizprice )
							vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - bizprice )
							triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
						else
							vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) - bizprice )
						end
						local x, y, z = getElementPosition ( player )
						setCameraMatrix ( player, x+10, y+10, z+10, x, y, z )
						setTimer ( fixBizBuyCam, 5000, 1, player ) 
						triggerClientEvent ( player, "achievsound", getRootElement() )
					else
						outputChatBox ( "Du hast bereits ein Geschaeft - tippe zuerst /sellbiz ein, um dein altes Geschaeft zu verkaufen.", player, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDas Geschaeft\ngehoert bereits\njemandem!!", 7500, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 7500, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bei\nkeinem Geschaeft!", 7500, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nTippe /buybiz\n[bar/bank], um\ndas Geschaeft zu\nkaufen!", 7500, 0, 125, 0 )
	end
end
addCommandHandler ( "buybiz", buybiz_func )

function sellbiz_func ( player )

	if vioGetElementData ( player, "bizkey" ) == 0 then
		outputChatBox ( "Du hast kein Geschaeft!", player, 125, 0, 0 )
	else
		local key = vioGetElementData ( player, "bizkey" )
		local biz = bizkeys[key]
		_G[biz.."Inhaber"] = "none"
		local bizprice = _G[biz.."Price"]
		local pname = getPlayerName ( player )
		outputDebugString ( "Spieler "..pname.." hat sein Geschaeft verkauft." )
		outputChatBox ( "Du hast dein Geschaeft verkauft und erhaelst "..bizprice.." $!", player, 0, 125, 0 )
		givePlayerMoney ( player, bizprice )
		vioSetElementData ( player, "bizkey", 0 )
		vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + bizprice )
		triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
		MySQL_SetString("userdata", "Bizschluessel", vioGetElementData ( player, "bizkey" ), "Name LIKE '"..pname.."'")
		MySQL_SetString("biz", "Inhaber", "none", "Name LIKE '".._G[biz.."Name"].."'")
		datasave_remote ( player )
	end
end
addCommandHandler ( "sellbiz", sellbiz_func )

function fixBizBuyCam ( player )

	setCameraTarget ( player, player )
end

function getNearestBiz ( player )

	local x1, y1, z1 = getElementPosition ( player )
	for i = 1, 10 do
		local biz = bizkeys[i]
		local x2, y2, z2 = getElementPosition ( _G[biz.."Icon"] )
		if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 3 then
			return biz, i
		end
	end
	return false, false
end

function bizhelp_func ( player )

	local bizkey = tonumber ( vioGetElementData ( player, "bizkey" ) )
	if bizkey == 0 then
		outputChatBox ( "Du besitzt kein Geschaeft!", player, 125, 0, 0 )
	else
		local bizname = _G[bizkeys[bizkey].."Name"]
		outputChatBox ( "Dein Geschaeft: "..bizname..", Kasse: ".._G[bizkeys[bizkey].."Kasse"].." $.", player, 200, 200, 15 )
		outputChatBox ( "/sellbiz - Geschaeft verkaufen, /bizhelp - Diese Hilfe, /bizdraw - Geld abheben, /bizstore - Geld einlagern.", player, 125, 125, 200 )
	end
end
addCommandHandler ( "bizhelp", bizhelp_func )

function bizdraw_func ( player, cmd, amount )

	if vioGetElementData ( player, "bizkey" ) > 0 then
		local amount = math.abs ( tonumber ( amount ) )
		if amount then
			local key = vioGetElementData ( player, "bizkey" )
			local biz = bizkeys[key]
			local curmoney = _G[biz.."Kasse"]
			if curmoney >= amount then
				_G[biz.."Kasse"] = curmoney - amount
				givePlayerMoney ( player, amount )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + amount )
				triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
			else
				outputChatBox ( "Du hast nicht so viel Geld in deinem Geschaeft!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Bitte gib eine gueltige Summe an!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Du besitzt kein Geschaeft!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "bizdraw", bizdraw_func )

function bizstore_func ( player, cmd, amount )

	if vioGetElementData ( player, "bizkey" ) > 0 then
		local amount = math.abs ( tonumber ( amount ) )
		if amount then
			local key = vioGetElementData ( player, "bizkey" )
			local biz = bizkeys[key]
			if vioGetElementData ( player, "money" ) >= amount then
				_G[biz.."Kasse"] = _G[biz.."Kasse"] + amount
				takePlayerMoney ( player, amount )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - amount )
				triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
			else
				outputChatBox ( "Du hast nicht genug Geld bei dir!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Bitte gib eine gueltige Summe an!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Du besitzt kein Geschaeft!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "bizstore", bizstore_func )

function addMoneyToBiz ( id, amount )

	local biz = ""
	if id == 6 then
		biz = "visageHotel"
	elseif id == 7 then
		biz = "vankHoff"
	end
	_G[biz.."Kasse"] = _G[biz.."Kasse"] + amount
end