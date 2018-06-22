fileCreateString = "\-\-dbExec ( handler, \"\" )\n\n\nlocal file = fileCreate ( \":vio/mysql/auto_update_db.lua\" )\nfileWrite ( file, fileCreateString )\nfileClose ( file )"
local gMysqlHost = "localhost"
local gMysqlUser = "root"
local gMysqlPass = ""
local gMysqlDatabase1 = "vio"
--local gMysqlDatabase2 = "vio_old"

local function MySQL_Startup()
	handler = dbConnect("mysql", "dbname="..gMysqlDatabase1..";host="..gMysqlHost, gMysqlUser, gMysqlPass, "tag=vio_extended;multi_statements=1")
	if( not handler) then
		outputDebugString("Couldn't run query: Unable to connect to the MySQL server!")
		outputDebugString("Please shutdown the server and start the MySQL server!")
	end	
	--[[handler_old = mysql_connect(gMysqlHost, gMysqlUser, gMysqlPass, gMysqlDatabase2)
	if( not handler_old) then
		outputDebugString("Couldn't run query: Unable to connect to the MySQL server!")
		outputDebugString("Please shutdown the server and start the MySQL server!")
	end	]]
end
MySQL_Startup()

function MySQL_End()
	destroyElement(handler)
end


-- von Bonus: nicht empfehlenswert zu nutzen
function MySQL_GetString(tablename, feldname, bedingung)
	local result, errorcode, errormsg = dbPoll( dbQuery( handler, "SELECT ?? from ?? WHERE "..bedingung, feldname, tablename ), -1 )
	if( not result) then
		 outputDebugString("Error executing the query: (" .. errorcode .. ") " .. errormsg)
	else
		if result[1] then
			local dsatz = result[1]
			local savename = feldname
			return dsatz[feldname]
		else
			return false
		end
	end
end

--[[function MySQL_GetStringDataset(tablename, fieldnames, bedingung)
	local result = mysql_query(handler, "SELECT "..fieldnames.." FROM "..tablename.." WHERE "..bedingung)
	if( not result) then
		 outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		if mysql_num_rows ( result ) > 0 then
			local dsatz = mysql_fetch_assoc(result)
			mysql_free_result(result)
			return dsatz
		else
			mysql_free_result(result)
			return false
		end
	end
end]]

function MySQL_ExistAmount ( tablename, bedingung )
	local result, errorcode, errormsg = dbPoll( dbQuery( handler, "SELECT true FROM " .. tablename .." WHERE " .. bedingung ), -1 )
	if ( not result ) then
		outputDebugString ( "Error executing the query: ("..errorcode..") "..errormsg )
	else	
		return #result 
	end
	return 0
end

--[[function MySQL_GetOldString(tablename, feldname, bedingung)
	local result = mysql_query(handler_old, "SELECT "..feldname.." from "..tablename.." WHERE "..bedingung)
	if( not result) then
		 outputDebugString("Error executing the query: (" .. mysql_errno(handler_old) .. ") " .. mysql_error(handler_old))
	else
		if(mysql_num_rows(result) > 0) then
			local dsatz = mysql_fetch_assoc(result)
			local savename = feldname
			mysql_free_result(result)
			return dsatz[feldname]
		else
			mysql_free_result(result)
			return false
		end
	end
end]]

--[[function MySQL_SetVar(tablename, feldname, var, bedingung)
	if var then
		local result = mysql_query(handler, "UPDATE "..tablename.." SET "..feldname.." = "..var.." WHERE "..bedingung)
		if( not result) then
			 outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
		else
			mysql_free_result(result)
			return false
		end
	end
end]]

--[[function MySQL_DelRow(tablename, bedingung)
	local result = mysql_query(handler, "DELETE FROM "..tablename.." WHERE "..bedingung)
	if( not result) then
		 outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		mysql_free_result(result)
		return false
	end
	outputDebugString ("geloescht?!")
end]]

function MySQL_SetString(tablename, feldname, var, bedingung)
	if var and bedingung then
		local result = dbExec( handler, "UPDATE ?? SET ?? = ? WHERE "..bedingung, tablename, feldname, var )
		if( not result) then
			outputDebugString("Error executing the query MySQL_SetString: (" .. tablename .. ") " .. feldname..", " .. var .. ", ".. bedingung)
		else
			return false
		end
	end
