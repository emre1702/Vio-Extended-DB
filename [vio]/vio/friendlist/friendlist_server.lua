function addFriend_func ( player, friend )

	friend = MySQL_Save ( friend )
	if player == client then
		if player == getPlayerFromName ( friend ) then
			outputChatBox ( "Du kannst dich nicht selber zur Friendlist hinzufuegen!", player, 125, 0, 0 )
		elseif getPlayerFromName ( friend ) then
			triggerClientEvent ( player, "addFriend", getRootElement(), getPlayerName(getPlayerFromName ( friend )) )
		elseif MySQL_GetString("userdata", "Name", "Name LIKE '" ..friend.."'") then
			triggerClientEvent ( player, "addFriend", getRootElement(), MySQL_GetString("userdata", "Name", "Name LIKE '" ..friend.."'") )
		else
			outputChatBox ( "Der Spieler existiert nicht!", player, 125, 0, 0 )
		end
	end
end
addEvent ( "addFriend", true )
addEventHandler ( "addFriend", getRootElement(), addFriend_func )