﻿tetrisHighscores = {}

function mySQLBlocksCreate ()

	highscoreCounter = highscoreCounter + 1
	blocksData = table.remove( result, 1 )
	if blocksData then
		tetrisHighscores[highscoreCounter] = {}
		
		tetrisHighscores[highscoreCounter]["name"] = blocksData["Name"]
		tetrisHighscores[highscoreCounter]["points"] = tonumber ( blocksData["Punkte"] )
		
		mySQLBlocksCreate ()
	else
		outputDebugString("Es wurden "..(highscoreCounter-1).." Tetris-Highscores gefunden.")
	end
end
  
function initTetrisHighscores ()

	highscoreCounter = 0
	result, errorcode, errormsg = dbPoll( dbQuery ( handler, "SELECT * FROM blocks"), -1 )
	if( not result) then
		outputDebugString("Error executing the query: (" .. errorcode .. ") " .. errormsg)
	else
		if result[1] then
			mySQLBlocksCreate ()
		else
			outputServerLog("Es wurden keine Highscores")
		end
	end
end
setTimer ( initTetrisHighscores, 5000, 1 )

function resort ()

	local n = #tetrisHighscores
	if n >= 2 then
		for i = 1, n do
			for k = 2, n do
				if tetrisHighscores[k]["points"] < tetrisHighscores[k-1]["points"] then
					bufferA = tetrisHighscores[k-1]["points"]
					bufferB = tetrisHighscores[k-1]["name"]
					
					tetrisHighscores[k-1]["points"] = tetrisHighscores[k]["points"]
					tetrisHighscores[k-1]["name"] = tetrisHighscores[k]["name"]
					
					tetrisHighscores[k]["points"] = bufferA
					tetrisHighscores[k]["name"] = bufferB
				end
			end
		end
	end
end

local count = 0
for i = 10, 1, -1 do

	if tetrisHighscores[i] then
		if tetrisHighscores[i]["name"] then
			count = count + 1
		end
	end
end

function showHighscore ( player )

	local count = 0
	for i = 10, 1, -1 do
		if tetrisHighscores[i] then
			count = count + 1
			outputChatBox ( "Platz "..count..": "..tetrisHighscores[i]["name"].." mit "..tetrisHighscores[i]["points"].." Punkten!", player, 200, 200, 0 )
		end
	end
end

function getLowestScore ()

	lowestGuy = "[Vio]Zipper"
	lowestPoints = 999999
	lowestPlace = 0
	bool = false
	for i = 10, 1, -1 do
		if tetrisHighscores[i] then
			if tetrisHighscores[i]["points"] < lowestPoints then
				lowestPoints = tetrisHighscores[i]["points"]
				lowestGuy = tetrisHighscores[i]["name"]
				lowestPlace = i
				bool = true
			end
		end
	end
	if bool then
		return lowestPoints, lowestPlace
	else
		return false, false
	end
end

function rewriteHighscore ()

	dbExec( handler, "TRUNCATE TABLE blocks" )
	for i = 1, 10 do
		dbExec( handler, "INSERT INTO blocks (Name, Punkte) VALUES (?, ?)", tetrisHighscores[i]["name"], tetrisHighscores[i]["points"] )
	end
end

function tetrisFinished_func ( score )

	local player = client
	if score < 99999 then
		local lowestPoints, lowestPlace = getLowestScore ()
		if lowestPoints then
			if score >= lowestPoints then
				tetrisHighscores[lowestPlace]["points"] = score
				tetrisHighscores[lowestPlace]["name"] = getPlayerName ( player )
				
				rewriteHighscore ()
				initTetrisHighscores ()
				resort ()
			end
		end
		showHighscore ( player )
	end
end
addEvent ( "tetrisFinished", true )
addEventHandler ( "tetrisFinished", getRootElement(), tetrisFinished_func )