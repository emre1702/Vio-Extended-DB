local chessPlayers = {}
local chessTimers = {}

function chess_func ( playerA, cmd, playerB )

	playerB = getPlayerFromName ( playerB )
	if vioGetElementData ( playerA, "chess" ) then
		if isElement ( playerB ) then
			if not chessPlayers[playerB] then
				outputChatBox ( "Anfrage zum Schach gesendet an: "..getPlayerName ( playerB ), playerA, 200, 200, 0 )
				outputChatBox ( getPlayerName ( playerA ).." moechte mit dir eine Runde Schach spielen! Tippe /accept chess zum annehmen.", playerB, 200, 200, 0 )
				vioSetElementData ( playerB, "chessOfferedBy", playerA )
			else
				outputChatBox ( "Der Spieler ist bereits in einem Spiel.", playerA, 125, 0, 0 )
			end
		else
			outputChatBox ( "Spieler nicht gefunden.", playerA, 125, 0, 0 )
		end
	else
		outputChatBox ( "Du musst dir erst ein Schachspiel im Bonusmenue kaufen!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "chess", chess_func )

function accept_chess_func ( player, cmd, string )

	if string == "chess" then
		local playerA, playerB = player, vioGetElementData ( player, "chessOfferedBy" )
		if isElement ( playerB ) then
			startChessMatchBetweenTwoPlayers ( playerA, playerB )
		else
			outputChatBox ( "Niemand hat dir eine Runde Schach angeboten oder der Spieler ist offline.", playerA, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "accept", accept_chess_func )

function startChessMatchBetweenTwoPlayers ( playerA, playerB )

	if isElement ( playerA ) and isElement ( playerB ) then
		if not chessPlayers[playerA] and not chessPlayers[playerB] then
			setElementData ( playerA, "ElementClicked", true )
			setElementData ( playerB, "ElementClicked", true )
			chessPlayers[playerA] = playerB
			chessPlayers[playerB] = playerA
			
			triggerClientEvent ( playerA, "startNewChessParty", playerA, 1 )
			triggerClientEvent ( playerB, "startNewChessParty", playerB, 2 )
			
			setPlayerStartDraw ( playerA )
			
			outputChatBox ( "Spiel gestartet!", playerA, 0, 125, 0 )
			outputChatBox ( "Spiel gestartet!", playerB, 0, 125, 0 )
			
			outputChatBox ( "Weisser Spieler: ".." "..getPlayerName ( playerA )..", schwarzer Spieler: "..getPlayerName ( playerB ), playerA, 0, 200, 200 )
			outputChatBox ( "Weisser Spieler: ".." "..getPlayerName ( playerA )..", schwarzer Spieler: "..getPlayerName ( playerB ), playerB, 0, 200, 200 )
		end
	end
end

function chessPlayerLeafe ()

	local player = source
	if isElement ( chessPlayers[player] ) then
		setElementData ( player, "ElementClicked", false )
		if isElement ( source ) then
			setElementData ( player, "ElementClicked", false )
		end
		outputChatBox ( "Dein Gegner hat das Spiel verlassen / ist gestorben.", chessPlayers[player], 200, 200, 0 )
		resign_func ( true, chessPlayers[player] )
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), chessPlayerLeafe )
addEventHandler ( "onPlayerWasted", getRootElement(), chessPlayerLeafe )

function setPlayerStartDraw ( player )

	vioSetElementData ( player, "chessPlayer", true )
	triggerClientEvent ( player, "startChessDraw", player )
	addEventHandler ( "onElementDataChange", player, dataChange )
end

function endDraw_func ( x1, y1, x2, y2, special )

	if special == "won" then
		setTimer ( resign_func, 3000, 1, true, client )
		outputChatBox ( "Du gewinnst!", client, 0, 125, 0 )
		outputChatBox ( "Du hast verloren.", chessPlayers[client], 0, 125, 0 )
	else
		removeEventHandler ( "onElementDataChange", client, dataChange )
		if vioGetElementData ( client, "chessPlayer" ) then
			local player = chessPlayers[client]
			vioSetElementData ( client, "chessPlayer", false )
			triggerClientEvent ( player, "changeFigurePosition", player, x1, y1, x2, y2, special )
			setPlayerStartDraw ( player )
		end
	end
end
addEvent ( "endDraw", true )
addEventHandler ( "endDraw", getRootElement(), endDraw_func )

function resign_func ( dontShowText, player )

	if dontShowText then
		local pname = getPlayerName ( player )
		playerA = player
		playerB = chessPlayers[player]
	else
		local pname = getPlayerName ( client )
		playerA = client
		playerB = chessPlayers[client]
	end
	if not dontShowText then
		outputChatBox ( pname.." hat aufgegeben!", playerA, 0, 125, 0 )
		outputChatBox ( "Du verlierst!", playerA, 125, 0, 0 )
		if isElement ( playerB ) then
			outputChatBox ( pname.." hat aufgegeben!", playerB, 0, 125, 0 )
			outputChatBox ( "Du gewinnst!", playerB, 0, 125, 0 )
		end
	end
	
	triggerClientEvent ( playerA, "endGame", getRootElement() )
	setElementData ( playerA, "ElementClicked", false )
	if isElement ( playerB ) then
		setElementData ( playerB, "ElementClicked", false )
		triggerClientEvent ( playerB, "endGame", getRootElement() )
	end
	
	chessPlayers[playerA] = nil
	chessPlayers[playerB] = nil
end
addEvent ( "resign", true )
addEventHandler ( "resign", getRootElement(), resign_func )