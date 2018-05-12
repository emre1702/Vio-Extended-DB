-- Caligulas
createBlip ( 2195.9187011719, 1677.1341552734, 11.345178604126, 25, 1.2, 255, 0, 0, 255, 0, 200 )

-- Four Dragons
createBlip ( 2020.2043457031, 1007.7569580078, 9.8054075241089, 25, 1.2, 255, 0, 0, 255, 0, 200 )

function getRandomCroupierSkin ()

	if math.random ( 1, 2 ) == 1 then
		return 194
	else
		return 240
	end
end