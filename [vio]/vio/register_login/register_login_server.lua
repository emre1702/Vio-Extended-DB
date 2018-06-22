_G["Clantag"] = "no"

clanMembers = {}
ticketPermitted = {}

local vals = {}
	vals[1] = "Water"
	vals[2] = "Bloom"
	vals[3] = "Carpaint"
	vals[4] = "Roadshine"

function banCheck ( nick, ip, uname, serial )

	bool = false
	connectCanceled = false
	local i, j = string.find ( nick, "mtasa" )
	if nick == "Player" then
		cancelEvent ( true, "Bitte waehle einen Nickname ( Unter \"Settings\" )" )
		connectCanceled = true
	elseif i and j then
		cancelEvent ( true, "Fuck you!" )
		connectCanceled = true
	else
		local result = dbPoll( dbQuery( handler, "SELECT * FROM ban WHERE Name LIKE ?", nick ), -1 )
		local bantime = result and result[1] and tonumber( result[1]["STime"] ) or 0
		if bantime then
			bool = not ( bantime == 0 )
		end
		if bool and bantime then
			if ( bantime - getTBanSecTime ( 0 ) ) < 0 then
				dbExec( handler, "DELETE FROM ban WHERE Name LIKE ?", nick )
			elseif bantime > 0 then
				local reason = result[1]["Grund"]
				local admin = result[1]["Admin"]
				local diff = math.floor ( ( ( bantime - getTBanSecTime ( 0 ) ) / 60 ) * 100 ) / 100
				cancelEvent ( true, "Du bist noch "..diff.." Stunden von "..admin.." gesperrt, Grund: "..reason )
				connectCanceled = true
			end
		else
			-- IP-Ban deaktiviert --
			local ipBanned = false--MySQL_GetString ( "ban", "Grund", "IP LIKE '" ..ip.."'" )
			-- IP-Ban deaktiviert --
			
			
			local ip1 = tostring ( gettok ( ip, 1, string.byte('.') ) )
			local ip2 = tostring ( gettok ( ip, 2, string.byte('.') ) )
			local ipRangeResult = dbPoll( dbQuery( handler, "SELECT * FROM ban WHERE IP LIKE ?", ip1.."."..ip..".*.*" ), -1 )
			
			local nickBannedResult = dbPoll( dbQuery( handler, "SELECT * FROM ban WHERE Name LIKE ?", nick ), -1 ) 
			
			if ipBanned and ipRangeResult and ipRangeResult[1] then
				local reason = ipRangeResult[1]["Grund"]
				local admin = ipRangeResult[1]["Admin"]
				cancelEvent ( true, "Du bist von "..admin.." gebannt worden! Grund: "..reason..", bei Fragen wende dich bitte an das Forum!" )
				connectCanceled = true
			elseif nickBannedResult and nickBannedResult[1] then
				local reason = nickBannedResult[1]["Grund"]
				local admin = nickBannedResult[1]["Admin"]
				cancelEvent ( true, "Du bist von "..admin.." gebannt worden! Grund: "..reason..", bei Fragen wende dich bitte an das Forum!" )
				connectCanceled = true
			elseif getPlayerWarnCount ( nick ) >= 3 then
				cancelEvent ( true, "Du hast 3 Warns! Ablaufdatum des nächsten Warns: "..getLowestWarnExtensionTime ( nick ) )
				connectCanceled = true
			else
				local serialBannedResult = dbPoll( dbQuery( handler, "SELECT * FROM ban WHERE Serial LIKE ?", "%"..serial.."%" ), -1 ) 
				if serialBannedResult and serialBannedResult[1] then
					local reason = serialBannedResult[1]["Grund"]
					local admin = serialBannedResult[1]["Admin"]
					cancelEvent ( true, "Du bist von "..admin.." gebannt worden! Grund: "..reason..", bei Fragen wende dich bitte an das Forum!" )
					connectCanceled = true
				end
			end
		end
	end
	if not connectCanceled then
		insertPlayerIntoLoggedIn ( nick, ip, serial )
	end
end
addEventHandler ( "onPlayerConnect", getRootElement(), banCheck )

function saltPassword ( salt, string )
	return string..salt
end

function generateNewSalt ()
	
	local runs = 1
	while true and runs <= 10 do
		runs = runs + 1
		salt = ""
		for i = 1, 20 do
			salt = salt .. string.char ( math.random(1,128) )
		end
		break
	end
	return salt
end

function regcheck_func ( player )

	setPedStat ( player, 22, 50 )
	
	vioSetElementData  ( player, "loggedin", 0 )
	vioSetElementData ( player, "pwfailed", 0 )
	
	pname = getPlayerName ( player )
	toggleAllControls ( player, false )
	if player == client then
		if isSerialValid ( getPlayerSerial(player) ) or isRegistered ( pname ) then
			if hasInvalidChar ( player ) and not isRegistered ( pname ) then
				kickPlayer ( player, "Dein Name enthaelt ungueltige Zeichen!" )
			else
				if pname ~= "player" then
					if isRegistered ( pname ) then
						triggerClientEvent ( player, "ShowLoginWindow", getRootElement() )
					else
						local clantag = gettok ( pname, 1, string.byte(']') )
						if testmode == true then
							triggerClientEvent ( player, "ShowRegisterGui", getRootElement() )
						else
							if string.lower ( clantag ) == "[vio" and not isThisTheBetaServer () then
								outputChatBox ("Du bist kein Mitglied des Clans!", player, 255, 0, 0 )
							elseif #pname < 3 or #pname > 20 then
								kickPlayer ( player, "Bitte mindestens 3 und maximal 20 Zeichen als Nickname!" )
							elseif hasInvalidChar ( player ) then
								kickPlayer ( player, "Bitte nimm einen Nickname ohne ueberfluessige Zeichen!" )
							else
								triggerClientEvent ( player, "ShowRegisterGui", getRootElement() )
							end
						end
					end
				else
					kickPlayer ( player, "Bitte aendere deinen Nickname!" )
				end
			end
		else
			kickPlayer ( player, "Dein MTA verwendet einen ungueltigen Serial. Bitte neu installieren!" )
		end
	end
end
addEvent ( "regcheck", true )
addEventHandler ("regcheck", getRootElement(), regcheck_func )


function register_func_telefon_DB ( qh, player, run, tnr )
	local result = dbPoll( qh, 0 )
	if result and result[1] and tnr ~= 911 and tnr ~= 333 and tnr ~= 400 and tnr ~= 666666 then
		vioSetElementData ( player, "telenr", tnr )
	else 
		if run >= 30 then
			vioSetElementData ( player, "telenr", math.random ( 9999999, 999999999999999 ) )
			return
		end
		tnr = math.random ( 100, 9999999 )
		dbQuery( register_func_telefon_DB, { player, run + 1, tnr }, handler, "SELECT Telefonnr FROM userdata WHERE Telefonnr LIKE ?", tnr )
	end	
end


