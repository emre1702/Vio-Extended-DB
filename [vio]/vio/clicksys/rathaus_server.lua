local function LizenzKaufen_func_wschein_DB ( qh, player, lizens, pname )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local string = tonumber ( result[1]["Time"] )
		if not string then
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 1495 )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nWaffenschein beantragt\n- du kannst ihn in\n48 Stunden abholen.", 5000, 0, 255, 0 )
			playSoundFrontEnd ( player, 40 )
			takePlayerMoney ( player, 1495 )
			triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
			dbExec( handler, "INSERT INTO gunlicense ( Name, Time ) VALUES ( ?, ? )", pname, getMinTime() )
		else
			local timeToWait = string - getMinTime () + 48 * 60
			if timeToWait > 0 then
				local hours, mins
				hours = math.floor ( timeToWait / 60 )
				mins = timeToWait - hours * 60
				infobox ( player, "\nDu hast bereits\neinen Schein beantragt\nund musst noch\n"..hours..":"..mins.." warten.", 5000, 125, 0, 0 )
			else
				playSoundFrontEnd ( player, 40 )
				vioSetElementData ( player, "gunlicense", 1 )
				prompt ( player, "Du hast soeben deinen Waffenschein erhalten,\nder dich zum Besitz einer Waffe berechtigt.\nTraegst du deine Waffen offen, so wird die\nPolizei sie dir abnehmen.\nFalls du zu oft negativ auffaellst ( z.b.\ndurch Schiesserein ), koennen sie dir ihn\nauch wieder abnehmen.\n\nAusserdem: GRUNDLOSES Toeten von Spielern ist verboten.\nGruende sind nicht: Geldgier, \"Hat mich angeguggt\"\nusw., sondern z.b. Selbstverteidigung oder Gangkriege.", 30 )
				dbExec( handler, "UPDATE userdata SET Waffenschein = ? WHERE Name LIKE ?", vioGetElementData ( player, "gunlicense" ), pname )
				dbExec( handler, "DELETE FROM gunlicense WHERE Name LIKE ?", pname )
			end
		end
		checkAchievLicense ( player )
	end
end


