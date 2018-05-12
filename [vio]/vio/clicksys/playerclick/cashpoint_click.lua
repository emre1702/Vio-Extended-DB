function showCashPoint_func ()

	if gWindow["cashPoint"] then
		guiSetVisible ( gWindow["cashPoint"], true )
	else
		guiSetInputEnabled ( false )
		gWindow["cashPoint"] = guiCreateWindow(screenwidth/2-352/2,screenheight/2-367/2,352,367,"Geldautomat",false)
		guiSetAlpha ( gWindow["cashPoint"], 1 )
		guiWindowSetMovable ( gWindow["cashPoint"], false )
		guiWindowSetSizable ( gWindow["cashPoint"], false )
		
		gButton["cashPointClose"] = guiCreateButton(132,317,77,41,"Schliessen",false,gWindow["cashPoint"])
		guiSetFont(gButton["cashPointClose"],"default-bold-small")
		addEventHandler ( "onClientGUIClick", gButton["cashPointClose"],
			function ()
				guiSetVisible ( gWindow["cashPoint"], false )
				setElementData ( lp, "ElementClicked", false )
				showCursor ( false )
				guiSetInputEnabled ( true )
			end,
		false )

		gTabPanel["cashPoint"] = guiCreateTabPanel(9,24,334,287,false,gWindow["cashPoint"])

			gTab["cashPointPayOut"] = guiCreateTab("Ein/Auszahlen",gTabPanel["cashPoint"])
				gButton["cashPointPayOut"] = guiCreateButton(41,173,94,45,"Auszahlen",false,gTab["cashPointPayOut"])
				gButton["cashPointPayIn"] = guiCreateButton(191,171,94,45,"Einzahlen",false,gTab["cashPointPayOut"])
				gEdit["cashPointPayAmount"] = guiCreateEdit(102,88,130,33,"0",false,gTab["cashPointPayOut"])
				gLabel[1] = guiCreateLabel(143,71,45,19,"Betrag",false,gTab["cashPointPayOut"])
				guiLabelSetColor(gLabel[1],255,255,255)
				guiLabelSetVerticalAlign(gLabel[1],"top")
				guiLabelSetHorizontalAlign(gLabel[1],"left",false)
				guiSetFont(gLabel[1],"default-bold-small")
				gLabel[2] = guiCreateLabel(236,97,14,23,"$",false,gTab["cashPointPayOut"])
				guiLabelSetColor(gLabel[2],0,125,0)
				guiLabelSetVerticalAlign(gLabel[2],"top")
				guiLabelSetHorizontalAlign(gLabel[2],"left",false)
				guiSetFont(gLabel[2],"default-bold-small")

				addEventHandler ( "onClientGUIClick", gButton["cashPointPayIn"],
					function ()
						local amount = tonumber ( guiGetText ( gEdit["cashPointPayAmount"] ) )
						triggerServerEvent ( "cashPointPayIn", lp, amount )
						setTimer ( refreshStatementLabels, 2000, 1, 1 )
					end,
				false )
				addEventHandler ( "onClientGUIClick", gButton["cashPointPayOut"],
					function ()
						local amount = tonumber ( guiGetText ( gEdit["cashPointPayAmount"] ) )
						triggerServerEvent ( "cashPointPayOut", lp, amount )
						setTimer ( refreshStatementLabels, 2000, 1, 1 )
					end,
				false )

			gTab["cashPointTransfer"] = guiCreateTab("Ueberweisung",gTabPanel["cashPoint"])
				gImage["cashPointTransferBG"] = guiCreateStaticImage(4,10,325,211,"images/colors/c_white.jpg",false,gTab["cashPointTransfer"])
				gImage["cashPointTransferBGHead"] = guiCreateStaticImage(0,0,325,19,"images/colors/c_red.jpg",false,gImage["cashPointTransferBG"])
				gLabel[3] = guiCreateLabel(102,1,127,14,"Ueberweisungsformular",false,gImage["cashPointTransferBGHead"])
				guiLabelSetColor(gLabel[3],255,255,255)
				guiLabelSetVerticalAlign(gLabel[3],"top")
				guiLabelSetHorizontalAlign(gLabel[3],"left",false)
				guiCreateStaticImage(0,192,325,19,"images/colors/c_red.jpg",false,gImage["cashPointTransferBG"])
				gLabel[4] = guiCreateLabel(2,32,150,20,"Name des Beguenstigten",false,gImage["cashPointTransferBG"])
				guiLabelSetColor(gLabel[4],0,0,0)
				guiLabelSetVerticalAlign(gLabel[4],"top")
				guiLabelSetHorizontalAlign(gLabel[4],"left",false)
				gLabel[5] = guiCreateLabel(2,81,148,34,"Summe, die Ueberwiesen\nwerden soll",false,gImage["cashPointTransferBG"])
				guiLabelSetColor(gLabel[5],0,0,0)
				guiLabelSetVerticalAlign(gLabel[5],"top")
				guiLabelSetHorizontalAlign(gLabel[5],"left",false)
				gLabel[6] = guiCreateLabel(306,91,12,22,"$",false,gImage["cashPointTransferBG"])
				guiLabelSetColor(gLabel[6],0,200,0)
				guiLabelSetVerticalAlign(gLabel[6],"top")
				guiLabelSetHorizontalAlign(gLabel[6],"left",false)
				gLabel[7] = guiCreateLabel(1,144,124,39,"Verwendungszweck \n/ Betreff",false,gImage["cashPointTransferBG"])
				guiLabelSetColor(gLabel[7],0,0,0)
				guiLabelSetVerticalAlign(gLabel[7],"top")
				guiLabelSetHorizontalAlign(gLabel[7],"left",false)
				gEdit["cashPointTransferTo"] = guiCreateEdit(165,23,153,35,"Name",false,gImage["cashPointTransferBG"])
				gEdit["cashPointTransferAmount"] = guiCreateEdit(165,83,135,35,"0",false,gImage["cashPointTransferBG"])
				gMemo["cashPointTransferReason"] = guiCreateMemo(146,124,174,62,"Grund",false,gImage["cashPointTransferBG"])
				gButton["cashPointTransferSend"] = guiCreateButton(129,224,66,35,"Senden",false,gTab["cashPointTransfer"])
				guiSetFont(gButton["cashPointTransferSend"],"default-bold-small")
				addEventHandler ( "onClientGUIClick", gButton["cashPointTransferSend"],
					function ()
						local amount = tonumber ( guiGetText ( gEdit["cashPointTransferAmount"] ) )
						local target = guiGetText ( gEdit["cashPointTransferTo"] )
						local reason = guiGetText ( gMemo["cashPointTransferReason"] )
						triggerServerEvent ( "cashPointTransfer", lp, amount, target, false, reason )
						setTimer ( refreshStatementLabels, 2000, 1, 1 )
					end,
				false )

			gTab["cashPointPrint"] = guiCreateTab("Kontoauszug",gTabPanel["cashPoint"])
				gImage["cashPointPrintBG"] = guiCreateStaticImage(4,8,325,211,"images/colors/c_white.jpg",false,gTab["cashPointPrint"])
				gImage["cashPointPrintBGHead"] = guiCreateStaticImage(0,0,325,19,"images/colors/c_red.jpg",false,gImage["cashPointPrintBG"])
				gLabel[8] = guiCreateLabel(125,0,75,17,"Kontoauszug",false,gImage["cashPointPrintBGHead"])
				guiLabelSetColor(gLabel[8],255,255,255)
				guiLabelSetVerticalAlign(gLabel[8],"top")
				guiLabelSetHorizontalAlign(gLabel[8],"left",false)
				guiSetFont(gLabel[8],"default-bold-small")
				gImage["cashPointPrintBGBottom"] = guiCreateStaticImage(0,192,325,19,"images/colors/c_red.jpg",false,gImage["cashPointPrintBG"])
				guiCreateStaticImage(101,170,100,2,"images/colors/c_black.jpg",false,gImage["cashPointPrintBG"])
				gLabel[12] = guiCreateLabel(17,177,69,17,"Total",false,gImage["cashPointPrintBG"])
				guiLabelSetColor(gLabel[12],200,0,0)
				guiLabelSetVerticalAlign(gLabel[12],"top")
				guiLabelSetHorizontalAlign(gLabel[12],"left",false)
				gLabel[15] = guiCreateLabel(16,30,73,19,"Grund",false,gImage["cashPointPrintBG"])
				guiLabelSetColor(gLabel[15],200,200,0)
				guiLabelSetVerticalAlign(gLabel[15],"top")
				guiLabelSetHorizontalAlign(gLabel[15],"left",false)
				gLabel[16] = guiCreateLabel(130,30,73,19,"Betrag",false,gImage["cashPointPrintBG"])
				guiLabelSetColor(gLabel[16],200,200,0)
				guiLabelSetVerticalAlign(gLabel[16],"top")
				guiLabelSetHorizontalAlign(gLabel[16],"left",false)
				gLabel[17] = guiCreateLabel(235,30,73,19,"Sonstiges",false,gImage["cashPointPrintBG"])
				guiLabelSetColor(gLabel[17],200,200,0)
				guiLabelSetVerticalAlign(gLabel[17],"top")
				guiLabelSetHorizontalAlign(gLabel[17],"left",false)
				gLabel[19] = guiCreateLabel(135,234,54,12,"Blaettern",false,gTab["cashPointPrint"])
				guiLabelSetColor(gLabel[19],255,255,255)
				guiLabelSetVerticalAlign(gLabel[19],"top")
				guiLabelSetHorizontalAlign(gLabel[19],"left",false)
				guiSetFont(gLabel[19],"default-bold-small")
				gLabel[9] = guiCreateLabel(274,0,48,12,getDateAsOneString(),false,gImage["cashPointPrintBGHead"])
				guiLabelSetColor(gLabel[9],255,255,255)
				guiLabelSetVerticalAlign(gLabel[9],"top")
				guiLabelSetHorizontalAlign(gLabel[9],"left",false)
				guiSetFont(gLabel[9],"default-small")

				gLabel["cashPointPages"] = guiCreateLabel(236,2,87,15,"Seite 1/1",false,gImage["cashPointPrintBGBottom"])
				guiLabelSetColor(gLabel["cashPointPages"],255,255,255)
				guiLabelSetVerticalAlign(gLabel["cashPointPages"],"top")
				guiLabelSetHorizontalAlign(gLabel["cashPointPages"],"right",false)
				
				gLabel["cashPointWhy"] = guiCreateLabel(17,50,85,121,"Barauszahlung\n\n\nLas Venturas\nCasino\n\nEinzahlung\nLos Santos",false,gImage["cashPointPrintBG"])
				guiLabelSetColor(gLabel["cashPointWhy"],0,0,0)
				guiLabelSetVerticalAlign(gLabel["cashPointWhy"],"top")
				guiLabelSetHorizontalAlign(gLabel["cashPointWhy"],"left",false)
				gLabel["cashPointAmount"] = guiCreateLabel(114,62,86,118,"-400 $\n\n\n-200 $\n\n\n+ 25 $",false,gImage["cashPointPrintBG"])
				guiLabelSetColor(gLabel["cashPointAmount"],0,0,0)
				guiLabelSetVerticalAlign(gLabel["cashPointAmount"],"top")
				guiLabelSetHorizontalAlign(gLabel["cashPointAmount"],"right",false)
				gLabel["cashPointWhere"] = guiCreateLabel(212,50,107,107,"SF Bahnhof\n\n\nFour Dragons\n\n\nMarket Station",false,gImage["cashPointPrintBG"])
				guiLabelSetColor(gLabel["cashPointWhere"],0,0,0)
				guiLabelSetVerticalAlign(gLabel["cashPointWhere"],"top")
				guiLabelSetHorizontalAlign(gLabel["cashPointWhere"],"right",false)
				
				gLabel["cashPointTotal"] = guiCreateLabel(99,176,101,16,"+ 0 $",false,gImage["cashPointPrintBG"])
				guiLabelSetColor(gLabel["cashPointTotal"],0,0,0)
				guiLabelSetVerticalAlign(gLabel["cashPointTotal"],"top")
				guiLabelSetHorizontalAlign(gLabel["cashPointTotal"],"right",false)
				--gButton["cashPointPrintPageUp"] = guiCreateButton(198,231,21,21,">",false,gTab["cashPointPrint"])
				--gButton["cashPointPrintPageDown"] = guiCreateButton(104,231,21,21,"<",false,gTab["cashPointPrint"])
	end
	refreshStatementLabels ( 0 )
end
addEvent ( "showCashPoint", true )
addEventHandler ( "showCashPoint", getRootElement(), showCashPoint_func )

function refreshStatementLabels ( page )

	local c1, c2, c3 = getStatementEntry ( number )
	guiSetText ( gLabel["cashPointWhy"], c1 )
	guiSetText ( gLabel["cashPointAmount"], c2 )
	guiSetText ( gLabel["cashPointWhere"], c3 )
	local money = getElementData ( lp, "bankmoney" )
	if money > 0 then
		money = "+ "..money.." $"
	elseif money < 0 then
		money = "- "..math.abs ( money ).." $"
	else
		money = "+- 0 $"
	end
	guiSetText ( gLabel["cashPointTotal"], money )
end

function getDateAsOneString ()

	local time = getRealTime()
	local day = time.monthday
	local month = time.month + 1
	local year = time.year + 1900
	return day.."."..month.."."..year
end