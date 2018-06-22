function mafiasettings ()
	local mafia = "Mafia"

	local result = dbPoll( dbQuery( handler, "SELECT * FROM fraktionswaffen WHERE Fraktion LIKE ?", mafia ), -1 )
	if result and result[1] then
		local d = result[1]
		MafiaSchlagringe = tonumber( d["Schlagringe"] )
		MafiaBaseballschlaeger = tonumber( d["Baseballschlaeger"] )
		MafiaMesser = tonumber( d["Messer"] )
		MafiaSchaufeln = tonumber( d["Schaufeln"] )
		MafiaPistolen = tonumber( d["Pistolen"] )
		MafiaSDPistolen = tonumber( d["SDPistolen"] )
		MafiaPistolenMagazine = tonumber( d["PistolenMagazine"]  )
		MafiaDesertEagles = tonumber( d["DesertEagles"]  )
		MafiaDesertEagleMunition = tonumber( d["DesertEagleMunition"]  )
		MafiaSchrotflinten = tonumber( d["Schrotflinten"]  )
		MafiaSchrotflintenMunition = tonumber( d["SchrotflintenMunition"]  )
		MafiaMP = tonumber( d["MP"]  )
		MafiaMPMunition = tonumber( d["MPMunition"]  )
		MafiaAK = tonumber( d["AK"] ) 
		MafiaAKMunition = tonumber( d["AKMunition"] )
		MafiaM = tonumber( d["M"] ) 
		MafiaMMunition = tonumber( d["MMunition"] ) 
		MafiaGewehre = tonumber( d["Gewehre"] ) 
		MafiaGewehrPatronen = tonumber( d["GewehrPatronen"] ) 
		MafiaSGewehr = tonumber( d["SGewehr"]  )
		MafiaSGewehrMunition = tonumber( d["SGewehrMunition"]  )
		MafiaRaketenwerfer = tonumber( d["Raketenwerfer"]  )
		MafiaRaketen = tonumber( d["Raketen"]  )
		MafiaSpezwaffen = tonumber( d["Spezwaffen"]  )
	end

	result = dbPoll( dbQuery( handler, "SELECT DepotGeld FROM fraktionen WHERE Name LIKE ?", mafia ), -1 )
	if result and result[1] then
		MafiaFamkasse = tonumber( result[1]["DepotGeld"] )
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), mafiasettings )