end

--[[function MySQL_SetOldString(tablename, feldname, var, bedingung)
	if var and bedingung then
		local result = mysql_query(handler_old, "UPDATE "..tablename.." SET "..feldname.." = '"..var.."' WHERE "..bedingung)
		if( not result) then
			outputDebugString("Error executing the query: (" .. mysql_errno(handler_func) .. ") " .. mysql_error(handler_func))
		else
			mysql_free_result(result)
			return false
		end
	end
end]]

function MySQL_DatasetExist(tablename, bedingung)
	local result, errorcode, errormsg = dbPoll( dbQuery( handler, "SELECT true FROM "..tablename.." WHERE "..bedingung ), -1 )
	if( not result) then
		 outputDebugString("Error executing the query MySQL_DatasetExist: (" .. errorcode .. ") " .. errormsg)
	else
		return #result > 0
	end
end

--[[function MySQL_DatasetOldExist(tablename, bedingung)
	local result = mysql_query(handler_old, "SELECT * from "..tablename.." WHERE "..bedingung)
	if( not result) then
		 outputDebugString("Error executing the query: (" .. mysql_errno(handler_old) .. ") " .. mysql_error(handler_old))
	else
		if(mysql_num_rows(result) > 0) then
			mysql_free_result(result)
			return true
		else
			mysql_free_result(result)
			return false
		end
	end
end]]

function MySQL_Safe ( string )
	return MySQL_Save ( string )
end
function MySQL_Save ( string )
	return dbPrepareString ( handler, "?", string )
end

--[[function mysql_vio_query ( query )

	if stringSaveFind(query, "Adminlevel") then
		outputDebugString ( "Query: "..query)
	end
	local result = mysql_query ( handler, query )
	local oldres = result
	if not result then
		outputDebugString ( "Error: Invalid Query: "..tostring ( query ) )
		outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else
		mysql_free_result ( result )
	end
	return oldres
end
function mysql_vio_old_query ( query )

	local result = mysql_query ( handler_old, query )
	local oldres = result
	if not result then
		outputDebugString ( "Error: Invalid Query: "..tostring ( query ) )
		outputDebugString("Error executing the query: (" .. mysql_errno(handler_old) .. ") " .. mysql_error(handler_old))
	else
		mysql_free_result ( result )
	end
	return oldres
end]]

function stringSaveFind ( arg1, arg2 )

	if arg1 and arg2 then
		return string.find ( arg1, arg2 )
	else
		return false
	end
end

--addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),MySQL_Startup )
addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()),MySQL_End)

--[[
Ich verfasse hier ein Tutorial zu MySQL,
da es meiner Ansicht nach der beste Weg ist,
Datensätze zu verarbeiten.

Was ihr dazu braucht:
-Ein lauffähiges Script, an dem ihr üben könnt
-Das MySQL-Modul von Ryden
-Einen Apache Server (z.b. über XAMPP), der auf eurem PC läuft sowie
eine Benutzeroberfläche, ich z.b. verwende PHP MyAdmin ( liegt bei XAMPP dabei )
-Grundliegende Kentnisse in Lua

Wozu MySQL?
MySQL empfiehlt sich, da es zum einen sehr schnell arbeitet und zum
anderen mit vielen weiteren Anwendungen und Sprachen kompatibel ist,
so könnte man z.b. einen Ingame-Account mit einem Forumsaccount verknüpfen
oder auch ein Control Panel in PHP schreiben.

Vorbereitung:

Das MySQL-Modul muss heruntergeladen werden,
anschließend packt ihr es in folgendes Verzeichnis:
[code]server\mods\deathmatch\modules[/code]
Und tragt folgendes in die .cfg ein:
[code]<module src="mta_mysql" />[/code]
Dabei ist zu beachten, dass das modul als letztes vor
den eigentlichen resourcen geladen werden sollte.

Funktionsweise:

MySQL speichert Daten im Tabellenformat, d.h. in z.b. folgende Struktur:

Datenbank: testDB

Tabelle Spieler:
[code]Name | Skin | Geld
Zipper | 75 | 500 $
Ryker | 175 | 400 $[/code]

Tabelle Fahrzeuge:
[code]
Modell | xPos | yPos | zPos
477 | 0 | 0 | 0
500 | 50 | 2000 | 0
[/code]



]]