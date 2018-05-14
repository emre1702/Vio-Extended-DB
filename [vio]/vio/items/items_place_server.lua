objects = {}
objectCount = 0
clientSoundFiles = {}
	clientSoundFiles["x"] = {}
	clientSoundFiles["y"] = {}
	clientSoundFiles["z"] = {}
	clientSoundFiles["url"] = {}

addEventHandler ( "onPlayerJoin", getRootElement(),
	function ()
		for key, index in pairs ( clientSoundFiles["x"] ) do
			if isElement ( key ) then
				local x, y, z = clientSoundFiles["x"][key], clientSoundFiles["y"][key], clientSoundFiles["z"][key]
				triggerClientEvent ( getRootElement(), "recieveSoundSource", key, x, y, z, clientSoundFiles["url"][key] )
			else
				clientSoundFiles["x"][key] = nil
			end
		end
	end
)

function finishObjectPlace_func ( x, y, z, rx, ry, rz, special )

	local player = client
	local model = vioGetElementData ( player, "object" )
	if placeAblesToBeSaved[model] then
		createObjectToSave ( model, x, y, z, rx, player, 3 )
	else
		if model > 0 then
			objectCount = objectCount + 1
			local object = createObject ( model, x, y, z, rx, ry, rz )
			objects[objectCount] = object
			vioSetElementData ( objects[objectCount], "placeableObject", true )
			vioSetElementData ( player, "object", 0 )
			if model == 841 or model == 842 then -- Fackeln
				local fire = createObject ( 3461, x, y, z - 1.8 )
				setElementParent ( fire, objects[objectCount] )
			elseif model == 2103 and special ~= "" then -- Radio
				url = special
				clientSoundFiles["x"][object] = x
				clientSoundFiles["y"][object] = y
				clientSoundFiles["z"][object] = z
				clientSoundFiles["url"][object] = url
				triggerClientEvent ( getRootElement(), "recieveSoundSource", object, x, y, z, url )
				
				setTimer ( destroyElement, 10 * 60 * 1000, 1, object )
			end
		end
	end
end
addEvent ( "finishObjectPlace", true )
addEventHandler ( "finishObjectPlace", getRootElement(), finishObjectPlace_func )

function purchaseItem_func ( model )

	local player = client
	local price = placeablePrices[model]
	if vioGetElementData ( player, "money" ) >= price then
		if vioGetElementData ( player, "object" ) == 0 then
			takePlayerSaveMoney ( player, price )
			vioSetElementData ( player, "object", model )
			infobox ( player, "\n\nDu hast das Objekt\nerworben!\nEs ist nun in\ndeinem Inventar.", 5000, 0, 2000, 0 )
		else
			infobox ( player, "\n\n\nDu hast bereits\nein Objekt!", 5000, 200, 0, 0 )
		end
	else
		infobox ( player, "\n\n\nDu hast nicht\ngenug Geld!", 5000, 200, 0, 0 )
	end
end
addEvent ( "purchaseItem", true )
addEventHandler ( "purchaseItem", getRootElement(), purchaseItem_func )

placedObjects = {}


local function createObjectToSave_DB2 ( qh, model, x, y, z, rx, placer )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		local id = tonumber ( result[1]["id"] )
		dbExec( handler, "UPDATE object SET taken = '1' WHERE id LIKE ?", id )
		local object = createObject ( model, x, y, z, 0, 0, rx )
		vioSetElementData ( object, "placer", getPlayerName ( placer ) )
		vioSetElementData ( object, "id", id )
		vioSetElementData ( object, "placeableObjectMySQL", true )
		placedObjects[id] = object
	end
end

local function createObjectToSave_DB1 ( qh, placer, model, x, y, z, rx, placer, time )
	local result = dbPoll( qh, 0 )
	if not result or #result < maxPlaceAbleObjectsPerPlayer then
		if vioGetElementData ( placer, "playingtime" ) >= 600 then
			dbExec( handler, "INSERT INTO object ( model, x, y, z, rx, placer, deleteTime ) VALUES ( ?, ?, ?, ?, ?, ?, ? )", model, x, y, z, rx, getPlayerName( placer ), time )
			setTimer ( dbQuery, 500, 1, createObjectToSave_DB2, { model, x, y, z, rx, placer }, handler, "SELECT id FROM object WHERE taken = '0'" )
			vioSetElementData ( placer, "object", 0 )
			infobox ( placer, "Objekt platziert.", 5000, 0, 200, 0 )
		else
			infobox ( placer, "Du hast keine 10\nSpielstunden!", 5000, 125, 0, 0 )
		end
	else
		infobox ( player, "Du kannst maximal\n"..maxPlaceAbleObjectsPerPlayer.." Objekte zur\nselben Zeit platzieren.\nTippe /delmyobjects\nzum loeschen.", 5000, 125, 0, 0 )	
	end
end

function createObjectToSave ( model, x, y, z, rx, placer, daysToKeep )
	local time = getMinTime () + 60 * 24 * daysToKeep
	dbQuery( createObjectToSave_DB1, { model, x, y, z, rx, placer, time }, handler, "SELECT placer FROM object WHERE placer LIKE ?", getPlayerName( placer ) )
end

local function delmyobjects_DB ( qh, player )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		for i = 1, #result do
			local id = tonumber( result[i]["id"] )
			destroyElement ( placedObjects[id] )
		end
		dbExec( handler, "DELETE FROM object WHERE placer LIKE ?", getPlayerName( player ) )
	end
	outputChatBox ( "Alle von dir plazierten Objekte wurden geloescht.", player, 200, 200, 0 )
end

function delmyobjects ( player )
	dbQuery( delmyobjects_DB, { player }, handler, "SELECT id FROM object WHERE placer LIKE ?", getPlayerName( player ) )
end
addCommandHandler ( "delmyobjects", delmyobjects )

local function createSaveAblePlacedObjects_DB ( qh )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		createNextPlaceableObject ( table.remove( result, 1 ), result )
	else 
		outputServerLog ( "Es wurden keine platzierbaren Objekte gefunden." )
	end
end

function createSaveAblePlacedObjects ()
	dbExec( handler, "DELETE FROM object WHERE deleteTime < '"..getMinTime ().."'" )
	dbQuery ( createSaveAblePlacedObjects_DB, handler, "SELECT * FROM object" )
end

function createNextPlaceableObject ( data, result )

	local id = data["id"]
	
	local model = data["model"]
	
	local x = data["x"]
	local y = data["y"]
	local z = data["z"]
	local rx = data["rx"]
	
	local placer = data["placer"]
	
	local object = createObject ( model, x, y, z, 0, 0, rx )
	
	vioSetElementData ( object, "placer", placer )
	vioSetElementData ( object, "id", id )
	vioSetElementData ( object, "placeableObjectMySQL", true )
	
	placedObjects[id] = object
	
	data = table.remove( result, 1 )
	if data then
		createNextPlaceableObject ( data, result )
	end
end
createSaveAblePlacedObjects ()