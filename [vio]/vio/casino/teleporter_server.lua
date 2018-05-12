i = 1
casinoTeleporters = {}
	casinoTeleporters["x"] = {}
	casinoTeleporters["y"] = {}
	casinoTeleporters["z"] = {}
	casinoTeleporters["int"] = {}
	
	casinoTeleporters["tx"] = {}
	casinoTeleporters["ty"] = {}
	casinoTeleporters["tz"] = {}
	casinoTeleporters["tint"] = {}
	casinoTeleporters["r"] = {}
	
	casinoTeleporters["size"] = {}

		-- Caligulas ( Out -> In )
		casinoTeleporters["x"][i], casinoTeleporters["y"][i], casinoTeleporters["z"][i], casinoTeleporters["int"][i] = 2195.9187011719, 1677.1341552734, 11.345178604126, 0
		casinoTeleporters["tx"][i], casinoTeleporters["ty"][i], casinoTeleporters["tz"][i], casinoTeleporters["tint"][i], casinoTeleporters["r"][i] = 2233.89453125, 1711.6635742188, 1011.2369384766, 1, 180
		casinoTeleporters["size"][i] = 2
		i = i + 1
		-- Caligulas ( In -> Out )
		casinoTeleporters["x"][i], casinoTeleporters["y"][i], casinoTeleporters["z"][i], casinoTeleporters["int"][i] = 2233.9501953125, 1713.791015625, 1010.7177734375, 1
		casinoTeleporters["tx"][i], casinoTeleporters["ty"][i], casinoTeleporters["tz"][i], casinoTeleporters["tint"][i], casinoTeleporters["r"][i] = 2194.3491210938, 1677.1180419922, 12.016412734985, 0, 90
		casinoTeleporters["size"][i] = 2
		i = i + 1
		
		-- Four Dragons ( Out -> In )
		casinoTeleporters["x"][i], casinoTeleporters["y"][i], casinoTeleporters["z"][i], casinoTeleporters["int"][i] = 2020.2043457031, 1007.7569580078, 9.8054075241089, 0
		casinoTeleporters["tx"][i], casinoTeleporters["ty"][i], casinoTeleporters["tz"][i], casinoTeleporters["tint"][i], casinoTeleporters["r"][i] = 2015.7701416016, 1017.8104858398, 996.52423095703, 10, 90
		casinoTeleporters["size"][i] = 2
		i = i + 1
		
		-- Four Dragons ( In -> Out )
		casinoTeleporters["x"][i], casinoTeleporters["y"][i], casinoTeleporters["z"][i], casinoTeleporters["int"][i] = 2018.6097412109, 1017.8402099609, 995.84375, 10
		casinoTeleporters["tx"][i], casinoTeleporters["ty"][i], casinoTeleporters["tz"][i], casinoTeleporters["tint"][i], casinoTeleporters["r"][i] = 2022.0834960938, 1007.7553710938, 10.469537734985, 0, -90
		casinoTeleporters["size"][i] = 2
		i = i + 1

for key, index in pairs ( casinoTeleporters["x"] ) do

	local i = key
	_G["casinoMarker"..i] = createMarker ( casinoTeleporters["x"][i], casinoTeleporters["y"][i], casinoTeleporters["z"][i], "cylinder", casinoTeleporters["size"][i], getColorFromString ( "#FF000099" ) )
	setElementInterior ( _G["casinoMarker"..i], casinoTeleporters["int"][i] )
	setElementData ( _G["casinoMarker"..i], "id", i )
	addEventHandler ( "onMarkerHit", _G["casinoMarker"..i],
		function ( hit, dim )
			if dim and getElementType ( hit ) == "player" then
				if not getPedOccupiedVehicle ( hit ) then
					local i = getElementData ( source, "id" )
					local x, y, z, int, rot = casinoTeleporters["tx"][i], casinoTeleporters["ty"][i], casinoTeleporters["tz"][i], casinoTeleporters["tint"][i], casinoTeleporters["r"][i]
					
					fadeElementInterior ( hit, int, x, y, z, rot )
				end
			end
		end
	)
end