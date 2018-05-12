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

	local i = 1
	
	while MySQL_DatasetExist ( "cars_ai", "ID LIKE '"..i.."'" ) do
		carTypesForAI[i] = {}
		
		local model = tonumber ( MySQL_GetString ( "cars_ai", "Model", "ID LIKE '"..i.."'" ) )
		local price = MySQL_GetString ( "cars_ai", "Preis", "ID LIKE '"..i.."'" )
		local name = MySQL_GetString ( "cars_ai", "Name", "ID LIKE '"..i.."'" )
		
		carTypesForAI[i]["model"] = model
		carTypesForAI[i]["price"] = price
		carTypesForAI[i]["name"] = name
		
		aiCarPrices[model] = price
				
		table.insert ( carprices, model, price )
		
		i = i + 1
	end
	aiCarTypes = i - 1
	i = 1
	while MySQL_DatasetExist ( "cars_peds_ai", "ID LIKE '"..i.."'" ) do
		carPedsForAI[i] = {}
		
		carPedsForAI[i]["vx"] = MySQL_GetString ( "cars_peds_ai", "VehX", "ID LIKE '"..i.."'" )
		carPedsForAI[i]["vy"] = MySQL_GetString ( "cars_peds_ai", "VehY", "ID LIKE '"..i.."'" )
		carPedsForAI[i]["vz"] = MySQL_GetString ( "cars_peds_ai", "VehZ", "ID LIKE '"..i.."'" )
		carPedsForAI[i]["vrx"] = MySQL_GetString ( "cars_peds_ai", "VehRX", "ID LIKE '"..i.."'" )
		carPedsForAI[i]["vry"] = MySQL_GetString ( "cars_peds_ai", "VehRY", "ID LIKE '"..i.."'" )
		carPedsForAI[i]["vrz"] = MySQL_GetString ( "cars_peds_ai", "VehRZ", "ID LIKE '"..i.."'" )
		
		carPedsForAI[i]["pedx"] = MySQL_GetString ( "cars_peds_ai", "PedX", "ID LIKE '"..i.."'" )
		carPedsForAI[i]["pedy"] = MySQL_GetString ( "cars_peds_ai", "PedY", "ID LIKE '"..i.."'" )
		carPedsForAI[i]["pedz"] = MySQL_GetString ( "cars_peds_ai", "PedZ", "ID LIKE '"..i.."'" )
		carPedsForAI[i]["pedr"] = MySQL_GetString ( "cars_peds_ai", "PedR", "ID LIKE '"..i.."'" )
		
		i = i + 1
	end
	carspots = i - 1
	for i = 1, carspots do
		curAiCarSpots[i] = {}
		curAiCarSpots[i]["bool"] = false
	end
end
loadBotCarTypes ()

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