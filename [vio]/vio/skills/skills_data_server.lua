local function skillDataLoad_DB ( qh, player )
	local result = dbPoll( qh, 0 )
	if result and result[1] then
		vioSetElementData ( player, "fishingSkill", tonumber ( result[1]["fishing"] ) )
		vioSetElementData ( player, "fishingSkillOld", vioGetElementData ( player, "fishingSkill" ) )
		vioSetElementData ( player, "gambleSkill",  tonumber ( result[1]["gamble"] ) ) )
	end
end

function skillDataLoad ( player )
	local pname = getPlayerName ( player )
	setFishingValues ( player )
	dbQuery( skillDataLoad_DB, { player }, handler, "SELECT fishing, gamble FROM skills WHERE Name LIKE ?", pname )
end

function skillDataSave ( player )

	local pname = getPlayerName ( player )
	if vioGetElementData ( player, "fishingSkill" ) > vioGetElementData ( player, "fishingSkillOld" ) then
		MySQL_SetString ( "skills", "fishing", vioGetElementData ( player, "fishingSkill" ), dbPrepareString( handler, "Name LIKE ?", pname ) )
	end
	saveFishingValues ( player )
	MySQL_SetString ( "skills", "gamble", vioGetElementData ( player, "gambleSkill" ), dbPrepareString( handler, "Name LIKE ?", pname ) )
end