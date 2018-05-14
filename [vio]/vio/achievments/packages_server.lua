packageNo1 = createPickup ( -1277.4365234375, 58.07186126709, 70.60230255127, 3, 1276, 0 )
packageNo2 = createPickup ( -1983.5153808594, 137.75064086914, 30.619560241699, 3, 1276, 0 )
packageNo3 = createPickup ( -1989.5472412109, 1117.8156738281, 73.581398010254, 3, 1276, 0 )
packageNo4 = createPickup ( -1375.9006347656, 1491.2154541016, 10.756679534912, 3, 1276, 0 )
packageNo5 = createPickup ( -1825.2287597656, 541.15783691406, 150.36605834961, 3, 1276, 0 )
packageNo6 = createPickup ( -2155.9328613281, -404.79080200195, 38.312358856201, 3, 1276, 0 )
packageNo7 = createPickup ( -2050.794921875, -443.80313110352, 74.822380065918, 3, 1276, 0 )
packageNo8 = createPickup ( -2052.0910644531, 305.60397338867, 41.545742034912, 3, 1276, 0 )
packageNo9 = createPickup ( -2514.53125, 796.62170410156, 41.655117034912, 3, 1276, 0 )
packageNo10 = createPickup ( -2474.8071289063, 1552.5639648438, 32.787929534912, 3, 1276, 0 )
packageNo11 = createPickup ( -2807.3764648438, 1162.4674072266, 25.803554534912, 3, 1276, 0 )
packageNo12 = createPickup ( -2708.1826171875, 377.91351318359, 11.533007621765, 3, 1276, 0 )
packageNo13 = createPickup ( -2571.0798339844, 327.51455688477, 10.116054534912, 3, 1276, 0 )
packageNo14 = createPickup ( -1860.9008789063, -29.447776794434, 21.641443252563, 3, 1276, 0 )
packageNo15 = createPickup ( -1517.8822021484, 108.67943572998, 16.881679534912, 3, 1276, 0 )
packageNo16 = createPickup ( -1304.6301269531, 483.47424316406, 1.6119002103806, 3, 1276, 0 )
packageNo17 = createPickup ( -1637.126953125, 488.01953125, 29.498867034912, 3, 1276, 0 )
packageNo18 = createPickup ( -2665.7138671875, 1595.0284423828, 216.82745361328, 3, 1276, 0 )
packageNo19 = createPickup ( -2682.5966796875, 1274.7376708984, 60.771320343018, 3, 1276, 0 )
packageNo20 = createPickup ( -1942.1853027344, 883.455078125, 71.173881530762, 3, 1276, 0 )
packageNo21 = createPickup ( -1826.4676513672, 366.33242797852, 16.717617034912, 3, 1276, 0 )
packageNo22 = createPickup ( -1943.0307617188, 487.23587036133, 31.522304534912, 3, 1276, 0 )
packageNo23 = createPickup ( -2240.646484375, 600.18481445313, 52.241054534912, 3, 1276, 0 )
packageNo24 = createPickup ( -2491.3928222656, 128.91076660156, 25.420742034912, 3, 1276, 0 )
packageNo25 = createPickup ( -1951.4162597656, 279.83767700195, 35.022304534912, 3, 1276, 0 )

function packageSettings ()

	for i = 1, 25 do
		setElementData ( _G["packageNo"..i], "number", i )
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), packageSettings )


local function packageLoad_DB ( qh, player, alreadytried )
	local pname = getPlayerName ( player )
	local result, errorcode, errormsg = dbPoll( qh, 0 )

	vioSetElementData ( player, "foundpackages", 0 )
	if not result or not result[1] then
		if alreadytried then
			if not result then
				outputDebugString("Error executing the query: ("		.. errorcode .. ") " .. errormsg)
			end
			return 
		end
		dbExec( handler, "INSERT INTO packages (Name, Paket1, Paket2, Paket3, Paket4, Paket5, Paket6, Paket7, Paket8, Paket9, Paket10, Paket11, Paket12, Paket13, Paket14, Paket15, Paket16, Paket17, Paket18, Paket19, Paket20, Paket21, Paket22, Paket23, Paket24, Paket25) VALUES (?,'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )", pname )
		dbQuery( packageLoad_DB, { player, true }, handler, "SELECT * FROM packages WHERE Name LIKE ?", pname )
		return
	end

	local dsatz = result[1] 
	
	for i = 1, 25 do
		local paket = tonumber ( dsatz["Paket"..i] )
		vioSetElementData ( player, "package"..i, paket )
		if paket == 1 then
			triggerClientEvent ( player, "hidePackages", getRootElement(), _G["packageNo"..i] )
			vioSetElementData ( player, "foundpackages", vioGetElementData ( player, "foundpackages" ) + 1 )
		end
	end
end


function packageLoad ( player )
	dbQuery( packageLoad_DB, { player, false }, handler, "SELECT * FROM packages WHERE Name LIKE ?", pname )
end

function packageSave ( player )

	
end

function pickupPackage ( player )

	local package = source
	local number = getElementData ( source, "number" )
	if number then
		if tonumber ( vioGetElementData ( player, "package"..number ) ) == 0 then
			local pname = getPlayerName ( player )
			vioSetElementData ( player, "package"..number, 1 )
			outputChatBox ( "Du hast ein von 25 versteckten Paeckchen gefunden und erhaelst 10 Punkte sowie 100 $!", player, 0, 125, 0 )
			triggerClientEvent ( player, "showAchievmentBox", getRootElement(), " Paeckchen\n gefunden!", 10, 10000 )
			vioSetElementData ( player, "foundpackages", vioGetElementData ( player, "foundpackages" ) + 1 )
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 100 )
			vioSetElementData ( player, "bonuspoints", vioGetElementData ( player, "bonuspoints" ) + 10 )
			givePlayerMoney ( player, 100 )
			triggerClientEvent ( player, "HudEinblendenMoney", getRootElement() )
			dbExec( handler, "UPDATE packages SET Paket"..number.." = ? WHERE Name LIKE ?", vioGetElementData ( player, "package"..number ), pname )
			dbExec( handler, "UPDATE userdata SET Bonuspunkte = ? WHERE Name LIKE ?", vioGetElementData ( player, "bonuspoints" ), pname )
			triggerClientEvent ( player, "hidePackages", getRootElement(), package )
		end
	end
	PackageAchievCheck ( player )
end
addEventHandler ( "onPickupHit", getRootElement(), pickupPackage )

function PackageAchievCheck ( player )

	if vioGetElementData ( player, "collectr_achiev" ) and vioGetElementData ( player, "foundpackages" ) then
		if vioGetElementData ( player, "collectr_achiev" ) ~= "done" and tonumber(vioGetElementData ( player, "foundpackages" )) >= 25 then						-- Achiev: Collector
			vioSetElementData ( player, "collectr_achiev", "done" )																								-- Achiev: Collector
			triggerClientEvent ( player, "showAchievmentBox", player, "  Der\n Sammler", 50, 10000 )															-- Achiev: Collector
			vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 50 )												-- Achiev: Collector
			dbExec( handler, "UPDATE achievments SET DerSammler = ? WHERE Name LIKE ?", vioGetElementData ( player, "collectr_achiev" ), getPlayerName(player) ) -- Achiev: Collector
		end																																						-- Achiev: Collector
	end
end