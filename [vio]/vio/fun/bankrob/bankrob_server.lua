local bankeingang = {}
bankeingang[1] = createColSphere ( 2364.8955078125, 2377.5654296875, 10.8203125, 1 ) -- ausserhalb
bankeingang[2] = createColSphere ( 286.5390625, -159.1982421875, 886.21331787109, 1 ) -- innerhalb
local bank_rob_col = createColSphere ( 267.767578125, -174.8671875, 873.62127685547, 5 ) -- rob
local bank_door = createObject ( 2924, 303.10000610352, -169.19999694824, 886.40002441406, 0, 0, 90 )
setElementInterior (bank_door,7)
bank_wird_ausgeraubt = 0
bank_robber = 0
bank_i = 3
bank_timer = 0
bank_robbed = 0
local movingVal = 5
bank_timer_global = 0
local bank_door_value = 0

addEventHandler( "onElementClicked", bank_door, 
	function ( _, state, player )
	
		if state == "down" and player then
		else
			return
		end
		
		if bank_wird_ausgeraubt ~= 0 then
			return
		end
		
		if isEvil(player) then
		else
			return
		end
		
		local key = getElementData ( player, "bankKeyCard" )
		
		if not key or key == 0 then
			outputChatBox ( "Du hast keinen Schluessel fuer diese Tuer!", player, 0, 125, 0 )
		else
		
			local x, y, z = getElementPosition ( bank_door )
			
			moveObject ( bank_door, 1000, x, y, z-movingVal )
			removeElementData ( player, "bankKeyCard" )
			bank_door_value = bank_door_value+1
			outputChatBox ( "Die Tuer bleibt nun genau 20 Minuten offen! Die Polizei ist bereits auf dem Weg, also beeilt euch!", player, 125, 0, 0 )
			setTimer ( 
				function ()
					local x, y, z = getElementPosition ( bank_door )
					moveObject ( bank_door, 1000, x, y, z+movingVal )
					bank_door_value = 0
				end, 1200000, 1 )
		
		end
	
	end )

createBlip ( 2364.8955078125, 2377.5654296875, 10.8203125, 52 )

function giveBankKeyCard ( _, player )

	if not player then return end
	
	outputChatBox ( "Du hast den Bankdirektor getoetet und erhaeltst die Schluesselkarte! Oeffne die Tuer zum Tresor! ( Klicke darauf )", player, 0, 125, 0 )
	setElementData ( player, "bankKeyCard", 1 )
	
	local target = player
	
	if vioGetElementData ( target, "wanteds" ) <= 3 then
		vioSetElementData ( target, "wanteds", vioGetElementData ( target, "wanteds" ) + 3 )
		setPlayerWantedLevel ( target, vioGetElementData ( target, "wanteds" ) )
	else
		vioSetElementData ( target, "wanteds", 6 )
		setPlayerWantedLevel ( target, vioGetElementData ( target, "wanteds" ) )
	end
	
	outputChatBox ( "Du hast ein Verbrechen begangen: Mord, Gemeldet von: Bank-Sicherheit", target, 255, 255, 0 )
	local msg = "Die Bank-Sicherheit meldet einen Mord von "..getPlayerName(target).." und fordert umgehend Hilfe!"
	sendMSGForFaction ( msg, 1, 0, 0, 200 )
	sendMSGForFaction ( msg, 6, 0, 0, 200 )
	sendMSGForFaction ( msg, 8, 0, 0, 200 )

end

local bank_ped 
bank_ped = createPed ( 17, 291.6162109375, -165.625, 886.21331787109, 90 )
addEventHandler( "onPedWasted", bank_ped, giveBankKeyCard )
triggerClientEvent ( "onBankPedGetsCool", bank_ped, bank_ped )
setElementInterior ( bank_ped, 7 )
setElementData ( bank_ped, "bank_ped", true )

function r_bankped ()

	destroyElement ( bank_ped )
	bank_ped = createPed ( 17, 291.6162109375, -165.625, 886.21331787109, 90 )
	addEventHandler( "onPedWasted", bank_ped, giveBankKeyCard )
	triggerClientEvent ( "onBankPedGetsCool", bank_ped, bank_ped )
	setElementInterior ( bank_ped, 7 )
	setElementData ( bank_ped, "bank_ped", true )

end

setTimer ( r_bankped, 600000, 0 ) 

function enter_bank ( thePlayer, matchingDimension )

	if getElementType ( thePlayer ) == "player" then
	
		if getPedOccupiedVehicle ( thePlayer ) then
			return
		end

		setElementInterior ( thePlayer, 7 )
		setElementPosition ( thePlayer, 287.1630859375, -162.38671875, 886.220703125 )
		setElementRotation ( thePlayer, 0, 0, 180 )
	
	end
	
end

addEventHandler ( "onColShapeHit", bankeingang[1], enter_bank )

