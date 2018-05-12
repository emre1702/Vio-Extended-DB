function realtime()

	local time = getRealTime()
	if time.hour+winterzeit == 24 then
		hour = 0
	else
		hour = time.hour+winterzeit
	end
	setTime ( hour, time.minute )
	setMinuteDuration ( 60000 )
end
addEventHandler("onResourceStart", getRootElement(), realtime )