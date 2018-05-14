function insertPlayerIntoLoggedIn ( name, ip, serial )

	local result = dbExec(handler, "INSERT INTO loggedin (Name,Serial,IP) VALUES (?, ?, ?)", name, serial, ip )
	if( not result) then
		outputDebugString("Error executing the query insertPlayerIntoLoggedIn")
	end
end

function setPlayerLoggedIn ( name )

	dbExec( handler, "UPDATE loggedin SET Loggedin = '1' WHERE Name LIKE ?", name )
end

function removePlayerFromLoggedIn ( name )

	dbExec( handler, "DELETE FROM loggedin WHERE Name LIKE ?", name )
end

function deleteAllFromLoggedIn ()

	dbExec( handler, "TRUNCATE TABLE loggedin" )
end
deleteAllFromLoggedIn ()