function register_func ( player, passwort, bday, bmon, byear, geschlecht )

	if player == client then
		local pname = getPlayerName ( player )
		if vioGetElementData ( player, "loggedin" ) == 0 and not isRegistered ( pname ) and player == client then
			setPlayerLoggedIn ( pname )
			
			dbExec( handler, "DELETE FROM achievments WHERE Name = ?", pname )
			dbExec( handler, "DELETE FROM bonustable WHERE Name = ?", pname )
			dbExec( handler, "DELETE FROM inventar WHERE Name = ?", pname )
			dbExec( handler, "DELETE FROM packages WHERE Name = ?", pname )
			dbExec( handler, "DELETE FROM players WHERE Name = ?", pname )
			dbExec( handler, "DELETE FROM skills WHERE Name = ?", pname )
			dbExec( handler, "DELETE FROM userdata WHERE Name = ?", pname )
			
			toggleAllControls ( player, true )
			vioSetElementData ( player, "loggedin", 1 )

			triggerClientEvent ( source, "DisableRegisterGui", getRootElement() )

			local ip = getPlayerIP ( player )
			
			if geschlecht == nil then
				geschlecht = 1
			end
			
			local regtime = getRealTime()
			local year = regtime.year + 1900
			local month = regtime.month
			local day = regtime.monthday
			local hour = regtime.hour
			local minute = regtime.minute
			
			local registerdatum = tostring(day.."."..month.."."..year..", "..hour..":"..minute)
			local lastlogin = registerdatum
			
			local salt = generateNewSalt ()
			vioSetElementData ( player, "salt", salt )
			
			local passwort = md5 ( passwort .. salt )
			local lastLoginInt = getSecTime ( 0 )
			
			local id = dbPoll( dbQuery( handler, "SELECT id FROM idcounter" ), -1 )[1]["id"]
			vioSetElementData ( player, "playerid", tonumber( id ) )
			dbExec( handler, "UPDATE idcounter SET id = id + 1" )
			
			local result = dbExec(handler, "INSERT INTO players ( id, Name, Serial, IP, Last_login, Geburtsdatum_Tag, Geburtsdatum_Monat, Geburtsdatum_Jahr, Passwort, Geschlecht, RegisterDatum, Salt, LastLogin) VALUES ( '"..id.."', ?, ?, , '"..lastlogin.."', "..tonumber ( bday)..", "..tonumber ( bmon)..", "..tonumber ( byear)..", ?, ?, '"..registerdatum.."', '"..salt.."', '"..lastLoginInt.."' )", pname, getPlayerSerial( player ), getPlayerIP( player ), passwort, geschlecht )
			if( not result) then
				outputDebugString("Error executing the query players at register" )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast dich\nerfolgreich registriert!\n\nDeine Daten werden\nnun gespeichert!", 7500, 0, 255, 0 )
			end
			
			local result = dbExec(handler, "INSERT INTO achievments (Name) VALUES (?)", pname )
			if( not result) then
				outputDebugString("Error executing the query achievments at register")
			end
			local result = dbExec(handler, "INSERT INTO inventar (Name) VALUES (?)", pname)
			if( not result) then
				outputDebugString("Error executing the query inventar at register")
			end
			local result = dbExec(handler, "INSERT INTO packages (Name, Paket1, Paket2, Paket3, Paket4, Paket5, Paket6, Paket7, Paket8, Paket9, Paket10, Paket11, Paket12, Paket13, Paket14, Paket15, Paket16, Paket17, Paket18, Paket19, Paket20, Paket21, Paket22, Paket23, Paket24, Paket25) VALUES (?,'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )", pname)
			if( not result) then
				outputDebugString("Error executing the query packages at register")
			end
			local result = dbExec(handler, "INSERT INTO bonustable (Name, Lungenvolumen, Muskeln, Kondition, Boxen, KungFu, Streetfighting, CurStyle, PistolenSkill, DeagleSkill, ShotgunSkill, AssaultSkill) VALUES (?, 'none', 'none', 'none', 'none', 'none', 'none', '4', 'none', 'none', 'none', 'none' )", pname)
			if( not result) then
				outputDebugString("Error executing the query bonustable at register")
			end
			dbExec( handler, "INSERT INTO skills ( id, Name ) VALUES ( '"..id.."', ? )", pname )
			
			local Geld = 350
			vioSetElementData ( player, "money", Geld )
			givePlayerMoney ( player, Geld )
			local Punkte = 0
			vioSetElementData ( player, "points", Punkte )
			local Paeckchen = "90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
			vioSetElementData ( player, "packages", Paeckchen )
			local Spawnpos_X = -2458.288085
			vioSetElementData ( player, "spawnpos_x", Spawnpos_X )
			local Spawnpos_Y = 774.354492
			vioSetElementData ( player, "spawnpos_y", Spawnpos_Y )
			local Spawnpos_Z = 35.171875
			vioSetElementData ( player, "spawnpos_z", Spawnpos_Z )
			local Spawnrot_X = 52.94
			vioSetElementData ( player, "spawnrot_x", Spawnrot_X )
			local SpawnInterior = 0
			vioSetElementData ( player, "spawnint", SpawnInterior )
			local SpawnDimension = 0
			vioSetElementData ( player, "spawndim", SpawnDimension )
			local Fraktion = 0
			vioSetElementData ( player, "fraktion", Fraktion )
			local FraktionsRang = 0
			vioSetElementData ( player, "rang", FraktionsRang )
			local Adminlevel = 0
			vioSetElementData ( player, "adminlvl", Adminlevel )
			local Spielzeit = 0
			vioSetElementData ( player, "playingtime", Spielzeit )
			local CurrentCars = 0
			vioSetElementData ( player, "curcars", CurrentCars )
			local Maximumcars = 3
			vioSetElementData ( player, "maxcars", Maximumcars )
			local Carslot1 = 0
			vioSetElementData ( player, "carslot1", Carslot1 )
			local Carslot2 = 0
			vioSetElementData ( player, "carslot2", Carslot2 )
			local Carslot3 = 0
			vioSetElementData ( player, "carslot3", Carslot3 )
			local Carslot4 = 0
			vioSetElementData ( player, "carslot4", Carslot4 )
			local Carslot5 = 0
			vioSetElementData ( player, "carslot5", Carslot5 )
			local Carslot6 = 0
			vioSetElementData ( player, "carslot6", Carslot6 )
			local Carslot7 = 0
			vioSetElementData ( player, "carslot7", Carslot7 )
			local Carslot8 = 0
			vioSetElementData ( player, "carslot8", Carslot8 )
			local Carslot9 = 0
			vioSetElementData ( player, "carslot9", Carslot9 )
			local Carslot10 = 0
			vioSetElementData ( player, "carslot10", Carslot10 )
			local Tode = 0
			vioSetElementData ( player, "deaths", Tode )
			local Kills = 0
			vioSetElementData ( player, "kills", Kills )
			local Knastzeit = 0
			vioSetElementData ( player, "jailtime", Knastzeit )
			local Alkazeit = 0
			vioSetElementData ( player, "prisontime", Alkazeit )
			local Hoellenzeit = 0
			vioSetElementData ( player, "helltime", Hoellenzeit )
			local Himmelszeit = 0
			vioSetElementData ( player, "heaventime", Himmelszeit )
			local Hausschluessel = 0
			vioSetElementData ( player, "housekey", 0 )
			local Bizschluessel = 0
			vioSetElementData ( player, "bizkey", Bizschluessel )
			local Bankgeld = 1500
			vioSetElementData ( player, "bankmoney", Bankgeld )
			local Drogen  = 0
			vioSetElementData ( player, "drugs", Drogen )
			if geschlecht == 1 then
				local rnd = math.random ( 1, 1 )
				Skinid = femalehomeless[rnd]
				vioSetElementData ( player, "skinid", Skinid )
			else
				local rnd = math.random ( 1, 5 )
				Skinid = malehomeless[rnd]
				vioSetElementData ( player, "skinid", Skinid )
			end
			local Autofuehrerschein = 0
			vioSetElementData ( player, "carlicense", Autofuehrerschein )
			local Motorradtfuehrerschein = 0
			vioSetElementData ( player, "bikelicense", Motorradtfuehrerschein )
			local LKWfuehrerschein = 0
			vioSetElementData ( player, "lkwlicense", LKWfuehrerschein )
			local Helikopterfuehrerschein = 0
			vioSetElementData ( player, "helilicense", Helikopterfuehrerschein )
			local FlugscheinKlasseA = 0
			vioSetElementData ( player, "planelicensea", FlugscheinKlasseA )
			local FlugscheinKlasseB = 0
			vioSetElementData ( player, "planelicenseb", FlugscheinKlasseB )
			local Motorbootschein = 0
			vioSetElementData ( player, "motorbootlicense", Motorbootschein )
			local Segelschein = 0
			vioSetElementData ( player, "segellicense", Segelschein)
			local Angelschein = 0
			vioSetElementData ( player, "fishinglicense", Angelschein)
			local Wanteds = 0
			vioSetElementData ( player, "wanteds", Wanteds )
			local StvoPunkte = 0
			vioSetElementData ( player, "stvo_punkte", StvoPunkte )
			local Waffenschein = 0
			vioSetElementData ( player, "gunlicense", Waffenschein )
			local Perso = 0
			vioSetElementData ( player, "perso", Perso )
			local IncomePayday = 0
			vioSetElementData ( player, "incomepayday", IncomePayday )
			local Boni = 1000
			vioSetElementData ( player, "boni", Boni )
			local PdayIncome = 0
			vioSetElementData ( player, "pdayincome", PdayIncome )
			local PdayKosten = 0
			vioSetElementData ( player, "pdaykosten", PdayKosten )

			local tnr = math.random ( 100, 9999999 )
			dbQuery( register_func_telefon_DB, { player, 1, tnr }, handler, "SELECT Telefonnr FROM userdata WHERE Telefonnr LIKE ?", tnr )

			local Warns = 0
			vioSetElementData ( player, "warns", Warns )
			local GunboxA = "0|0"
			vioSetElementData ( player, "gunboxa", GunboxA )
			local GunboxB = "0|0"
			vioSetElementData ( player, "gunboxb", GunboxB )
			local GunboxC = "0|0"
			vioSetElementData ( player, "gunboxc", GunboxC )
			local Job = "none"
			vioSetElementData ( player, "job", Job )
			local Jobtime = 0
			vioSetElementData ( player, "jobtime", Jobtime )
			local Club = "none"
			vioSetElementData ( player, "club", Club )
			local FavChannel = 0
			vioSetElementData ( player, "favchannel", FavChannel )
			local BonusPunkte = 0
			vioSetElementData ( player, "bonuspoints", BonusPunkte )
			local Truckerskill = 1
			vioSetElementData ( player, "truckerlvl", Truckerskill )
			local Airportskill = 1
			vioSetElementData ( player, "airportlvl", Airportskill )		
			local farmerLVL = 0
			vioSetElementData ( player, "farmerLVL", farmerLVL )
			local Contract = 0
			vioSetElementData ( player, "contract", Contract )
			local socialState = "Obdachloser"
			vioSetElementData ( player, "socialState", socialState )
			local streetCleanPoints = 0
			vioSetElementData ( player, "streetCleanPoints", streetCleanPoints )
			
			vioSetElementData ( player, "handyType", 1 )
			vioSetElementData ( player, "handyCosts", 0 )
			
			_G[pname.."paydaytime"] = setTimer ( playingtime, 60000, 1, player )
			
			vioSetElementData  ( player, "loggedin", 1 )
			vioSetElementData ( player, "muted", 0 )
			vioSetElementData ( player, "ElementClicked", false )
			vioSetElementData ( player, "curplayingtime", 0 )
			vioSetElementData ( player, "housex", 0 )
			vioSetElementData ( player, "housey", 0 )
			vioSetElementData ( player, "housez", 0 )
			vioSetElementData ( player, "house", "none" )
			vioSetElementData ( player, "handystate", "on" )
			vioSetElementData ( player, "object", 0 )
			vioSetElementData ( player, "ammoTyp", 0 )
			vioSetElementData ( player, "curAmmoTyp", 0 )

			bindKey ( source, "r", "down", reload )
			
			triggerClientEvent ( player, "sec_health_give", getRootElement(), 999 )
			spawnPlayer ( player, vioGetElementData ( player, "spawnpos_z" ), vioGetElementData ( player, "spawnpos_y" ), vioGetElementData ( player, "spawnpos_z" ), vioGetElementData ( player, "spawnrot_x" ), vioGetElementData ( player, "spawnint" ), vioGetElementData ( player, "spawndim" ) )
			triggerClientEvent ( player, "sec_health_give", getRootElement(), 999 )
						
			isPremium ( player )
			
			--fadeCamera ( player, true )
			--setCameraTarget( player, player )
			
			setPlayerWantedLevel ( player, Wanteds )
			
			packageLoad ( player )
			achievload ( player )
			inventoryload ( player )
			elementDataSettings ( player )
			bonusLoad ( player )
			skillDataLoad ( player )

			local result = dbExec(handler, "INSERT INTO userdata ( Name,Skinid,Telefonnr) VALUES(?, ?, ?)", pname, vioGetElementData( player, "skinid" ), vioGetElementData ( player, "telenr" ) )
			if( not result) then
				outputDebugString("Error executing the query userdata at register" )
			else
				outputDebugString ("Daten fuer Spieler "..pname.." wurden angelegt!")
			end
			outputChatBox ( "Druecke F1, um das Hilfemenue zu oeffnen!", player, 200, 200, 0 )
			
			vioSetElementData ( player, "gameboy", 0 )
			
			loadAddictionsForPlayer ( player )
			
			-- Tutorial --
			vioSetElementData ( player, "isInTut", true )
			--triggerClientEvent ( player, "setPlayerInTutorial", player )
			startintro_func ( player )
			
			triggerEvent ( "onVioPlayerLogin", player )
		end
	end
