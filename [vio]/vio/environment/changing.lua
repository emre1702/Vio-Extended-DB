baustelle = false
bridge1 = false
bridge2 = true

-- false 		= 	Geschlossen
-- Bridge 1 	= 	SF Nord
-- Bridge 2 	= 	SF East

--bridge2Object = createObject ( 4518, -1699.0743408203, 512.74597167969, 39.094360351563, 0, 0, 228 )

function changeEnvironment ()

	local rnd = math.random ( 1, 2 )
	if rnd == 1 then
		if bridge1 then
			bridge1 = false
			bridge2 = true
			destroyElement ( bridge1Object )
			bridge2Object = createObject ( 4518, -1699.0743408203, 512.74597167969, 39.094360351563, 0, 0, 228 )
			sendMSGForFaction ( "Hinweis: Bruecke vom Highway nach Las Venutras gesperrt!", 5, 200, 200, 125 )
		else
			bridge1 = true
			bridge2 = false
			destroyElement ( bridge2Object )
			bridge1Object = createObject ( 4518, -2681.12890625, 1309.966796875, 56.183994293213, 0, 0, 270 )
			sendMSGForFaction ( "Hinweis: Golden Gate Bridge gesperrt!", 5, 200, 200, 125 )
		end
	else
		if baustelle then
			killBaustelle()
			sendMSGForFaction ( "Hinweis: Baustelle in San Fierro vollendet!", 5, 200, 200, 125 )
		else
			createBaustelle()
			sendMSGForFaction ( "Hinweis: Neue Baustelle in San Fierro!", 5, 200, 200, 125 )
		end
	end
end
--setTimer ( changeEnvironment, 120*60*1000, -1 )

