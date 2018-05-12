local biker_freeways = {}

biker_freeways[1] = createFactionVehicle ( 463, -2223.40234375, -2318.9384765625, 30.224336624146, 0, 0, 85.995483398438, 9, 119, 1 )
biker_freeways[2] = createFactionVehicle ( 463, -2218.7080078125, -2313.21875, 30.220146179199, 0, 0, 85.995483398438, 9, 119, 1 )
biker_freeways[3] = createFactionVehicle ( 463, -2219.7934570313, -2314.6669921875, 30.221206665039, 0, 0, 85.995483398438, 9, 119, 1 )
biker_freeways[4] = createFactionVehicle ( 463, -2220.958984375, -2316.1826171875, 30.222318649292, 0, 0, 85.995483398438, 9, 119, 1 )
biker_freeways[5] = createFactionVehicle ( 463, -2222.1044921875, -2317.4462890625, 30.223243713379, 0, 0, 85.995483398438, 9, 119, 1 )
biker_freeways[6] = createFactionVehicle ( 463, -2231.3845214844, -2328.6069335938, 30.242000579834, 0, 0, 233.99548339844, 9, 119, 1 )
biker_freeways[7] = createFactionVehicle ( 463, -2233.9841308594, -2326.4035644531, 30.170684814453, 0, 0, 233.99230957031, 9, 119, 1 )
biker_freeways[8] = createFactionVehicle ( 463, -2236.662109375, -2324.5380859375, 29.991535186768, 0, 0, 233.99230957031, 9, 119, 1 )
biker_freeways[9] = createFactionVehicle ( 463, -2239.3286132813, -2322.6127929688, 29.814113616943, 0, 0, 233.99230957031, 9, 119, 1 )
biker_freeways[10] = createFactionVehicle ( 463, -2241.900390625, -2320.6591796875, 29.644172668457, 0, 0, 233.99230957031, 9, 119, 1 )

createFactionVehicle ( 413, -2214.8579101563, -2324.8239746094, 30.890289306641, 0, 0, 137, 9, 113, 113, 8, 9 )
createFactionVehicle ( 413, -2218.1259765625, -2322.107421875, 30.890289306641, 0, 0, 136.99951171875, 9, 113, 113, 8, 9 )

createFactionVehicle ( 413, -2227.666015625, -2310.4716796875, 30.685554504395, 0, 0, 180, 9, 113, 113, 8, 9 )

---

createFactionVehicle ( 413, 2440.9658203125, 1570.283203125, 10.97031211853, 0, 0, 270, 9, 113, 113, 8, 9 )
createFactionVehicle ( 413, 2440.9658203125, 1566.783203125, 10.97031211853, 0, 0, 270, 9, 113, 113, 8, 9 )
createFactionVehicle ( 413, 2440.9658203125, 1573.5336914063, 10.97031211853, 0, 0, 270, 9, 113, 113, 8, 9 )

biker_freeways[11] = createFactionVehicle ( 463, 2502.08203125, 1523.5361328125, 10.291449546814, 0, 0, 296.74938964844, 9, 113, 113, 8, 9 )
biker_freeways[12] = createFactionVehicle ( 463, 2499.33203125, 1524.7861328125, 10.291449546814, 0, 0, 296.74938964844, 9, 113, 113, 8, 9 )
biker_freeways[13] = createFactionVehicle ( 463, 2496.33203125, 1526.0361328125, 10.291449546814, 0, 0, 296.74938964844, 9, 113, 113, 8, 9 )
biker_freeways[14] = createFactionVehicle ( 463, 2492.58203125, 1527.7861328125, 10.291449546814, 0, 0, 296.74938964844, 9, 113, 113, 8, 9 )
biker_freeways[15] = createFactionVehicle ( 463, 2481.08203125, 1536.0361328125, 10.291449546814, 0, 0, 300.74621582031, 9, 113, 113, 8, 9 )
biker_freeways[16] = createFactionVehicle ( 463, 2480.08203125, 1538.7861328125, 10.291449546814, 0, 0, 300.74523925781, 9, 113, 113, 8, 9 )
biker_freeways[17] = createFactionVehicle ( 463, 2478.83203125, 1541.7861328125, 10.291449546814, 0, 0, 300.74523925781, 9, 113, 113, 8, 9 )
biker_freeways[18] = createFactionVehicle ( 463, 2477.58203125, 1544.7861328125, 10.291449546814, 0, 0, 300.74523925781, 9, 113, 113, 8, 9 )

createFactionVehicle ( 487, 2494.6979980469, 1507.1423339844, 19.210311889648, 0, 0, 0, 9, 113, 113, 8, 9 )
createFactionVehicle ( 566, 2466.2041015625, 1599.2142333984, 10.718072891235, 0, 0, 180, 9, 113, 113, 8, 9 )
createFactionVehicle ( 566, 2470.7041015625, 1599.2138671875, 10.718072891235, 0, 0, 180, 9, 113, 113, 8, 9 )

function bikerKnockOff ( player, boolean )

	triggerClientEvent ( player, "onBikerBoolGiven", player, boolean )

end

for key, veh in pairs (biker_freeways) do

	setVehicleHandling ( veh, "maxVelocity", 240 )
	setVehicleHandling ( veh, "engineAcceleration", 21 )
	setVehicleHandling ( veh, "mass", 1500 )
	
	addEventHandler ( "onVehicleEnter", veh, 
		function ( player )
			
			bikerKnockOff ( player, false )
			
		end )
		
	addEventHandler ( "onVehicleExit", veh, 
		function ( player )
			
			bikerKnockOff ( player, true )
			
		end )

end