end
addEvent ( "register", true )
addEventHandler ( "register", getRootElement(), register_func)

function gameBeginGuiShow_func ( player )

	if player == client then
		vioSetElementData ( player, "isInTut", false )
		triggerClientEvent ( player, "showBeginGui", getRootElement() )
		showCursor ( player, true )
		vioSetElementData ( player, "ElementClicked", true )
		toggleAllControls ( player, true )
		setElementPosition ( player, -1421.3, -287.2, 13.8 )
		setElementInterior ( player, 0 )
		bindKey ( source, "ralt", "down", showcurser, source )
		bindKey ( source, "m", "down", showcurser, source )
		bindKey ( source, "f1", "down", showhmenue, source )
	end
end
addEvent ( "gameBeginGuiShow", true )
addEventHandler ( "gameBeginGuiShow", getRootElement(), gameBeginGuiShow_func)

local function login_func_ticketansweres_DB ( qh, player )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		outputChatBox ( "Du hast eine Antwort auf deine Anfrage erhalten! Tippe /readticket, um sie zu lesen.", player, 0, 200, 0 )
	end
end

local function login_func_vehicle_DB ( qh, player, pname )
	local result = dbPoll( qh, 0 )
	for i=1, 10 do
		vioSetElementData ( player, "carslot"..i, 0 )
	end
	if result and result[1] then
		for i=1, #result do
			local slot = result[i]["Slot"]
			local carvalue = result[i]["Special"]
			if carvalue == 2 then
				vioSetElementData( player, "yachtImBesitz", true )
			elseif carvalue ~= 0 then
				carvalue = 1
			end 
			vioSetElementData ( player, "carslot"..slot, carvalue )
		end
		vioSetElementData ( player, "curcars", #result )
	end
end

local function login_func_house_DB ( qh, player, dsatzschluessel )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local Hausschluessel = result[1]["ID"]
		local key = tonumber ( dsatzschluessel )
		if Hausschluessel then
			vioSetElementData ( player, "housekey", tonumber ( Hausschluessel ) )
		elseif key <= 0 then
			vioSetElementData ( player, "housekey", key )
		else
			vioSetElementData ( player, "housekey", 0 )
		end
	end
end

local function login_func_object_DB ( qh, player )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		vioSetElementData ( player, "object", tonumber ( result[1]["Objekt"] ) )
	end
end

local function login_func_logout_DB ( qh, player )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		dbExec( handler, "DELETE FROM logout WHERE Name LIKE ?", pname ) 
		local position = result[1]["Position"]
		if position then
			weapons = result[1]["Waffen"] 
			for i = 1, 12 do
				local wstring = gettok ( weapons, i, string.byte( '|' ) )
				if wstring then
					if wstring then
						if #wstring >= 3 then
							local weapon = tonumber ( gettok ( wstring, 1, string.byte( ',' ) ) )
							local ammo = tonumber ( gettok ( wstring, 2, string.byte( ',' ) ) )
							giveWeapon ( player, weapon, ammo, true )
							triggerClientEvent ( player, "sec_gun_give", getRootElement(), weapon, ammo )
						end
					end
				end
			end
			if position ~= "false" then
				local x = tonumber ( gettok ( position, 1, string.byte( '|' ) ) )
				local y = tonumber ( gettok ( position, 2, string.byte( '|' ) ) )
				local z = tonumber ( gettok ( position, 3, string.byte( '|' ) ) )
				local int = tonumber ( gettok ( position, 4, string.byte( '|' ) ) )
				local dim = tonumber ( gettok ( position, 5, string.byte( '|' ) ) )
				setTimer ( setElementInterior, 1000, 1, player, int )
				setTimer ( setElementDimension, 1000, 1, player, dim )
				setTimer ( setElementPosition, 1000, 1, player, x, y, z )
			end
		end
	end 
end

local function login_func_DB2 ( qh, player, lastLoginInt, lastlogin )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local dsatz = result[1]
		
		local money = tonumber ( dsatz["Geld"] )
		vioSetElementData ( player, "money", money )
		if money >= 0 then
			givePlayerMoney ( player, money )
		else
			takePlayerMoney ( player, money )
		end
		local fraktion = tonumber ( dsatz["Fraktion"] )
		vioSetElementData ( player, "fraktion", fraktion )
		if fraktion > 0 then
			fraktionMembers[fraktion][player] = fraktion
		end
		local rang = tonumber ( dsatz["FraktionsRang"] )
		if rang == 1 then
			bindKey ( player, "1", "down", tazer_func, player )
		end
		vioSetElementData ( player, "rang", tonumber ( rang ) )
		local admnlvl = tonumber ( dsatz["Adminlevel"] )
		vioSetElementData ( player, "adminlvl", admnlvl )
		if admnlvl >= 1 then
			adminsIngame[player] = admnlvl
		end
		
		vioSetElementData ( player, "spawnpos_x", dsatz["Spawnpos_X"] )
		vioSetElementData ( player, "spawnpos_y", dsatz["Spawnpos_Y"] )
		vioSetElementData ( player, "spawnpos_z", tonumber ( dsatz["Spawnpos_Z"] ) )
		vioSetElementData ( player, "spawnrot_x", tonumber ( dsatz["Spawnrot_X"] ) )
		vioSetElementData ( player, "spawnint", tonumber ( dsatz["SpawnInterior"] ) )
		vioSetElementData ( player, "spawndim", tonumber ( dsatz["SpawnDimension"] ) )
		vioSetElementData ( player, "playingtime", tonumber ( dsatz["Spielzeit"] ) )
		vioSetElementData ( player, "curcars", tonumber ( dsatz["CurrentCars"] ) )
		
		dbQuery( login_func_vehicle_DB, { player, pname }, handler, "SELECT Special, Slot FROM vehicles WHERE Besitzer LIKE ?", pname )
		
		vioSetElementData ( player, "deaths", tonumber ( dsatz["Tode"] ) )
		vioSetElementData ( player, "kills", tonumber ( dsatz["Kills"] ) )
		vioSetElementData ( player, "jailtime", tonumber ( dsatz["Knastzeit"] ) )
		vioSetElementData ( player, "heaventime", tonumber ( dsatz["Himmelszeit"] ) )
		
		dbQuery( login_func_house_DB, { player, dsatz["Hausschluessel"] }, handler, "SELECT ID FROM houses WHERE Besitzer LIKE ?", pname )

		vioSetElementData ( player, "bizkey", tonumber ( dsatz["Bizschluessel"] ) )
		vioSetElementData ( player, "bankmoney", tonumber ( dsatz["Bankgeld"] ) )
		vioSetElementData ( player, "drugs", tonumber ( dsatz["Drogen"] ) )
		vioSetElementData ( player, "skinid", tonumber ( dsatz["Skinid"] ) )
		vioSetElementData ( player, "carlicense", tonumber ( dsatz["Autofuehrerschein"] ) )
		vioSetElementData ( player, "bikelicense", tonumber ( dsatz["Motorradtfuehrerschein"] ) )
		vioSetElementData ( player, "lkwlicense", tonumber ( dsatz["LKWfuehrerschein"] ) )
		vioSetElementData ( player, "helilicense", tonumber ( dsatz["Helikopterfuehrerschein"] ) )
		vioSetElementData ( player, "planelicensea", tonumber ( dsatz["FlugscheinKlasseA"] ) )
		vioSetElementData ( player, "planelicenseb", tonumber ( dsatz["FlugscheinKlasseB"] ) )
		vioSetElementData ( player, "motorbootlicense", tonumber ( dsatz["Motorbootschein"] ) )
		vioSetElementData ( player, "segellicense", tonumber ( dsatz["Segelschein"] ) )
		vioSetElementData ( player, "fishinglicense", tonumber ( dsatz["Angelschein"] ) )
		vioSetElementData ( player, "wanteds", tonumber ( dsatz["Wanteds"] ) )
		vioSetElementData ( player, "stvo_punkte", tonumber ( dsatz["StvoPunkte"] ) )
		vioSetElementData ( player, "gunlicense", tonumber ( dsatz["Waffenschein"] ) )
		vioSetElementData ( player, "perso", tonumber ( dsatz["Perso"] ) )
		vioSetElementData ( player, "boni", tonumber ( dsatz["Boni"] ) )
		vioSetElementData ( player, "incomepayday", tonumber ( dsatz["IncomePayday"] ) )
		vioSetElementData ( player, "pdayincome", tonumber ( dsatz["PdayIncome"] ) )
		vioSetElementData ( player, "pdaykosten", tonumber ( dsatz["PdayKosten"] ) )
		vioSetElementData ( player, "telenr", tonumber ( dsatz["Telefonnr"] ) )
		vioSetElementData ( player, "warns", getPlayerWarnCount ( pname ) )
		vioSetElementData ( player, "gunboxa", dsatz["Gunbox1"] )
		vioSetElementData ( player, "gunboxb", dsatz["Gunbox2"] )
		vioSetElementData ( player, "gunboxc", dsatz["Gunbox3"] )
		vioSetElementData ( player, "job", dsatz["Job"] )
		vioSetElementData ( player, "jobtime", dsatz["Jobtime"] )
		vioSetElementData ( player, "club", dsatz["Club"] )
		vioSetElementData ( player, "favchannel", tonumber ( dsatz["FavRadio"] ) )
		vioSetElementData ( player, "bonuspoints", tonumber ( dsatz["Bonuspunkte"] ) )
		local skill = tonumber ( dsatz["Truckerskill"] )
		if not skill then
			skill = 0
		end
		vioSetElementData ( player, "truckerlvl", skill )
		vioSetElementData ( player, "airportlvl", tonumber ( dsatz["AirportLevel"] ) )
		vioSetElementData ( player, "farmerLVL", tonumber ( dsatz["farmerLVL"] ) )
		vioSetElementData ( player, "contract", tonumber ( dsatz["Contract"] ) )
		vioSetElementData ( player, "socialState", dsatz["SocialState"] )
		if tonumber ( dsatz["SocialState"] ) then
			if tonumber ( dsatz["SocialState"] ) == 0 then
				vioSetElementData ( player, "socialState", "Obdachloser" )
			end
		end
		vioSetElementData ( player, "streetCleanPoints", tonumber ( dsatz["StreetCleanPoints"] ) )
		
		local handyString = dsatz["Handy"] 
		local v1, v2
		v1 = tonumber ( gettok ( handyString, 1, string.byte ( '|' ) ) )
		v2 = tonumber ( gettok ( handyString, 2, string.byte ( '|' ) ) )
		vioSetElementData ( player, "handyType", v1 )
		vioSetElementData ( player, "handyCosts", v2 )
		
		loadAddictionsForPlayer ( player )
		
		isPremium ( player )
		
		vioSetElementData ( player, "housex", 0 )
		vioSetElementData ( player, "housey", 0 )
		vioSetElementData ( player, "housez", 0 )
		vioSetElementData ( player, "house", "none" )
		vioSetElementData ( player, "curplayingtime", 0 )
		vioSetElementData ( player, "handystate", "on" )
		
		vioSetElementData ( player, "ammoTyp", 0 )
		vioSetElementData ( player, "ammoAmount", 0 )
		
		packageLoad ( player )
		achievload ( player )
		inventoryload ( player )
		elementDataSettings ( player )
		bonusLoad ( player )
		setPremiumData ( player )
		skillDataLoad ( player )
		
		showFittingBlipForPlayer ( player )
		
		_G[pname.."paydaytime"] = setTimer ( playingtime, 60000, 1, player )
		
		RemoteSpawnPlayer ( player )
		vioSetElementData ( player, "muted", 0 )
		triggerClientEvent ( player, "DisableLoginWindow", getRootElement() )
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast dich\nerfolgreich eingeloggt!\nDruecke F1 um das\nHilfemenue zu\noeffnen!", 5000, 0, 255, 0 )
		outputDebugString ("Spieler "..pname.." wurde eingeloggt, IP: "..getPlayerIP(player))
		vioSetElementData ( player, "loggedin", 1 )
		vioSetElementData ( player, "ElementClicked", false )

		if vioGetElementData ( player, "stvo_punkte" ) >= 15 then			-- SearchSTVO
			vioSetElementData ( player, "carlicense", 0 )
			vioSetElementData ( player, "stvo_punkte", 0 )
			MySQL_SetString("userdata", "Autofuehrerschein", vioGetElementData ( player, "carlicense" ), dbPrepareString( handler, "Name LIKE ?", pname ) )
			outputChatBox ( "Wegen deines schlechten Fahrverhaltens wurde dir dein Fuehrerschein abgenommen!", player, 125, 0, 0 )
		end

		dbQuery( login_func_object_DB, { player }, handler, "SELECT Object FROM inventar WHERE Name LIKE ?", pname )
		
		checkmsgs ( player )
		
		blacklistLogin ( pname )
		
		-- *** EasterEgg ***
			--[[if month == 4 and day == 4 then
				local oldlogin = MySQL_GetString("players", "Last_login", "Name LIKE '" ..pname.."'")
				local oldlogin1 = tonumber (  gettok ( oldlogin, 1, string.byte('.') ) )
				local oldlogin2 = tonumber (  gettok ( oldlogin, 2, string.byte('.') ) )
				if ( oldlogin1 ~= 4 or oldlogin2 ~= 4 ) or ( minute < 25 and hour < 16 ) then
					putFoodInSlot ( player, 5 )
				end
			elseif month == 4 and day == 5 then
				local oldlogin = MySQL_GetString("players", "Last_login", "Name LIKE '" ..pname.."'")
				local oldlogin1 = tonumber (  gettok ( oldlogin, 1, string.byte('.') ) )
				local oldlogin2 = tonumber (  gettok ( oldlogin, 2, string.byte('.') ) )
				if oldlogin1 ~= 4 or oldlogin2 ~= 5 then
					putFoodInSlot ( player, 5 )
				end
			end]]
		-- *** EasterEgg ***
		dbExec( handler, "UPDATE players SET Last_login = ?, LastLogin = ? WHERE Name LIKE ?", lastlogin, lastLoginInt, pname )
		
		dbQuery( login_func_logout_DB, { player }, handler, "SELECT * FROM logout WHERE Name LIKE ?", pname )

		getMailsForClient_func ( pname )
		setMaximumCarsForPlayer ( player )
		triggerEvent ( "onVioPlayerLogin", player )
		
		if tonumber ( dsatz["pred"] ) == 0 then
			prompt ( player, promptMainText, 30 )
			dbExec( handler, "UPDATE userdata SET pred = '1' WHERE Name = ?", pname )
		end
	end
end

local function login_func_DB ( qh, player, passwort, pname ) 
	local result, errorcode, errormsg = dbPoll( qh, 0 )
	if not result then
		outputDebugString("Error executing the query: (" .. errorcode .. ") " .. errormsg)
		return;
	end 
	if not result[1] then
		return
	end
	result = result[1]

	local salt = result["Salt"]
	passwort = saltPassword ( salt, passwort )

	if result["Passwort"] == md5(passwort) then	
		local clantag = gettok ( pname, 1, string.byte(']') )

		if string.lower ( clantag ) == "[".._G["Clantag"] then --or MySQL_ExistAmount ( "ticket_permitted", "name LIKE '"..pname.."'" ) > 0 then
			if string.lower ( clantag ) == "[".._G["Clantag"] then
				clanMembers[player] = pname
			end
			ticketPermitted[player] = pname
			outputChatBox ( "Du kannst ankommende Anfragen mit /tickets bearbeiten.", player, 125, 0, 0 )
		end
		dbQuery( login_func_ticketansweres_DB, { player }, handler, "SELECT name FROM ticket_answeres WHERE name LIKE ?", pname )
		
		setPlayerLoggedIn ( pname )
		-- Alte Passwörter ohne Salt auf Salt umschreiben --
		if salt == "" then
			salt = generateNewSalt()
			passwort = md5 ( passwort .. salt )
			dbExec( handler, "UPDATE players SET Salt = ?, Passwort = ? WHERE Name LIKE ?", salt, passwort, pname )
		end
		-- Salt --
		vioSetElementData ( player, "salt", salt )
		vioSetElementData ( player, "playerid", tonumber( result["id"] ) )
		
		toggleAllControls ( player, true )

		vioSetElementData ( player, "loggedin", 1 )
		
		local logtime = getRealTime()
		local year = logtime.year + 1900
		local month = logtime.month + 1
		local day = logtime.monthday
		local hour = logtime.hour
		local minute = logtime.minute
		
		local lastLoginInt = getSecTime ( 0 )
		local lastlogin = tostring(day.."."..month.."."..year..", "..hour..":"..minute)
		
		dbQuery( login_func_DB2, { player, lastLoginInt, lastlogin }, handler, "SELECT * FROM userdata WHERE Name LIKE ?", pname )
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Ungueltiges Passwort -\nueberpruefe\ndeine Eingabe\noder melde dich\nim Forum.", 5000, 255, 0, 0 )
		triggerClientEvent ( player, "guiShowLoginAgain", getRootElement() )
		vioSetElementData ( player, "pwfailed", tonumber ( vioGetElementData ( player, "pwfailed" )) + 1 )
		if vioGetElementData ( player, "pwfailed" ) >= 3 then
			outputDebugString ("Spieler "..tostring ( getPlayerName(player) ).." wurde aufgrund eines falschen Passworts gekickt!IP: "..tostring ( getPlayerIP(player) ) )
			kickPlayer ( player, "Du hast 3x das falsche Passwort eingegeben - Bitte melde dich bei einem Admin!", 0 )
		end
	end
	bindKey ( player, "ralt", "down", showcurser, player )
	bindKey ( player, "m", "down", showcurser, player )
	bindKey ( player, "f1", "down", showhmenue, player )
	bindKey ( player, "r", "down", reload )
end

function login_func ( player, passwort )
	
	if player == client then
		if vioGetElementData ( player, "loggedin" ) == 0 then
			local pname = getPlayerName ( player )
				
			dbQuery( login_func_DB, { player, passwort, pname }, handler, "SELECT * FROM players WHERE Name LIKE ?", pname )
		end
	end
end
addEvent ( "einloggen", true )
addEventHandler ( "einloggen", getRootElement(), login_func )

function datasave ( quitReason, reason )

	if clanMembers[source] then
		clanMembers[source] = nil
	end
	if ticketPermitted[source] then
		ticketPermitted[source] = nil
	end
	local pname = getPlayerName ( source )
	removePlayerFromLoggedIn ( pname )
	if vioGetElementData ( source, "loggedin" ) == 1 then
		triggerEvent ( "onLoggedInPlayerQuit", source )
		pname = getPlayerName ( source )
		fraktionMembers[vioGetElementData(source,"fraktion")][source] = nil
		adminsIngame[source] = nil
		if getElementData ( source, "isInHighNoon" ) or vioGetElementData ( source, "shootingRanchGun" ) then
		elseif quitReason and reason ~= "Ausgeloggt." then
			if vioGetElementData ( source, "wanteds" ) >= 1 --[[and ( quitReason == "Quit" or quitReason == "Unknown" )]] and vioGetElementData ( source, "jailtime" ) == 0 then
				local x, y, z = getElementPosition ( source )
				local copShape = createColSphere ( x, y, z, 20 )
				local elementsInCopSphere = getElementsWithinColShape ( copShape, "player" )
				destroyElement ( copShape )
				for key, cPlayer in ipairs ( elementsInCopSphere ) do
					if ( isOnDuty ( cPlayer ) or isArmy ( cPlayer ) ) and cPlayer ~= source then
						local wanteds = vioGetElementData ( source, "wanteds" )
						vioSetElementData ( source, "wanteds", 0 )
						vioSetElementData ( source, "jailtime", wanteds * 12 + vioGetElementData ( source, "jailtime" ) )
						wantedCost = 100*wanteds*(wanteds*.5)
						vioSetElementData ( source, "money", vioGetElementData ( source, "money" ) - wantedCost )
						if vioGetElementData ( source, "money" ) < 0 then
							vioSetElementData ( source, "money", 0 )
						end
						outputChatBox ( "Der Gesuchte "..getPlayerName ( source ).." ist offline gegangen - er wird beim naechsten Einloggen im Knast sein.", cPlayer, 0, 125, 0 )
						offlinemsg ( "Du bist fuer "..(wanteds*15).." mins im Gefaengnis (Offlineflucht?)", "Server", getPlayerName(source) )
						break
					end
				end
			end
			if quitReason == "Kicked" or quitReason == "Bad Connection" or quitReason == "Timed out" then
				local curWeaponsForSave = "|"
				for i = 1, 12 do
					if i ~= 10 and i ~= 12 then
						local weapon = getPedWeapon ( source, i )
						local ammo = getPedTotalAmmo ( source, i )
						if weapon and ammo then
							if weapon > 0 and ammo > 0 then
								if #curWeaponsForSave <= 40 then
									curWeaponsForSave = curWeaponsForSave..weapon..","..ammo.."|"
								end
							end
						end
					end
				end
				if #curWeaponsForSave > 1 then
					dbExec ( handler, "INSERT INTO logout (Position, Waffen, Name) VALUES ('false', '"..curWeaponsForSave.."', ?)", pname )
				end
			end
		end
		if vioGetElementData ( source, "callswith" ) then
			if vioGetElementData ( source, "callswith" ) ~= "none" then
				local caller = getPlayerFromName ( vioGetElementData ( source, "callswith" ) )
				if caller then
					vioSetElementData ( caller, "callswith", "none" )
					vioSetElementData ( caller, "call", false )
					vioSetElementData ( caller, "calls", "none" )
					vioSetElementData ( caller, "callswith", "none" )
					vioSetElementData ( caller, "calledby", "none" )
					outputChatBox ( "*Knack* - Die Leitung ist tod!", caller, 125, 0, 0 )
				end
				vioSetElementData ( source, "callswith", "none" )
				vioSetElementData ( source, "call", false )
				vioSetElementData ( source, "calls", "none" )
				vioSetElementData ( source, "callswith", "none" )
				vioSetElementData ( source, "calledby", "none" )
			end
		end
		datasave_remote ( source )
		if vioGetElementData ( source, "isInArea51Mission" ) then
			removeArea51Bots ( pname )
		end
		local veh = getPedOccupiedVehicle ( source )
		if veh then
			if isElement ( veh ) then
				if getElementModel(veh) == 502 then
					destroyElement ( veh )
				end
			end
		end
		killTimer ( _G[pname.."paydaytime"] )
		clearInv ( source )
		clearUserdata ( source )
		clearBonus ( source )
		clearAchiev ( source )
		clearPackage ( source )
		clearDataSettings ( source )
	end
end
addEventHandler ("onPlayerQuit", getRootElement(), datasave )


local function elementDataSettings_spezial_DB ( qh, player )
	local result = dbPoll ( qh, 0 )
	if result and result[1] then
		local Weapon_Settings = result[1]["Spezial"]
		local shads = {}
		
		if not Weapon_Settings then
			for i = 1, 6 do
				shads[i] = 0
			end
		else
			for i = 1, 6 do
				shads[i] = tonumber ( gettok ( Weapon_Settings, i, string.byte( '|' ) ) )
			end
		end
		
		for i, on in pairs ( shads ) do
			vioSetElementData ( player, "ammoTyp"..i, tonumber(on) )
		end
	end
end

local function elementDataSettings_userdata_DB ( qh, player )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		-------------------------------------------------------------
		local Shader_Settings = result[1]["Shader"]
		local shads = {}
		
		if not Shader_Settings then
			for i = 1, 4 do
				shads[i] = 0
			end
		else
			for i = 1, 4 do
				shads[i] = tonumber ( gettok ( Shader_Settings, i, string.byte( '|' ) ) )
			end
		end
		
		for i, on in pairs ( shads ) do
			if on == 1 then
				triggerClientEvent ( player, "triggerVioShader"..i, player )
				vioSetElementData ( player, "shader"..vals[i], 1 )
			else
				vioSetElementData ( player, "shader"..vals[i], 0 )
			end
		end
		---------------------------------------------------------

		ArmyPermissions = result[1]["ArmyPermissions"]
		if not ArmyPermissions then
			for i = 1, 9 do
				vioSetElementData ( player, "armyperm"..i, 0 )
			end
		else
			for i = 1, 9 do
				vioSetElementData ( player, "armyperm"..i, tonumber ( gettok ( ArmyPermissions, i, string.byte( '|' ) ) ) )
			end
		end
	end
end

function elementDataSettings ( player )

	local pname = getPlayerName ( player )
	betaServerMessage ( player )
	vioSetElementData ( player, "In_DMArena", 0 )
	vioSetElementData ( player, "objectToPlace", false )
	vioSetElementData ( player, "cheatingtrys", -1 )
	vioSetElementData ( player, "growing", false )
	vioSetElementData ( player, "isInRace", false )
	vioSetElementData ( player, "callswithpolice", false )
	vioSetElementData ( player, "isLive", false )
	vioSetElementData ( player, "isInArea51Mission", false )
	vioSetElementData ( player, "armingBomb", false )
	vioSetElementData ( player, "tied", true )
	vioSetElementData ( player, "hasBomb", false )
	vioSetElementData ( player, "wanzen", false )
	vioSetElementData ( player, "hunger", 50 )
	vioSetElementData ( player, "isInHighNoon", false )
	------------------
	
	dbQuery ( elementDataSettings_spezial_DB, { player }, handler, "SELECT Spezial FROM inventar WHERE Name LIKE ?", pname )
	dbQuery ( elementDataSettings_userdata_DB, { player }, handler, "SELECT Shader, ArmyPermissions FROM userdata WHERE Name LIKE ?", pname )
end

function saveArmyPermissions ( player )

	local pname = getPlayerName ( player )
	local empty = ""
	for i = 1, 9 do
		empty = empty.."|"..vioGetElementData ( player, "armyperm"..i )
	end
	empty = empty.."|"
	dbExec( handler, "UPDATE userdata SET ArmyPermissions = ? WHERE Name LIKE ?", empty, pname )
end

function saveShaderInfo ( player )
		
	local s_string = "|"..tonumber(getElementData( player, "shader"..vals[1] )).."|"..tonumber(getElementData( player, "shader"..vals[2] )).."|"..tonumber(getElementData( player, "shader"..vals[3] )).."|"..tonumber(getElementData( player, "shader"..vals[4] )).."|"
	
	local pname = getPlayerName ( player )
	
	MySQL_SetString("userdata", "Shader", s_string, dbPrepareString( handler, "Name LIKE ?", pname ))

end

function saveSpecialInfo ( player )

	local wert1, wert2, wert3, wert4, wert5, wert6
	
	if not vioGetElementData( player, "ammoTyp1" ) or vioGetElementData( player, "ammoTyp1" ) == nil then
		wert1 = 0
	else
		wert1 = tonumber(vioGetElementData( player, "ammoTyp1" ))
	end
	
	if not vioGetElementData( player, "ammoTyp2" ) or vioGetElementData( player, "ammoTyp2" ) == nil then
		wert2 = 0
	else
		wert2 = tonumber(vioGetElementData( player, "ammoTyp2" ))
	end
	
	if not vioGetElementData( player, "ammoTyp3" ) or vioGetElementData( player, "ammoTyp3" ) == nil then
		wert3 = 0
	else
		wert3 = tonumber(vioGetElementData( player, "ammoTyp3" ))
	end

	if not vioGetElementData( player, "ammoTyp4" ) or vioGetElementData( player, "ammoTyp4" ) == nil then
		wert4 = 0
	else
		wert4 = tonumber(vioGetElementData( player, "ammoTyp4" ))
	end

	if not vioGetElementData( player, "ammoTyp5" ) or vioGetElementData( player, "ammoTyp5" ) == nil then
		wert5 = 0
	else
		wert5 = tonumber(vioGetElementData( player, "ammoTyp5" ))
	end

	if not vioGetElementData( player, "ammoTyp6" ) or vioGetElementData( player, "ammoTyp6" ) == nil then
		wert6 = 0
	else
		wert6 = tonumber(vioGetElementData( player, "ammoTyp6" ))
	end

	local s_string = "|"..wert1.."|"..wert2.."|"..wert3.."|"..wert4.."|"..wert5.."|"..wert6.."|"
	-- "|0|0|0|0|0|0|"
	local pname = getPlayerName ( player )

	MySQL_SetString("inventar", "Spezial", s_string, dbPrepareString( handler, "Name LIKE ?", pname ) )
end

function SaveCarData ( player )

	local pname = getPlayerName ( player )
	dbExec( handler, "UPDATE userdata SET Geld=?, CurrentCars=?, Maximumcars=? WHERE Name LIKE ?", vioGetElementData ( player, "money" ), vioGetElementData ( player, "curcars" ), vioGetElementData ( player, "maxcars" ), pname )
end

function datasave_remote ( player )
	
	local source = player
	if tonumber ( vioGetElementData ( source, "loggedin" ) ) == 1 then
		local pname = getPlayerName ( source )
		local fields = "SET"
		fields = fields.." Geld = '"..math.abs ( math.floor ( vioGetElementData ( source, "money" ) ) ).."'"
		fields = fields..", Fraktion = '"..math.abs ( math.floor ( vioGetElementData ( source, "fraktion") ) ).."'"
		fields = fields..", FraktionsRang = '"..math.floor ( vioGetElementData ( source, "rang" ) ).."'"
		fields = fields..", Spielzeit = '"..math.floor ( vioGetElementData ( source, "playingtime" ) ).."'"
		fields = fields..", CurrentCars = '"..math.floor ( vioGetElementData ( source, "curcars" ) ).."'"
		fields = fields..", Maximumcars = '"..math.floor ( vioGetElementData ( source, "maxcars" ) ).."'"
		fields = fields..", Tode = '"..math.floor ( vioGetElementData ( source, "deaths" ) ).."'"
		fields = fields..", Kills = '"..math.floor ( vioGetElementData ( source, "kills" ) ).."'"
		fields = fields..", Knastzeit = '"..math.floor ( vioGetElementData ( source, "jailtime" ) ).."'"
		fields = fields..", Himmelszeit = '"..math.floor ( vioGetElementData ( source, "heaventime" ) ).."'"
		fields = fields..", Hausschluessel = '"..math.floor ( vioGetElementData ( source, "housekey" ) ).."'"
		fields = fields..", Bankgeld = '"..math.floor ( vioGetElementData ( source, "bankmoney" ) ).."'"
		fields = fields..", Drogen = '"..math.floor ( vioGetElementData ( source, "drugs" ) ).."'"
		fields = fields..", Skinid = '"..math.floor ( vioGetElementData ( source, "skinid" ) ).."'"
		fields = fields..", Wanteds = '"..math.floor ( vioGetElementData ( source, "wanteds" ) ).."'"
		fields = fields..", StvoPunkte = '"..math.floor ( vioGetElementData ( source, "stvo_punkte" ) ).."'"
		fields = fields..", Boni = '"..math.floor ( vioGetElementData ( source, "boni" ) ).."'"
		fields = fields..", IncomePayday = '"..math.floor ( vioGetElementData ( source, "incomepayday" ) ).."'"
		fields = fields..", PdayIncome = '"..math.floor ( vioGetElementData ( source, "pdayincome" ) ).."'"
		fields = fields..", PdayKosten = '"..math.floor ( vioGetElementData ( source, "pdaykosten" ) ).."'"
		fields = fields..", Warns = '"..math.floor ( vioGetElementData ( source, "warns" ) ).."'"
		fields = fields..", Gunbox1 = '"..vioGetElementData ( source, "gunboxa" ).."'"
		fields = fields..", Gunbox2 = '"..vioGetElementData ( source, "gunboxb" ).."'"
		fields = fields..", Gunbox3 = '"..vioGetElementData ( source, "gunboxc" ).."'"
		fields = fields..", Job = '"..vioGetElementData ( source, "job" ).."'"
		fields = fields..", Jobtime = '"..math.floor ( vioGetElementData ( source, "jobtime" ) ).."'"
		fields = fields..", Club = '"..vioGetElementData ( source, "club" ).."'"
		fields = fields..", FavRadio = '"..math.floor ( vioGetElementData ( source, "favchannel" ) ).."'"
		fields = fields..", Bonuspunkte = '"..math.floor ( vioGetElementData ( source, "bonuspoints" ) ).."'"
		local skill = tonumber ( vioGetElementData ( source, "truckerlvl" ) )
		if not skill then
			skill = 0
		end
		fields = fields..", Truckerskill = '"..skill.."'"
		fields = fields..", farmerLVL = '"..vioGetElementData ( source, "farmerLVL" ).."'"
		fields = fields..", AirportLevel = '"..math.floor ( vioGetElementData ( source, "airportlvl" ) ).."'"
		fields = fields..", Contract = '"..math.floor ( vioGetElementData ( source, "contract" ) ).."'"
		fields = fields..", SocialState = '"..getElementData ( source, "socialState").."'"
		fields = fields..", StreetCleanPoints = '"..math.floor ( getElementData ( source, "streetCleanPoints" ) ).."'"
		local v1 = "|"..vioGetElementData ( source, "handyType" ).."|"
		local v2 = vioGetElementData ( source, "handyCosts" ).."|"
		local v3 = v1..v2
		fields = fields..", Handy = '"..v3.."'"
		dbExec ( handler, "UPDATE userdata "..fields.." WHERE Name LIKE ?", pname )
		
		saveAddictionsForPlayer ( source )
		packageSave(source)
		achievsave(source)
		inventorysave(source)
		bonusSave(source)
		skillDataSave ( player )
		saveArmyPermissions ( player )
		saveShaderInfo ( player )
		saveSpecialInfo ( player )
		outputDebugString ("Daten fuer Spieler "..pname.." wurden gesichert!")
	end
end

function achievsave ( player )

	local pname = getPlayerName ( player ) 
	saveHorseShoesFound ( player, pname )
	dbExec( handler, "UPDATE achievments SET Waffenschieber=?, Fahrzeugwahn=? WHERE Name LIKE ?", vioGetElementData ( player, "gunloads" ), vioGetElementData ( player, "carwahn_achiev" ), pname )
	savePlayingTimeForSleeplessAchiev ( player, pname )
end

local function achievload_DB ( qh, player, pname )
	local result = dbPoll( qh, 0 )
	if result and result[1] then 
		local dsatz = result[1]
		vioSetElementData ( player, "schlaflosinsa", dsatz["SchlaflosInSA"] )
		vioSetElementData ( player, "gunloads", dsatz["Waffenschieber"] )
		vioSetElementData ( player, "angler_achiev", dsatz["Angler"] )
		vioSetElementData ( player, "licenses_achiev", dsatz["Lizensen"] )
		vioSetElementData ( player, "carwahn_achiev", dsatz["Fahrzeugwahn"] )
		vioSetElementData ( player, "collectr_achiev", dsatz["DerSammler"] )
		vioSetElementData ( player, "rl_achiev", dsatz["ReallifeWTF"] )
		vioSetElementData ( player, "own_foots", dsatz["EigeneFuesse"] )
		vioSetElementData ( player, "kingofthehill_achiev", dsatz["KingOfTheHill"] )
		vioSetElementData ( player, "thetruthisoutthere_achiev", dsatz["TheTruthIsOutThere"] )
		vioSetElementData ( player, "silentassasin_achiev", dsatz["SilentAssasin"] )
		vioSetElementData ( player, "highwaytohell_achiev", dsatz["HighwayToHell"] )
		
		vioSetElementData ( player, "revolverheld_achiev", tonumber ( dsatz["Revolverheld"] ) )
		vioSetElementData ( player, "chickendinner_achiev", tonumber ( dsatz["ChickenDinner"] ) )
		vioSetElementData ( player, "nichtsgehtmehr_achiev", tonumber ( dsatz["NichtGehtMehr"] ) )
		vioSetElementData ( player, "highscore_achiev", tonumber ( dsatz["highscore"] ) == 1 )

		local dstring = dsatz["LookoutsA"]
		triggerClientEvent ( player, "hideLookoutMarkers", getRootElement(), dstring )
		local count = 0
		for i = 1, 10 do
			if tonumber ( gettok ( dstring, i, string.byte ( '|' ) ) ) == 1 then
				count = count + 1
			end
		end
		vioSetElementData ( player, "viewpoints", count )
	end
end

function achievload ( player )

	local pname = getPlayerName ( player )
	dbQuery ( achievload_DB, { player, pname }, handler, "SELECT * from achievments WHERE Name LIKE ?", pname )
	--[[
	vioSetElementData ( player, "schlaflosinsa", MySQL_GetString("achievments", "SchlaflosInSA", "Name LIKE '" ..pname.."'") )
	vioSetElementData ( player, "gunloads", MySQL_GetString("achievments", "Waffenschieber", "Name LIKE '" ..pname.."'") )
	vioSetElementData ( player, "angler_achiev", MySQL_GetString("achievments", "Angler", "Name LIKE '" ..pname.."'") )
	vioSetElementData ( player, "licenses_achiev", MySQL_GetString("achievments", "Lizensen", "Name LIKE '" ..pname.."'") )
	vioSetElementData ( player, "carwahn_achiev", MySQL_GetString("achievments", "Fahrzeugwahn", "Name LIKE '" ..pname.."'") )
	vioSetElementData ( player, "collectr_achiev", MySQL_GetString("achievments", "DerSammler", "Name LIKE '" ..pname.."'") )
	vioSetElementData ( player, "rl_achiev", MySQL_GetString("achievments", "ReallifeWTF", "Name LIKE '" ..pname.."'") )
	vioSetElementData ( player, "own_foots", MySQL_GetString("achievments", "EigeneFuesse", "Name LIKE '" ..pname.."'") )
	vioSetElementData ( player, "kingofthehill_achiev", MySQL_GetString("achievments", "KingOfTheHill", "Name LIKE '" ..pname.."'") )
	vioSetElementData ( player, "thetruthisoutthere_achiev", MySQL_GetString("achievments", "TheTruthIsOutThere", "Name LIKE '" ..pname.."'") )
	vioSetElementData ( player, "silentassasin_achiev", MySQL_GetString("achievments", "SilentAssasin", "Name LIKE '" ..pname.."'") )
	vioSetElementData ( player, "highwaytohell_achiev", MySQL_GetString("achievments", "HighwayToHell", "Name LIKE '" ..pname.."'") )
	
	vioSetElementData ( player, "revolverheld_achiev", tonumber ( MySQL_GetString("achievments", "Revolverheld", "Name LIKE '" ..pname.."'") ) )
	vioSetElementData ( player, "chickendinner_achiev", tonumber ( MySQL_GetString("achievments", "ChickenDinner", "Name LIKE '" ..pname.."'") ) )
	vioSetElementData ( player, "nichtsgehtmehr_achiev", tonumber ( MySQL_GetString("achievments", "NichtGehtMehr", "Name LIKE '" ..pname.."'") ) )
	]]
	loadHorseShoesFound ( player, pname )
	loadPlayingTimeForSleeplessAchiev ( player, pname )
end

function inventorysave ( player )

	local pname = getPlayerName ( player )
	--[[MySQL_SetString("inventar", "Blumensamen", MySQL_Save ( vioGetElementData ( player, "flowerseeds") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Essensslot1", MySQL_Save ( vioGetElementData ( player, "food1") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Essensslot2", MySQL_Save ( vioGetElementData ( player, "food2") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Essensslot3", MySQL_Save ( vioGetElementData ( player, "food3") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Zigaretten", MySQL_Save ( vioGetElementData ( player, "zigaretten") ), "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Materials", MySQL_Save ( vioGetElementData ( player, "mats") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Benzinkanister", MySQL_Save ( vioGetElementData ( player, "benzinkannister") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "FruitNotebook", MySQL_Save ( vioGetElementData ( player, "fruitNotebook" )) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Objekt", vioGetElementData ( player, "object" ), "Name LIKE '" ..pname.."'" )
	MySQL_SetString("inventar", "Chips", vioGetElementData ( player, "casinoChips" ), "Name LIKE '" ..pname.."'" )]]
	--[[MySQL_SetString("inventar", "Peilsender", MySQL_Save ( vioGetElementData ( player, "peilsender")"Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Wuerfel", MySQL_Save ( vioGetElementData ( player, "dice") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Palmensamen", MySQL_Save ( vioGetElementData ( player, "palmseeds") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Telefonbuch", MySQL_Save ( vioGetElementData ( player, "phonebook") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Lottoschein", MySQL_Save ( vioGetElementData ( player, "lottozahlen") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Waffenslot1", MySQL_Save ( vioGetElementData ( player, "guninv1") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Waffenslot2", MySQL_Save ( vioGetElementData ( player, "guninv2") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Waffenslot3", MySQL_Save ( vioGetElementData ( player, "guninv3") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Waffenslot4", MySQL_Save ( vioGetElementData ( player, "guninv4") ) , "Name LIKE '"..pname.."'")
	MySQL_SetString("inventar", "Waffenslot5", MySQL_Save ( vioGetElementData ( player, "guninv5") ) , "Name LIKE '"..pname.."'")]]

	local fields = "SET"
	fields = fields.." Blumensamen = '"..vioGetElementData ( player, "flowerseeds" ).."'"
	fields = fields..", Essensslot1 = '"..vioGetElementData ( player, "food1" ).."'"
	fields = fields..", Essensslot2 = '"..vioGetElementData ( player, "food2" ).."'"
	fields = fields..", Essensslot3 = '"..vioGetElementData ( player, "food3" ).."'"
	fields = fields..", Zigaretten = '"..vioGetElementData ( player, "zigaretten" ).."'"
	fields = fields..", Materials = '"..vioGetElementData ( player, "mats" ).."'"
	fields = fields..", Benzinkanister = '"..vioGetElementData ( player, "benzinkannister" ).."'"
	fields = fields..", FruitNotebook = '"..vioGetElementData ( player, "fruitNotebook" ).."'"
	fields = fields..", Objekt = '"..vioGetElementData ( player, "object" ).."'"
	fields = fields..", Chips = '"..vioGetElementData ( player, "casinoChips" ).."'"
	fields = fields..", eggs = '"..vioGetElementData ( player, "easterEggs" ).."'"
	--fields = fields..", Geschenke = '"..vioGetElementData ( player, "presents" ).."'"
	dbExec ( handler, "UPDATE inventar "..fields.." WHERE Name LIKE ?", pname )
end

function casinoMoneySave ( player )

	if vioGetElementData ( player, "loggedin" ) == 1 then
		local name = getPlayerName ( player )
		local chips = math.abs ( math.floor ( vioGetElementData ( player, "casinoChips" ) ) )
		local money = math.floor ( vioGetElementData ( player, "money" ) )
		local bankMoney = math.floor ( vioGetElementData ( player, "bankmoney" ) )
		dbExec ( handler, "UPDATE inventar SET Chips = '"..chips.."' WHERE Name LIKE ?", name )
		dbExec ( handler, "UPDATE userdata SET Geld = '"..money.."', Bankgeld = '"..bankMoney.."' WHERE Name LIKE ?", name )
	end
end


local function inventoryload_DB ( qh, player, pname )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local dsatz = result[1]
		vioSetElementData ( player, "dice", tonumber ( dsatz["Wuerfel"] ) )
		vioSetElementData ( player, "flowerseeds", tonumber ( dsatz["Blumensamen"] ) )
		vioSetElementData ( player, "food1", tonumber ( dsatz["Essensslot1"] ) )
		vioSetElementData ( player, "food2", tonumber ( dsatz["Essensslot2"] ) )
		vioSetElementData ( player, "food3", tonumber ( dsatz["Essensslot3"] ) )
		vioSetElementData ( player, "zigaretten", tonumber ( dsatz["Zigaretten"] ) )
		vioSetElementData ( player, "mats", tonumber ( dsatz["Materials"] ) )
		vioSetElementData ( player, "benzinkannister", tonumber ( dsatz["Benzinkanister"] ) )
		vioSetElementData ( player, "fruitNotebook", tonumber ( dsatz["FruitNotebook"] ) )
		vioSetElementData ( player, "casinoChips", tonumber ( dsatz["Chips"] ) )
		vioSetElementData ( player, "gameboy", tonumber ( dsatz["Gameboy"] ) )
		vioSetElementData ( player, "easterEggs", tonumber ( dsatz["eggs"] ) )
	end
end

function inventoryload ( player )

	local pname = getPlayerName ( player )
	
	local dsatz
	dbQuery ( inventoryload_DB, { player, pname }, handler, "SELECT * from inventar WHERE Name LIKE ?" )
	
	-- X-MAS --
	-- vioSetElementData ( player, "presents", tonumber ( dsatz["Geschenke"] ) )
	-- X-MAS --
	
	--[[
	vioSetElementData ( player, "dice", tonumber ( MySQL_GetString("inventar", "Wuerfel", "Name LIKE '" ..pname.."'")) )
	vioSetElementData ( player, "flowerseeds", tonumber ( MySQL_GetString("inventar", "Blumensamen", "Name LIKE '" ..pname.."'")) )
	vioSetElementData ( player, "food1", tonumber ( MySQL_GetString("inventar", "Essensslot1", "Name LIKE '" ..pname.."'")) )
	vioSetElementData ( player, "food2", tonumber ( MySQL_GetString("inventar", "Essensslot2", "Name LIKE '" ..pname.."'")) )
	vioSetElementData ( player, "food3", tonumber ( MySQL_GetString("inventar", "Essensslot3", "Name LIKE '" ..pname.."'")) )
	vioSetElementData ( player, "zigaretten", tonumber ( MySQL_GetString("inventar", "Zigaretten", "Name LIKE '" ..pname.."'") ) )
	vioSetElementData ( player, "mats", tonumber ( MySQL_GetString("inventar", "Materials", "Name LIKE '" ..pname.."'") ) )
	vioSetElementData ( player, "benzinkannister", tonumber ( MySQL_GetString("inventar", "Benzinkanister", "Name LIKE '" ..pname.."'") ) )
	vioSetElementData ( player, "fruitNotebook", tonumber ( MySQL_GetString("inventar", "FruitNotebook", "Name LIKE '" ..pname.."'") ) )
	vioSetElementData ( player, "casinoChips", tonumber ( MySQL_GetString( "inventar", "Chips", "Name LIKE '" ..pname.."'") ) )
	vioSetElementData ( player, "gameboy", tonumber ( MySQL_GetString ( "inventar", "Gameboy", "Name LIKE '"..pname.."'" ) ) )
	]]
end

-- Info: Angabe von Last_Login in Tagen seit Jahresanfang, Angabe von Geschlecht in 1 u. 0 - 1 = Weiblich, 0 = männlich
-- Anreise in 1 u. 0, 0 = Schiff, 1 = Flugzeug
-- Scheine: 0 = nicht vorhanden, 1 = vorhanden

function logoutPlayer_func ( x, y, z, int, dim )

	if vioGetElementData ( client, "shootingRanchGun" ) then
		
	else
		local pname = getPlayerName ( client )
		local int = tonumber ( int )
		local dim = tonumber ( dim )
		local curWeaponsForSave = "|"
		for i = 1, 11 do
			if i ~= 10 then
				local weapon = getPedWeapon ( client, i )
				local ammo = getPedTotalAmmo ( client, i )
				if weapon and ammo then
					if weapon > 0 and ammo > 0 then
						if #curWeaponsForSave <= 40 then
							curWeaponsForSave = curWeaponsForSave..weapon..","..ammo.."|"
						end
					end
				end
			end
		end
		pos = "|"..(math.floor(x*100)/100).."|"..(math.floor(y*100)/100).."|"..(math.floor(z*100)/100).."|"..int.."|"..dim.."|"
		if #curWeaponsForSave < 5 then
			curWeaponsForSave = ""
		end
		dbExec ( handler, "INSERT INTO logout (Position, Waffen, Name) VALUES ('"..pos.."', '"..curWeaponsForSave.."', ?)", pname )
		kickPlayer ( client, "Ausgeloggt." )
	end
end
addEvent ( "logoutPlayer", true )
addEventHandler ( "logoutPlayer", getRootElement(), logoutPlayer_func )