function exit_bank ( thePlayer, matchingDimension )

	if getElementType ( thePlayer ) == "player" then
	
		if getPedOccupiedVehicle ( thePlayer ) then
			return
		end
	
		setElementInterior ( thePlayer, 0 )
		setElementPosition ( thePlayer, 2361.6572265625, 2378.244140625, 10.8203125 )
		setElementRotation ( thePlayer, 0, 0, 90 )
	
	end
	
end

addEventHandler ( "onColShapeHit", bankeingang[2], exit_bank )

function rob_bank ( thePlayer, matchingDimension )

	outputChatBox ( "Gebe /bankrob ein, um die Bank auszurauben.", thePlayer, 0, 125, 0 )
	
end

addEventHandler ( "onColShapeHit", bank_rob_col, rob_bank )

function robber_wasted ()

	removeEventHandler ( "onPlayerWasted", bank_robber, robber_wasted )
	removeEventHandler ( "onColShapeLeave", bank_rob_col, bank_col_leave )
	bank_robber = 0
	bank_i = 3
	bank_timer = 0

end

function info_bank_timer ()

	if bank_i == 0 then
	 
		if isElementWithinColShape ( bank_robber, bank_rob_col ) then
		
			local aval = 1 - ( bank_robbed / 10 )
			local bank_money = 20000 * aval
	
			outputChatBox ( "Dein Bankraub war erfolgreich.", bank_robber, 0, 125, 0 )
			outputChatBox ( "Du hast "..bank_money.." Geld erhalten. Fluechte schnell!", bank_robber, 0, 125, 0 )
			givePlayerMoney ( bank_robber, bank_money )
			vioSetElementData ( bank_robber, "money", vioGetElementData (bank_robber, "money" ) + bank_money )
			robber_wasted ()
		
		else
		
			outputChatBox ( "Dein Bankraub ist fehlgeschlagen.", source, 125, 0, 0 )
			killTimer ( bank_timer )
			robber_wasted()
		
		end
	
	else
	
		outputChatBox ( "Noch "..bank_i.." Minuten bis zum Abschluss.", bank_robber, 0, 125, 0 )
		bank_i = bank_i - 1	
	
	end

end

function bank_col_leave (ele)

	if ele == bank_robber then
	
		outputChatBox ( "Dein Bankraub ist fehlgeschlagen.", ele, 125, 0, 0 )
		killTimer ( bank_timer )
		robber_wasted()
	
	end

end

function robber_die ()

	outputChatBox ( "Dein Bankraub ist fehlgeschlagen.", source, 125, 0, 0 )
	killTimer ( bank_timer )
	robber_wasted()

end

function bank_rob ( player, _ )

	if isEvil ( player ) and vioGetElementData ( player, "rang" ) >= 2 and isElementWithinColShape ( player, bank_rob_col ) then
	
		if bank_wird_ausgeraubt ~= 1 then
		
			if bank_door_value < 1 then
				outputChatBox ( "Error 403", player, 0, 125, 0 )
				return
			end
	
			bank_wird_ausgeraubt = 1
			outputChatBox ( "Du hast einen Bankraub gestartet. Bleibe 4 Minuten bei den Geldsaecken.", player, 0, 125, 0 )
			outputChatBox ( "Solltest du sterben oder weggehen, wird der Raub abgebrochen.", player, 0, 125, 0 )
			
			sendMSGForFaction ( "Die Las Venturas Bank meldet einen Einbruch in den Tresorraum!", 1, 150, 0, 0 )
			sendMSGForFaction ( "Sie sollten sich umgehend dorthin bewegen!", 1, 150, 0, 0 )

			sendMSGForFaction ( "Die Las Venturas Bank meldet einen Einbruch in den Tresorraum!", 6, 150, 0, 0 )
			sendMSGForFaction ( "Sie sollten sich umgehend dorthin bewegen!", 6, 150, 0, 0 )
			
			sendMSGForFaction ( "Die Las Venturas Bank meldet einen Einbruch in den Tresorraum!",8, 150, 0, 0 )
			sendMSGForFaction ( "Sie sollten sich umgehend dorthin bewegen!", 8, 150, 0, 0 )
			
			bank_robber = player
			
			bank_timer = setTimer ( info_bank_timer, 60000, 4 )
			
			bank_timer_global = setTimer ( 
				function ()
				
					bank_wird_ausgeraubt = 0
				
				end, 7200000, 1 )
			
			addEventHandler ( "onPlayerWasted", player, robber_die ) 
			addEventHandler ( "onColShapeLeave", bank_rob_col, bank_col_leave )
		
		else
			
			local _time, _, _2 = getTimerDetails ( bank_timer_global )
			
			local var = _time / 1000
			local var1 = math.floor ( var / 60 )
			
			outputChatBox ( "Du kannst in "..var1.." Minuten wieder ausrauben.", player, 125, 0, 0 )
		
		end
	
	else
		outputChatBox ( "Diese Funktion steht dir erst ab Rang 2 in einer boesen Fraktion zur Verfuegung.", player, 125, 0, 0 )
	end

end

addCommandHandler ( "bankrob", bank_rob )