function createBaustelle()

	baustelle1 = createObject ( 8875, -1911.3403320313, 736.91729736328, 50.392379760742, 0, 0, 131.00997924805 )
	baustelle2 = createObject ( 8876, -1908.3051757813, 732.93139648438, 51.167991638184, 0, 0, 127.05505371094 )
	baustelle3 = createObject ( 9131, -1906.1524658203, 732.75921630859, 45.425788879395, 0, 0, 37.714996337891 )
	baustelle4 = createObject ( 2960, -1906.1258544922, 732.77807617188, 46.969512939453, 0, 0, 0 )
	baustelle5 = createObject ( 2960, -1905.3571777344, 726.58587646484, 44.696517944336, 0, 0, 302.43499755859 )
	baustelle6 = createObject ( 12930, -1899.7059326172, 725.57934570313, 45.106845855713, 0, 0, 0 )
	baustelle7 = createObject ( 3722, -1890.2663574219, 722.34704589844, 46.465156555176, 0, 0, 328.23999023438 )
	baustelle8 = createObject ( 3502, -1893.4645996094, 734.4580078125, 46.225517272949, 0, 0, 45.654998779297 )
	baustelle9 = createObject ( 1238, -1876.7111816406, 720.93609619141, 44.763492584229, 0, 0, 0 )
	baustelle10 = createObject ( 1238, -1876.6087646484, 723.93621826172, 44.615055084229, 0, 0, 0 )
	baustelle11 = createObject ( 1238, -1899.169921875, 746.14013671875, 44.615055084229, 0, 0, 0 )
	baustelle12 = createObject ( 1238, -1899.2313232422, 705.92211914063, 44.615055084229, 0, 0, 0 )
	baustelle13 = createObject ( 1238, -1876.6263427734, 726.37414550781, 44.615055084229, 0, 0, 0 )
	baustelle14 = createObject ( 1238, -1876.666015625, 728.76043701172, 44.615055084229, 0, 0, 0 )
	baustelle15 = createObject ( 1238, -1876.7020263672, 731.37701416016, 44.615055084229, 0, 0, 0 )
	baustelle16 = createObject ( 1238, -1876.7309570313, 734.45697021484, 44.615055084229, 0, 0, 0 )
	baustelle17 = createObject ( 1238, -1876.7344970703, 737.06695556641, 44.615055084229, 0, 0, 0 )
	baustelle18 = createObject ( 1238, -1896.8522949219, 746.09820556641, 44.615055084229, 0, 0, 0 )
	baustelle19 = createObject ( 1238, -1894.4573974609, 746.08551025391, 44.615055084229, 0, 0, 0 )
	baustelle20 = createObject ( 1238, -1891.8737792969, 746.06103515625, 44.615055084229, 0, 0, 0 )
	baustelle21 = createObject ( 1238, -1889.2242431641, 745.97198486328, 44.763492584229, 0, 0, 0 )
	baustelle22 = createObject ( 1238, -1901.6437988281, 746.12365722656, 44.615055084229, 0, 0, 0 )
	baustelle23 = createObject ( 1238, -1903.9692382813, 746.06396484375, 44.615055084229, 0, 0, 0 )
	baustelle24 = createObject ( 1238, -1906.3713378906, 746.00885009766, 44.615055084229, 0, 0, 0 )
	baustelle25 = createObject ( 1238, -1909.2746582031, 745.96313476563, 44.763492584229, 0, 0, 0 )
	baustelle26 = createObject ( 1238, -1915.4415283203, 731.23858642578, 44.615055084229, 0, 0, 0 )
	baustelle27 = createObject ( 1238, -1915.4146728516, 733.61676025391, 44.615055084229, 0, 0, 0 )
	baustelle28 = createObject ( 1238, -1915.4027099609, 736.06573486328, 44.615055084229, 0, 0, 0 )
	baustelle29 = createObject ( 1238, -1915.4560546875, 738.35998535156, 44.615055084229, 0, 0, 0 )
	baustelle30 = createObject ( 1238, -1915.4111328125, 728.66455078125, 44.615055084229, 0, 0, 0 )
	baustelle31 = createObject ( 1238, -1915.4200439453, 726.50354003906, 44.615055084229, 0, 0, 0 )
	baustelle32 = createObject ( 1238, -1915.3819580078, 724.23059082031, 44.615055084229, 0, 0, 0 )
	baustelle33 = createObject ( 1238, -1915.3551025391, 722.05963134766, 44.763492584229, 0, 0, 0 )
	baustelle34 = createObject ( 1238, -1915.3452148438, 720.15509033203, 44.763492584229, 0, 0, 0 )
	baustelle35 = createObject ( 1238, -1901.7790527344, 705.84826660156, 44.615055084229, 0, 0, 0 )
	baustelle36 = createObject ( 1238, -1904.3774414063, 705.96911621094, 44.615055084229, 0, 0, 0 )
	baustelle37 = createObject ( 1238, -1907.0980224609, 705.83697509766, 44.763492584229, 0, 0, 0 )
	baustelle38 = createObject ( 1238, -1909.5847167969, 705.75659179688, 44.763492584229, 0, 0, 0 )
	baustelle39 = createObject ( 1238, -1896.8348388672, 706.05212402344, 44.615055084229, 0, 0, 0 )
	baustelle40 = createObject ( 1238, -1894.3509521484, 706.13244628906, 44.615055084229, 0, 0, 0 )
	baustelle41 = createObject ( 1238, -1891.7652587891, 706.09649658203, 44.615055084229, 0, 0, 0 )
	baustelle42 = createObject ( 1238, -1889.0982666016, 706.23492431641, 44.763492584229, 0, 0, 0 )
	baustelle43 = createObject ( 3091, -1899.462890625, 701.728515625, 44.941917419434, 0, 0, 0 )
	baustelle44 = createObject ( 3091, -1898.9400634766, 750.00927734375, 44.941917419434, 0, 0, 180 )
	baustelle45 = createObject ( 3091, -1919.2827148438, 731.35888671875, 44.941917419434, 0, 0, 270 )
	baustelle46 = createObject ( 3091, -1873.6030273438, 731.10766601563, 44.941917419434, 0, 0, 90 )
	baustelle = true
end

function killBaustelle ()

	if baustelle1 then
		for i = 1, 46 do
			local bool = destroyElement ( _G["baustelle"..i] )
			if not bool then outputDebugString ( tostring(i) )
				break
			end
		end
	end
	baustelle = false
end