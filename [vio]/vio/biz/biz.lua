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

	local result = dbPoll( dbQuery( handler, "SELECT * FROM biz" ), -1 )
	if result and result[1] then
		for i=1, #result do
			local biz = result[i]["Biz"]
			if biz == "PaynSprayWangcars" then
				pnsDohertyName = result[i]["Name"]
				pnsDohertyKasse = tonumber( result[i]["Kasse"] )
				pnsDohertyInhaber = result[i]["Inhaber"]
				pnsDohertyPrice = tonumber( result[i]["Preis"] )
			elseif biz == "PaynSprayJuniper" then
				pnsJuniperName = result[i]["Name"]
				pnsJuniperKasse = tonumber( result[i]["Kasse"] )
				pnsJuniperInhaber = result[i]["Inhaber"]
				pnsJuniperPrice = tonumber( result[i]["Preis"] )
			elseif biz == "Sprunk" then
				sprunkName = result[i]["Name"]
				sprunkKasse = tonumber( result[i]["Kasse"] )
				sprunkInhaber = result[i]["Inhaber"]
				sprunkPrice = tonumber( result[i]["Preis"] )
			elseif biz == "WellStackedPizza" then
				pizzaStackName = result[i]["Name"]
				pizzaStackKasse = tonumber( result[i]["Kasse"] )
				pizzaStackInhaber = result[i]["Inhaber"]
				pizzaStackPrice = tonumber( result[i]["Preis"] )
			elseif biz == "MistysBar" then
				mystiesBarName = result[i]["Name"]
				mystiesBarKasse = tonumber( result[i]["Kasse"] )
				mystiesBarInhaber = result[i]["Inhaber"]
				mystiesBarPrice = tonumber( result[i]["Preis"] )
			elseif biz == "Visage" then
				visageHotelName = result[i]["Name"]
				visageHotelKasse = tonumber( result[i]["Kasse"] )
				visageHotelInhaber = result[i]["Inhaber"]
				visageHotelPrice = tonumber( result[i]["Preis"] )
			elseif biz == "VankHoff" then
				vankHoffName = result[i]["Name"]
				vankHoffKasse = tonumber( result[i]["Kasse"] )
				vankHoffInhaber = result[i]["Inhaber"]
				vankHoffPrice = tonumber( result[i]["Preis"] )
			elseif biz == "TankstelleNord" then
				tankstelleNordName = result[i]["Name"]
				tankstelleNordKasse = tonumber( result[i]["Kasse"] )
				tankstelleNordInhaber = result[i]["Inhaber"]
				tankstelleNordPrice = tonumber( result[i]["Preis"] )
			elseif biz == "TankstelleSued" then
				tankstelleSuedName = result[i]["Name"]
				tankstelleSuedKasse = tonumber( result[i]["Kasse"] )
				tankstelleSuedInhaber = result[i]["Inhaber"]
				tankstelleSuedPrice = tonumber( result[i]["Preis"] )
			elseif biz == "TankstellePine" then
				tankstellePineName = result[i]["Name"]
				tankstellePineKasse = tonumber( result[i]["Kasse"] )
				tankstellePineInhaber = result[i]["Inhaber"]
				tankstellePinePrice = tonumber( result[i]["Preis"] )
			end
		end
	end
	bizkeys = { [1]="pnsDoherty", [2]="pnsJuniper", [3]="sprunk", [4]="pizzaStack", [5]="mystiesBar", [6]="visageHotel", [7]="vankHoff", [8]="tankstelleNord", [9]="tankstelleSued", [10]="tankstellePine" }
	
	addEventHandler ( "onPickupHit", getRootElement(), onBizPickupHit )
	
	setTimer ( updateBizKasse, 300000, 1 )
end
addEventHandler("onResourceStart", resourceRoot, setBizData)


function updateBizKasse ()
	local querystr = dbPrepareString( handler, "UPDATE biz SET Kasse=? WHERE Name LIKE ?;", pnsDohertyKasse, pnsDohertyName )
	querystr = querystr .. dbPrepareString( handler, "UPDATE biz SET Kasse=? WHERE Name LIKE ?;", pnsJuniperKasse, pnsJuniperName )
	querystr = querystr .. dbPrepareString( handler, "UPDATE biz SET Kasse=? WHERE Name LIKE ?;", sprunkKasse, sprunkName )
	querystr = querystr .. dbPrepareString( handler, "UPDATE biz SET Kasse=? WHERE Name LIKE ?;", pizzaStackKasse, pizzaStackName )
	querystr = querystr .. dbPrepareString( handler, "UPDATE biz SET Kasse=? WHERE Name LIKE ?;", mystiesBarKasse, mystiesBarName )
	querystr = querystr .. dbPrepareString( handler, "UPDATE biz SET Kasse=? WHERE Name LIKE ?;", visageHotelKasse, visageHotelName )
	querystr = querystr .. dbPrepareString( handler, "UPDATE biz SET Kasse=? WHERE Name LIKE ?;", vankHoffKasse, vankHoffName )
	querystr = querystr .. dbPrepareString( handler, "UPDATE biz SET Kasse=? WHERE Name LIKE ?;", tankstelleNordKasse, tankstelleNordName )
	querystr = querystr .. dbPrepareString( handler, "UPDATE biz SET Kasse=? WHERE Name LIKE ?;", tankstelleSuedKasse, tankstelleSuedName )
	querystr = querystr .. dbPrepareString( handler, "UPDATE biz SET Kasse=? WHERE Name LIKE ?;", tankstellePineKasse, tankstellePineName )

	dbExec( handler, querystr )
	
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
						dbExec( handler, "UPDATE userdata SET Bizschluessel = ? WHERE Name LIKE ?", vioGetElementData ( player, "bizkey" ), pname )
						dbExec( handler, "UPDATE biz SET Inhaber = ? WHERE Name LIKE ?", pname, _G[biz.."Name"])
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
		dbExec( handler, "UPDATE userdata SET Bizschluessel = ? WHERE Name LIKE ?", vioGetElementData ( player, "bizkey" ), pname )
		dbExec( handler, "UPDATE biz SET Inhaber = ? WHERE Name LIKE ?", "none", _G[biz.."Name"] )
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