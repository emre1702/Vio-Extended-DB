local marker = createMarker ( -2016.06, 453.69, 34.16, "cylinder", 1, 125, 0, 0, 150 )

addEventHandler ( "onClientMarkerHit", marker,
	function ( hit )
		if hit == lp then
			local lottoNRCount = {}
			local selectedLottoNRs = {}
			
			showCursor ( true )
			setElementData ( lp, "ElementClicked", true )
			
			gWindow["lotto"] = guiCreateWindow(screenwidth / 2 - 220 / 2, screenheight / 2 - 161 / 2, 220,161,"Lottoschein",false)
			guiSetAlpha(gWindow["lotto"],1)
			
			local count = 0
			for i = 1, 3 do
				for k = 1, 4 do
					count = count + 1
					
					gImage["lotto"..count] = guiCreateStaticImage(13 + ( k - 1 ) * 26,24 + ( i - 1 ) * 26,24,24,"images/colors/c_red.jpg",false,gWindow["lotto"])
					guiSetAlpha(gImage["lotto"..count],1)
					
					gLabel["lottoLabel"..count] = guiCreateLabel(0,0,24,24,tostring(count),false,guiCreateStaticImage ( 2, 2, 20, 20, "images/colors/c_white.jpg", false, gImage["lotto"..count] ))
					guiSetAlpha(gLabel["lottoLabel"..count],1)
					guiLabelSetColor(gLabel["lottoLabel"..count],255,0,0)
					guiLabelSetVerticalAlign(gLabel["lottoLabel"..count],"center",false)
					guiLabelSetHorizontalAlign(gLabel["lottoLabel"..count],"center",false)
					guiSetFont(gLabel["lottoLabel"..count],"default-bold-small")
					
					lottoNRCount[gLabel["lottoLabel"..count]] = count
					
					addEventHandler ( "onClientGUIClick", gLabel["lottoLabel"..count],
						function ()
							local nr = lottoNRCount[source]
							if isElement ( selectedLottoNRs[nr] ) then
								destroyElement ( selectedLottoNRs[nr] )
								selectedLottoNRs[nr] = nil
							elseif tableElementSize ( selectedLottoNRs ) < 3 then
								selectedLottoNRs[nr] = guiCreateStaticImage( 0, 0, 24, 24, "images/gui/cross.png", false, gLabel["lottoLabel"..nr] )
								addEventHandler ( "onClientGUIClick", selectedLottoNRs[nr],
									function ()
										destroyElement ( selectedLottoNRs[nr] )
									end,
								false )
							end
						end,
					false )
				end
			end
			
			gButton["fillOutLotto"] = guiCreateButton(9,114,71,37,"Ausfuellen",false,gWindow["lotto"])
			guiSetAlpha(gButton["fillOutLotto"],1)
			guiSetFont(gButton["fillOutLotto"],"default-bold-small")
			gButton["closeLotto"] = guiCreateButton(98,115,69,37,"Schliessen",false,gWindow["lotto"])
			guiSetAlpha(gButton["closeLotto"],1)
			guiSetFont(gButton["closeLotto"],"default-bold-small")
			
			addEventHandler ( "onClientGUIClick", gButton["fillOutLotto"],
				function ()
					if tableElementSize ( table ) then
						destroyElement ( gWindow["lotto"] )
						showCursor ( false )
						setElementData ( lp, "ElementClicked", false )
						
						local l1, l2, l3
						
						for key, index in pairs ( selectedLottoNRs ) do
							l1 = key
							selectedLottoNRs[key] = nil
							break
						end
						for key, index in pairs ( selectedLottoNRs ) do
							l2 = key
							selectedLottoNRs[key] = nil
							break
						end
						for key, index in pairs ( selectedLottoNRs ) do
							l3 = key
							selectedLottoNRs[key] = nil
							break
						end
						
						triggerServerEvent ( "recieveClientLotto", lp, l1, l2, l3 )
					else
						infobox ( "Du musst 3\nKreuze setzen.", 5000, 125, 0, 0 )
					end
				end,
			false )
			
			addEventHandler ( "onClientGUIClick", gButton["closeLotto"],
				function ()
					destroyElement ( gWindow["lotto"] )
					showCursor ( false )
					setElementData ( lp, "ElementClicked", false )
				end,
			false )
			
			gLabel["lottoJackpot"] = guiCreateLabel(115+3,24,225-115,100,"Kosten: 10 $,\nnur 3 Scheine\npro Person,\nakt. Jackpot:\n50.000 $",false,gWindow["lotto"])
			guiSetAlpha(gLabel["lottoJackpot"],1)
			guiLabelSetColor(gLabel["lottoJackpot"],200,200,0)
			guiLabelSetVerticalAlign(gLabel["lottoJackpot"],"left",false)
			guiLabelSetHorizontalAlign(gLabel["lottoJackpot"],"top",false)
			guiSetFont(gLabel["lottoJackpot"],"default-bold-small")
			
			triggerServerEvent ( "requestLottoJackpot", lp )
		end
	end
)

function recieveLottoJackpot ( jackpot )

	if isElement ( gLabel["lottoJackpot"] ) then
		guiSetText ( gLabel["lottoJackpot"], "Kosten: 10 $,\nnur 3 Scheine\npro Person,\nakt. Jackpot:\n"..formNumberToMoneyString ( jackpot ) )
	end
end
addEvent ( "recieveLottoJackpot", true )
addEventHandler ( "recieveLottoJackpot", getRootElement(), recieveLottoJackpot )

function tableElementSize ( table )

	local count = 0
	for key, index in pairs ( table ) do
		if isElement ( index ) then
			count = count + 1
		end
	end
	return count
end