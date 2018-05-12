function news1 ()
	outputChatBox ( "---Info---", getRootElement(), 200, 200, 0 )
	outputChatBox ( "Der Chat ist nur in der unmittelbaren Umgebung lesbar!", getRootElement(), 200, 200, 0 )
	outputChatBox ( "Bei Fragen und Problemen benutzt /support, und /admins um zu sehen, wer online ist!", getRootElement(), 200, 200, 0 )
	outputChatBox ( "Unser Tipp: Flugjob, Truckerjob oder der Farmerjob ist gut fuer den Anfang!", getRootElement(), 200, 200, 0 )
	outputChatBox ( "Forum: FORUMADRESSE, Weiteres: F1 - Hilfemenue, F11 - Karte, Polizei-NR: 911", getRootElement(), 200, 200, 0 )
	setTimer ( news2, 300000, 1 )
end
function news2 ()
	outputChatBox ( "---Info---", getRootElement(), 200, 200, 0 )
	outputChatBox ( "Besuche doch die neue Bank auf Servername!", getRootElement(), 200, 200, 0 )
	outputChatBox ( "Bei Fragen und Problemen benutzt /support, und /admins um zu sehen, wer online ist!", getRootElement(), 200, 200, 0 )
	outputChatBox ( "Du kannst 911 anrufen, um Verbrechen der Polizei zu melden.", getRootElement(), 200, 200, 0 )
	setTimer ( news3, 300000, 1 )
end
function news3 ()
	outputChatBox ( "---Info---", getRootElement(), 200, 200, 0 )
	outputChatBox ( "Du willst dich fuer eine Fraktion bewerben? Melde dich auf FORUMADRESSE!", getRootElement(), 200, 200, 0 )
	outputChatBox ( "Bei Fragen und Problemen benutzt /support, und /admins um zu sehen, wer online ist!", getRootElement(), 200, 200, 0 )
	outputChatBox ( "Nutze /save, um deine Position und deine Waffen zu sichern!", getRootElement(), 200, 200, 0 )
	setTimer ( news1, 300000, 1 )
end
setTimer ( news1, 300000, 1 )

function infobox ( player, text, time, r, g, b )

	if isElement ( player ) then
		triggerClientEvent ( player, "infobox_start", getRootElement(), text, time, r, g, b )
	end
end