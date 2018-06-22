function aztecasData_load ()

	local mafia = "Aztecas"

	local result = dbPoll( dbQuery( handler, "SELECT * FROM fraktionswaffen WHERE Fraktion LIKE ?", mafia ), -1 )
	if result and result[1] then
		local d = result[1]
		AztecasSchlagringe = tonumber( d["Schlagringe"] )
		AztecasBaseballschlaeger = tonumber( d["Baseballschlaeger"] )
		AztecasMesser = tonumber( d["Messer"] )
		AztecasSchaufeln = tonumber( d["Schaufeln"] )
		AztecasPistolen = tonumber( d["Pistolen"] )
		AztecasSDPistolen = tonumber( d["SDPistolen"] )
		AztecasPistolenMagazine = tonumber( d["PistolenMagazine"]  )
		AztecasDesertEagles = tonumber( d["DesertEagles"]  )
		AztecasDesertEagleMunition = tonumber( d["DesertEagleMunition"]  )
		AztecasSchrotflinten = tonumber( d["Schrotflinten"]  )
		AztecasSchrotflintenMunition = tonumber( d["SchrotflintenMunition"]  )
		AztecasMP = tonumber( d["MP"]  )
		AztecasMPMunition = tonumber( d["MPMunition"]  )
		AztecasAK = tonumber( d["AK"] ) 
		AztecasAKMunition = tonumber( d["AKMunition"] )
		AztecasM = tonumber( d["M"] ) 
		AztecasMMunition = tonumber( d["MMunition"] ) 
		AztecasGewehre = tonumber( d["Gewehre"] ) 
		AztecasGewehrPatronen = tonumber( d["GewehrPatronen"] ) 
		AztecasSGewehr = tonumber( d["SGewehr"]  )
		AztecasSGewehrMunition = tonumber( d["SGewehrMunition"]  )
		AztecasRaketenwerfer = tonumber( d["Raketenwerfer"]  )
		AztecasRaketen = tonumber( d["Raketen"]  )
		AztecasSpezwaffen = tonumber( d["Spezwaffen"]  )
	end

	result = dbPoll( dbQuery( handler, "SELECT DepotGeld FROM fraktionen WHERE Name LIKE ?", mafia ), -1 )
	if result and result[1] then
		AztecasFamkasse = tonumber( result[1]["DepotGeld"] )
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), aztecasData_load )