function LizenzKaufen_func ( player, lizens )

	if player == client then
		local pname = getPlayerName ( player )
		if lizens == "planeb" then
			if tonumber(vioGetElementData ( player, "planelicenseb" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 34950 then
					if vioGetElementData ( player, "planelicensea" ) == 1 then
						vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 34950 )
						vioSetElementData ( player, "planelicenseb", 1 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nFluglizens\nTyp B erhalten!", 5000, 0, 255, 0 )
						playSoundFrontEnd ( player, 40 )
						takePlayerMoney ( player, 34950 )
						dbExec( handler, "UPDATE userdata SET FlugscheinKlasseB = ? WHERE Name LIKE ?", vioGetElementData ( player, "planelicenseb" ), pname )
						triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Du benoetigst\nzuerst einen\nFlugschein Typ A!", 5000, 255, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen Flugschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "wschein" then
			if tonumber(vioGetElementData ( player, "gunlicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 1495 then
					if tonumber(vioGetElementData ( player, "playingtime" )) >= 180 then
						dbQuery( LizenzKaufen_func_wschein_DB, { player, lizens, pname }, handler, "SELECT Time FROM gunlicense WHERE Name LIKE ?", pname )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nErst ab 3\nStunden verfuegbar!", 5000, 255, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast bereits\neinen Waffenschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "bike" then
			if tonumber(vioGetElementData ( player, "bikelicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 450 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 450 )
					vioSetElementData ( player, "bikelicense", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nMotorradfuehrerschein\nerhalten!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					takePlayerMoney ( player, 450 )
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
					dbExec( handler, "UPDATE userdata SET Motorradtfuehrerschein = ? WHERE Name LIKE ?", vioGetElementData ( player, "bikelicense" ), pname )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen\nMotorradfuehrerschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "planea" then
			if tonumber(vioGetElementData ( player, "planelicensea" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 15000 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 15000 )
					vioSetElementData ( player, "planelicensea", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nFlugschein\nerhalten!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					takePlayerMoney ( player, 15000 )
					dbExec( handler, "UPDATE userdata SET FlugscheinKlasseA = ? WHERE Name LIKE ?", vioGetElementData ( player, "planelicensea" ), pname )
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen\nFlugschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "fishing" then
			if tonumber(vioGetElementData ( player, "fishinglicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 79 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 79 )
					vioSetElementData ( player, "fishinglicense", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nAngelschein\nerhalten!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					takePlayerMoney ( player, 79 )
					dbExec( handler, "UPDATE userdata SET Angelschein = ? WHERE Name LIKE ?", vioGetElementData ( player, "fishinglicense" ), pname )
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen Angelschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "car" then
			local price
			if getElementData ( player, "playingtime" ) >= 60 * 50 then
				price = 4750
			elseif getElementData ( player, "playingtime" ) >= 60 * 25 then
				price = 1750
			else
				price = 750
			end
			vioSetElementData ( player, "drivingLicensePrice", price )
			if tonumber(vioGetElementData ( player, "carlicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= price then
					startDrivingSchoolTheory_func ()
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen Fuehrerschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "perso" then
			if tonumber(vioGetElementData ( player, "perso" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 40 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 40 )
					vioSetElementData ( player, "perso", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nPersonalausweiss\nerhalten!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					takePlayerMoney ( player, 40 )
					dbExec( handler, "UPDATE userdata SET Perso = ? WHERE Name LIKE ?", vioGetElementData ( player, "perso" ), pname )
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen\nPersonalausweiss!", 5000, 255, 0, 0 )
			end
		elseif lizens == "lkw" then
			if tonumber(vioGetElementData ( player, "lkwlicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 450 then
					if vioGetElementData ( player, "carlicense" ) == 1 then
						vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 450 )
						vioSetElementData ( player, "lkwlicense", 1 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nLKW-Fuehrerschein\nerhalten!", 5000, 0, 255, 0 )
						playSoundFrontEnd ( player, 40 )
						takePlayerMoney ( player, 450 )
						triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
						dbExec( handler, "UPDATE userdata SET LKWfuehrerschein = ? WHERE Name LIKE ?", vioGetElementData ( player, "lkwlicense" ), pname )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Du benoetigst\nzuerst einen\nFuehrerschein!", 5000, 255, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen\nLKW-Fuehrerschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "heli" then
			if tonumber(vioGetElementData ( player, "helilicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 20000 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 20000 )
					vioSetElementData ( player, "helilicense", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nHelikopter-\nflugschein\nerhalten!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					takePlayerMoney ( player, 20000 )
					dbExec( handler, "UPDATE userdata SET Helikopterfuehrerschein = ? WHERE Name LIKE ?", vioGetElementData ( player, "helilicense" ), pname )
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits\neinen Helikopter-\nflugschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "raft" then
			if tonumber(vioGetElementData ( player, "segellicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 350 then
					if vioGetElementData ( player, "motorbootlicense" ) == 1 then
						vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 350 )
						vioSetElementData ( player, "segellicense", 1 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSegellizens\nerhalten!", 5000, 0, 255, 0 )
						playSoundFrontEnd ( player, 40 )
						takePlayerMoney ( player, 350 )
						dbExec( handler, "UPDATE userdata SET Segelschein = ? WHERE Name LIKE ?", vioGetElementData ( player, "segellicense" ), pname )
						triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Du benoetigst\nzuerst einen\nMotorboot-\nfuehrerschein!", 5000, 255, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen Segelschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "motorboot" then
			if tonumber(vioGetElementData ( player, "motorbootlicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 400 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 400 )
					vioSetElementData ( player, "motorbootlicense", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nMotorboot-\nfuehrerschein\nerhalten!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					takePlayerMoney ( player, 400 )
					dbExec( handler, "UPDATE userdata SET Motorbootschein = ? WHERE Name LIKE ?", vioGetElementData ( player, "motorbootlicense" ), pname )
					triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits\neinen Motorboot-\nfuehrerschein!", 5000, 255, 0, 0 )
			end
		end
		checkAchievLicense ( player )
	end
end
addEvent ( "LizenzKaufen", true )
addEventHandler ( "LizenzKaufen", getRootElement(), LizenzKaufen_func )

function checkAchievLicense ( player )

	if tonumber ( vioGetElementData ( player, "motorbootlicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "segellicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "helilicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "lkwlicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "lkwlicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "perso" ) )  == 1 and tonumber ( vioGetElementData ( player, "carlicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "fishinglicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "planelicensea" ) ) == 1 and tonumber ( vioGetElementData ( player, "planelicenseb" ) ) == 1 and tonumber ( vioGetElementData ( player, "bikelicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "gunlicense" ) ) == 1 and vioGetElementData ( player, "licenses_achiev" ) ~= "done" then
		if vioGetElementData ( player, "licenses_achiev" ) ~= "done" then																						-- Achiev: Mr. License
			vioSetElementData ( player, "licenses_achiev", "done" )																								-- Achiev: Mr. License
			triggerClientEvent ( player, "showAchievmentBox", player, " Mr. License", 40, 10000 )																-- Achiev: Mr. License
			vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 40 )												-- Achiev: Mr. License
			dbExec( handler, "UPDATE achievments SET Lizensen = ? WHERE Name LIKE ?", vioGetElementData ( player, "licenses_achiev" ), getPlayerName( player ) ) -- Achiev: Mr. License
		end	
	end
end