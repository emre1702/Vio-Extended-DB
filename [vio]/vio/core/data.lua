elementData = {}

function vioSetElementData ( player, dataString, value )

	if player and dataString and value ~= nil then
		if not elementData[player] then
			elementData[player] = {}
		end
		
		elementData[player][dataString] = value
		setElementData ( player, dataString, value )
	else
		return nil
	end
end

function vioGetElementData ( player, dataString )

	if player and dataString then
		if not elementData[player] then
			elementData[player] = {}
			return nil
		end
		
		if elementData[player][dataString] then
			return elementData[player][dataString]
		elseif not elementData[player][dataString] and dataString ~= "adminlvl" and dataString ~= "loggedin" then
			elementData[player][dataString] = getElementData ( player, dataString )
			return elementData[player][dataString]
		end
	else
		return nil
	end
end

function freeElementData ()

	if elementData then
		if getElementType ( source ) ~= "player" then
			if elementData[source] then
				elementData[source] = nil
			end
		end
	end
end
addEventHandler ( "onElementDestroy", getRootElement(), freeElementData )

function findPlayerByName( playerPart )

	local pl = getPlayerFromName( playerPart )
	
	if isElement(pl) then
	
		return pl
		
	else
	
		for i,v in ipairs (getElementsByType ("player")) do
		
            if (string.find(string.gsub ( string.lower(getPlayerName(v)), '#%x%x%x%x%x%x', '' ),string.lower(playerPart))) then
			
                return v
				
            end
			
        end
		
	end
	
 end