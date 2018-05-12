function insertPlayerIntoLoggedIn ( name, ip, serial )

	local result = mysql_query(handler, "INSERT INTO loggedin (Name,Serial,IP) VALUES ('"..name.."','"..serial.."','"..ip.."')")
	if( not result) then
		outputDebugString("Error executing the query: ("		.. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		mysql_free_result(result)
	end
end

function setPlayerLoggedIn ( name )

	mysql_vio_query ( "UPDATE loggedin SET Loggedin = '1' WHERE Name LIKE '"..name.."'" )
end

function removePlayerFromLoggedIn ( name )

	mysql_vio_query ( "DELETE FROM loggedin WHERE Name LIKE '"..name.."'" )
end

function deleteAllFromLoggedIn ()

	mysql_vio_query ( "TRUNCATE TABLE loggedin" )
end
deleteAllFromLoggedIn ()