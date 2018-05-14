function triadsettings ()

	local mafia = "Triaden"

	local result = dbPoll( dbQuery( handler, "SELECT * FROM fraktionswaffen WHERE Fraktion LIKE ?", mafia ), -1 )
	if result and result[1] then
		local d = result[1]
		TriadenSchlagringe = tonumber( d["Schlagringe"] )
		TriadenBaseballschlaeger = tonumber( d["Baseballschlaeger"] )
		TriadenMesser = tonumber( d["Messer"] )
		TriadenSchaufeln = tonumber( d["Schaufeln"] )
		TriadenPistolen = tonumber( d["Pistolen"] )
		TriadenSDPistolen = tonumber( d["SDPistolen"] )
		TriadenPistolenMagazine = tonumber( d["PistolenMagazine"]  )
		TriadenDesertEagles = tonumber( d["DesertEagles"]  )
		TriadenDesertEagleMunition = tonumber( d["DesertEagleMunition"]  )
		TriadenSchrotflinten = tonumber( d["Schrotflinten"]  )
		TriadenSchrotflintenMunition = tonumber( d["SchrotflintenMunition"]  )
		TriadenMP = tonumber( d["MP"]  )
		TriadenMPMunition = tonumber( d["MPMunition"]  )
		TriadenAK = tonumber( d["AK"] ) 
		TriadenAKMunition = tonumber( d["AKMunition"] )
		TriadenM = tonumber( d["M"] ) 
		TriadenMMunition = tonumber( d["MMunition"] ) 
		TriadenGewehre = tonumber( d["Gewehre"] ) 
		TriadenGewehrPatronen = tonumber( d["GewehrPatronen"] ) 
		TriadenSGewehr = tonumber( d["SGewehr"]  )
		TriadenSGewehrMunition = tonumber( d["SGewehrMunition"]  )
		TriadenRaketenwerfer = tonumber( d["Raketenwerfer"]  )
		TriadenRaketen = tonumber( d["Raketen"]  )
		TriadenSpezwaffen = tonumber( d["Spezwaffen"]  )
	end

	result = dbPoll( dbQuery( handler, "SELECT DepotGeld FROM fraktionen WHERE Name LIKE ?", mafia ), -1 )
	if result and result[1] then
		TriadenFamkasse = tonumber( d["DepotGeld"] )
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), triadsettings )