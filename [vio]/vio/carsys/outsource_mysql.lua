local result = mysql_query ( handler_old, "SHOW FIELDS FROM `vehicles`" )
local i = 0
local vehicleMySQLColumns = ""
local vehicleMySQLFields = {}
while mysql_num_rows ( result ) > 0 do
	i = i + 1
	local data = mysql_fetch_assoc ( result )
	if data then
		if # vehicleMySQLColumns > 0 then
			vehicleMySQLColumns = vehicleMySQLColumns..", "
		end
		vehicleMySQLFields[i] = data["Field"]
		vehicleMySQLColumns = vehicleMySQLColumns.." "..data["Field"]
	else
		break
	end
end
mysql_free_result ( result )

function moveVehiclesToOldDatabase ( name )

	local result = mysql_query ( handler, "SELECT * FROM vehicles WHERE Besitzer LIKE '"..name.."'" )
	local data = mysql_fetch_assoc ( result )
	local runs = 0
	while mysql_num_rows ( result ) > 0 do
		runs = runs + 1
		if runs > 15 then
			break
		end
		if data then
			if data["id"] then
				local i = 0
				local fieldValues = ""
				for key, index in pairs ( vehicleMySQLFields ) do
					i = i + 1
					if i > 1 then
						fieldValues = fieldValues..","
					end
					fieldValues = fieldValues.."'"..data[index].."'"
				end
				local query = "INSERT INTO vehicles ( "..vehicleMySQLColumns.." ) VALUES ( "..fieldValues.." )"
				local res = mysql_query ( handler_old, query )
				if res then
					mysql_free_result ( res )
				end
				
				MySQL_DelRow ( "vehicles", "Besitzer LIKE '"..name.."' AND Slot LIKE '"..data["Slot"].."'" )
				
				data = mysql_fetch_assoc ( result )
			else
				break
			end
		else
			break
		end
	end
	mysql_free_result ( result )
end

function moveVehiclesToNewDatabase ( name )

	local result = mysql_query ( handler_old, "SELECT * FROM vehicles WHERE Besitzer LIKE '"..name.."'" )
	local data = mysql_fetch_assoc ( result )
	local runs = 0
	while mysql_num_rows ( result ) > 0 do
		runs = runs + 1
		if runs > 15 then
			break
		end
		if data then
			if data["id"] then
				local i = 0
				local fieldValues = ""
				for key, index in pairs ( vehicleMySQLFields ) do
					i = i + 1
					if i > 1 then
						fieldValues = fieldValues..","
					end
					fieldValues = fieldValues.."'"..data[index].."'"
				end
				local query = "INSERT INTO vehicles ( "..vehicleMySQLColumns.." ) VALUES ( "..fieldValues.." )"
				local res = mysql_query ( handler, query )
				if res then
					mysql_free_result ( res )
					res = nil
				end
				
				local res = mysql_query ( handler_old, "DELETE FROM vehicles WHERE Besitzer LIKE '"..name.."' AND Slot LIKE '"..data["Slot"].."'" )
				if res then
					mysql_free_result ( res )
					res = nil
				end
				
				data = mysql_fetch_assoc ( result )
			else
				break
			end
		else
			break
		end
	end
	mysql_free_result ( result )
end