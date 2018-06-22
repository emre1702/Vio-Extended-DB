--Mothership: 483 - Lackierung!
carTypesForAI = {}
carPedsForAI = {}

aiCarPrices = {}

curAiCarSpots = {}

carSellerSkin = {
 [1]=14,
 [2]=12,
 [3]=98,
 [4]=180,
 [5]=206
 }

carSellerSkins = 0
for key, index in pairs ( carSellerSkin ) do
	carSellerSkins = carSellerSkins + 1
end

function loadBotCarTypes ()
	local result = dbPoll( dbQuery ( handler, "SELECT Model, Preis, Name FROM cars_ai" ), -1 )
	if result and result[1] then
		for i=1, #result do
			carTypesForAI[i] = {}
		
			local model = result[i]["Model"]
			local price = result[i]["Preis"]
			local name = result[i]["Name"]
			
			carTypesForAI[i]["model"] = model
			carTypesForAI[i]["price"] = price
			carTypesForAI[i]["name"] = name
			
			aiCarPrices[model] = price
					
			table.insert ( carprices, model, price )	
		end
	end

	result = dbPoll( dbQuery ( handler, "SELECT * FROM cars_peds_ai" ), -1 )
	if result and result[1] then
		for i=1, #result do
			carPedsForAI[i] = {}
		
			carPedsForAI[i]["vx"] = result[i]["VehX"]
			carPedsForAI[i]["vy"] = result[i]["VehY"]
			carPedsForAI[i]["vz"] = result[i]["VehZ"]
			carPedsForAI[i]["vrx"] = result[i]["VehRX"]
			carPedsForAI[i]["vry"] = result[i]["VehRY"]
			carPedsForAI[i]["vrz"] = result[i]["VehRZ"]
			
			carPedsForAI[i]["pedx"] = result[i]["PedX"]
			carPedsForAI[i]["pedy"] = result[i]["PedY"]
			carPedsForAI[i]["pedz"] = result[i]["PedZ"]
			carPedsForAI[i]["pedr"] = result[i]["PedR"]

			curAiCarSpots[i] = {}
			curAiCarSpots[i]["bool"] = false
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, loadBotCarTypes)


function createNewCarAI ()

	local carspot = math.random ( 1, carspots )
	if not curAiCarSpots[carspot]["bool"] then
		local rnd = math.random ( 1, aiCarTypes )
		local model = carTypesForAI[rnd]["model"]
		local price = carTypesForAI[rnd]["price"]
		local name = carTypesForAI[rnd]["name"]
		
		local vx = carPedsForAI[carspot]["vx"]
		local vy = carPedsForAI[carspot]["vy"]
		local vz = carPedsForAI[carspot]["vz"]
		local vrx = carPedsForAI[carspot]["vrx"]
		local vry = carPedsForAI[carspot]["vry"]
		local vrz = carPedsForAI[carspot]["vrz"]
		
		local pedx = carPedsForAI[carspot]["pedx"]
		local pedy = carPedsForAI[carspot]["pedy"]
		local pedz = carPedsForAI[carspot]["pedz"]
		local pedr = carPedsForAI[carspot]["pedr"]
		
		local rnd = math.random ( 1, carSellerSkins )
		local skin = carSellerSkin[rnd]
		
		curAiCarSpots[carspot]["bool"] = true
		curAiCarSpots[carspot]["car"] = createVehicle ( model, vx, vy, vz, vrx, vry, vrz )
		curAiCarSpots[carspot]["bot"] = createPed ( skin, pedx, pedy, pedz, pedr )
		curAiCarSpots[carspot]["bool"] = true
		
		local veh = curAiCarSpots[carspot]["car"]
		
		setVehicleLocked ( veh, true )
		setVehicleDamageProof ( veh, true )
		setElementFrozen ( veh, true )
		
		outputServerLog ( "Fahrzeugbot erstellt!" )
		
		vioSetElementData ( curAiCarSpots[carspot]["bot"], "id", carspot )
		vioSetElementData ( curAiCarSpots[carspot]["bot"], "typ", "car" )
		vioSetElementData ( curAiCarSpots[carspot]["bot"], "veh", veh )
		vioSetElementData ( curAiCarSpots[carspot]["bot"], "clickPed", true )
		
		vioSetElementData ( veh, "name", name )
		vioSetElementData ( veh, "price", price )
		
		addEventHandler ( "onPedWasted", curAiCarSpots[carspot]["bot"],
			function ( ammo, killer )
				vanishElement ( source )
				vanishElement ( curAiCarSpots[carspot]["car"] )
				
				local data = vioGetElementData ( source, "id" )
				curAiCarSpots[data]["bool"] = false
				
				if killer then
					vioSetElementData ( killer, "wanteds", vioGetElementData ( killer, "wanteds" ) + 2 )
					if vioGetElementData ( killer, "wanteds" ) > 6 then
						vioSetElementData ( killer, "wanteds", 6 )
						setPlayerWantedLevel ( killer, 6 )
					else
						setPlayerWantedLevel ( killer, vioGetElementData ( killer, "wanteds" ) )
					end
					outputChatBox ( "Du hast ein Verbrechen begangen: Mord", killer, 0, 0, 200 )
				end
			end
		)
		setTimer ( createNewCarAI, math.random ( 50, 24*60*60*1000 ), 1 )
	end
end
setTimer ( createNewCarAI, math.random ( 50, 24*60*60*1000 ), 1 )

function buyCarFromAI ( player, car, ped )
	
	local price = tonumber ( vioGetElementData ( car, "price" ) )
	if price <= vioGetElementData ( player, "money" ) then
		local x, y, z = getElementPosition ( car )
		local rx, ry, rz = getElementRotation ( car )
		local model = getElementModel ( car )
		
		local f1, f2, f3, f4 = getVehicleColor ( car )
		local p = getVehiclePaintjob ( car )
		
		local bool = carbuy ( player, price, model, x, y, z, rx, ry, rz, f1, f2, f3, f4, p )
		if bool then
			destroyElement ( car )
			vanishElement ( ped )
			
			local data = vioGetElementData ( ped, "id" )
			curAiCarSpots[data]["bool"] = false
		end
	else
		outputChatBox ( "Du hast nicht genug Geld dafuer!", player, 125, 0, 0 )
	end
end