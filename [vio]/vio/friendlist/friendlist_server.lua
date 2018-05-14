local function addFriend_func_DB ( qh, player, friend )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		triggerClientEvent ( player, "addFriend", getRootElement(), result[1]["Name"] )
	else 
		outputChatBox ( "Der Spieler existiert nicht!", player, 125, 0, 0 )
	end
end

function addFriend_func ( player, friend )

	if player == client then
		if player == getPlayerFromName ( friend ) then
			outputChatBox ( "Du kannst dich nicht selber zur Friendlist hinzufuegen!", player, 125, 0, 0 )
		elseif getPlayerFromName ( friend ) then
			triggerClientEvent ( player, "addFriend", getRootElement(), getPlayerName(getPlayerFromName ( friend )) )
		else
			dbQuery( addFriend_func_DB, { player, friend }, handler, "SELECT Name FROM userdata WHERE Name LIKE ?", friend )
		end
	end
end
addEvent ( "addFriend", true )
addEventHandler ( "addFriend", getRootElement(), addFriend_func )