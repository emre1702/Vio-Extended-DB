function calcTruckerJobTourValue ( vehicle, time, danger )

	local amount = 0
	if vehicle == "pizza" then
		amount = 75
	elseif vehicle == "van" then
		amount = 125
	elseif vehicle == "roadtrain" then
		amount = 200
	elseif vehicle == "linerunner" then
		amount = 225
	elseif vehicle == "tanker" then
		amount = 250
	end
	if time then
		if danger then
			amount = amount * 1.5
		else
			amount = amount * 1.2
		end
	elseif danger then
		amount = amount * 1.2
	end
	return math.floor ( math.abs ( amount ) )
end