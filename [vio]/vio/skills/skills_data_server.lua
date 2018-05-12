function skillDataLoad ( player )

	local pname = getPlayerName ( player )
	setFishingValues ( player )
	vioSetElementData ( player, "fishingSkill", tonumber ( MySQL_GetString ( "skills", "fishing", "Name LIKE '"..pname.."'" ) ) )
	vioSetElementData ( player, "fishingSkillOld", vioGetElementData ( player, "fishingSkill" ) )
	vioSetElementData ( player, "gambleSkill", tonumber ( MySQL_GetString ( "skills", "gamble", "Name LIKE '"..pname.."'" ) ) )
end

function skillDataSave ( player )

	local pname = getPlayerName ( player )
	if vioGetElementData ( player, "fishingSkill" ) > vioGetElementData ( player, "fishingSkillOld" ) then
		MySQL_SetString ( "skills", "fishing", vioGetElementData ( player, "fishingSkill" ), "Name LIKE '"..pname.."'" )
	end
	saveFishingValues ( player )
	MySQL_SetString ( "skills", "gamble", vioGetElementData ( player, "gambleSkill" ), "Name LIKE '"..pname.."'" )
end