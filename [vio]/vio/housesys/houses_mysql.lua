houses = {}
 houses["id"] = {}
 houses["pickup"] = {}

function houseCreation()

	local houseamount = 0
	local result,errorcode, errormsg = dbPoll( dbQuery( handler, "SELECT * FROM houses" ), -1 )
	if( not result) then
		 outputDebugString("Error executing the query: (" ..errorcode .. ") " .. errormsg)
	else
		if #result > 0 then
			local dsatz = table.remove ( result, 1 )
			while( dsatz ) do
				houseamount = houseamount + 1
				
				local id = tonumber(dsatz["ID"])
				local x = tonumber(dsatz["SymbolX"])
				local y = tonumber(dsatz["SymbolY"])
				local z = tonumber(dsatz["SymbolZ"])
				local owner = dsatz["Besitzer"]
				local cost = tonumber(dsatz["Preis"])
				local min = tonumber(dsatz["Mindestzeit"])
				local int = tonumber(dsatz["CurrentInterior"])
				local kasse = tonumber(dsatz["Kasse"])
				local rent = tonumber(dsatz["Miete"])
				
				createHouse ( id, x, y, z, owner, cost, min, int, kasse, rent )
				
				if not ( owner == "none" ) then
					--[[local lastLogin = MySQL_GetOldString ( "players", "LastLogin", "Name LIKE '"..owner.."'" )
					if lastLogin then
						lastLogin = tonumber ( lastLogin )
						if lastLogin ~= 0 then
							if ( getMinTime() - lastLogin ) / 60 / 24 >= 60 then
								outputServerLog ( "Hausbesitzer "..owner.." wurde enteignet." )
								outputLog ( owner.." wurde enteignet.", "house" )
								MySQL_SetOldString ( "userdata", "Hausschluessel", "0", "Name LIKE '"..owner.."'" )
								mysql_vio_query ( "UPDATE houses SET Besitzer = 'none' WHERE Besitzer LIKE '"..owner.."'" )
								owner = "none"
							end
						end
					end]]
				end
				
				loadGangData ( id )
				
				dsatz = table.remove ( result, 1 )
			end
			outputServerLog("Es wurden "..houseamount.." Haeuser gefunden")
		else
			outputServerLog("Es wurden keine Haueser gefunden")
		end
	end
end
setTimer ( houseCreation, 5000, 1 )

function createHouse ( id, x, y, z, owner, cost, min, int, kasse, rent )

	local img
	if owner == "none" then img = 1273 else img = 1272 end
	
	local pickup = createPickup ( x, y, z, 3, img, 1000, 0 )
	
	houses["id"][pickup] = id
	houses["pickup"][id] = pickup
	
	vioSetElementData ( pickup, "owner", owner )
	vioSetElementData ( pickup, "locked", true )
	vioSetElementData ( pickup, "preis", cost )
	vioSetElementData ( pickup, "mintime", min )
	vioSetElementData ( pickup, "curint", int )
	vioSetElementData ( pickup, "id", id )
	vioSetElementData ( pickup, "miete", rent )
	vioSetElementData ( pickup, "kasse", kasse )
end