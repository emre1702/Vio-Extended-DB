﻿newsPaperPath = ":vio_stored_files/newspaper/newspaper.vio"

newspaperPickup = createPickup ( -2015.88, 490.12, 34.791370391846, 3, 1239, 100 )
postbox = createObject ( 1291, -2017.1666259766, 490.11837768555, 34.686275482178, 0, 0, 270 )

function newspaperPickupHit ( hit )

	if getElementType ( hit ) == "player" then
		outputChatBox ( "Tippe /newspaper, um hier eine Zeitung fuer 10 $ zu erwerben!", hit, 0, 125, 0 )
	end
end
addEventHandler ( "onPickupHit", newspaperPickup, newspaperPickupHit )

function newspaper_func ( player )

	if vioGetElementData ( player, "money" ) >= 10 then
		local x1, y1, z1 = getElementPosition ( player )
		local x2, y2, z2 = getElementPosition ( newspaperPickup )
		if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 10 then
			vioSetElementData ( player, "newspaper", true )
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 10 )
			outputChatBox ( "Zeitung erworben - du kannst sie jetzt im Inventar benutzen!", player, 0, 125, 0 )
			
			local fraktion = fraktionNames[5]
			_G[fraktion.."Money"] = _G[fraktion.."Money"] + 10
			MySQL_SetString("fraktionen", "DepotGeld", _G[fraktion.."Money"], "Name LIKE '"..fraktion.."'")
		else
			outputChatBox ( "Du bist nicht beim Liberty Tree Gebaeude!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Du hast nicht genug Geld! Eine Zeitung kostet 10 $!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "newspaper", newspaper_func )

function readnewspaper_func ( player )

	if vioGetElementData ( player, "newspaper" ) then
		triggerClientEvent ( player, "showNewspaper", player, newsPaperText )
	else
		outputChatBox ( "Du hast keine Zeitung!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "readnewspaper", readnewspaper_func )

function loadnewsPaper()

	local newsPaper = fileOpen ( newsPaperPath, false )
	local filesize = fileGetSize ( newsPaper )
	newsPaperText = fileRead ( newsPaper, filesize )
	if not newsPaperText then
		newsPaperText = ""
	end
	fileClose ( newsPaper )
end
loadnewsPaper()

function edit_func ( player )

	if isReporter ( player ) and vioGetElementData ( player, "rang" ) >= 3 then
		triggerClientEvent ( player, "showNewspaperReporter", player, newsPaperText )
	else
		outputChatBox ( "Du bist nicht befugt!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "edit", edit_func )

function redoNewspaperServer_func ( text )

	if source == client then
		vioSetElementData ( getRootElement(), "newspaper", false )
		newsPaperText = text
		fileDelete ( newsPaperPath )
		local newsPaper = fileCreate ( newsPaperPath )
		fileWrite ( newsPaper, text )
		fileClose ( newsPaper )
		outputServerLog ( getPlayerName(source).." hat die Zeitung editiert." )
		outputChatBox ( "Du hast die Zeitung neu geschrieben!", source, 0, 125, 0 )
	end
end
addEvent ( "redoNewspaperServer", true )
addEventHandler  ( "redoNewspaperServer", getRootElement(), redoNewspaperServer_func )